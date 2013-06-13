/**
 * @file
 * A simple library for collecting in-line timing data.
 *
 * @author Copyright (c) 2012, Mark Gondree
 * @author Copyright (c) 2012, Alric Althoff
 * @date 2008-2013
 * @copyright BSD 2-Clause License
 *            See http://opensource.org/licenses/BSD-2-Clause
 **/
#include "time_it.h"

timeit_t* time_it_ptr = NULL;


/**
 * @brief Set ups library data structures.
 *
 * Call once, before using any other library macros / functions. 
 **/
void time_it_init(void)
{
#ifdef _TIMING_DATA
    if (time_it_ptr != NULL) {
        fprintf(stderr, "WARNING: double time_it_init, prev data lost.\n");
        time_it_cleanup();
    }
    time_it_ptr = (timeit_t*) calloc(1,sizeof(timeit_t));
    if (time_it_ptr == NULL)
        exit(-1);
    time_it_ptr->data = (struct time_it_timer_data*) 
            calloc(MAX_TIMERS, sizeof(struct time_it_timer_data));
    if (time_it_ptr->data == NULL)
        exit(-1);
    time_it_ptr->heads = 0;
    time_it_ptr->gets = 0;
    time_it_ptr->puts = 0;
    time_it_ptr->posts = 0;
    time_it_ptr->lists = 0;
    time_it_ptr->copys = 0;
    time_it_ptr->data_sz = MAX_TIMERS;
#endif
}


/**
 * @brief Cleans up library data structures.
 **/
void time_it_cleanup(void)
{
#ifdef _TIMING_DATA
    free(time_it_ptr->data);
    free(time_it_ptr);
    time_it_ptr = NULL;
#endif
}


/**
 * @brief Inserts a timing record into the global list of timing data.
 *
 * @param[in]      t          global list of timing records
 * @param[in]      time       time collected
 * @param[in]      st_line    starting line of in-line timing command
 * @param[in]      en_line    ending line of in-line timing command
 * @param[in]      func       function name holding in-line timing command
 * @param[in]      file       file of in-line timing command
 * @param[in]      comment    comment to 
 **/
void time_it_insert_time(timeit_t *t, double time, 
        unsigned int st_line, unsigned int en_line, 
        const char *func, const char *file, const char *comment)
{
#ifdef _TIMING_DATA
    if (t == NULL)
        return;

    if (t->tic_no_toc) {
        fprintf(stdout, "WARNING at line %d in %s: %s\n", st_line, file, 
                "Insert over TIC aborted.");
        fflush(stdout);
        return;
    }
    if (t->idx >= t->data_sz) {
        fprintf(stdout, "WARNING at line %d in %s: %s\n", st_line, file, 
                "MAX_TIMER limit reached, bad things are about to happen.");
        fflush(stdout);
        t->data_sz *= 2;
        t->data = (struct time_it_timer_data*) 
            realloc(t->data, sizeof(struct time_it_timer_data)*(t->data_sz));
    }
    t->data[t->idx].st_line = st_line;
    t->data[t->idx].en_line = en_line;
    t->data[t->idx].time = time;
    t->data[t->idx].func = func;
    t->data[t->idx].file = file;
    t->data[t->idx].comment = comment;
    t->idx++;
#endif
}


/**
 * @brief Starts collecting a single timing record.
 *
 * @param[in]      t          global list of timing records
 * @param[in]      st_line    starting line of in-line timing command
 **/
void time_it_start_timer(timeit_t *t, int st_line) 
{
#ifdef _TIMING_DATA
    if(t == NULL)
        return;
    /* Don't reset the start time before recording a stop time */
    if(t->tic_no_toc){
        fprintf(stdout, "WARNING at line %d: %s.\n", st_line,
                "Double TIC called, most recent TIC aborted");
        fflush(stdout);
        return;
    }

    t->tic_no_toc = 1;
    t->data[t->idx].st_line = st_line;
    gettimeofday(&(t->tv_start), NULL);
#endif
}


/**
 * @brief Finishes a single timing record.
 *
 * @param[in]      t          global list of timing records
 * @param[in]      en_line    ending line of in-line timing command
 * @param[in]      func       function name holding in-line timing command
 * @param[in]      file       file of in-line timing command
 * @param[in]      comment    comment to  
 **/
void time_it_stop_timer(timeit_t *t, unsigned int en_line, 
        const char *func, const char *file, const char *comment)
{
#ifdef _TIMING_DATA
    if (t == NULL)
        return;

    // Don't calculate the stop time with invalid start time
    if(!t->tic_no_toc){
        fprintf(stdout, "WARNING at line %d: %s\n", en_line,
                "Double TOC call aborted. TIC must occur first.");
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
    if (t->idx >= t->data_sz) {
        printf("WARNING at line %d in %s: %s\n", en_line, file,
               "MAX_TIMER limit reached, bad things are about to happen.");
        fflush(stdout);
        t->data_sz *= 2;
        t->data = (struct time_it_timer_data*)
            realloc(t->data, sizeof(struct time_it_timer_data)*(t->data_sz));
    }
#endif
}


/**
 * @brief Outputs collected timing records to CSV file.
 *
 * @param[in]      file_name  name of the output file
 * @param[in]      mode       mode used to open the output file
 **/
int time_it_write_csv(const char *file_name, const char *mode)
{
#ifdef _TIMING_DATA
    timeit_t *t = time_it_ptr;
    int i, rc = 0;
    FILE *f = NULL;
    time_t curtime;
    struct tm *loctime;

    if (t == NULL)
        return 0;
    if (strncmp(mode,"w",1) && strncmp(mode,"a",1))
        goto cleanup;
    if ((f = fopen(file_name, mode)) == NULL)
        goto cleanup;

    for(i = 0; i < t->idx; i++) {
        fprintf(f, "%s\t", t->data[i].comment);
    }
    fprintf(f, "HEAD\tGET\tPUT\tCOPY\tLIST\tPOST\tMetadata\tTimestamp\n");

    for(i = 0; i < t->idx; i++){
        fprintf(f, "%.7lf\t", t->data[i].time);
    }
    curtime = time(NULL);
    loctime = localtime(&curtime);
    fprintf(f, "%u\t%u\t%u\t%u\t%u\t%u\t%s\t%s", 
               t->heads, t->gets, t->puts, t->copys, t->lists, 
               t->posts, t->meta, asctime(loctime));
    fclose(f); 
    rc = 1;

cleanup:
    return rc;
#else
    return 0;
#endif
}
