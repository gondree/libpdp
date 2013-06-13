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
#ifndef __TIME_IT_H__
#define __TIME_IT_H__

#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <sys/stat.h>
#include <string.h>
#include <unistd.h>
#include <time.h>

#define MAX_TIMERS   16384 ///< Total size of global list for timing records
#define MAX_CSV_CELL 4096  ///< Length of CSV cell header metadata string

/// A single timing record, from TIC to TOC 
struct time_it_timer_data {
    double time;
    const char *func;
    unsigned int st_line;
    unsigned int en_line;
    const char *file;
    const char *comment;
};

/// All timing results and bookkeeping 
typedef struct {
    char *meta;
    unsigned int idx;
    unsigned short tic_no_toc;
    struct timeval tv_start;
    struct timeval tv_stop;
    unsigned int heads;
    unsigned int gets;
    unsigned int puts;
    unsigned int posts;
    unsigned int lists;
    unsigned int copys;
    unsigned int data_sz;
    struct time_it_timer_data *data;
} timeit_t;

extern timeit_t* time_it_ptr;

/*
 * function prototypes
 */
void time_it_insert_time(timeit_t *t, double time, unsigned int st_line, 
                         unsigned int en_line, const char *func, 
                         const char *file, const char *comment);
void time_it_start_timer(timeit_t *t, int st_line);
void time_it_stop_timer(timeit_t *t, unsigned int en_line, const char *func, 
                        const char *file, const char *comment);
int time_it_write_csv(const char *file_name, const char *mode);
void time_it_init(void);
void time_it_cleanup(void);



#ifdef _TIMING_DATA
// timing macros --------------------------------------------------------------
#define TIC { time_it_start_timer(time_it_ptr, __LINE__); }
#define TOC(comment) { \
    time_it_stop_timer(time_it_ptr, __LINE__, __func__, __FILE__, comment); \
}
#define TIME_IT_INSERT(time, comment) { \
    time_it_insert_time(time_it_ptr, time, __LINE__, __LINE__, \
                        __func__, __FILE__, comment); \
} 
#define PRINT_TIME { \
    struct time_it_timeit_t_data cur = \
            time_it_ptr->data[(time_it_ptr->idx)-1]; \
    printf("%lf sec, at %s:%d-%d in %s\n", \
            cur.time, cur.file, cur.st_line, cur.en_line, cur.func); \
};
#define PRINT_ALL_TIMES { \
    int __i; \
    struct time_it_timeit_t_data cur = {0}; \
    printf("\n\n====== TIMES ======\n"); \
    for(__i = 0; __i < time_it_ptr->idx; __i++){ \
        cur = time_it_ptr->data[__i]; \
        printf("%s:%d-%d in %s :: %lf :: %s\n", \
                cur.file, cur.st_line, cur.en_line, \
                cur.func, cur.time, cur.comment); \
    } \
    printf("===================\n"); \
};
#define TIME_IT_ADD_META(meta) { \
    if(time_it_ptr) time_it_ptr->meta = meta; \
}
#define INC_PUTS { if(time_it_ptr) (time_it_ptr->puts)++; }
#define INC_GETS { if(time_it_ptr) (time_it_ptr->gets)++; }
#define INC_LISTS { if(time_it_ptr) (time_it_ptr->lists)++; }
#define INC_COPYS { if(time_it_ptr) (time_it_ptr->copys)++; }
#define INC_POSTS { if(time_it_ptr) (time_it_ptr->posts)++; }
#define INC_HEADS { if(time_it_ptr) (time_it_ptr->heads)++; }

#else // timing stubs ---------------------------------------------------------
#define TIC
#define TOC(x)
#define PRINT_TIME
#define PRINT_ALL_TIMES
#define TIME_IT_ADD_META(meta) 
#define INC_PUTS \
; 
#define INC_GETS \
;
#define INC_LISTS \
;
#define INC_COPYS \
;
#define INC_POSTS \
;
#define INC_HEADS \
;

#endif //_TIMING_DATA
#endif //__TIME_IT_H__
