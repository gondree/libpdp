#include "time_it.h"

timer* time_it_ptr = NULL;

void time_it_init(void){
	if(time_it_ptr != NULL){
		fprintf(stderr, "WARNING: Time It double init! Previous data lost.\n");
		time_it_cleanup();
	}
	time_it_ptr = (timer*)calloc(1,sizeof(timer));
	if(time_it_ptr == NULL)
		exit(-1);
	time_it_ptr->data = (struct time_it_timer_data*)calloc(MAX_TIMERS,sizeof(struct time_it_timer_data));
	if(time_it_ptr->data == NULL)
		exit(-1);
	time_it_ptr->heads = 0;
	time_it_ptr->gets = 0;
	time_it_ptr->puts = 0;
	time_it_ptr->posts = 0;
	time_it_ptr->lists = 0;
	time_it_ptr->copys = 0;
	time_it_ptr->data_sz = MAX_TIMERS;
}
void time_it_cleanup(void){
	free(time_it_ptr->data);
	free(time_it_ptr);
	time_it_ptr = NULL;
}

void time_it_insert_time(timer *t, double time, 
		unsigned int st_line, unsigned int en_line, 
		const char *func, const char *file, const char *comment){
	if(t == NULL)
		return;

	if(t->tic_no_toc){
		printf("WARNING at line %d in %s: Insert over TIC aborted.\n",st_line,file);
		fflush(stdout);
		return;
	}

	if(t->idx >= t->data_sz) {
		printf("WARNING at line %d in %s: MAX_TIMER limit reached, bad things are about to happen.\n",st_line,file);
		fflush(stdout);
		t->data_sz *= 2;
		t->data = (struct time_it_timer_data*)realloc(t->data, sizeof(struct time_it_timer_data)*(t->data_sz));
	}

	t->data[t->idx].st_line = st_line;
	t->data[t->idx].en_line = en_line;
	t->data[t->idx].time = time;
	t->data[t->idx].func = func;
	t->data[t->idx].file = file;
	t->data[t->idx].comment = comment;
	t->idx++;
}

void time_it_start_timer(timer *t, int st_line){
	if(t == NULL)
		return;
	/* Don't reset the start time before recording a stop time */
	if(t->tic_no_toc){
		printf("WARNING at line %d: Double TIC called, most recent TIC aborted.\n",st_line);
		fflush(stdout);
		return;
	}

	t->tic_no_toc = 1;
	t->data[t->idx].st_line = st_line;
	gettimeofday(&(t->tv_start), NULL);
}

void time_it_stop_timer(timer *t, unsigned int en_line, 
		const char *func, const char *file, const char *comment){
	if(t == NULL)
		return;
	/* Don't calculate the stop time with invalid start time */
	if(!t->tic_no_toc){
		printf("WARNING at line %d: Double TOC call aborted. TIC must occur first.\n",en_line);
		fflush(stdout);
		return;
	}

	gettimeofday(&(t->tv_stop), NULL);

	t->tic_no_toc = 0;
	t->data[t->idx].en_line = en_line;

	double usst = (double)t->tv_start.tv_usec/1000000.0;
	double ussp = (double)t->tv_stop.tv_usec/1000000.0;
	double sst = (double)((double)t->tv_start.tv_sec + usst);
	double ssp = (double)((double)t->tv_stop.tv_sec + ussp);
	t->data[t->idx].time = ssp - sst;
	t->data[t->idx].func = func;
	t->data[t->idx].file = file;
	t->data[t->idx].comment = comment;
	t->idx++;

	if(t->idx >= t->data_sz){
		printf("WARNING at line %d in %s: MAX_TIMER limit reached, bad things are about to happen.\n",en_line,file);
		fflush(stdout);
		t->data_sz *= 2;
		t->data = (struct time_it_timer_data*)realloc(t->data, sizeof(struct time_it_timer_data)*(t->data_sz));
	}
}

int time_it_write_csv(timer *t, const char *file_name, const char * mode){
	if(t == NULL)
		return 0;

	int i,rc = 0;
	FILE *f = NULL;
	time_t curtime;
	struct tm *loctime;

	if(strncmp(mode,"w",1) && strncmp(mode,"a",1)) goto cleanup;
	if((f = fopen(file_name, mode)) == NULL) goto cleanup;

	for(i = 0; i < t->idx; i++){
		fprintf(f, "%s\t", t->data[i].comment);
	}
	fprintf(f, "%s\n", "HEAD\tGET\tPUT\tCOPY\tLIST\tPOST\tMetadata\tTimestamp");

	for(i = 0; i < t->idx; i++){
		fprintf(f, "%.7lf\t", t->data[i].time);
	}
	curtime = time(NULL);
	loctime = localtime(&curtime);
	fprintf(f, "%u\t%u\t%u\t%u\t%u\t%u\t%s\t%s", t->heads, t->gets, t->puts, t->copys, t->lists, t->posts, t->meta, asctime(loctime));

	fclose(f); 
	rc = 1;

	cleanup:
	return rc;
	
} 


