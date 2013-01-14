# 1 "./src/request.c"
# 1 "<command-line>"
# 1 "./src/request.c"
# 27 "./src/request.c"
# 1 "/usr/include/ctype.h" 1 3 4
# 27 "/usr/include/ctype.h" 3 4
# 1 "/usr/include/features.h" 1 3 4
# 362 "/usr/include/features.h" 3 4
# 1 "/usr/include/sys/cdefs.h" 1 3 4
# 390 "/usr/include/sys/cdefs.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 391 "/usr/include/sys/cdefs.h" 2 3 4
# 363 "/usr/include/features.h" 2 3 4
# 386 "/usr/include/features.h" 3 4
# 1 "/usr/include/gnu/stubs.h" 1 3 4



# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 5 "/usr/include/gnu/stubs.h" 2 3 4




# 1 "/usr/include/gnu/stubs-64.h" 1 3 4
# 10 "/usr/include/gnu/stubs.h" 2 3 4
# 387 "/usr/include/features.h" 2 3 4
# 28 "/usr/include/ctype.h" 2 3 4
# 1 "/usr/include/bits/types.h" 1 3 4
# 28 "/usr/include/bits/types.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 29 "/usr/include/bits/types.h" 2 3 4


typedef unsigned char __u_char;
typedef unsigned short int __u_short;
typedef unsigned int __u_int;
typedef unsigned long int __u_long;


typedef signed char __int8_t;
typedef unsigned char __uint8_t;
typedef signed short int __int16_t;
typedef unsigned short int __uint16_t;
typedef signed int __int32_t;
typedef unsigned int __uint32_t;

typedef signed long int __int64_t;
typedef unsigned long int __uint64_t;







typedef long int __quad_t;
typedef unsigned long int __u_quad_t;
# 131 "/usr/include/bits/types.h" 3 4
# 1 "/usr/include/bits/typesizes.h" 1 3 4
# 132 "/usr/include/bits/types.h" 2 3 4


typedef unsigned long int __dev_t;
typedef unsigned int __uid_t;
typedef unsigned int __gid_t;
typedef unsigned long int __ino_t;
typedef unsigned long int __ino64_t;
typedef unsigned int __mode_t;
typedef unsigned long int __nlink_t;
typedef long int __off_t;
typedef long int __off64_t;
typedef int __pid_t;
typedef struct { int __val[2]; } __fsid_t;
typedef long int __clock_t;
typedef unsigned long int __rlim_t;
typedef unsigned long int __rlim64_t;
typedef unsigned int __id_t;
typedef long int __time_t;
typedef unsigned int __useconds_t;
typedef long int __suseconds_t;

typedef int __daddr_t;
typedef long int __swblk_t;
typedef int __key_t;


typedef int __clockid_t;


typedef void * __timer_t;


typedef long int __blksize_t;




typedef long int __blkcnt_t;
typedef long int __blkcnt64_t;


typedef unsigned long int __fsblkcnt_t;
typedef unsigned long int __fsblkcnt64_t;


typedef unsigned long int __fsfilcnt_t;
typedef unsigned long int __fsfilcnt64_t;

typedef long int __ssize_t;



typedef __off64_t __loff_t;
typedef __quad_t *__qaddr_t;
typedef char *__caddr_t;


typedef long int __intptr_t;


typedef unsigned int __socklen_t;
# 29 "/usr/include/ctype.h" 2 3 4


# 41 "/usr/include/ctype.h" 3 4
# 1 "/usr/include/endian.h" 1 3 4
# 37 "/usr/include/endian.h" 3 4
# 1 "/usr/include/bits/endian.h" 1 3 4
# 38 "/usr/include/endian.h" 2 3 4
# 61 "/usr/include/endian.h" 3 4
# 1 "/usr/include/bits/byteswap.h" 1 3 4
# 28 "/usr/include/bits/byteswap.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 29 "/usr/include/bits/byteswap.h" 2 3 4
# 62 "/usr/include/endian.h" 2 3 4
# 42 "/usr/include/ctype.h" 2 3 4






enum
{
  _ISupper = ((0) < 8 ? ((1 << (0)) << 8) : ((1 << (0)) >> 8)),
  _ISlower = ((1) < 8 ? ((1 << (1)) << 8) : ((1 << (1)) >> 8)),
  _ISalpha = ((2) < 8 ? ((1 << (2)) << 8) : ((1 << (2)) >> 8)),
  _ISdigit = ((3) < 8 ? ((1 << (3)) << 8) : ((1 << (3)) >> 8)),
  _ISxdigit = ((4) < 8 ? ((1 << (4)) << 8) : ((1 << (4)) >> 8)),
  _ISspace = ((5) < 8 ? ((1 << (5)) << 8) : ((1 << (5)) >> 8)),
  _ISprint = ((6) < 8 ? ((1 << (6)) << 8) : ((1 << (6)) >> 8)),
  _ISgraph = ((7) < 8 ? ((1 << (7)) << 8) : ((1 << (7)) >> 8)),
  _ISblank = ((8) < 8 ? ((1 << (8)) << 8) : ((1 << (8)) >> 8)),
  _IScntrl = ((9) < 8 ? ((1 << (9)) << 8) : ((1 << (9)) >> 8)),
  _ISpunct = ((10) < 8 ? ((1 << (10)) << 8) : ((1 << (10)) >> 8)),
  _ISalnum = ((11) < 8 ? ((1 << (11)) << 8) : ((1 << (11)) >> 8))
};
# 81 "/usr/include/ctype.h" 3 4
extern __const unsigned short int **__ctype_b_loc (void)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const));
extern __const __int32_t **__ctype_tolower_loc (void)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const));
extern __const __int32_t **__ctype_toupper_loc (void)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const));
# 106 "/usr/include/ctype.h" 3 4






extern int isalnum (int) __attribute__ ((__nothrow__ , __leaf__));
extern int isalpha (int) __attribute__ ((__nothrow__ , __leaf__));
extern int iscntrl (int) __attribute__ ((__nothrow__ , __leaf__));
extern int isdigit (int) __attribute__ ((__nothrow__ , __leaf__));
extern int islower (int) __attribute__ ((__nothrow__ , __leaf__));
extern int isgraph (int) __attribute__ ((__nothrow__ , __leaf__));
extern int isprint (int) __attribute__ ((__nothrow__ , __leaf__));
extern int ispunct (int) __attribute__ ((__nothrow__ , __leaf__));
extern int isspace (int) __attribute__ ((__nothrow__ , __leaf__));
extern int isupper (int) __attribute__ ((__nothrow__ , __leaf__));
extern int isxdigit (int) __attribute__ ((__nothrow__ , __leaf__));



extern int tolower (int __c) __attribute__ ((__nothrow__ , __leaf__));


extern int toupper (int __c) __attribute__ ((__nothrow__ , __leaf__));








extern int isblank (int) __attribute__ ((__nothrow__ , __leaf__));


# 152 "/usr/include/ctype.h" 3 4
extern int isascii (int __c) __attribute__ ((__nothrow__ , __leaf__));



extern int toascii (int __c) __attribute__ ((__nothrow__ , __leaf__));



extern int _toupper (int) __attribute__ ((__nothrow__ , __leaf__));
extern int _tolower (int) __attribute__ ((__nothrow__ , __leaf__));
# 259 "/usr/include/ctype.h" 3 4
# 1 "/usr/include/xlocale.h" 1 3 4
# 28 "/usr/include/xlocale.h" 3 4
typedef struct __locale_struct
{

  struct __locale_data *__locales[13];


  const unsigned short int *__ctype_b;
  const int *__ctype_tolower;
  const int *__ctype_toupper;


  const char *__names[13];
} *__locale_t;


typedef __locale_t locale_t;
# 260 "/usr/include/ctype.h" 2 3 4
# 273 "/usr/include/ctype.h" 3 4
extern int isalnum_l (int, __locale_t) __attribute__ ((__nothrow__ , __leaf__));
extern int isalpha_l (int, __locale_t) __attribute__ ((__nothrow__ , __leaf__));
extern int iscntrl_l (int, __locale_t) __attribute__ ((__nothrow__ , __leaf__));
extern int isdigit_l (int, __locale_t) __attribute__ ((__nothrow__ , __leaf__));
extern int islower_l (int, __locale_t) __attribute__ ((__nothrow__ , __leaf__));
extern int isgraph_l (int, __locale_t) __attribute__ ((__nothrow__ , __leaf__));
extern int isprint_l (int, __locale_t) __attribute__ ((__nothrow__ , __leaf__));
extern int ispunct_l (int, __locale_t) __attribute__ ((__nothrow__ , __leaf__));
extern int isspace_l (int, __locale_t) __attribute__ ((__nothrow__ , __leaf__));
extern int isupper_l (int, __locale_t) __attribute__ ((__nothrow__ , __leaf__));
extern int isxdigit_l (int, __locale_t) __attribute__ ((__nothrow__ , __leaf__));

extern int isblank_l (int, __locale_t) __attribute__ ((__nothrow__ , __leaf__));



extern int __tolower_l (int __c, __locale_t __l) __attribute__ ((__nothrow__ , __leaf__));
extern int tolower_l (int __c, __locale_t __l) __attribute__ ((__nothrow__ , __leaf__));


extern int __toupper_l (int __c, __locale_t __l) __attribute__ ((__nothrow__ , __leaf__));
extern int toupper_l (int __c, __locale_t __l) __attribute__ ((__nothrow__ , __leaf__));
# 349 "/usr/include/ctype.h" 3 4

# 28 "./src/request.c" 2
# 1 "/usr/include/pthread.h" 1 3 4
# 25 "/usr/include/pthread.h" 3 4
# 1 "/usr/include/sched.h" 1 3 4
# 30 "/usr/include/sched.h" 3 4
# 1 "/usr/lib/gcc/x86_64-redhat-linux/4.7.0/include/stddef.h" 1 3 4
# 213 "/usr/lib/gcc/x86_64-redhat-linux/4.7.0/include/stddef.h" 3 4
typedef long unsigned int size_t;
# 31 "/usr/include/sched.h" 2 3 4



# 1 "/usr/include/time.h" 1 3 4
# 74 "/usr/include/time.h" 3 4


typedef __time_t time_t;



# 120 "/usr/include/time.h" 3 4
struct timespec
  {
    __time_t tv_sec;
    long int tv_nsec;
  };
# 35 "/usr/include/sched.h" 2 3 4


typedef __pid_t pid_t;





# 1 "/usr/include/bits/sched.h" 1 3 4
# 74 "/usr/include/bits/sched.h" 3 4
struct sched_param
  {
    int __sched_priority;
  };


# 97 "/usr/include/bits/sched.h" 3 4








struct __sched_param
  {
    int __sched_priority;
  };
# 120 "/usr/include/bits/sched.h" 3 4
typedef unsigned long int __cpu_mask;






typedef struct
{
  __cpu_mask __bits[1024 / (8 * sizeof (__cpu_mask))];
} cpu_set_t;
# 203 "/usr/include/bits/sched.h" 3 4


extern int __sched_cpucount (size_t __setsize, const cpu_set_t *__setp)
  __attribute__ ((__nothrow__ , __leaf__));
extern cpu_set_t *__sched_cpualloc (size_t __count) __attribute__ ((__nothrow__ , __leaf__)) ;
extern void __sched_cpufree (cpu_set_t *__set) __attribute__ ((__nothrow__ , __leaf__));


# 44 "/usr/include/sched.h" 2 3 4







extern int sched_setparam (__pid_t __pid, __const struct sched_param *__param)
     __attribute__ ((__nothrow__ , __leaf__));


extern int sched_getparam (__pid_t __pid, struct sched_param *__param) __attribute__ ((__nothrow__ , __leaf__));


extern int sched_setscheduler (__pid_t __pid, int __policy,
          __const struct sched_param *__param) __attribute__ ((__nothrow__ , __leaf__));


extern int sched_getscheduler (__pid_t __pid) __attribute__ ((__nothrow__ , __leaf__));


extern int sched_yield (void) __attribute__ ((__nothrow__ , __leaf__));


extern int sched_get_priority_max (int __algorithm) __attribute__ ((__nothrow__ , __leaf__));


extern int sched_get_priority_min (int __algorithm) __attribute__ ((__nothrow__ , __leaf__));


extern int sched_rr_get_interval (__pid_t __pid, struct timespec *__t) __attribute__ ((__nothrow__ , __leaf__));
# 126 "/usr/include/sched.h" 3 4

# 26 "/usr/include/pthread.h" 2 3 4
# 1 "/usr/include/time.h" 1 3 4
# 30 "/usr/include/time.h" 3 4








# 1 "/usr/lib/gcc/x86_64-redhat-linux/4.7.0/include/stddef.h" 1 3 4
# 39 "/usr/include/time.h" 2 3 4



# 1 "/usr/include/bits/time.h" 1 3 4
# 43 "/usr/include/time.h" 2 3 4
# 58 "/usr/include/time.h" 3 4


typedef __clock_t clock_t;



# 92 "/usr/include/time.h" 3 4
typedef __clockid_t clockid_t;
# 104 "/usr/include/time.h" 3 4
typedef __timer_t timer_t;
# 131 "/usr/include/time.h" 3 4


struct tm
{
  int tm_sec;
  int tm_min;
  int tm_hour;
  int tm_mday;
  int tm_mon;
  int tm_year;
  int tm_wday;
  int tm_yday;
  int tm_isdst;


  long int tm_gmtoff;
  __const char *tm_zone;




};








struct itimerspec
  {
    struct timespec it_interval;
    struct timespec it_value;
  };


struct sigevent;
# 180 "/usr/include/time.h" 3 4



extern clock_t clock (void) __attribute__ ((__nothrow__ , __leaf__));


extern time_t time (time_t *__timer) __attribute__ ((__nothrow__ , __leaf__));


extern double difftime (time_t __time1, time_t __time0)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__));


extern time_t mktime (struct tm *__tp) __attribute__ ((__nothrow__ , __leaf__));





extern size_t strftime (char *__restrict __s, size_t __maxsize,
   __const char *__restrict __format,
   __const struct tm *__restrict __tp) __attribute__ ((__nothrow__ , __leaf__));

# 217 "/usr/include/time.h" 3 4
extern size_t strftime_l (char *__restrict __s, size_t __maxsize,
     __const char *__restrict __format,
     __const struct tm *__restrict __tp,
     __locale_t __loc) __attribute__ ((__nothrow__ , __leaf__));
# 230 "/usr/include/time.h" 3 4



extern struct tm *gmtime (__const time_t *__timer) __attribute__ ((__nothrow__ , __leaf__));



extern struct tm *localtime (__const time_t *__timer) __attribute__ ((__nothrow__ , __leaf__));





extern struct tm *gmtime_r (__const time_t *__restrict __timer,
       struct tm *__restrict __tp) __attribute__ ((__nothrow__ , __leaf__));



extern struct tm *localtime_r (__const time_t *__restrict __timer,
          struct tm *__restrict __tp) __attribute__ ((__nothrow__ , __leaf__));





extern char *asctime (__const struct tm *__tp) __attribute__ ((__nothrow__ , __leaf__));


extern char *ctime (__const time_t *__timer) __attribute__ ((__nothrow__ , __leaf__));







extern char *asctime_r (__const struct tm *__restrict __tp,
   char *__restrict __buf) __attribute__ ((__nothrow__ , __leaf__));


extern char *ctime_r (__const time_t *__restrict __timer,
        char *__restrict __buf) __attribute__ ((__nothrow__ , __leaf__));




extern char *__tzname[2];
extern int __daylight;
extern long int __timezone;




extern char *tzname[2];



extern void tzset (void) __attribute__ ((__nothrow__ , __leaf__));



extern int daylight;
extern long int timezone;





extern int stime (__const time_t *__when) __attribute__ ((__nothrow__ , __leaf__));
# 313 "/usr/include/time.h" 3 4
extern time_t timegm (struct tm *__tp) __attribute__ ((__nothrow__ , __leaf__));


extern time_t timelocal (struct tm *__tp) __attribute__ ((__nothrow__ , __leaf__));


extern int dysize (int __year) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__));
# 328 "/usr/include/time.h" 3 4
extern int nanosleep (__const struct timespec *__requested_time,
        struct timespec *__remaining);



extern int clock_getres (clockid_t __clock_id, struct timespec *__res) __attribute__ ((__nothrow__ , __leaf__));


extern int clock_gettime (clockid_t __clock_id, struct timespec *__tp) __attribute__ ((__nothrow__ , __leaf__));


extern int clock_settime (clockid_t __clock_id, __const struct timespec *__tp)
     __attribute__ ((__nothrow__ , __leaf__));






extern int clock_nanosleep (clockid_t __clock_id, int __flags,
       __const struct timespec *__req,
       struct timespec *__rem);


extern int clock_getcpuclockid (pid_t __pid, clockid_t *__clock_id) __attribute__ ((__nothrow__ , __leaf__));




extern int timer_create (clockid_t __clock_id,
    struct sigevent *__restrict __evp,
    timer_t *__restrict __timerid) __attribute__ ((__nothrow__ , __leaf__));


extern int timer_delete (timer_t __timerid) __attribute__ ((__nothrow__ , __leaf__));


extern int timer_settime (timer_t __timerid, int __flags,
     __const struct itimerspec *__restrict __value,
     struct itimerspec *__restrict __ovalue) __attribute__ ((__nothrow__ , __leaf__));


extern int timer_gettime (timer_t __timerid, struct itimerspec *__value)
     __attribute__ ((__nothrow__ , __leaf__));


extern int timer_getoverrun (timer_t __timerid) __attribute__ ((__nothrow__ , __leaf__));
# 417 "/usr/include/time.h" 3 4

# 27 "/usr/include/pthread.h" 2 3 4

# 1 "/usr/include/bits/pthreadtypes.h" 1 3 4
# 23 "/usr/include/bits/pthreadtypes.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 24 "/usr/include/bits/pthreadtypes.h" 2 3 4
# 50 "/usr/include/bits/pthreadtypes.h" 3 4
typedef unsigned long int pthread_t;


typedef union
{
  char __size[56];
  long int __align;
} pthread_attr_t;



typedef struct __pthread_internal_list
{
  struct __pthread_internal_list *__prev;
  struct __pthread_internal_list *__next;
} __pthread_list_t;
# 76 "/usr/include/bits/pthreadtypes.h" 3 4
typedef union
{
  struct __pthread_mutex_s
  {
    int __lock;
    unsigned int __count;
    int __owner;

    unsigned int __nusers;



    int __kind;

    int __spins;
    __pthread_list_t __list;
# 101 "/usr/include/bits/pthreadtypes.h" 3 4
  } __data;
  char __size[40];
  long int __align;
} pthread_mutex_t;

typedef union
{
  char __size[4];
  int __align;
} pthread_mutexattr_t;




typedef union
{
  struct
  {
    int __lock;
    unsigned int __futex;
    __extension__ unsigned long long int __total_seq;
    __extension__ unsigned long long int __wakeup_seq;
    __extension__ unsigned long long int __woken_seq;
    void *__mutex;
    unsigned int __nwaiters;
    unsigned int __broadcast_seq;
  } __data;
  char __size[48];
  __extension__ long long int __align;
} pthread_cond_t;

typedef union
{
  char __size[4];
  int __align;
} pthread_condattr_t;



typedef unsigned int pthread_key_t;



typedef int pthread_once_t;





typedef union
{

  struct
  {
    int __lock;
    unsigned int __nr_readers;
    unsigned int __readers_wakeup;
    unsigned int __writer_wakeup;
    unsigned int __nr_readers_queued;
    unsigned int __nr_writers_queued;
    int __writer;
    int __shared;
    unsigned long int __pad1;
    unsigned long int __pad2;


    unsigned int __flags;
  } __data;
# 187 "/usr/include/bits/pthreadtypes.h" 3 4
  char __size[56];
  long int __align;
} pthread_rwlock_t;

typedef union
{
  char __size[8];
  long int __align;
} pthread_rwlockattr_t;





typedef volatile int pthread_spinlock_t;




typedef union
{
  char __size[32];
  long int __align;
} pthread_barrier_t;

typedef union
{
  char __size[4];
  int __align;
} pthread_barrierattr_t;
# 29 "/usr/include/pthread.h" 2 3 4
# 1 "/usr/include/bits/setjmp.h" 1 3 4
# 27 "/usr/include/bits/setjmp.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 28 "/usr/include/bits/setjmp.h" 2 3 4




typedef long int __jmp_buf[8];
# 30 "/usr/include/pthread.h" 2 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 31 "/usr/include/pthread.h" 2 3 4



enum
{
  PTHREAD_CREATE_JOINABLE,

  PTHREAD_CREATE_DETACHED

};



enum
{
  PTHREAD_MUTEX_TIMED_NP,
  PTHREAD_MUTEX_RECURSIVE_NP,
  PTHREAD_MUTEX_ERRORCHECK_NP,
  PTHREAD_MUTEX_ADAPTIVE_NP

  ,
  PTHREAD_MUTEX_NORMAL = PTHREAD_MUTEX_TIMED_NP,
  PTHREAD_MUTEX_RECURSIVE = PTHREAD_MUTEX_RECURSIVE_NP,
  PTHREAD_MUTEX_ERRORCHECK = PTHREAD_MUTEX_ERRORCHECK_NP,
  PTHREAD_MUTEX_DEFAULT = PTHREAD_MUTEX_NORMAL





};




enum
{
  PTHREAD_MUTEX_STALLED,
  PTHREAD_MUTEX_STALLED_NP = PTHREAD_MUTEX_STALLED,
  PTHREAD_MUTEX_ROBUST,
  PTHREAD_MUTEX_ROBUST_NP = PTHREAD_MUTEX_ROBUST
};
# 115 "/usr/include/pthread.h" 3 4
enum
{
  PTHREAD_RWLOCK_PREFER_READER_NP,
  PTHREAD_RWLOCK_PREFER_WRITER_NP,
  PTHREAD_RWLOCK_PREFER_WRITER_NONRECURSIVE_NP,
  PTHREAD_RWLOCK_DEFAULT_NP = PTHREAD_RWLOCK_PREFER_READER_NP
};
# 147 "/usr/include/pthread.h" 3 4
enum
{
  PTHREAD_INHERIT_SCHED,

  PTHREAD_EXPLICIT_SCHED

};



enum
{
  PTHREAD_SCOPE_SYSTEM,

  PTHREAD_SCOPE_PROCESS

};



enum
{
  PTHREAD_PROCESS_PRIVATE,

  PTHREAD_PROCESS_SHARED

};
# 182 "/usr/include/pthread.h" 3 4
struct _pthread_cleanup_buffer
{
  void (*__routine) (void *);
  void *__arg;
  int __canceltype;
  struct _pthread_cleanup_buffer *__prev;
};


enum
{
  PTHREAD_CANCEL_ENABLE,

  PTHREAD_CANCEL_DISABLE

};
enum
{
  PTHREAD_CANCEL_DEFERRED,

  PTHREAD_CANCEL_ASYNCHRONOUS

};
# 220 "/usr/include/pthread.h" 3 4





extern int pthread_create (pthread_t *__restrict __newthread,
      __const pthread_attr_t *__restrict __attr,
      void *(*__start_routine) (void *),
      void *__restrict __arg) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 3)));





extern void pthread_exit (void *__retval) __attribute__ ((__noreturn__));







extern int pthread_join (pthread_t __th, void **__thread_return);
# 263 "/usr/include/pthread.h" 3 4
extern int pthread_detach (pthread_t __th) __attribute__ ((__nothrow__ , __leaf__));



extern pthread_t pthread_self (void) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__));


extern int pthread_equal (pthread_t __thread1, pthread_t __thread2) __attribute__ ((__nothrow__ , __leaf__));







extern int pthread_attr_init (pthread_attr_t *__attr) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern int pthread_attr_destroy (pthread_attr_t *__attr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern int pthread_attr_getdetachstate (__const pthread_attr_t *__attr,
     int *__detachstate)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern int pthread_attr_setdetachstate (pthread_attr_t *__attr,
     int __detachstate)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));



extern int pthread_attr_getguardsize (__const pthread_attr_t *__attr,
          size_t *__guardsize)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern int pthread_attr_setguardsize (pthread_attr_t *__attr,
          size_t __guardsize)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));



extern int pthread_attr_getschedparam (__const pthread_attr_t *__restrict
           __attr,
           struct sched_param *__restrict __param)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern int pthread_attr_setschedparam (pthread_attr_t *__restrict __attr,
           __const struct sched_param *__restrict
           __param) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern int pthread_attr_getschedpolicy (__const pthread_attr_t *__restrict
     __attr, int *__restrict __policy)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern int pthread_attr_setschedpolicy (pthread_attr_t *__attr, int __policy)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern int pthread_attr_getinheritsched (__const pthread_attr_t *__restrict
      __attr, int *__restrict __inherit)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern int pthread_attr_setinheritsched (pthread_attr_t *__attr,
      int __inherit)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));



extern int pthread_attr_getscope (__const pthread_attr_t *__restrict __attr,
      int *__restrict __scope)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern int pthread_attr_setscope (pthread_attr_t *__attr, int __scope)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern int pthread_attr_getstackaddr (__const pthread_attr_t *__restrict
          __attr, void **__restrict __stackaddr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2))) __attribute__ ((__deprecated__));





extern int pthread_attr_setstackaddr (pthread_attr_t *__attr,
          void *__stackaddr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) __attribute__ ((__deprecated__));


extern int pthread_attr_getstacksize (__const pthread_attr_t *__restrict
          __attr, size_t *__restrict __stacksize)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));




extern int pthread_attr_setstacksize (pthread_attr_t *__attr,
          size_t __stacksize)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));



extern int pthread_attr_getstack (__const pthread_attr_t *__restrict __attr,
      void **__restrict __stackaddr,
      size_t *__restrict __stacksize)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2, 3)));




extern int pthread_attr_setstack (pthread_attr_t *__attr, void *__stackaddr,
      size_t __stacksize) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));
# 413 "/usr/include/pthread.h" 3 4
extern int pthread_setschedparam (pthread_t __target_thread, int __policy,
      __const struct sched_param *__param)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3)));


extern int pthread_getschedparam (pthread_t __target_thread,
      int *__restrict __policy,
      struct sched_param *__restrict __param)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 3)));


extern int pthread_setschedprio (pthread_t __target_thread, int __prio)
     __attribute__ ((__nothrow__ , __leaf__));
# 478 "/usr/include/pthread.h" 3 4
extern int pthread_once (pthread_once_t *__once_control,
    void (*__init_routine) (void)) __attribute__ ((__nonnull__ (1, 2)));
# 490 "/usr/include/pthread.h" 3 4
extern int pthread_setcancelstate (int __state, int *__oldstate);



extern int pthread_setcanceltype (int __type, int *__oldtype);


extern int pthread_cancel (pthread_t __th);




extern void pthread_testcancel (void);




typedef struct
{
  struct
  {
    __jmp_buf __cancel_jmp_buf;
    int __mask_was_saved;
  } __cancel_jmp_buf[1];
  void *__pad[4];
} __pthread_unwind_buf_t __attribute__ ((__aligned__));
# 524 "/usr/include/pthread.h" 3 4
struct __pthread_cleanup_frame
{
  void (*__cancel_routine) (void *);
  void *__cancel_arg;
  int __do_it;
  int __cancel_type;
};
# 664 "/usr/include/pthread.h" 3 4
extern void __pthread_register_cancel (__pthread_unwind_buf_t *__buf)
     ;
# 676 "/usr/include/pthread.h" 3 4
extern void __pthread_unregister_cancel (__pthread_unwind_buf_t *__buf)
  ;
# 717 "/usr/include/pthread.h" 3 4
extern void __pthread_unwind_next (__pthread_unwind_buf_t *__buf)
     __attribute__ ((__noreturn__))

     __attribute__ ((__weak__))

     ;



struct __jmp_buf_tag;
extern int __sigsetjmp (struct __jmp_buf_tag *__env, int __savemask) __attribute__ ((__nothrow__ , __leaf__));





extern int pthread_mutex_init (pthread_mutex_t *__mutex,
          __const pthread_mutexattr_t *__mutexattr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern int pthread_mutex_destroy (pthread_mutex_t *__mutex)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern int pthread_mutex_trylock (pthread_mutex_t *__mutex)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));


extern int pthread_mutex_lock (pthread_mutex_t *__mutex)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));



extern int pthread_mutex_timedlock (pthread_mutex_t *__restrict __mutex,
        __const struct timespec *__restrict
        __abstime) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));



extern int pthread_mutex_unlock (pthread_mutex_t *__mutex)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));



extern int pthread_mutex_getprioceiling (__const pthread_mutex_t *
      __restrict __mutex,
      int *__restrict __prioceiling)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));



extern int pthread_mutex_setprioceiling (pthread_mutex_t *__restrict __mutex,
      int __prioceiling,
      int *__restrict __old_ceiling)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 3)));




extern int pthread_mutex_consistent (pthread_mutex_t *__mutex)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));
# 790 "/usr/include/pthread.h" 3 4
extern int pthread_mutexattr_init (pthread_mutexattr_t *__attr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern int pthread_mutexattr_destroy (pthread_mutexattr_t *__attr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern int pthread_mutexattr_getpshared (__const pthread_mutexattr_t *
      __restrict __attr,
      int *__restrict __pshared)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern int pthread_mutexattr_setpshared (pthread_mutexattr_t *__attr,
      int __pshared)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));



extern int pthread_mutexattr_gettype (__const pthread_mutexattr_t *__restrict
          __attr, int *__restrict __kind)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));




extern int pthread_mutexattr_settype (pthread_mutexattr_t *__attr, int __kind)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));



extern int pthread_mutexattr_getprotocol (__const pthread_mutexattr_t *
       __restrict __attr,
       int *__restrict __protocol)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));



extern int pthread_mutexattr_setprotocol (pthread_mutexattr_t *__attr,
       int __protocol)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern int pthread_mutexattr_getprioceiling (__const pthread_mutexattr_t *
          __restrict __attr,
          int *__restrict __prioceiling)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern int pthread_mutexattr_setprioceiling (pthread_mutexattr_t *__attr,
          int __prioceiling)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));



extern int pthread_mutexattr_getrobust (__const pthread_mutexattr_t *__attr,
     int *__robustness)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));







extern int pthread_mutexattr_setrobust (pthread_mutexattr_t *__attr,
     int __robustness)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));
# 872 "/usr/include/pthread.h" 3 4
extern int pthread_rwlock_init (pthread_rwlock_t *__restrict __rwlock,
    __const pthread_rwlockattr_t *__restrict
    __attr) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern int pthread_rwlock_destroy (pthread_rwlock_t *__rwlock)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern int pthread_rwlock_rdlock (pthread_rwlock_t *__rwlock)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));


extern int pthread_rwlock_tryrdlock (pthread_rwlock_t *__rwlock)
  __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));



extern int pthread_rwlock_timedrdlock (pthread_rwlock_t *__restrict __rwlock,
           __const struct timespec *__restrict
           __abstime) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));



extern int pthread_rwlock_wrlock (pthread_rwlock_t *__rwlock)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));


extern int pthread_rwlock_trywrlock (pthread_rwlock_t *__rwlock)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));



extern int pthread_rwlock_timedwrlock (pthread_rwlock_t *__restrict __rwlock,
           __const struct timespec *__restrict
           __abstime) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));



extern int pthread_rwlock_unlock (pthread_rwlock_t *__rwlock)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));





extern int pthread_rwlockattr_init (pthread_rwlockattr_t *__attr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern int pthread_rwlockattr_destroy (pthread_rwlockattr_t *__attr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern int pthread_rwlockattr_getpshared (__const pthread_rwlockattr_t *
       __restrict __attr,
       int *__restrict __pshared)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern int pthread_rwlockattr_setpshared (pthread_rwlockattr_t *__attr,
       int __pshared)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern int pthread_rwlockattr_getkind_np (__const pthread_rwlockattr_t *
       __restrict __attr,
       int *__restrict __pref)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern int pthread_rwlockattr_setkind_np (pthread_rwlockattr_t *__attr,
       int __pref) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));







extern int pthread_cond_init (pthread_cond_t *__restrict __cond,
         __const pthread_condattr_t *__restrict
         __cond_attr) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern int pthread_cond_destroy (pthread_cond_t *__cond)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern int pthread_cond_signal (pthread_cond_t *__cond)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));


extern int pthread_cond_broadcast (pthread_cond_t *__cond)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));






extern int pthread_cond_wait (pthread_cond_t *__restrict __cond,
         pthread_mutex_t *__restrict __mutex)
     __attribute__ ((__nonnull__ (1, 2)));
# 984 "/usr/include/pthread.h" 3 4
extern int pthread_cond_timedwait (pthread_cond_t *__restrict __cond,
       pthread_mutex_t *__restrict __mutex,
       __const struct timespec *__restrict
       __abstime) __attribute__ ((__nonnull__ (1, 2, 3)));




extern int pthread_condattr_init (pthread_condattr_t *__attr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern int pthread_condattr_destroy (pthread_condattr_t *__attr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern int pthread_condattr_getpshared (__const pthread_condattr_t *
     __restrict __attr,
     int *__restrict __pshared)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern int pthread_condattr_setpshared (pthread_condattr_t *__attr,
     int __pshared) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));



extern int pthread_condattr_getclock (__const pthread_condattr_t *
          __restrict __attr,
          __clockid_t *__restrict __clock_id)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern int pthread_condattr_setclock (pthread_condattr_t *__attr,
          __clockid_t __clock_id)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));
# 1028 "/usr/include/pthread.h" 3 4
extern int pthread_spin_init (pthread_spinlock_t *__lock, int __pshared)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern int pthread_spin_destroy (pthread_spinlock_t *__lock)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern int pthread_spin_lock (pthread_spinlock_t *__lock)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));


extern int pthread_spin_trylock (pthread_spinlock_t *__lock)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));


extern int pthread_spin_unlock (pthread_spinlock_t *__lock)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));






extern int pthread_barrier_init (pthread_barrier_t *__restrict __barrier,
     __const pthread_barrierattr_t *__restrict
     __attr, unsigned int __count)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern int pthread_barrier_destroy (pthread_barrier_t *__barrier)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern int pthread_barrier_wait (pthread_barrier_t *__barrier)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));



extern int pthread_barrierattr_init (pthread_barrierattr_t *__attr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern int pthread_barrierattr_destroy (pthread_barrierattr_t *__attr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern int pthread_barrierattr_getpshared (__const pthread_barrierattr_t *
        __restrict __attr,
        int *__restrict __pshared)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern int pthread_barrierattr_setpshared (pthread_barrierattr_t *__attr,
        int __pshared)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));
# 1095 "/usr/include/pthread.h" 3 4
extern int pthread_key_create (pthread_key_t *__key,
          void (*__destr_function) (void *))
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern int pthread_key_delete (pthread_key_t __key) __attribute__ ((__nothrow__ , __leaf__));


extern void *pthread_getspecific (pthread_key_t __key) __attribute__ ((__nothrow__ , __leaf__));


extern int pthread_setspecific (pthread_key_t __key,
    __const void *__pointer) __attribute__ ((__nothrow__ , __leaf__)) ;




extern int pthread_getcpuclockid (pthread_t __thread_id,
      __clockid_t *__clock_id)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));
# 1129 "/usr/include/pthread.h" 3 4
extern int pthread_atfork (void (*__prepare) (void),
      void (*__parent) (void),
      void (*__child) (void)) __attribute__ ((__nothrow__ , __leaf__));
# 1143 "/usr/include/pthread.h" 3 4

# 29 "./src/request.c" 2
# 1 "/usr/include/stdlib.h" 1 3 4
# 33 "/usr/include/stdlib.h" 3 4
# 1 "/usr/lib/gcc/x86_64-redhat-linux/4.7.0/include/stddef.h" 1 3 4
# 325 "/usr/lib/gcc/x86_64-redhat-linux/4.7.0/include/stddef.h" 3 4
typedef int wchar_t;
# 34 "/usr/include/stdlib.h" 2 3 4








# 1 "/usr/include/bits/waitflags.h" 1 3 4
# 43 "/usr/include/stdlib.h" 2 3 4
# 1 "/usr/include/bits/waitstatus.h" 1 3 4
# 67 "/usr/include/bits/waitstatus.h" 3 4
union wait
  {
    int w_status;
    struct
      {

 unsigned int __w_termsig:7;
 unsigned int __w_coredump:1;
 unsigned int __w_retcode:8;
 unsigned int:16;







      } __wait_terminated;
    struct
      {

 unsigned int __w_stopval:8;
 unsigned int __w_stopsig:8;
 unsigned int:16;






      } __wait_stopped;
  };
# 44 "/usr/include/stdlib.h" 2 3 4
# 68 "/usr/include/stdlib.h" 3 4
typedef union
  {
    union wait *__uptr;
    int *__iptr;
  } __WAIT_STATUS __attribute__ ((__transparent_union__));
# 96 "/usr/include/stdlib.h" 3 4


typedef struct
  {
    int quot;
    int rem;
  } div_t;



typedef struct
  {
    long int quot;
    long int rem;
  } ldiv_t;







__extension__ typedef struct
  {
    long long int quot;
    long long int rem;
  } lldiv_t;


# 140 "/usr/include/stdlib.h" 3 4
extern size_t __ctype_get_mb_cur_max (void) __attribute__ ((__nothrow__ , __leaf__)) ;




extern double atof (__const char *__nptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1))) ;

extern int atoi (__const char *__nptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1))) ;

extern long int atol (__const char *__nptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1))) ;





__extension__ extern long long int atoll (__const char *__nptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1))) ;





extern double strtod (__const char *__restrict __nptr,
        char **__restrict __endptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;





extern float strtof (__const char *__restrict __nptr,
       char **__restrict __endptr) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;

extern long double strtold (__const char *__restrict __nptr,
       char **__restrict __endptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;





extern long int strtol (__const char *__restrict __nptr,
   char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;

extern unsigned long int strtoul (__const char *__restrict __nptr,
      char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;




__extension__
extern long long int strtoq (__const char *__restrict __nptr,
        char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;

__extension__
extern unsigned long long int strtouq (__const char *__restrict __nptr,
           char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;





__extension__
extern long long int strtoll (__const char *__restrict __nptr,
         char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;

__extension__
extern unsigned long long int strtoull (__const char *__restrict __nptr,
     char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;

# 311 "/usr/include/stdlib.h" 3 4
extern char *l64a (long int __n) __attribute__ ((__nothrow__ , __leaf__)) ;


extern long int a64l (__const char *__s)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1))) ;




# 1 "/usr/include/sys/types.h" 1 3 4
# 28 "/usr/include/sys/types.h" 3 4






typedef __u_char u_char;
typedef __u_short u_short;
typedef __u_int u_int;
typedef __u_long u_long;
typedef __quad_t quad_t;
typedef __u_quad_t u_quad_t;
typedef __fsid_t fsid_t;




typedef __loff_t loff_t;



typedef __ino_t ino_t;
# 61 "/usr/include/sys/types.h" 3 4
typedef __dev_t dev_t;




typedef __gid_t gid_t;




typedef __mode_t mode_t;




typedef __nlink_t nlink_t;




typedef __uid_t uid_t;





typedef __off_t off_t;
# 105 "/usr/include/sys/types.h" 3 4
typedef __id_t id_t;




typedef __ssize_t ssize_t;





typedef __daddr_t daddr_t;
typedef __caddr_t caddr_t;





typedef __key_t key_t;
# 147 "/usr/include/sys/types.h" 3 4
# 1 "/usr/lib/gcc/x86_64-redhat-linux/4.7.0/include/stddef.h" 1 3 4
# 148 "/usr/include/sys/types.h" 2 3 4



typedef unsigned long int ulong;
typedef unsigned short int ushort;
typedef unsigned int uint;
# 195 "/usr/include/sys/types.h" 3 4
typedef int int8_t __attribute__ ((__mode__ (__QI__)));
typedef int int16_t __attribute__ ((__mode__ (__HI__)));
typedef int int32_t __attribute__ ((__mode__ (__SI__)));
typedef int int64_t __attribute__ ((__mode__ (__DI__)));


typedef unsigned int u_int8_t __attribute__ ((__mode__ (__QI__)));
typedef unsigned int u_int16_t __attribute__ ((__mode__ (__HI__)));
typedef unsigned int u_int32_t __attribute__ ((__mode__ (__SI__)));
typedef unsigned int u_int64_t __attribute__ ((__mode__ (__DI__)));

typedef int register_t __attribute__ ((__mode__ (__word__)));
# 220 "/usr/include/sys/types.h" 3 4
# 1 "/usr/include/sys/select.h" 1 3 4
# 31 "/usr/include/sys/select.h" 3 4
# 1 "/usr/include/bits/select.h" 1 3 4
# 23 "/usr/include/bits/select.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 24 "/usr/include/bits/select.h" 2 3 4
# 32 "/usr/include/sys/select.h" 2 3 4


# 1 "/usr/include/bits/sigset.h" 1 3 4
# 24 "/usr/include/bits/sigset.h" 3 4
typedef int __sig_atomic_t;




typedef struct
  {
    unsigned long int __val[(1024 / (8 * sizeof (unsigned long int)))];
  } __sigset_t;
# 35 "/usr/include/sys/select.h" 2 3 4



typedef __sigset_t sigset_t;







# 1 "/usr/include/bits/time.h" 1 3 4
# 31 "/usr/include/bits/time.h" 3 4
struct timeval
  {
    __time_t tv_sec;
    __suseconds_t tv_usec;
  };
# 47 "/usr/include/sys/select.h" 2 3 4


typedef __suseconds_t suseconds_t;





typedef long int __fd_mask;
# 65 "/usr/include/sys/select.h" 3 4
typedef struct
  {






    __fd_mask __fds_bits[1024 / (8 * (int) sizeof (__fd_mask))];


  } fd_set;






typedef __fd_mask fd_mask;
# 97 "/usr/include/sys/select.h" 3 4

# 107 "/usr/include/sys/select.h" 3 4
extern int select (int __nfds, fd_set *__restrict __readfds,
     fd_set *__restrict __writefds,
     fd_set *__restrict __exceptfds,
     struct timeval *__restrict __timeout);
# 119 "/usr/include/sys/select.h" 3 4
extern int pselect (int __nfds, fd_set *__restrict __readfds,
      fd_set *__restrict __writefds,
      fd_set *__restrict __exceptfds,
      const struct timespec *__restrict __timeout,
      const __sigset_t *__restrict __sigmask);
# 132 "/usr/include/sys/select.h" 3 4

# 221 "/usr/include/sys/types.h" 2 3 4


# 1 "/usr/include/sys/sysmacros.h" 1 3 4
# 30 "/usr/include/sys/sysmacros.h" 3 4


__extension__
extern unsigned int gnu_dev_major (unsigned long long int __dev)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__));
__extension__
extern unsigned int gnu_dev_minor (unsigned long long int __dev)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__));
__extension__
extern unsigned long long int gnu_dev_makedev (unsigned int __major,
            unsigned int __minor)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__));
# 64 "/usr/include/sys/sysmacros.h" 3 4

# 224 "/usr/include/sys/types.h" 2 3 4





typedef __blksize_t blksize_t;






typedef __blkcnt_t blkcnt_t;



typedef __fsblkcnt_t fsblkcnt_t;



typedef __fsfilcnt_t fsfilcnt_t;
# 274 "/usr/include/sys/types.h" 3 4

# 321 "/usr/include/stdlib.h" 2 3 4






extern long int random (void) __attribute__ ((__nothrow__ , __leaf__));


extern void srandom (unsigned int __seed) __attribute__ ((__nothrow__ , __leaf__));





extern char *initstate (unsigned int __seed, char *__statebuf,
   size_t __statelen) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));



extern char *setstate (char *__statebuf) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));







struct random_data
  {
    int32_t *fptr;
    int32_t *rptr;
    int32_t *state;
    int rand_type;
    int rand_deg;
    int rand_sep;
    int32_t *end_ptr;
  };

extern int random_r (struct random_data *__restrict __buf,
       int32_t *__restrict __result) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));

extern int srandom_r (unsigned int __seed, struct random_data *__buf)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));

extern int initstate_r (unsigned int __seed, char *__restrict __statebuf,
   size_t __statelen,
   struct random_data *__restrict __buf)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 4)));

extern int setstate_r (char *__restrict __statebuf,
         struct random_data *__restrict __buf)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));






extern int rand (void) __attribute__ ((__nothrow__ , __leaf__));

extern void srand (unsigned int __seed) __attribute__ ((__nothrow__ , __leaf__));




extern int rand_r (unsigned int *__seed) __attribute__ ((__nothrow__ , __leaf__));







extern double drand48 (void) __attribute__ ((__nothrow__ , __leaf__));
extern double erand48 (unsigned short int __xsubi[3]) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern long int lrand48 (void) __attribute__ ((__nothrow__ , __leaf__));
extern long int nrand48 (unsigned short int __xsubi[3])
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern long int mrand48 (void) __attribute__ ((__nothrow__ , __leaf__));
extern long int jrand48 (unsigned short int __xsubi[3])
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern void srand48 (long int __seedval) __attribute__ ((__nothrow__ , __leaf__));
extern unsigned short int *seed48 (unsigned short int __seed16v[3])
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));
extern void lcong48 (unsigned short int __param[7]) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));





struct drand48_data
  {
    unsigned short int __x[3];
    unsigned short int __old_x[3];
    unsigned short int __c;
    unsigned short int __init;
    unsigned long long int __a;
  };


extern int drand48_r (struct drand48_data *__restrict __buffer,
        double *__restrict __result) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));
extern int erand48_r (unsigned short int __xsubi[3],
        struct drand48_data *__restrict __buffer,
        double *__restrict __result) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern int lrand48_r (struct drand48_data *__restrict __buffer,
        long int *__restrict __result)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));
extern int nrand48_r (unsigned short int __xsubi[3],
        struct drand48_data *__restrict __buffer,
        long int *__restrict __result)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern int mrand48_r (struct drand48_data *__restrict __buffer,
        long int *__restrict __result)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));
extern int jrand48_r (unsigned short int __xsubi[3],
        struct drand48_data *__restrict __buffer,
        long int *__restrict __result)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern int srand48_r (long int __seedval, struct drand48_data *__buffer)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));

extern int seed48_r (unsigned short int __seed16v[3],
       struct drand48_data *__buffer) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));

extern int lcong48_r (unsigned short int __param[7],
        struct drand48_data *__buffer)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));









extern void *malloc (size_t __size) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__malloc__)) ;

extern void *calloc (size_t __nmemb, size_t __size)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__malloc__)) ;










extern void *realloc (void *__ptr, size_t __size)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__warn_unused_result__));

extern void free (void *__ptr) __attribute__ ((__nothrow__ , __leaf__));




extern void cfree (void *__ptr) __attribute__ ((__nothrow__ , __leaf__));



# 1 "/usr/include/alloca.h" 1 3 4
# 25 "/usr/include/alloca.h" 3 4
# 1 "/usr/lib/gcc/x86_64-redhat-linux/4.7.0/include/stddef.h" 1 3 4
# 26 "/usr/include/alloca.h" 2 3 4







extern void *alloca (size_t __size) __attribute__ ((__nothrow__ , __leaf__));






# 498 "/usr/include/stdlib.h" 2 3 4





extern void *valloc (size_t __size) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__malloc__)) ;




extern int posix_memalign (void **__memptr, size_t __alignment, size_t __size)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;




extern void abort (void) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__noreturn__));



extern int atexit (void (*__func) (void)) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));
# 531 "/usr/include/stdlib.h" 3 4





extern int on_exit (void (*__func) (int __status, void *__arg), void *__arg)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));






extern void exit (int __status) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__noreturn__));
# 554 "/usr/include/stdlib.h" 3 4






extern void _Exit (int __status) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__noreturn__));






extern char *getenv (__const char *__name) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;




extern char *__secure_getenv (__const char *__name)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;





extern int putenv (char *__string) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));





extern int setenv (__const char *__name, __const char *__value, int __replace)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));


extern int unsetenv (__const char *__name) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));






extern int clearenv (void) __attribute__ ((__nothrow__ , __leaf__));
# 606 "/usr/include/stdlib.h" 3 4
extern char *mktemp (char *__template) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;
# 620 "/usr/include/stdlib.h" 3 4
extern int mkstemp (char *__template) __attribute__ ((__nonnull__ (1))) ;
# 642 "/usr/include/stdlib.h" 3 4
extern int mkstemps (char *__template, int __suffixlen) __attribute__ ((__nonnull__ (1))) ;
# 663 "/usr/include/stdlib.h" 3 4
extern char *mkdtemp (char *__template) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;
# 712 "/usr/include/stdlib.h" 3 4





extern int system (__const char *__command) ;

# 734 "/usr/include/stdlib.h" 3 4
extern char *realpath (__const char *__restrict __name,
         char *__restrict __resolved) __attribute__ ((__nothrow__ , __leaf__)) ;






typedef int (*__compar_fn_t) (__const void *, __const void *);
# 752 "/usr/include/stdlib.h" 3 4



extern void *bsearch (__const void *__key, __const void *__base,
        size_t __nmemb, size_t __size, __compar_fn_t __compar)
     __attribute__ ((__nonnull__ (1, 2, 5))) ;



extern void qsort (void *__base, size_t __nmemb, size_t __size,
     __compar_fn_t __compar) __attribute__ ((__nonnull__ (1, 4)));
# 771 "/usr/include/stdlib.h" 3 4
extern int abs (int __x) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__)) ;
extern long int labs (long int __x) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__)) ;



__extension__ extern long long int llabs (long long int __x)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__)) ;







extern div_t div (int __numer, int __denom)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__)) ;
extern ldiv_t ldiv (long int __numer, long int __denom)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__)) ;




__extension__ extern lldiv_t lldiv (long long int __numer,
        long long int __denom)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__)) ;

# 808 "/usr/include/stdlib.h" 3 4
extern char *ecvt (double __value, int __ndigit, int *__restrict __decpt,
     int *__restrict __sign) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3, 4))) ;




extern char *fcvt (double __value, int __ndigit, int *__restrict __decpt,
     int *__restrict __sign) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3, 4))) ;




extern char *gcvt (double __value, int __ndigit, char *__buf)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3))) ;




extern char *qecvt (long double __value, int __ndigit,
      int *__restrict __decpt, int *__restrict __sign)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3, 4))) ;
extern char *qfcvt (long double __value, int __ndigit,
      int *__restrict __decpt, int *__restrict __sign)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3, 4))) ;
extern char *qgcvt (long double __value, int __ndigit, char *__buf)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3))) ;




extern int ecvt_r (double __value, int __ndigit, int *__restrict __decpt,
     int *__restrict __sign, char *__restrict __buf,
     size_t __len) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3, 4, 5)));
extern int fcvt_r (double __value, int __ndigit, int *__restrict __decpt,
     int *__restrict __sign, char *__restrict __buf,
     size_t __len) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3, 4, 5)));

extern int qecvt_r (long double __value, int __ndigit,
      int *__restrict __decpt, int *__restrict __sign,
      char *__restrict __buf, size_t __len)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3, 4, 5)));
extern int qfcvt_r (long double __value, int __ndigit,
      int *__restrict __decpt, int *__restrict __sign,
      char *__restrict __buf, size_t __len)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3, 4, 5)));







extern int mblen (__const char *__s, size_t __n) __attribute__ ((__nothrow__ , __leaf__)) ;


extern int mbtowc (wchar_t *__restrict __pwc,
     __const char *__restrict __s, size_t __n) __attribute__ ((__nothrow__ , __leaf__)) ;


extern int wctomb (char *__s, wchar_t __wchar) __attribute__ ((__nothrow__ , __leaf__)) ;



extern size_t mbstowcs (wchar_t *__restrict __pwcs,
   __const char *__restrict __s, size_t __n) __attribute__ ((__nothrow__ , __leaf__));

extern size_t wcstombs (char *__restrict __s,
   __const wchar_t *__restrict __pwcs, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__));








extern int rpmatch (__const char *__response) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;
# 896 "/usr/include/stdlib.h" 3 4
extern int getsubopt (char **__restrict __optionp,
        char *__const *__restrict __tokens,
        char **__restrict __valuep)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2, 3))) ;
# 948 "/usr/include/stdlib.h" 3 4
extern int getloadavg (double __loadavg[], int __nelem)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));
# 964 "/usr/include/stdlib.h" 3 4

# 30 "./src/request.c" 2
# 1 "/usr/include/string.h" 1 3 4
# 29 "/usr/include/string.h" 3 4





# 1 "/usr/lib/gcc/x86_64-redhat-linux/4.7.0/include/stddef.h" 1 3 4
# 35 "/usr/include/string.h" 2 3 4









extern void *memcpy (void *__restrict __dest,
       __const void *__restrict __src, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern void *memmove (void *__dest, __const void *__src, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));






extern void *memccpy (void *__restrict __dest, __const void *__restrict __src,
        int __c, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));





extern void *memset (void *__s, int __c, size_t __n) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern int memcmp (__const void *__s1, __const void *__s2, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));
# 95 "/usr/include/string.h" 3 4
extern void *memchr (__const void *__s, int __c, size_t __n)
      __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));


# 126 "/usr/include/string.h" 3 4


extern char *strcpy (char *__restrict __dest, __const char *__restrict __src)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));

extern char *strncpy (char *__restrict __dest,
        __const char *__restrict __src, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern char *strcat (char *__restrict __dest, __const char *__restrict __src)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));

extern char *strncat (char *__restrict __dest, __const char *__restrict __src,
        size_t __n) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern int strcmp (__const char *__s1, __const char *__s2)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));

extern int strncmp (__const char *__s1, __const char *__s2, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));


extern int strcoll (__const char *__s1, __const char *__s2)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));

extern size_t strxfrm (char *__restrict __dest,
         __const char *__restrict __src, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));

# 165 "/usr/include/string.h" 3 4
extern int strcoll_l (__const char *__s1, __const char *__s2, __locale_t __l)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2, 3)));

extern size_t strxfrm_l (char *__dest, __const char *__src, size_t __n,
    __locale_t __l) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 4)));





extern char *strdup (__const char *__s)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__malloc__)) __attribute__ ((__nonnull__ (1)));






extern char *strndup (__const char *__string, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__malloc__)) __attribute__ ((__nonnull__ (1)));
# 210 "/usr/include/string.h" 3 4

# 235 "/usr/include/string.h" 3 4
extern char *strchr (__const char *__s, int __c)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));
# 262 "/usr/include/string.h" 3 4
extern char *strrchr (__const char *__s, int __c)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));


# 281 "/usr/include/string.h" 3 4



extern size_t strcspn (__const char *__s, __const char *__reject)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));


extern size_t strspn (__const char *__s, __const char *__accept)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));
# 314 "/usr/include/string.h" 3 4
extern char *strpbrk (__const char *__s, __const char *__accept)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));
# 342 "/usr/include/string.h" 3 4
extern char *strstr (__const char *__haystack, __const char *__needle)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));




extern char *strtok (char *__restrict __s, __const char *__restrict __delim)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));




extern char *__strtok_r (char *__restrict __s,
    __const char *__restrict __delim,
    char **__restrict __save_ptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 3)));

extern char *strtok_r (char *__restrict __s, __const char *__restrict __delim,
         char **__restrict __save_ptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 3)));
# 397 "/usr/include/string.h" 3 4


extern size_t strlen (__const char *__s)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));





extern size_t strnlen (__const char *__string, size_t __maxlen)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));





extern char *strerror (int __errnum) __attribute__ ((__nothrow__ , __leaf__));

# 427 "/usr/include/string.h" 3 4
extern int strerror_r (int __errnum, char *__buf, size_t __buflen) __asm__ ("" "__xpg_strerror_r") __attribute__ ((__nothrow__ , __leaf__))

                        __attribute__ ((__nonnull__ (2)));
# 445 "/usr/include/string.h" 3 4
extern char *strerror_l (int __errnum, __locale_t __l) __attribute__ ((__nothrow__ , __leaf__));





extern void __bzero (void *__s, size_t __n) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));



extern void bcopy (__const void *__src, void *__dest, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern void bzero (void *__s, size_t __n) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern int bcmp (__const void *__s1, __const void *__s2, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));
# 489 "/usr/include/string.h" 3 4
extern char *index (__const char *__s, int __c)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));
# 517 "/usr/include/string.h" 3 4
extern char *rindex (__const char *__s, int __c)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));




extern int ffs (int __i) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__));
# 536 "/usr/include/string.h" 3 4
extern int strcasecmp (__const char *__s1, __const char *__s2)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));


extern int strncasecmp (__const char *__s1, __const char *__s2, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));
# 559 "/usr/include/string.h" 3 4
extern char *strsep (char **__restrict __stringp,
       __const char *__restrict __delim)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));




extern char *strsignal (int __sig) __attribute__ ((__nothrow__ , __leaf__));


extern char *__stpcpy (char *__restrict __dest, __const char *__restrict __src)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));
extern char *stpcpy (char *__restrict __dest, __const char *__restrict __src)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));



extern char *__stpncpy (char *__restrict __dest,
   __const char *__restrict __src, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));
extern char *stpncpy (char *__restrict __dest,
        __const char *__restrict __src, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));
# 646 "/usr/include/string.h" 3 4

# 31 "./src/request.c" 2
# 1 "/usr/include/sys/utsname.h" 1 3 4
# 28 "/usr/include/sys/utsname.h" 3 4


# 1 "/usr/include/bits/utsname.h" 1 3 4
# 31 "/usr/include/sys/utsname.h" 2 3 4
# 49 "/usr/include/sys/utsname.h" 3 4
struct utsname
  {

    char sysname[65];


    char nodename[65];


    char release[65];

    char version[65];


    char machine[65];






    char __domainname[65];


  };
# 82 "/usr/include/sys/utsname.h" 3 4
extern int uname (struct utsname *__name) __attribute__ ((__nothrow__ , __leaf__));



# 32 "./src/request.c" 2
# 1 "./inc/request.h" 1
# 30 "./inc/request.h"
# 1 "./inc/libs3.h" 1
# 30 "./inc/libs3.h"
# 1 "/usr/lib/gcc/x86_64-redhat-linux/4.7.0/include/stdint.h" 1 3 4


# 1 "/usr/include/stdint.h" 1 3 4
# 27 "/usr/include/stdint.h" 3 4
# 1 "/usr/include/bits/wchar.h" 1 3 4
# 28 "/usr/include/stdint.h" 2 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 29 "/usr/include/stdint.h" 2 3 4
# 49 "/usr/include/stdint.h" 3 4
typedef unsigned char uint8_t;
typedef unsigned short int uint16_t;

typedef unsigned int uint32_t;



typedef unsigned long int uint64_t;
# 66 "/usr/include/stdint.h" 3 4
typedef signed char int_least8_t;
typedef short int int_least16_t;
typedef int int_least32_t;

typedef long int int_least64_t;






typedef unsigned char uint_least8_t;
typedef unsigned short int uint_least16_t;
typedef unsigned int uint_least32_t;

typedef unsigned long int uint_least64_t;
# 91 "/usr/include/stdint.h" 3 4
typedef signed char int_fast8_t;

typedef long int int_fast16_t;
typedef long int int_fast32_t;
typedef long int int_fast64_t;
# 104 "/usr/include/stdint.h" 3 4
typedef unsigned char uint_fast8_t;

typedef unsigned long int uint_fast16_t;
typedef unsigned long int uint_fast32_t;
typedef unsigned long int uint_fast64_t;
# 120 "/usr/include/stdint.h" 3 4
typedef long int intptr_t;


typedef unsigned long int uintptr_t;
# 135 "/usr/include/stdint.h" 3 4
typedef long int intmax_t;
typedef unsigned long int uintmax_t;
# 4 "/usr/lib/gcc/x86_64-redhat-linux/4.7.0/include/stdint.h" 2 3 4
# 31 "./inc/libs3.h" 2
# 229 "./inc/libs3.h"
typedef enum
{
    S3StatusOK ,





    S3StatusInternalError ,
    S3StatusOutOfMemory ,
    S3StatusInterrupted ,
    S3StatusInvalidBucketNameTooLong ,
    S3StatusInvalidBucketNameFirstCharacter ,
    S3StatusInvalidBucketNameCharacter ,
    S3StatusInvalidBucketNameCharacterSequence ,
    S3StatusInvalidBucketNameTooShort ,
    S3StatusInvalidBucketNameDotQuadNotation ,
    S3StatusQueryParamsTooLong ,
    S3StatusFailedToInitializeRequest ,
    S3StatusMetaDataHeadersTooLong ,
    S3StatusBadMetaData ,
    S3StatusBadContentType ,
    S3StatusContentTypeTooLong ,
    S3StatusBadMD5 ,
    S3StatusMD5TooLong ,
    S3StatusBadCacheControl ,
    S3StatusCacheControlTooLong ,
    S3StatusBadContentDispositionFilename ,
    S3StatusContentDispositionFilenameTooLong ,
    S3StatusBadContentEncoding ,
    S3StatusContentEncodingTooLong ,
    S3StatusBadIfMatchETag ,
    S3StatusIfMatchETagTooLong ,
    S3StatusBadIfNotMatchETag ,
    S3StatusIfNotMatchETagTooLong ,
    S3StatusHeadersTooLong ,
    S3StatusKeyTooLong ,
    S3StatusUriTooLong ,
    S3StatusXmlParseFailure ,
    S3StatusEmailAddressTooLong ,
    S3StatusUserIdTooLong ,
    S3StatusUserDisplayNameTooLong ,
    S3StatusGroupUriTooLong ,
    S3StatusPermissionTooLong ,
    S3StatusTargetBucketTooLong ,
    S3StatusTargetPrefixTooLong ,
    S3StatusTooManyGrants ,
    S3StatusBadGrantee ,
    S3StatusBadPermission ,
    S3StatusXmlDocumentTooLarge ,
    S3StatusNameLookupError ,
    S3StatusFailedToConnect ,
    S3StatusServerFailedVerification ,
    S3StatusConnectionFailed ,
    S3StatusAbortedByCallback ,




    S3StatusErrorAccessDenied ,
    S3StatusErrorAccountProblem ,
    S3StatusErrorAmbiguousGrantByEmailAddress ,
    S3StatusErrorBadDigest ,
    S3StatusErrorBucketAlreadyExists ,
    S3StatusErrorBucketAlreadyOwnedByYou ,
    S3StatusErrorBucketNotEmpty ,
    S3StatusErrorCredentialsNotSupported ,
    S3StatusErrorCrossLocationLoggingProhibited ,
    S3StatusErrorEntityTooSmall ,
    S3StatusErrorEntityTooLarge ,
    S3StatusErrorExpiredToken ,
    S3StatusErrorIncompleteBody ,
    S3StatusErrorIncorrectNumberOfFilesInPostRequest ,
    S3StatusErrorInlineDataTooLarge ,
    S3StatusErrorInternalError ,
    S3StatusErrorInvalidAccessKeyId ,
    S3StatusErrorInvalidAddressingHeader ,
    S3StatusErrorInvalidArgument ,
    S3StatusErrorInvalidBucketName ,
    S3StatusErrorInvalidDigest ,
    S3StatusErrorInvalidLocationConstraint ,
    S3StatusErrorInvalidPayer ,
    S3StatusErrorInvalidPolicyDocument ,
    S3StatusErrorInvalidRange ,
    S3StatusErrorInvalidSecurity ,
    S3StatusErrorInvalidSOAPRequest ,
    S3StatusErrorInvalidStorageClass ,
    S3StatusErrorInvalidTargetBucketForLogging ,
    S3StatusErrorInvalidToken ,
    S3StatusErrorInvalidURI ,
    S3StatusErrorKeyTooLong ,
    S3StatusErrorMalformedACLError ,
    S3StatusErrorMalformedXML ,
    S3StatusErrorMaxMessageLengthExceeded ,
    S3StatusErrorMaxPostPreDataLengthExceededError ,
    S3StatusErrorMetadataTooLarge ,
    S3StatusErrorMethodNotAllowed ,
    S3StatusErrorMissingAttachment ,
    S3StatusErrorMissingContentLength ,
    S3StatusErrorMissingSecurityElement ,
    S3StatusErrorMissingSecurityHeader ,
    S3StatusErrorNoLoggingStatusForKey ,
    S3StatusErrorNoSuchBucket ,
    S3StatusErrorNoSuchKey ,
    S3StatusErrorNotImplemented ,
    S3StatusErrorNotSignedUp ,
    S3StatusErrorOperationAborted ,
    S3StatusErrorPermanentRedirect ,
    S3StatusErrorPreconditionFailed ,
    S3StatusErrorRedirect ,
    S3StatusErrorRequestIsNotMultiPartContent ,
    S3StatusErrorRequestTimeout ,
    S3StatusErrorRequestTimeTooSkewed ,
    S3StatusErrorRequestTorrentOfBucketError ,
    S3StatusErrorSignatureDoesNotMatch ,
    S3StatusErrorSlowDown ,
    S3StatusErrorTemporaryRedirect ,
    S3StatusErrorTokenRefreshRequired ,
    S3StatusErrorTooManyBuckets ,
    S3StatusErrorUnexpectedContent ,
    S3StatusErrorUnresolvableGrantByEmailAddress ,
    S3StatusErrorUserKeyMustBeSpecified ,
    S3StatusErrorUnknown ,





    S3StatusHttpErrorMovedTemporarily ,
    S3StatusHttpErrorBadRequest ,
    S3StatusHttpErrorForbidden ,
    S3StatusHttpErrorNotFound ,
    S3StatusHttpErrorConflict ,
    S3StatusHttpErrorUnknown
} S3Status;
# 376 "./inc/libs3.h"
typedef enum
{
    S3ProtocolHTTPS = 0,
    S3ProtocolHTTP = 1
} S3Protocol;
# 395 "./inc/libs3.h"
typedef enum
{
    S3UriStyleVirtualHost = 0,
    S3UriStylePath = 1
} S3UriStyle;
# 414 "./inc/libs3.h"
typedef enum
{
    S3GranteeTypeAmazonCustomerByEmail = 0,
    S3GranteeTypeCanonicalUser = 1,
    S3GranteeTypeAllAwsUsers = 2,
    S3GranteeTypeAllUsers = 3,
    S3GranteeTypeLogDelivery = 4
} S3GranteeType;
# 439 "./inc/libs3.h"
typedef enum
{
    S3PermissionRead = 0,
    S3PermissionWrite = 1,
    S3PermissionReadACP = 2,
    S3PermissionWriteACP = 3,
    S3PermissionFullControl = 4
} S3Permission;
# 462 "./inc/libs3.h"
typedef enum
{
    S3CannedAclPrivate = 0,
    S3CannedAclPublicRead = 1,
    S3CannedAclPublicReadWrite = 2,
    S3CannedAclAuthenticatedRead = 3
} S3CannedAcl;
# 479 "./inc/libs3.h"
typedef struct S3RequestContext S3RequestContext;






typedef struct S3NameValue
{



    const char *name;




    const char *value;
} S3NameValue;
# 506 "./inc/libs3.h"
typedef struct S3ResponseProperties
{




    const char *requestId;





    const char *requestId2;






    const char *contentType;
# 534 "./inc/libs3.h"
    uint64_t contentLength;




    const char *server;







    const char *eTag;
# 557 "./inc/libs3.h"
    int64_t lastModified;





    int metaDataCount;







    const S3NameValue *metaData;
} S3ResponseProperties;
# 581 "./inc/libs3.h"
typedef struct S3AclGrant
{



    S3GranteeType granteeType;
# 596 "./inc/libs3.h"
    union
    {




        struct
        {




            char emailAddress[128];
        } amazonCustomerByEmail;




        struct
        {



            char id[128];



            char displayName[128];
        } canonicalUser;
    } grantee;



    S3Permission permission;
} S3AclGrant;
# 639 "./inc/libs3.h"
typedef struct S3BucketContext
{




    const char *hostName;




    const char *bucketName;




    S3Protocol protocol;





    S3UriStyle uriStyle;




    const char *accessKeyId;




    const char *secretAccessKey;
} S3BucketContext;







typedef struct S3ListBucketContent
{



    const char *key;





    int64_t lastModified;





    const char *eTag;




    uint64_t size;





    const char *ownerId;





    const char *ownerDisplayName;
} S3ListBucketContent;







typedef struct S3PutProperties
{




    const char *contentType;






    const char *md5;





    const char *cacheControl;
# 751 "./inc/libs3.h"
    const char *contentDispositionFilename;






    const char *contentEncoding;






    int64_t expires;





    S3CannedAcl cannedAcl;




    int metaDataCount;






    const S3NameValue *metaData;
} S3PutProperties;






typedef struct S3GetConditions
{






    int64_t ifModifiedSince;







    int64_t ifNotModifiedSince;







    const char *ifMatchETag;







    const char *ifNotMatchETag;
} S3GetConditions;







typedef struct S3ErrorDetails
{




    const char *message;




    const char *resource;





    const char *furtherDetails;





    int extraDetailsCount;






    S3NameValue *extraDetails;
} S3ErrorDetails;
# 883 "./inc/libs3.h"
typedef S3Status (S3ResponsePropertiesCallback)
    (const S3ResponseProperties *properties, void *callbackData);
# 903 "./inc/libs3.h"
typedef void (S3ResponseCompleteCallback)(S3Status status,
                                          const S3ErrorDetails *errorDetails,
                                          void *callbackData);
# 926 "./inc/libs3.h"
typedef S3Status (S3ListServiceCallback)(const char *ownerId,
                                         const char *ownerDisplayName,
                                         const char *bucketName,
                                         int64_t creationDateSeconds,
                                         void *callbackData);
# 963 "./inc/libs3.h"
typedef S3Status (S3ListBucketCallback)(int isTruncated,
                                        const char *nextMarker,
                                        int contentsCount,
                                        const S3ListBucketContent *contents,
                                        int commonPrefixesCount,
                                        const char **commonPrefixes,
                                        void *callbackData);
# 990 "./inc/libs3.h"
typedef int (S3PutObjectDataCallback)(int bufferSize, char *buffer,
                                      void *callbackData);
# 1012 "./inc/libs3.h"
typedef S3Status (S3GetObjectDataCallback)(int bufferSize, const char *buffer,
                                           void *callbackData);
# 1025 "./inc/libs3.h"
typedef struct S3ResponseHandler
{





    S3ResponsePropertiesCallback *propertiesCallback;







    S3ResponseCompleteCallback *completeCallback;
} S3ResponseHandler;






typedef struct S3ListServiceHandler
{



    S3ResponseHandler responseHandler;





    S3ListServiceCallback *listServiceCallback;
} S3ListServiceHandler;






typedef struct S3ListBucketHandler
{



    S3ResponseHandler responseHandler;







    S3ListBucketCallback *listBucketCallback;
} S3ListBucketHandler;






typedef struct S3PutObjectHandler
{



    S3ResponseHandler responseHandler;







    S3PutObjectDataCallback *putObjectDataCallback;
} S3PutObjectHandler;






typedef struct S3GetObjectHandler
{



    S3ResponseHandler responseHandler;
# 1123 "./inc/libs3.h"
    S3GetObjectDataCallback *getObjectDataCallback;
} S3GetObjectHandler;
# 1169 "./inc/libs3.h"
S3Status S3_initialize(const char *userAgentInfo, int flags,
                       const char *defaultS3HostName);







void S3_deinitialize();
# 1187 "./inc/libs3.h"
const char *S3_get_status_name(S3Status status);
# 1229 "./inc/libs3.h"
S3Status S3_validate_bucket_name(const char *bucketName, S3UriStyle uriStyle);
# 1258 "./inc/libs3.h"
S3Status S3_convert_acl(char *aclXml, char *ownerId, char *ownerDisplayName,
                        int *aclGrantCountReturn, S3AclGrant *aclGrants);
# 1272 "./inc/libs3.h"
int S3_status_is_retryable(S3Status status);
# 1297 "./inc/libs3.h"
S3Status S3_create_request_context(S3RequestContext **requestContextReturn);
# 1308 "./inc/libs3.h"
void S3_destroy_request_context(S3RequestContext *requestContext);
# 1324 "./inc/libs3.h"
S3Status S3_runall_request_context(S3RequestContext *requestContext);
# 1345 "./inc/libs3.h"
S3Status S3_runonce_request_context(S3RequestContext *requestContext,
                                    int *requestsRemainingReturn);
# 1379 "./inc/libs3.h"
S3Status S3_get_request_context_fdsets(S3RequestContext *requestContext,
                                       fd_set *readFdSet, fd_set *writeFdSet,
                                       fd_set *exceptFdSet, int *maxFd);
# 1398 "./inc/libs3.h"
int64_t S3_get_request_context_timeout(S3RequestContext *requestContext);
# 1430 "./inc/libs3.h"
S3Status S3_generate_authenticated_query_string
    (char *buffer, const S3BucketContext *bucketContext,
     const char *key, int64_t expires, const char *resource);
# 1457 "./inc/libs3.h"
void S3_list_service(S3Protocol protocol, const char *accessKeyId,
                     const char *secretAccessKey, const char *hostName,
                     S3RequestContext *requestContext,
                     const S3ListServiceHandler *handler,
                     void *callbackData);
# 1498 "./inc/libs3.h"
void S3_test_bucket(S3Protocol protocol, S3UriStyle uriStyle,
                    const char *accessKeyId, const char *secretAccessKey,
                    const char *hostName, const char *bucketName,
                    int locationConstraintReturnSize,
                    char *locationConstraintReturn,
                    S3RequestContext *requestContext,
                    const S3ResponseHandler *handler, void *callbackData);
# 1529 "./inc/libs3.h"
void S3_create_bucket(S3Protocol protocol, const char *accessKeyId,
                      const char *secretAccessKey, const char *hostName,
                      const char *bucketName, S3CannedAcl cannedAcl,
                      const char *locationConstraint,
                      S3RequestContext *requestContext,
                      const S3ResponseHandler *handler, void *callbackData);
# 1558 "./inc/libs3.h"
void S3_delete_bucket(S3Protocol protocol, S3UriStyle uriStyle,
                      const char *accessKeyId, const char *secretAccessKey,
                      const char *hostName, const char *bucketName,
                      S3RequestContext *requestContext,
                      const S3ResponseHandler *handler, void *callbackData);
# 1585 "./inc/libs3.h"
void S3_list_bucket(const S3BucketContext *bucketContext,
                    const char *prefix, const char *marker,
                    const char *delimiter, int maxkeys,
                    S3RequestContext *requestContext,
                    const S3ListBucketHandler *handler, void *callbackData);
# 1616 "./inc/libs3.h"
void S3_put_object(const S3BucketContext *bucketContext, const char *key,
                   uint64_t contentLength,
                   const S3PutProperties *putProperties,
                   S3RequestContext *requestContext,
                   const S3PutObjectHandler *handler, void *callbackData);
# 1657 "./inc/libs3.h"
void S3_copy_object(const S3BucketContext *bucketContext,
                    const char *key, const char *destinationBucket,
                    const char *destinationKey,
                    const S3PutProperties *putProperties,
                    int64_t *lastModifiedReturn, int eTagReturnSize,
                    char *eTagReturn, S3RequestContext *requestContext,
                    const S3ResponseHandler *handler, void *callbackData);
# 1687 "./inc/libs3.h"
void S3_get_object(const S3BucketContext *bucketContext, const char *key,
                   const S3GetConditions *getConditions,
                   uint64_t startByte, uint64_t byteCount,
                   S3RequestContext *requestContext,
                   const S3GetObjectHandler *handler, void *callbackData);
# 1708 "./inc/libs3.h"
void S3_head_object(const S3BucketContext *bucketContext, const char *key,
                    S3RequestContext *requestContext,
                    const S3ResponseHandler *handler, void *callbackData);
# 1726 "./inc/libs3.h"
void S3_delete_object(const S3BucketContext *bucketContext, const char *key,
                      S3RequestContext *requestContext,
                      const S3ResponseHandler *handler, void *callbackData);
# 1761 "./inc/libs3.h"
void S3_get_acl(const S3BucketContext *bucketContext, const char *key,
                char *ownerId, char *ownerDisplayName,
                int *aclGrantCountReturn, S3AclGrant *aclGrants,
                S3RequestContext *requestContext,
                const S3ResponseHandler *handler, void *callbackData);
# 1793 "./inc/libs3.h"
void S3_set_acl(const S3BucketContext *bucketContext, const char *key,
                const char *ownerId, const char *ownerDisplayName,
                int aclGrantCount, const S3AclGrant *aclGrants,
                S3RequestContext *requestContext,
                const S3ResponseHandler *handler, void *callbackData);
# 1840 "./inc/libs3.h"
void S3_get_server_access_logging(const S3BucketContext *bucketContext,
                                  char *targetBucketReturn,
                                  char *targetPrefixReturn,
                                  int *aclGrantCountReturn,
                                  S3AclGrant *aclGrants,
                                  S3RequestContext *requestContext,
                                  const S3ResponseHandler *handler,
                                  void *callbackData);
# 1879 "./inc/libs3.h"
void S3_set_server_access_logging(const S3BucketContext *bucketContext,
                                  const char *targetBucket,
                                  const char *targetPrefix, int aclGrantCount,
                                  const S3AclGrant *aclGrants,
                                  S3RequestContext *requestContext,
                                  const S3ResponseHandler *handler,
                                  void *callbackData);
# 31 "./inc/request.h" 2
# 1 "./inc/error_parser.h" 1
# 31 "./inc/error_parser.h"
# 1 "./inc/simplexml.h" 1
# 43 "./inc/simplexml.h"
typedef S3Status (SimpleXmlCallback)(const char *elementPath, const char *data,
                                     int dataLen, void *callbackData);

typedef struct SimpleXml
{
    void *xmlParser;

    SimpleXmlCallback *callback;

    void *callbackData;

    char elementPath[512];

    int elementPathLen;

    S3Status status;
} SimpleXml;






void simplexml_initialize(SimpleXml *simpleXml, SimpleXmlCallback *callback,
                          void *callbackData);

S3Status simplexml_add(SimpleXml *simpleXml, const char *data, int dataLen);



void simplexml_deinitialize(SimpleXml *simpleXml);
# 32 "./inc/error_parser.h" 2
# 1 "./inc/string_buffer.h" 1
# 30 "./inc/string_buffer.h"
# 1 "/usr/include/stdio.h" 1 3 4
# 30 "/usr/include/stdio.h" 3 4




# 1 "/usr/lib/gcc/x86_64-redhat-linux/4.7.0/include/stddef.h" 1 3 4
# 35 "/usr/include/stdio.h" 2 3 4
# 45 "/usr/include/stdio.h" 3 4
struct _IO_FILE;



typedef struct _IO_FILE FILE;





# 65 "/usr/include/stdio.h" 3 4
typedef struct _IO_FILE __FILE;
# 75 "/usr/include/stdio.h" 3 4
# 1 "/usr/include/libio.h" 1 3 4
# 32 "/usr/include/libio.h" 3 4
# 1 "/usr/include/_G_config.h" 1 3 4
# 15 "/usr/include/_G_config.h" 3 4
# 1 "/usr/lib/gcc/x86_64-redhat-linux/4.7.0/include/stddef.h" 1 3 4
# 16 "/usr/include/_G_config.h" 2 3 4




# 1 "/usr/include/wchar.h" 1 3 4
# 83 "/usr/include/wchar.h" 3 4
typedef struct
{
  int __count;
  union
  {

    unsigned int __wch;



    char __wchb[4];
  } __value;
} __mbstate_t;
# 21 "/usr/include/_G_config.h" 2 3 4

typedef struct
{
  __off_t __pos;
  __mbstate_t __state;
} _G_fpos_t;
typedef struct
{
  __off64_t __pos;
  __mbstate_t __state;
} _G_fpos64_t;
# 53 "/usr/include/_G_config.h" 3 4
typedef int _G_int16_t __attribute__ ((__mode__ (__HI__)));
typedef int _G_int32_t __attribute__ ((__mode__ (__SI__)));
typedef unsigned int _G_uint16_t __attribute__ ((__mode__ (__HI__)));
typedef unsigned int _G_uint32_t __attribute__ ((__mode__ (__SI__)));
# 33 "/usr/include/libio.h" 2 3 4
# 53 "/usr/include/libio.h" 3 4
# 1 "/usr/lib/gcc/x86_64-redhat-linux/4.7.0/include/stdarg.h" 1 3 4
# 40 "/usr/lib/gcc/x86_64-redhat-linux/4.7.0/include/stdarg.h" 3 4
typedef __builtin_va_list __gnuc_va_list;
# 54 "/usr/include/libio.h" 2 3 4
# 172 "/usr/include/libio.h" 3 4
struct _IO_jump_t; struct _IO_FILE;
# 182 "/usr/include/libio.h" 3 4
typedef void _IO_lock_t;





struct _IO_marker {
  struct _IO_marker *_next;
  struct _IO_FILE *_sbuf;



  int _pos;
# 205 "/usr/include/libio.h" 3 4
};


enum __codecvt_result
{
  __codecvt_ok,
  __codecvt_partial,
  __codecvt_error,
  __codecvt_noconv
};
# 273 "/usr/include/libio.h" 3 4
struct _IO_FILE {
  int _flags;




  char* _IO_read_ptr;
  char* _IO_read_end;
  char* _IO_read_base;
  char* _IO_write_base;
  char* _IO_write_ptr;
  char* _IO_write_end;
  char* _IO_buf_base;
  char* _IO_buf_end;

  char *_IO_save_base;
  char *_IO_backup_base;
  char *_IO_save_end;

  struct _IO_marker *_markers;

  struct _IO_FILE *_chain;

  int _fileno;



  int _flags2;

  __off_t _old_offset;



  unsigned short _cur_column;
  signed char _vtable_offset;
  char _shortbuf[1];



  _IO_lock_t *_lock;
# 321 "/usr/include/libio.h" 3 4
  __off64_t _offset;
# 330 "/usr/include/libio.h" 3 4
  void *__pad1;
  void *__pad2;
  void *__pad3;
  void *__pad4;
  size_t __pad5;

  int _mode;

  char _unused2[15 * sizeof (int) - 4 * sizeof (void *) - sizeof (size_t)];

};


typedef struct _IO_FILE _IO_FILE;


struct _IO_FILE_plus;

extern struct _IO_FILE_plus _IO_2_1_stdin_;
extern struct _IO_FILE_plus _IO_2_1_stdout_;
extern struct _IO_FILE_plus _IO_2_1_stderr_;
# 366 "/usr/include/libio.h" 3 4
typedef __ssize_t __io_read_fn (void *__cookie, char *__buf, size_t __nbytes);







typedef __ssize_t __io_write_fn (void *__cookie, __const char *__buf,
     size_t __n);







typedef int __io_seek_fn (void *__cookie, __off64_t *__pos, int __w);


typedef int __io_close_fn (void *__cookie);
# 418 "/usr/include/libio.h" 3 4
extern int __underflow (_IO_FILE *);
extern int __uflow (_IO_FILE *);
extern int __overflow (_IO_FILE *, int);
# 462 "/usr/include/libio.h" 3 4
extern int _IO_getc (_IO_FILE *__fp);
extern int _IO_putc (int __c, _IO_FILE *__fp);
extern int _IO_feof (_IO_FILE *__fp) __attribute__ ((__nothrow__ , __leaf__));
extern int _IO_ferror (_IO_FILE *__fp) __attribute__ ((__nothrow__ , __leaf__));

extern int _IO_peekc_locked (_IO_FILE *__fp);





extern void _IO_flockfile (_IO_FILE *) __attribute__ ((__nothrow__ , __leaf__));
extern void _IO_funlockfile (_IO_FILE *) __attribute__ ((__nothrow__ , __leaf__));
extern int _IO_ftrylockfile (_IO_FILE *) __attribute__ ((__nothrow__ , __leaf__));
# 492 "/usr/include/libio.h" 3 4
extern int _IO_vfscanf (_IO_FILE * __restrict, const char * __restrict,
   __gnuc_va_list, int *__restrict);
extern int _IO_vfprintf (_IO_FILE *__restrict, const char *__restrict,
    __gnuc_va_list);
extern __ssize_t _IO_padn (_IO_FILE *, int, __ssize_t);
extern size_t _IO_sgetn (_IO_FILE *, void *, size_t);

extern __off64_t _IO_seekoff (_IO_FILE *, __off64_t, int, int);
extern __off64_t _IO_seekpos (_IO_FILE *, __off64_t, int);

extern void _IO_free_backup_area (_IO_FILE *) __attribute__ ((__nothrow__ , __leaf__));
# 76 "/usr/include/stdio.h" 2 3 4




typedef __gnuc_va_list va_list;
# 109 "/usr/include/stdio.h" 3 4


typedef _G_fpos_t fpos_t;




# 165 "/usr/include/stdio.h" 3 4
# 1 "/usr/include/bits/stdio_lim.h" 1 3 4
# 166 "/usr/include/stdio.h" 2 3 4



extern struct _IO_FILE *stdin;
extern struct _IO_FILE *stdout;
extern struct _IO_FILE *stderr;









extern int remove (__const char *__filename) __attribute__ ((__nothrow__ , __leaf__));

extern int rename (__const char *__old, __const char *__new) __attribute__ ((__nothrow__ , __leaf__));




extern int renameat (int __oldfd, __const char *__old, int __newfd,
       __const char *__new) __attribute__ ((__nothrow__ , __leaf__));








extern FILE *tmpfile (void) ;
# 212 "/usr/include/stdio.h" 3 4
extern char *tmpnam (char *__s) __attribute__ ((__nothrow__ , __leaf__)) ;





extern char *tmpnam_r (char *__s) __attribute__ ((__nothrow__ , __leaf__)) ;
# 230 "/usr/include/stdio.h" 3 4
extern char *tempnam (__const char *__dir, __const char *__pfx)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__malloc__)) ;








extern int fclose (FILE *__stream);




extern int fflush (FILE *__stream);

# 255 "/usr/include/stdio.h" 3 4
extern int fflush_unlocked (FILE *__stream);
# 269 "/usr/include/stdio.h" 3 4






extern FILE *fopen (__const char *__restrict __filename,
      __const char *__restrict __modes) ;




extern FILE *freopen (__const char *__restrict __filename,
        __const char *__restrict __modes,
        FILE *__restrict __stream) ;
# 298 "/usr/include/stdio.h" 3 4

# 309 "/usr/include/stdio.h" 3 4
extern FILE *fdopen (int __fd, __const char *__modes) __attribute__ ((__nothrow__ , __leaf__)) ;
# 322 "/usr/include/stdio.h" 3 4
extern FILE *fmemopen (void *__s, size_t __len, __const char *__modes)
  __attribute__ ((__nothrow__ , __leaf__)) ;




extern FILE *open_memstream (char **__bufloc, size_t *__sizeloc) __attribute__ ((__nothrow__ , __leaf__)) ;






extern void setbuf (FILE *__restrict __stream, char *__restrict __buf) __attribute__ ((__nothrow__ , __leaf__));



extern int setvbuf (FILE *__restrict __stream, char *__restrict __buf,
      int __modes, size_t __n) __attribute__ ((__nothrow__ , __leaf__));





extern void setbuffer (FILE *__restrict __stream, char *__restrict __buf,
         size_t __size) __attribute__ ((__nothrow__ , __leaf__));


extern void setlinebuf (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__));








extern int fprintf (FILE *__restrict __stream,
      __const char *__restrict __format, ...);




extern int printf (__const char *__restrict __format, ...);

extern int sprintf (char *__restrict __s,
      __const char *__restrict __format, ...) __attribute__ ((__nothrow__));





extern int vfprintf (FILE *__restrict __s, __const char *__restrict __format,
       __gnuc_va_list __arg);




extern int vprintf (__const char *__restrict __format, __gnuc_va_list __arg);

extern int vsprintf (char *__restrict __s, __const char *__restrict __format,
       __gnuc_va_list __arg) __attribute__ ((__nothrow__));





extern int snprintf (char *__restrict __s, size_t __maxlen,
       __const char *__restrict __format, ...)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 3, 4)));

extern int vsnprintf (char *__restrict __s, size_t __maxlen,
        __const char *__restrict __format, __gnuc_va_list __arg)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 3, 0)));

# 420 "/usr/include/stdio.h" 3 4
extern int vdprintf (int __fd, __const char *__restrict __fmt,
       __gnuc_va_list __arg)
     __attribute__ ((__format__ (__printf__, 2, 0)));
extern int dprintf (int __fd, __const char *__restrict __fmt, ...)
     __attribute__ ((__format__ (__printf__, 2, 3)));








extern int fscanf (FILE *__restrict __stream,
     __const char *__restrict __format, ...) ;




extern int scanf (__const char *__restrict __format, ...) ;

extern int sscanf (__const char *__restrict __s,
     __const char *__restrict __format, ...) __attribute__ ((__nothrow__ , __leaf__));
# 451 "/usr/include/stdio.h" 3 4
extern int fscanf (FILE *__restrict __stream, __const char *__restrict __format, ...) __asm__ ("" "__isoc99_fscanf")

                               ;
extern int scanf (__const char *__restrict __format, ...) __asm__ ("" "__isoc99_scanf")
                              ;
extern int sscanf (__const char *__restrict __s, __const char *__restrict __format, ...) __asm__ ("" "__isoc99_sscanf") __attribute__ ((__nothrow__ , __leaf__))

                      ;
# 471 "/usr/include/stdio.h" 3 4








extern int vfscanf (FILE *__restrict __s, __const char *__restrict __format,
      __gnuc_va_list __arg)
     __attribute__ ((__format__ (__scanf__, 2, 0))) ;





extern int vscanf (__const char *__restrict __format, __gnuc_va_list __arg)
     __attribute__ ((__format__ (__scanf__, 1, 0))) ;


extern int vsscanf (__const char *__restrict __s,
      __const char *__restrict __format, __gnuc_va_list __arg)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__format__ (__scanf__, 2, 0)));
# 502 "/usr/include/stdio.h" 3 4
extern int vfscanf (FILE *__restrict __s, __const char *__restrict __format, __gnuc_va_list __arg) __asm__ ("" "__isoc99_vfscanf")



     __attribute__ ((__format__ (__scanf__, 2, 0))) ;
extern int vscanf (__const char *__restrict __format, __gnuc_va_list __arg) __asm__ ("" "__isoc99_vscanf")

     __attribute__ ((__format__ (__scanf__, 1, 0))) ;
extern int vsscanf (__const char *__restrict __s, __const char *__restrict __format, __gnuc_va_list __arg) __asm__ ("" "__isoc99_vsscanf") __attribute__ ((__nothrow__ , __leaf__))



     __attribute__ ((__format__ (__scanf__, 2, 0)));
# 530 "/usr/include/stdio.h" 3 4









extern int fgetc (FILE *__stream);
extern int getc (FILE *__stream);





extern int getchar (void);

# 558 "/usr/include/stdio.h" 3 4
extern int getc_unlocked (FILE *__stream);
extern int getchar_unlocked (void);
# 569 "/usr/include/stdio.h" 3 4
extern int fgetc_unlocked (FILE *__stream);











extern int fputc (int __c, FILE *__stream);
extern int putc (int __c, FILE *__stream);





extern int putchar (int __c);

# 602 "/usr/include/stdio.h" 3 4
extern int fputc_unlocked (int __c, FILE *__stream);







extern int putc_unlocked (int __c, FILE *__stream);
extern int putchar_unlocked (int __c);






extern int getw (FILE *__stream);


extern int putw (int __w, FILE *__stream);








extern char *fgets (char *__restrict __s, int __n, FILE *__restrict __stream)
     ;






extern char *gets (char *__s) ;

# 664 "/usr/include/stdio.h" 3 4
extern __ssize_t __getdelim (char **__restrict __lineptr,
          size_t *__restrict __n, int __delimiter,
          FILE *__restrict __stream) ;
extern __ssize_t getdelim (char **__restrict __lineptr,
        size_t *__restrict __n, int __delimiter,
        FILE *__restrict __stream) ;







extern __ssize_t getline (char **__restrict __lineptr,
       size_t *__restrict __n,
       FILE *__restrict __stream) ;








extern int fputs (__const char *__restrict __s, FILE *__restrict __stream);





extern int puts (__const char *__s);






extern int ungetc (int __c, FILE *__stream);






extern size_t fread (void *__restrict __ptr, size_t __size,
       size_t __n, FILE *__restrict __stream) ;




extern size_t fwrite (__const void *__restrict __ptr, size_t __size,
        size_t __n, FILE *__restrict __s) ;

# 736 "/usr/include/stdio.h" 3 4
extern size_t fread_unlocked (void *__restrict __ptr, size_t __size,
         size_t __n, FILE *__restrict __stream) ;
extern size_t fwrite_unlocked (__const void *__restrict __ptr, size_t __size,
          size_t __n, FILE *__restrict __stream) ;








extern int fseek (FILE *__stream, long int __off, int __whence);




extern long int ftell (FILE *__stream) ;




extern void rewind (FILE *__stream);

# 772 "/usr/include/stdio.h" 3 4
extern int fseeko (FILE *__stream, __off_t __off, int __whence);




extern __off_t ftello (FILE *__stream) ;
# 791 "/usr/include/stdio.h" 3 4






extern int fgetpos (FILE *__restrict __stream, fpos_t *__restrict __pos);




extern int fsetpos (FILE *__stream, __const fpos_t *__pos);
# 814 "/usr/include/stdio.h" 3 4

# 823 "/usr/include/stdio.h" 3 4


extern void clearerr (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__));

extern int feof (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;

extern int ferror (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;




extern void clearerr_unlocked (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__));
extern int feof_unlocked (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;
extern int ferror_unlocked (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;








extern void perror (__const char *__s);






# 1 "/usr/include/bits/sys_errlist.h" 1 3 4
# 27 "/usr/include/bits/sys_errlist.h" 3 4
extern int sys_nerr;
extern __const char *__const sys_errlist[];
# 853 "/usr/include/stdio.h" 2 3 4




extern int fileno (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;




extern int fileno_unlocked (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;
# 872 "/usr/include/stdio.h" 3 4
extern FILE *popen (__const char *__command, __const char *__modes) ;





extern int pclose (FILE *__stream);





extern char *ctermid (char *__s) __attribute__ ((__nothrow__ , __leaf__));
# 912 "/usr/include/stdio.h" 3 4
extern void flockfile (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__));



extern int ftrylockfile (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;


extern void funlockfile (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__));
# 942 "/usr/include/stdio.h" 3 4

# 31 "./inc/string_buffer.h" 2
# 33 "./inc/error_parser.h" 2




typedef struct ErrorParser
{


    S3ErrorDetails s3ErrorDetails;


    SimpleXml errorXmlParser;


    int errorXmlParserInitialized;


    char code[1024 + 1]; int codeLen;


    char message[1024 + 1]; int messageLen;


    char resource[1024 + 1]; int resourceLen;


    char furtherDetails[1024 + 1]; int furtherDetailsLen;


    S3NameValue extraDetails[8];



    char extraDetailsNamesValues[8 * 1024]; int extraDetailsNamesValuesSize;
} ErrorParser;



void error_parser_initialize(ErrorParser *errorParser);

S3Status error_parser_add(ErrorParser *errorParser, char *buffer,
                          int bufferSize);

void error_parser_convert_status(ErrorParser *errorParser, S3Status *status);


void error_parser_deinitialize(ErrorParser *errorParser);
# 32 "./inc/request.h" 2
# 1 "./inc/response_headers_handler.h" 1
# 32 "./inc/response_headers_handler.h"
# 1 "./inc/util.h" 1
# 30 "./inc/util.h"
# 1 "/usr/include/curl/curl.h" 1 3 4
# 33 "/usr/include/curl/curl.h" 3 4
# 1 "/usr/include/curl/curlver.h" 1 3 4
# 34 "/usr/include/curl/curl.h" 2 3 4
# 1 "/usr/include/curl/curlbuild.h" 1 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 2 "/usr/include/curl/curlbuild.h" 2 3 4




# 1 "/usr/include/curl/curlbuild-64.h" 1 3 4
# 152 "/usr/include/curl/curlbuild-64.h" 3 4
# 1 "/usr/include/sys/socket.h" 1 3 4
# 26 "/usr/include/sys/socket.h" 3 4


# 1 "/usr/include/sys/uio.h" 1 3 4
# 26 "/usr/include/sys/uio.h" 3 4



# 1 "/usr/include/bits/uio.h" 1 3 4
# 44 "/usr/include/bits/uio.h" 3 4
struct iovec
  {
    void *iov_base;
    size_t iov_len;
  };









extern ssize_t process_vm_readv (pid_t __pid, __const struct iovec *__lvec,
     unsigned long int __liovcnt,
     __const struct iovec *__rvec,
     unsigned long int __riovcnt,
     unsigned long int __flags)
  __attribute__ ((__nothrow__ , __leaf__));


extern ssize_t process_vm_writev (pid_t __pid, __const struct iovec *__lvec,
      unsigned long int __liovcnt,
      __const struct iovec *__rvec,
      unsigned long int __riovcnt,
      unsigned long int __flags)
  __attribute__ ((__nothrow__ , __leaf__));


# 30 "/usr/include/sys/uio.h" 2 3 4
# 40 "/usr/include/sys/uio.h" 3 4
extern ssize_t readv (int __fd, __const struct iovec *__iovec, int __count)
  ;
# 51 "/usr/include/sys/uio.h" 3 4
extern ssize_t writev (int __fd, __const struct iovec *__iovec, int __count)
  ;
# 66 "/usr/include/sys/uio.h" 3 4
extern ssize_t preadv (int __fd, __const struct iovec *__iovec, int __count,
         __off_t __offset) ;
# 78 "/usr/include/sys/uio.h" 3 4
extern ssize_t pwritev (int __fd, __const struct iovec *__iovec, int __count,
   __off_t __offset) ;
# 121 "/usr/include/sys/uio.h" 3 4

# 29 "/usr/include/sys/socket.h" 2 3 4

# 1 "/usr/lib/gcc/x86_64-redhat-linux/4.7.0/include/stddef.h" 1 3 4
# 31 "/usr/include/sys/socket.h" 2 3 4
# 40 "/usr/include/sys/socket.h" 3 4
# 1 "/usr/include/bits/socket.h" 1 3 4
# 29 "/usr/include/bits/socket.h" 3 4
# 1 "/usr/lib/gcc/x86_64-redhat-linux/4.7.0/include/stddef.h" 1 3 4
# 30 "/usr/include/bits/socket.h" 2 3 4





typedef __socklen_t socklen_t;




enum __socket_type
{
  SOCK_STREAM = 1,


  SOCK_DGRAM = 2,


  SOCK_RAW = 3,

  SOCK_RDM = 4,

  SOCK_SEQPACKET = 5,


  SOCK_DCCP = 6,

  SOCK_PACKET = 10,







  SOCK_CLOEXEC = 02000000,


  SOCK_NONBLOCK = 04000


};
# 177 "/usr/include/bits/socket.h" 3 4
# 1 "/usr/include/bits/sockaddr.h" 1 3 4
# 29 "/usr/include/bits/sockaddr.h" 3 4
typedef unsigned short int sa_family_t;
# 178 "/usr/include/bits/socket.h" 2 3 4


struct sockaddr
  {
    sa_family_t sa_family;
    char sa_data[14];
  };
# 193 "/usr/include/bits/socket.h" 3 4
struct sockaddr_storage
  {
    sa_family_t ss_family;
    unsigned long int __ss_align;
    char __ss_padding[(128 - (2 * sizeof (unsigned long int)))];
  };



enum
  {
    MSG_OOB = 0x01,

    MSG_PEEK = 0x02,

    MSG_DONTROUTE = 0x04,






    MSG_CTRUNC = 0x08,

    MSG_PROXY = 0x10,

    MSG_TRUNC = 0x20,

    MSG_DONTWAIT = 0x40,

    MSG_EOR = 0x80,

    MSG_WAITALL = 0x100,

    MSG_FIN = 0x200,

    MSG_SYN = 0x400,

    MSG_CONFIRM = 0x800,

    MSG_RST = 0x1000,

    MSG_ERRQUEUE = 0x2000,

    MSG_NOSIGNAL = 0x4000,

    MSG_MORE = 0x8000,

    MSG_WAITFORONE = 0x10000,


    MSG_CMSG_CLOEXEC = 0x40000000



  };




struct msghdr
  {
    void *msg_name;
    socklen_t msg_namelen;

    struct iovec *msg_iov;
    size_t msg_iovlen;

    void *msg_control;
    size_t msg_controllen;




    int msg_flags;
  };
# 280 "/usr/include/bits/socket.h" 3 4
struct cmsghdr
  {
    size_t cmsg_len;




    int cmsg_level;
    int cmsg_type;

    __extension__ unsigned char __cmsg_data [];

  };
# 310 "/usr/include/bits/socket.h" 3 4
extern struct cmsghdr *__cmsg_nxthdr (struct msghdr *__mhdr,
          struct cmsghdr *__cmsg) __attribute__ ((__nothrow__ , __leaf__));
# 337 "/usr/include/bits/socket.h" 3 4
enum
  {
    SCM_RIGHTS = 0x01





  };
# 383 "/usr/include/bits/socket.h" 3 4
# 1 "/usr/include/asm/socket.h" 1 3 4
# 1 "/usr/include/asm-generic/socket.h" 1 3 4



# 1 "/usr/include/asm/sockios.h" 1 3 4
# 1 "/usr/include/asm-generic/sockios.h" 1 3 4
# 1 "/usr/include/asm/sockios.h" 2 3 4
# 5 "/usr/include/asm-generic/socket.h" 2 3 4
# 1 "/usr/include/asm/socket.h" 2 3 4
# 384 "/usr/include/bits/socket.h" 2 3 4
# 417 "/usr/include/bits/socket.h" 3 4
struct linger
  {
    int l_onoff;
    int l_linger;
  };









extern int recvmmsg (int __fd, struct mmsghdr *__vmessages,
       unsigned int __vlen, int __flags,
       __const struct timespec *__tmo);





extern int sendmmsg (int __fd, struct mmsghdr *__vmessages,
       unsigned int __vlen, int __flags);


# 41 "/usr/include/sys/socket.h" 2 3 4




struct osockaddr
  {
    unsigned short int sa_family;
    unsigned char sa_data[14];
  };




enum
{
  SHUT_RD = 0,

  SHUT_WR,

  SHUT_RDWR

};
# 105 "/usr/include/sys/socket.h" 3 4
extern int socket (int __domain, int __type, int __protocol) __attribute__ ((__nothrow__ , __leaf__));





extern int socketpair (int __domain, int __type, int __protocol,
         int __fds[2]) __attribute__ ((__nothrow__ , __leaf__));


extern int bind (int __fd, __const struct sockaddr * __addr, socklen_t __len)
     __attribute__ ((__nothrow__ , __leaf__));


extern int getsockname (int __fd, struct sockaddr *__restrict __addr,
   socklen_t *__restrict __len) __attribute__ ((__nothrow__ , __leaf__));
# 129 "/usr/include/sys/socket.h" 3 4
extern int connect (int __fd, __const struct sockaddr * __addr, socklen_t __len);



extern int getpeername (int __fd, struct sockaddr *__restrict __addr,
   socklen_t *__restrict __len) __attribute__ ((__nothrow__ , __leaf__));






extern ssize_t send (int __fd, __const void *__buf, size_t __n, int __flags);






extern ssize_t recv (int __fd, void *__buf, size_t __n, int __flags);






extern ssize_t sendto (int __fd, __const void *__buf, size_t __n,
         int __flags, __const struct sockaddr * __addr,
         socklen_t __addr_len);
# 166 "/usr/include/sys/socket.h" 3 4
extern ssize_t recvfrom (int __fd, void *__restrict __buf, size_t __n,
    int __flags, struct sockaddr *__restrict __addr,
    socklen_t *__restrict __addr_len);







extern ssize_t sendmsg (int __fd, __const struct msghdr *__message,
   int __flags);






extern ssize_t recvmsg (int __fd, struct msghdr *__message, int __flags);





extern int getsockopt (int __fd, int __level, int __optname,
         void *__restrict __optval,
         socklen_t *__restrict __optlen) __attribute__ ((__nothrow__ , __leaf__));




extern int setsockopt (int __fd, int __level, int __optname,
         __const void *__optval, socklen_t __optlen) __attribute__ ((__nothrow__ , __leaf__));





extern int listen (int __fd, int __n) __attribute__ ((__nothrow__ , __leaf__));
# 214 "/usr/include/sys/socket.h" 3 4
extern int accept (int __fd, struct sockaddr *__restrict __addr,
     socklen_t *__restrict __addr_len);
# 232 "/usr/include/sys/socket.h" 3 4
extern int shutdown (int __fd, int __how) __attribute__ ((__nothrow__ , __leaf__));




extern int sockatmark (int __fd) __attribute__ ((__nothrow__ , __leaf__));







extern int isfdtype (int __fd, int __fdtype) __attribute__ ((__nothrow__ , __leaf__));
# 254 "/usr/include/sys/socket.h" 3 4

# 153 "/usr/include/curl/curlbuild-64.h" 2 3 4
# 165 "/usr/include/curl/curlbuild-64.h" 3 4
typedef socklen_t curl_socklen_t;





typedef long curl_off_t;
# 7 "/usr/include/curl/curlbuild.h" 2 3 4
# 35 "/usr/include/curl/curl.h" 2 3 4
# 1 "/usr/include/curl/curlrules.h" 1 3 4
# 141 "/usr/include/curl/curlrules.h" 3 4
typedef char
  __curl_rule_01__
    [sizeof(long) == 8 ? 1 : -1];







typedef char
  __curl_rule_02__
    [sizeof(curl_off_t) == 8 ? 1 : -1];







typedef char
  __curl_rule_03__
    [sizeof(curl_off_t) >= sizeof(long) ? 1 : -1];







typedef char
  __curl_rule_04__
    [sizeof(curl_socklen_t) == 4 ? 1 : -1];







typedef char
  __curl_rule_05__
    [sizeof(curl_socklen_t) >= sizeof(int) ? 1 : -1];
# 36 "/usr/include/curl/curl.h" 2 3 4
# 47 "/usr/include/curl/curl.h" 3 4
# 1 "/usr/lib/gcc/x86_64-redhat-linux/4.7.0/include/limits.h" 1 3 4
# 34 "/usr/lib/gcc/x86_64-redhat-linux/4.7.0/include/limits.h" 3 4
# 1 "/usr/lib/gcc/x86_64-redhat-linux/4.7.0/include/syslimits.h" 1 3 4






# 1 "/usr/lib/gcc/x86_64-redhat-linux/4.7.0/include/limits.h" 1 3 4
# 169 "/usr/lib/gcc/x86_64-redhat-linux/4.7.0/include/limits.h" 3 4
# 1 "/usr/include/limits.h" 1 3 4
# 145 "/usr/include/limits.h" 3 4
# 1 "/usr/include/bits/posix1_lim.h" 1 3 4
# 157 "/usr/include/bits/posix1_lim.h" 3 4
# 1 "/usr/include/bits/local_lim.h" 1 3 4
# 39 "/usr/include/bits/local_lim.h" 3 4
# 1 "/usr/include/linux/limits.h" 1 3 4
# 40 "/usr/include/bits/local_lim.h" 2 3 4
# 158 "/usr/include/bits/posix1_lim.h" 2 3 4
# 146 "/usr/include/limits.h" 2 3 4



# 1 "/usr/include/bits/posix2_lim.h" 1 3 4
# 150 "/usr/include/limits.h" 2 3 4
# 170 "/usr/lib/gcc/x86_64-redhat-linux/4.7.0/include/limits.h" 2 3 4
# 8 "/usr/lib/gcc/x86_64-redhat-linux/4.7.0/include/syslimits.h" 2 3 4
# 35 "/usr/lib/gcc/x86_64-redhat-linux/4.7.0/include/limits.h" 2 3 4
# 48 "/usr/include/curl/curl.h" 2 3 4
# 82 "/usr/include/curl/curl.h" 3 4
# 1 "/usr/include/sys/time.h" 1 3 4
# 29 "/usr/include/sys/time.h" 3 4
# 1 "/usr/include/bits/time.h" 1 3 4
# 30 "/usr/include/sys/time.h" 2 3 4
# 39 "/usr/include/sys/time.h" 3 4

# 57 "/usr/include/sys/time.h" 3 4
struct timezone
  {
    int tz_minuteswest;
    int tz_dsttime;
  };

typedef struct timezone *__restrict __timezone_ptr_t;
# 73 "/usr/include/sys/time.h" 3 4
extern int gettimeofday (struct timeval *__restrict __tv,
    __timezone_ptr_t __tz) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));




extern int settimeofday (__const struct timeval *__tv,
    __const struct timezone *__tz)
     __attribute__ ((__nothrow__ , __leaf__));





extern int adjtime (__const struct timeval *__delta,
      struct timeval *__olddelta) __attribute__ ((__nothrow__ , __leaf__));




enum __itimer_which
  {

    ITIMER_REAL = 0,


    ITIMER_VIRTUAL = 1,



    ITIMER_PROF = 2

  };



struct itimerval
  {

    struct timeval it_interval;

    struct timeval it_value;
  };






typedef int __itimer_which_t;




extern int getitimer (__itimer_which_t __which,
        struct itimerval *__value) __attribute__ ((__nothrow__ , __leaf__));




extern int setitimer (__itimer_which_t __which,
        __const struct itimerval *__restrict __new,
        struct itimerval *__restrict __old) __attribute__ ((__nothrow__ , __leaf__));




extern int utimes (__const char *__file, __const struct timeval __tvp[2])
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));



extern int lutimes (__const char *__file, __const struct timeval __tvp[2])
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern int futimes (int __fd, __const struct timeval __tvp[2]) __attribute__ ((__nothrow__ , __leaf__));
# 191 "/usr/include/sys/time.h" 3 4

# 83 "/usr/include/curl/curl.h" 2 3 4
# 93 "/usr/include/curl/curl.h" 3 4
typedef void CURL;
# 127 "/usr/include/curl/curl.h" 3 4
typedef int curl_socket_t;





struct curl_httppost {
  struct curl_httppost *next;
  char *name;
  long namelength;
  char *contents;
  long contentslength;
  char *buffer;
  long bufferlength;
  char *contenttype;
  struct curl_slist* contentheader;
  struct curl_httppost *more;


  long flags;
# 160 "/usr/include/curl/curl.h" 3 4
  char *showfilename;


  void *userp;

};

typedef int (*curl_progress_callback)(void *clientp,
                                      double dltotal,
                                      double dlnow,
                                      double ultotal,
                                      double ulnow);
# 194 "/usr/include/curl/curl.h" 3 4
typedef size_t (*curl_write_callback)(char *buffer,
                                      size_t size,
                                      size_t nitems,
                                      void *outstream);




typedef enum {
  CURLFILETYPE_FILE = 0,
  CURLFILETYPE_DIRECTORY,
  CURLFILETYPE_SYMLINK,
  CURLFILETYPE_DEVICE_BLOCK,
  CURLFILETYPE_DEVICE_CHAR,
  CURLFILETYPE_NAMEDPIPE,
  CURLFILETYPE_SOCKET,
  CURLFILETYPE_DOOR,

  CURLFILETYPE_UNKNOWN
} curlfiletype;
# 228 "/usr/include/curl/curl.h" 3 4
struct curl_fileinfo {
  char *filename;
  curlfiletype filetype;
  time_t time;
  unsigned int perm;
  int uid;
  int gid;
  curl_off_t size;
  long int hardlinks;

  struct {

    char *time;
    char *perm;
    char *user;
    char *group;
    char *target;
  } strings;

  unsigned int flags;


  char * b_data;
  size_t b_size;
  size_t b_used;
};
# 263 "/usr/include/curl/curl.h" 3 4
typedef long (*curl_chunk_bgn_callback)(const void *transfer_info,
                                        void *ptr,
                                        int remains);
# 277 "/usr/include/curl/curl.h" 3 4
typedef long (*curl_chunk_end_callback)(void *ptr);
# 286 "/usr/include/curl/curl.h" 3 4
typedef int (*curl_fnmatch_callback)(void *ptr,
                                     const char *pattern,
                                     const char *string);






typedef int (*curl_seek_callback)(void *instream,
                                  curl_off_t offset,
                                  int origin);
# 306 "/usr/include/curl/curl.h" 3 4
typedef size_t (*curl_read_callback)(char *buffer,
                                      size_t size,
                                      size_t nitems,
                                      void *instream);

typedef enum {
  CURLSOCKTYPE_IPCXN,
  CURLSOCKTYPE_LAST
} curlsocktype;
# 323 "/usr/include/curl/curl.h" 3 4
typedef int (*curl_sockopt_callback)(void *clientp,
                                     curl_socket_t curlfd,
                                     curlsocktype purpose);

struct curl_sockaddr {
  int family;
  int socktype;
  int protocol;
  unsigned int addrlen;


  struct sockaddr addr;
};

typedef curl_socket_t
(*curl_opensocket_callback)(void *clientp,
                            curlsocktype purpose,
                            struct curl_sockaddr *address);

typedef int
(*curl_closesocket_callback)(void *clientp, curl_socket_t item);

typedef enum {
  CURLIOE_OK,
  CURLIOE_UNKNOWNCMD,
  CURLIOE_FAILRESTART,
  CURLIOE_LAST
} curlioerr;

typedef enum {
  CURLIOCMD_NOP,
  CURLIOCMD_RESTARTREAD,
  CURLIOCMD_LAST
} curliocmd;

typedef curlioerr (*curl_ioctl_callback)(CURL *handle,
                                         int cmd,
                                         void *clientp);







typedef void *(*curl_malloc_callback)(size_t size);
typedef void (*curl_free_callback)(void *ptr);
typedef void *(*curl_realloc_callback)(void *ptr, size_t size);
typedef char *(*curl_strdup_callback)(const char *str);
typedef void *(*curl_calloc_callback)(size_t nmemb, size_t size);


typedef enum {
  CURLINFO_TEXT = 0,
  CURLINFO_HEADER_IN,
  CURLINFO_HEADER_OUT,
  CURLINFO_DATA_IN,
  CURLINFO_DATA_OUT,
  CURLINFO_SSL_DATA_IN,
  CURLINFO_SSL_DATA_OUT,
  CURLINFO_END
} curl_infotype;

typedef int (*curl_debug_callback)
       (CURL *handle,
        curl_infotype type,
        char *data,
        size_t size,
        void *userptr);
# 400 "/usr/include/curl/curl.h" 3 4
typedef enum {
  CURLE_OK = 0,
  CURLE_UNSUPPORTED_PROTOCOL,
  CURLE_FAILED_INIT,
  CURLE_URL_MALFORMAT,
  CURLE_NOT_BUILT_IN,

  CURLE_COULDNT_RESOLVE_PROXY,
  CURLE_COULDNT_RESOLVE_HOST,
  CURLE_COULDNT_CONNECT,
  CURLE_FTP_WEIRD_SERVER_REPLY,
  CURLE_REMOTE_ACCESS_DENIED,


  CURLE_FTP_ACCEPT_FAILED,

  CURLE_FTP_WEIRD_PASS_REPLY,
  CURLE_FTP_ACCEPT_TIMEOUT,


  CURLE_FTP_WEIRD_PASV_REPLY,
  CURLE_FTP_WEIRD_227_FORMAT,
  CURLE_FTP_CANT_GET_HOST,
  CURLE_OBSOLETE16,
  CURLE_FTP_COULDNT_SET_TYPE,
  CURLE_PARTIAL_FILE,
  CURLE_FTP_COULDNT_RETR_FILE,
  CURLE_OBSOLETE20,
  CURLE_QUOTE_ERROR,
  CURLE_HTTP_RETURNED_ERROR,
  CURLE_WRITE_ERROR,
  CURLE_OBSOLETE24,
  CURLE_UPLOAD_FAILED,
  CURLE_READ_ERROR,
  CURLE_OUT_OF_MEMORY,




  CURLE_OPERATION_TIMEDOUT,
  CURLE_OBSOLETE29,
  CURLE_FTP_PORT_FAILED,
  CURLE_FTP_COULDNT_USE_REST,
  CURLE_OBSOLETE32,
  CURLE_RANGE_ERROR,
  CURLE_HTTP_POST_ERROR,
  CURLE_SSL_CONNECT_ERROR,
  CURLE_BAD_DOWNLOAD_RESUME,
  CURLE_FILE_COULDNT_READ_FILE,
  CURLE_LDAP_CANNOT_BIND,
  CURLE_LDAP_SEARCH_FAILED,
  CURLE_OBSOLETE40,
  CURLE_FUNCTION_NOT_FOUND,
  CURLE_ABORTED_BY_CALLBACK,
  CURLE_BAD_FUNCTION_ARGUMENT,
  CURLE_OBSOLETE44,
  CURLE_INTERFACE_FAILED,
  CURLE_OBSOLETE46,
  CURLE_TOO_MANY_REDIRECTS ,
  CURLE_UNKNOWN_OPTION,
  CURLE_TELNET_OPTION_SYNTAX ,
  CURLE_OBSOLETE50,
  CURLE_PEER_FAILED_VERIFICATION,

  CURLE_GOT_NOTHING,
  CURLE_SSL_ENGINE_NOTFOUND,
  CURLE_SSL_ENGINE_SETFAILED,

  CURLE_SEND_ERROR,
  CURLE_RECV_ERROR,
  CURLE_OBSOLETE57,
  CURLE_SSL_CERTPROBLEM,
  CURLE_SSL_CIPHER,
  CURLE_SSL_CACERT,
  CURLE_BAD_CONTENT_ENCODING,
  CURLE_LDAP_INVALID_URL,
  CURLE_FILESIZE_EXCEEDED,
  CURLE_USE_SSL_FAILED,
  CURLE_SEND_FAIL_REWIND,

  CURLE_SSL_ENGINE_INITFAILED,
  CURLE_LOGIN_DENIED,

  CURLE_TFTP_NOTFOUND,
  CURLE_TFTP_PERM,
  CURLE_REMOTE_DISK_FULL,
  CURLE_TFTP_ILLEGAL,
  CURLE_TFTP_UNKNOWNID,
  CURLE_REMOTE_FILE_EXISTS,
  CURLE_TFTP_NOSUCHUSER,
  CURLE_CONV_FAILED,
  CURLE_CONV_REQD,




  CURLE_SSL_CACERT_BADFILE,

  CURLE_REMOTE_FILE_NOT_FOUND,
  CURLE_SSH,



  CURLE_SSL_SHUTDOWN_FAILED,

  CURLE_AGAIN,


  CURLE_SSL_CRL_BADFILE,

  CURLE_SSL_ISSUER_ERROR,

  CURLE_FTP_PRET_FAILED,
  CURLE_RTSP_CSEQ_ERROR,
  CURLE_RTSP_SESSION_ERROR,
  CURLE_FTP_BAD_FILE_LIST,
  CURLE_CHUNK_FAILED,
  CURL_LAST
} CURLcode;
# 580 "/usr/include/curl/curl.h" 3 4
typedef CURLcode (*curl_conv_callback)(char *buffer, size_t length);

typedef CURLcode (*curl_ssl_ctx_callback)(CURL *curl,
                                          void *ssl_ctx,

                                          void *userptr);

typedef enum {
  CURLPROXY_HTTP = 0,

  CURLPROXY_HTTP_1_0 = 1,

  CURLPROXY_SOCKS4 = 4,

  CURLPROXY_SOCKS5 = 5,
  CURLPROXY_SOCKS4A = 6,
  CURLPROXY_SOCKS5_HOSTNAME = 7


} curl_proxytype;
# 628 "/usr/include/curl/curl.h" 3 4
struct curl_khkey {
  const char *key;

  size_t len;
  enum type {
    CURLKHTYPE_UNKNOWN,
    CURLKHTYPE_RSA1,
    CURLKHTYPE_RSA,
    CURLKHTYPE_DSS
  } keytype;
};



enum curl_khstat {
  CURLKHSTAT_FINE_ADD_TO_FILE,
  CURLKHSTAT_FINE,
  CURLKHSTAT_REJECT,
  CURLKHSTAT_DEFER,


  CURLKHSTAT_LAST
};


enum curl_khmatch {
  CURLKHMATCH_OK,
  CURLKHMATCH_MISMATCH,
  CURLKHMATCH_MISSING,
  CURLKHMATCH_LAST
};

typedef int
  (*curl_sshkeycallback) (CURL *easy,
                          const struct curl_khkey *knownkey,
                          const struct curl_khkey *foundkey,
                          enum curl_khmatch,
                          void *clientp);


typedef enum {
  CURLUSESSL_NONE,
  CURLUSESSL_TRY,
  CURLUSESSL_CONTROL,
  CURLUSESSL_ALL,
  CURLUSESSL_LAST
} curl_usessl;
# 691 "/usr/include/curl/curl.h" 3 4
typedef enum {
  CURLFTPSSL_CCC_NONE,
  CURLFTPSSL_CCC_PASSIVE,
  CURLFTPSSL_CCC_ACTIVE,
  CURLFTPSSL_CCC_LAST
} curl_ftpccc;


typedef enum {
  CURLFTPAUTH_DEFAULT,
  CURLFTPAUTH_SSL,
  CURLFTPAUTH_TLS,
  CURLFTPAUTH_LAST
} curl_ftpauth;


typedef enum {
  CURLFTP_CREATE_DIR_NONE,
  CURLFTP_CREATE_DIR,


  CURLFTP_CREATE_DIR_RETRY,

  CURLFTP_CREATE_DIR_LAST
} curl_ftpcreatedir;


typedef enum {
  CURLFTPMETHOD_DEFAULT,
  CURLFTPMETHOD_MULTICWD,
  CURLFTPMETHOD_NOCWD,
  CURLFTPMETHOD_SINGLECWD,
  CURLFTPMETHOD_LAST
} curl_ftpmethod;
# 786 "/usr/include/curl/curl.h" 3 4
typedef enum {

  CURLOPT_FILE = 10000 + 1,


  CURLOPT_URL = 10000 + 2,


  CURLOPT_PORT = 0 + 3,


  CURLOPT_PROXY = 10000 + 4,


  CURLOPT_USERPWD = 10000 + 5,


  CURLOPT_PROXYUSERPWD = 10000 + 6,


  CURLOPT_RANGE = 10000 + 7,




  CURLOPT_INFILE = 10000 + 9,



  CURLOPT_ERRORBUFFER = 10000 + 10,



  CURLOPT_WRITEFUNCTION = 20000 + 11,



  CURLOPT_READFUNCTION = 20000 + 12,


  CURLOPT_TIMEOUT = 0 + 13,
# 837 "/usr/include/curl/curl.h" 3 4
  CURLOPT_INFILESIZE = 0 + 14,


  CURLOPT_POSTFIELDS = 10000 + 15,


  CURLOPT_REFERER = 10000 + 16,



  CURLOPT_FTPPORT = 10000 + 17,


  CURLOPT_USERAGENT = 10000 + 18,
# 859 "/usr/include/curl/curl.h" 3 4
  CURLOPT_LOW_SPEED_LIMIT = 0 + 19,


  CURLOPT_LOW_SPEED_TIME = 0 + 20,







  CURLOPT_RESUME_FROM = 0 + 21,


  CURLOPT_COOKIE = 10000 + 22,


  CURLOPT_HTTPHEADER = 10000 + 23,


  CURLOPT_HTTPPOST = 10000 + 24,


  CURLOPT_SSLCERT = 10000 + 25,


  CURLOPT_KEYPASSWD = 10000 + 26,


  CURLOPT_CRLF = 0 + 27,


  CURLOPT_QUOTE = 10000 + 28,



  CURLOPT_WRITEHEADER = 10000 + 29,



  CURLOPT_COOKIEFILE = 10000 + 31,



  CURLOPT_SSLVERSION = 0 + 32,


  CURLOPT_TIMECONDITION = 0 + 33,



  CURLOPT_TIMEVALUE = 0 + 34,







  CURLOPT_CUSTOMREQUEST = 10000 + 36,


  CURLOPT_STDERR = 10000 + 37,




  CURLOPT_POSTQUOTE = 10000 + 39,

  CURLOPT_WRITEINFO = 10000 + 40,

  CURLOPT_VERBOSE = 0 + 41,
  CURLOPT_HEADER = 0 + 42,
  CURLOPT_NOPROGRESS = 0 + 43,
  CURLOPT_NOBODY = 0 + 44,
  CURLOPT_FAILONERROR = 0 + 45,
  CURLOPT_UPLOAD = 0 + 46,
  CURLOPT_POST = 0 + 47,
  CURLOPT_DIRLISTONLY = 0 + 48,

  CURLOPT_APPEND = 0 + 50,



  CURLOPT_NETRC = 0 + 51,

  CURLOPT_FOLLOWLOCATION = 0 + 52,

  CURLOPT_TRANSFERTEXT = 0 + 53,
  CURLOPT_PUT = 0 + 54,






  CURLOPT_PROGRESSFUNCTION = 20000 + 56,


  CURLOPT_PROGRESSDATA = 10000 + 57,


  CURLOPT_AUTOREFERER = 0 + 58,



  CURLOPT_PROXYPORT = 0 + 59,


  CURLOPT_POSTFIELDSIZE = 0 + 60,


  CURLOPT_HTTPPROXYTUNNEL = 0 + 61,


  CURLOPT_INTERFACE = 10000 + 62,




  CURLOPT_KRBLEVEL = 10000 + 63,


  CURLOPT_SSL_VERIFYPEER = 0 + 64,



  CURLOPT_CAINFO = 10000 + 65,





  CURLOPT_MAXREDIRS = 0 + 68,



  CURLOPT_FILETIME = 0 + 69,


  CURLOPT_TELNETOPTIONS = 10000 + 70,


  CURLOPT_MAXCONNECTS = 0 + 71,

  CURLOPT_CLOSEPOLICY = 0 + 72,






  CURLOPT_FRESH_CONNECT = 0 + 74,




  CURLOPT_FORBID_REUSE = 0 + 75,



  CURLOPT_RANDOM_FILE = 10000 + 76,


  CURLOPT_EGDSOCKET = 10000 + 77,




  CURLOPT_CONNECTTIMEOUT = 0 + 78,



  CURLOPT_HEADERFUNCTION = 20000 + 79,




  CURLOPT_HTTPGET = 0 + 80,




  CURLOPT_SSL_VERIFYHOST = 0 + 81,



  CURLOPT_COOKIEJAR = 10000 + 82,


  CURLOPT_SSL_CIPHER_LIST = 10000 + 83,



  CURLOPT_HTTP_VERSION = 0 + 84,




  CURLOPT_FTP_USE_EPSV = 0 + 85,


  CURLOPT_SSLCERTTYPE = 10000 + 86,


  CURLOPT_SSLKEY = 10000 + 87,


  CURLOPT_SSLKEYTYPE = 10000 + 88,


  CURLOPT_SSLENGINE = 10000 + 89,




  CURLOPT_SSLENGINE_DEFAULT = 0 + 90,


  CURLOPT_DNS_USE_GLOBAL_CACHE = 0 + 91,


  CURLOPT_DNS_CACHE_TIMEOUT = 0 + 92,


  CURLOPT_PREQUOTE = 10000 + 93,


  CURLOPT_DEBUGFUNCTION = 20000 + 94,


  CURLOPT_DEBUGDATA = 10000 + 95,


  CURLOPT_COOKIESESSION = 0 + 96,



  CURLOPT_CAPATH = 10000 + 97,


  CURLOPT_BUFFERSIZE = 0 + 98,




  CURLOPT_NOSIGNAL = 0 + 99,


  CURLOPT_SHARE = 10000 + 100,



  CURLOPT_PROXYTYPE = 0 + 101,




  CURLOPT_ACCEPT_ENCODING = 10000 + 102,


  CURLOPT_PRIVATE = 10000 + 103,


  CURLOPT_HTTP200ALIASES = 10000 + 104,




  CURLOPT_UNRESTRICTED_AUTH = 0 + 105,




  CURLOPT_FTP_USE_EPRT = 0 + 106,




  CURLOPT_HTTPAUTH = 0 + 107,




  CURLOPT_SSL_CTX_FUNCTION = 20000 + 108,



  CURLOPT_SSL_CTX_DATA = 10000 + 109,





  CURLOPT_FTP_CREATE_MISSING_DIRS = 0 + 110,




  CURLOPT_PROXYAUTH = 0 + 111,





  CURLOPT_FTP_RESPONSE_TIMEOUT = 0 + 112,





  CURLOPT_IPRESOLVE = 0 + 113,






  CURLOPT_MAXFILESIZE = 0 + 114,




  CURLOPT_INFILESIZE_LARGE = 30000 + 115,




  CURLOPT_RESUME_FROM_LARGE = 30000 + 116,




  CURLOPT_MAXFILESIZE_LARGE = 30000 + 117,





  CURLOPT_NETRC_FILE = 10000 + 118,






  CURLOPT_USE_SSL = 0 + 119,


  CURLOPT_POSTFIELDSIZE_LARGE = 30000 + 120,


  CURLOPT_TCP_NODELAY = 0 + 121,
# 1231 "/usr/include/curl/curl.h" 3 4
  CURLOPT_FTPSSLAUTH = 0 + 129,

  CURLOPT_IOCTLFUNCTION = 20000 + 130,
  CURLOPT_IOCTLDATA = 10000 + 131,






  CURLOPT_FTP_ACCOUNT = 10000 + 134,


  CURLOPT_COOKIELIST = 10000 + 135,


  CURLOPT_IGNORE_CONTENT_LENGTH = 0 + 136,





  CURLOPT_FTP_SKIP_PASV_IP = 0 + 137,



  CURLOPT_FTP_FILEMETHOD = 0 + 138,


  CURLOPT_LOCALPORT = 0 + 139,




  CURLOPT_LOCALPORTRANGE = 0 + 140,



  CURLOPT_CONNECT_ONLY = 0 + 141,



  CURLOPT_CONV_FROM_NETWORK_FUNCTION = 20000 + 142,



  CURLOPT_CONV_TO_NETWORK_FUNCTION = 20000 + 143,




  CURLOPT_CONV_FROM_UTF8_FUNCTION = 20000 + 144,



  CURLOPT_MAX_SEND_SPEED_LARGE = 30000 + 145,
  CURLOPT_MAX_RECV_SPEED_LARGE = 30000 + 146,


  CURLOPT_FTP_ALTERNATIVE_TO_USER = 10000 + 147,


  CURLOPT_SOCKOPTFUNCTION = 20000 + 148,
  CURLOPT_SOCKOPTDATA = 10000 + 149,



  CURLOPT_SSL_SESSIONID_CACHE = 0 + 150,


  CURLOPT_SSH_AUTH_TYPES = 0 + 151,


  CURLOPT_SSH_PUBLIC_KEYFILE = 10000 + 152,
  CURLOPT_SSH_PRIVATE_KEYFILE = 10000 + 153,


  CURLOPT_FTP_SSL_CCC = 0 + 154,


  CURLOPT_TIMEOUT_MS = 0 + 155,
  CURLOPT_CONNECTTIMEOUT_MS = 0 + 156,



  CURLOPT_HTTP_TRANSFER_DECODING = 0 + 157,
  CURLOPT_HTTP_CONTENT_DECODING = 0 + 158,



  CURLOPT_NEW_FILE_PERMS = 0 + 159,
  CURLOPT_NEW_DIRECTORY_PERMS = 0 + 160,



  CURLOPT_POSTREDIR = 0 + 161,


  CURLOPT_SSH_HOST_PUBLIC_KEY_MD5 = 10000 + 162,





  CURLOPT_OPENSOCKETFUNCTION = 20000 + 163,
  CURLOPT_OPENSOCKETDATA = 10000 + 164,


  CURLOPT_COPYPOSTFIELDS = 10000 + 165,


  CURLOPT_PROXY_TRANSFER_MODE = 0 + 166,


  CURLOPT_SEEKFUNCTION = 20000 + 167,
  CURLOPT_SEEKDATA = 10000 + 168,


  CURLOPT_CRLFILE = 10000 + 169,


  CURLOPT_ISSUERCERT = 10000 + 170,


  CURLOPT_ADDRESS_SCOPE = 0 + 171,




  CURLOPT_CERTINFO = 0 + 172,


  CURLOPT_USERNAME = 10000 + 173,
  CURLOPT_PASSWORD = 10000 + 174,


  CURLOPT_PROXYUSERNAME = 10000 + 175,
  CURLOPT_PROXYPASSWORD = 10000 + 176,
# 1377 "/usr/include/curl/curl.h" 3 4
  CURLOPT_NOPROXY = 10000 + 177,


  CURLOPT_TFTP_BLKSIZE = 0 + 178,


  CURLOPT_SOCKS5_GSSAPI_SERVICE = 10000 + 179,


  CURLOPT_SOCKS5_GSSAPI_NEC = 0 + 180,





  CURLOPT_PROTOCOLS = 0 + 181,





  CURLOPT_REDIR_PROTOCOLS = 0 + 182,


  CURLOPT_SSH_KNOWNHOSTS = 10000 + 183,



  CURLOPT_SSH_KEYFUNCTION = 20000 + 184,


  CURLOPT_SSH_KEYDATA = 10000 + 185,


  CURLOPT_MAIL_FROM = 10000 + 186,


  CURLOPT_MAIL_RCPT = 10000 + 187,


  CURLOPT_FTP_USE_PRET = 0 + 188,


  CURLOPT_RTSP_REQUEST = 0 + 189,


  CURLOPT_RTSP_SESSION_ID = 10000 + 190,


  CURLOPT_RTSP_STREAM_URI = 10000 + 191,


  CURLOPT_RTSP_TRANSPORT = 10000 + 192,


  CURLOPT_RTSP_CLIENT_CSEQ = 0 + 193,


  CURLOPT_RTSP_SERVER_CSEQ = 0 + 194,


  CURLOPT_INTERLEAVEDATA = 10000 + 195,


  CURLOPT_INTERLEAVEFUNCTION = 20000 + 196,


  CURLOPT_WILDCARDMATCH = 0 + 197,



  CURLOPT_CHUNK_BGN_FUNCTION = 20000 + 198,



  CURLOPT_CHUNK_END_FUNCTION = 20000 + 199,


  CURLOPT_FNMATCH_FUNCTION = 20000 + 200,


  CURLOPT_CHUNK_DATA = 10000 + 201,


  CURLOPT_FNMATCH_DATA = 10000 + 202,


  CURLOPT_RESOLVE = 10000 + 203,


  CURLOPT_TLSAUTH_USERNAME = 10000 + 204,


  CURLOPT_TLSAUTH_PASSWORD = 10000 + 205,


  CURLOPT_TLSAUTH_TYPE = 10000 + 206,
# 1485 "/usr/include/curl/curl.h" 3 4
  CURLOPT_TRANSFER_ENCODING = 0 + 207,



  CURLOPT_CLOSESOCKETFUNCTION = 20000 + 208,
  CURLOPT_CLOSESOCKETDATA = 10000 + 209,


  CURLOPT_GSSAPI_DELEGATION = 0 + 210,


  CURLOPT_DNS_SERVERS = 10000 + 211,



  CURLOPT_ACCEPTTIMEOUT_MS = 0 + 212,

  CURLOPT_LASTENTRY
} CURLoption;
# 1548 "/usr/include/curl/curl.h" 3 4
enum {
  CURL_HTTP_VERSION_NONE,


  CURL_HTTP_VERSION_1_0,
  CURL_HTTP_VERSION_1_1,

  CURL_HTTP_VERSION_LAST
};




enum {
    CURL_RTSPREQ_NONE,
    CURL_RTSPREQ_OPTIONS,
    CURL_RTSPREQ_DESCRIBE,
    CURL_RTSPREQ_ANNOUNCE,
    CURL_RTSPREQ_SETUP,
    CURL_RTSPREQ_PLAY,
    CURL_RTSPREQ_PAUSE,
    CURL_RTSPREQ_TEARDOWN,
    CURL_RTSPREQ_GET_PARAMETER,
    CURL_RTSPREQ_SET_PARAMETER,
    CURL_RTSPREQ_RECORD,
    CURL_RTSPREQ_RECEIVE,
    CURL_RTSPREQ_LAST
};


enum CURL_NETRC_OPTION {
  CURL_NETRC_IGNORED,

  CURL_NETRC_OPTIONAL,

  CURL_NETRC_REQUIRED,


  CURL_NETRC_LAST
};

enum {
  CURL_SSLVERSION_DEFAULT,
  CURL_SSLVERSION_TLSv1,
  CURL_SSLVERSION_SSLv2,
  CURL_SSLVERSION_SSLv3,

  CURL_SSLVERSION_LAST
};

enum CURL_TLSAUTH {
  CURL_TLSAUTH_NONE,
  CURL_TLSAUTH_SRP,
  CURL_TLSAUTH_LAST
};
# 1613 "/usr/include/curl/curl.h" 3 4
typedef enum {
  CURL_TIMECOND_NONE,

  CURL_TIMECOND_IFMODSINCE,
  CURL_TIMECOND_IFUNMODSINCE,
  CURL_TIMECOND_LASTMOD,

  CURL_TIMECOND_LAST
} curl_TimeCond;




 int (curl_strequal)(const char *s1, const char *s2);
 int (curl_strnequal)(const char *s1, const char *s2, size_t n);
# 1641 "/usr/include/curl/curl.h" 3 4
typedef enum {
  CURLFORM_NOTHING,


  CURLFORM_COPYNAME,
  CURLFORM_PTRNAME,
  CURLFORM_NAMELENGTH,
  CURLFORM_COPYCONTENTS,
  CURLFORM_PTRCONTENTS,
  CURLFORM_CONTENTSLENGTH,
  CURLFORM_FILECONTENT,
  CURLFORM_ARRAY,
  CURLFORM_OBSOLETE,
  CURLFORM_FILE,

  CURLFORM_BUFFER,
  CURLFORM_BUFFERPTR,
  CURLFORM_BUFFERLENGTH,

  CURLFORM_CONTENTTYPE,
  CURLFORM_CONTENTHEADER,
  CURLFORM_FILENAME,
  CURLFORM_END,
  CURLFORM_OBSOLETE2,

  CURLFORM_STREAM,

  CURLFORM_LASTENTRY
} CURLformoption;




struct curl_forms {
  CURLformoption option;
  const char *value;
};
# 1695 "/usr/include/curl/curl.h" 3 4
typedef enum {
  CURL_FORMADD_OK,

  CURL_FORMADD_MEMORY,
  CURL_FORMADD_OPTION_TWICE,
  CURL_FORMADD_NULL,
  CURL_FORMADD_UNKNOWN_OPTION,
  CURL_FORMADD_INCOMPLETE,
  CURL_FORMADD_ILLEGAL_ARRAY,
  CURL_FORMADD_DISABLED,

  CURL_FORMADD_LAST
} CURLFORMcode;
# 1718 "/usr/include/curl/curl.h" 3 4
 CURLFORMcode curl_formadd(struct curl_httppost **httppost,
                                      struct curl_httppost **last_post,
                                      ...);
# 1730 "/usr/include/curl/curl.h" 3 4
typedef size_t (*curl_formget_callback)(void *arg, const char *buf,
                                        size_t len);
# 1743 "/usr/include/curl/curl.h" 3 4
 int curl_formget(struct curl_httppost *form, void *arg,
                             curl_formget_callback append);







 void curl_formfree(struct curl_httppost *form);
# 1762 "/usr/include/curl/curl.h" 3 4
 char *curl_getenv(const char *variable);
# 1771 "/usr/include/curl/curl.h" 3 4
 char *curl_version(void);
# 1782 "/usr/include/curl/curl.h" 3 4
 char *curl_easy_escape(CURL *handle,
                                   const char *string,
                                   int length);


 char *curl_escape(const char *string,
                              int length);
# 1802 "/usr/include/curl/curl.h" 3 4
 char *curl_easy_unescape(CURL *handle,
                                     const char *string,
                                     int length,
                                     int *outlength);


 char *curl_unescape(const char *string,
                                int length);
# 1819 "/usr/include/curl/curl.h" 3 4
 void curl_free(void *p);
# 1831 "/usr/include/curl/curl.h" 3 4
 CURLcode curl_global_init(long flags);
# 1846 "/usr/include/curl/curl.h" 3 4
 CURLcode curl_global_init_mem(long flags,
                                          curl_malloc_callback m,
                                          curl_free_callback f,
                                          curl_realloc_callback r,
                                          curl_strdup_callback s,
                                          curl_calloc_callback c);
# 1861 "/usr/include/curl/curl.h" 3 4
 void curl_global_cleanup(void);


struct curl_slist {
  char *data;
  struct curl_slist *next;
};
# 1877 "/usr/include/curl/curl.h" 3 4
 struct curl_slist *curl_slist_append(struct curl_slist *,
                                                 const char *);
# 1887 "/usr/include/curl/curl.h" 3 4
 void curl_slist_free_all(struct curl_slist *);
# 1898 "/usr/include/curl/curl.h" 3 4
 time_t curl_getdate(const char *p, const time_t *unused);



struct curl_certinfo {
  int num_of_certs;
  struct curl_slist **certinfo;


};
# 1916 "/usr/include/curl/curl.h" 3 4
typedef enum {
  CURLINFO_NONE,
  CURLINFO_EFFECTIVE_URL = 0x100000 + 1,
  CURLINFO_RESPONSE_CODE = 0x200000 + 2,
  CURLINFO_TOTAL_TIME = 0x300000 + 3,
  CURLINFO_NAMELOOKUP_TIME = 0x300000 + 4,
  CURLINFO_CONNECT_TIME = 0x300000 + 5,
  CURLINFO_PRETRANSFER_TIME = 0x300000 + 6,
  CURLINFO_SIZE_UPLOAD = 0x300000 + 7,
  CURLINFO_SIZE_DOWNLOAD = 0x300000 + 8,
  CURLINFO_SPEED_DOWNLOAD = 0x300000 + 9,
  CURLINFO_SPEED_UPLOAD = 0x300000 + 10,
  CURLINFO_HEADER_SIZE = 0x200000 + 11,
  CURLINFO_REQUEST_SIZE = 0x200000 + 12,
  CURLINFO_SSL_VERIFYRESULT = 0x200000 + 13,
  CURLINFO_FILETIME = 0x200000 + 14,
  CURLINFO_CONTENT_LENGTH_DOWNLOAD = 0x300000 + 15,
  CURLINFO_CONTENT_LENGTH_UPLOAD = 0x300000 + 16,
  CURLINFO_STARTTRANSFER_TIME = 0x300000 + 17,
  CURLINFO_CONTENT_TYPE = 0x100000 + 18,
  CURLINFO_REDIRECT_TIME = 0x300000 + 19,
  CURLINFO_REDIRECT_COUNT = 0x200000 + 20,
  CURLINFO_PRIVATE = 0x100000 + 21,
  CURLINFO_HTTP_CONNECTCODE = 0x200000 + 22,
  CURLINFO_HTTPAUTH_AVAIL = 0x200000 + 23,
  CURLINFO_PROXYAUTH_AVAIL = 0x200000 + 24,
  CURLINFO_OS_ERRNO = 0x200000 + 25,
  CURLINFO_NUM_CONNECTS = 0x200000 + 26,
  CURLINFO_SSL_ENGINES = 0x400000 + 27,
  CURLINFO_COOKIELIST = 0x400000 + 28,
  CURLINFO_LASTSOCKET = 0x200000 + 29,
  CURLINFO_FTP_ENTRY_PATH = 0x100000 + 30,
  CURLINFO_REDIRECT_URL = 0x100000 + 31,
  CURLINFO_PRIMARY_IP = 0x100000 + 32,
  CURLINFO_APPCONNECT_TIME = 0x300000 + 33,
  CURLINFO_CERTINFO = 0x400000 + 34,
  CURLINFO_CONDITION_UNMET = 0x200000 + 35,
  CURLINFO_RTSP_SESSION_ID = 0x100000 + 36,
  CURLINFO_RTSP_CLIENT_CSEQ = 0x200000 + 37,
  CURLINFO_RTSP_SERVER_CSEQ = 0x200000 + 38,
  CURLINFO_RTSP_CSEQ_RECV = 0x200000 + 39,
  CURLINFO_PRIMARY_PORT = 0x200000 + 40,
  CURLINFO_LOCAL_IP = 0x100000 + 41,
  CURLINFO_LOCAL_PORT = 0x200000 + 42,


  CURLINFO_LASTONE = 42
} CURLINFO;





typedef enum {
  CURLCLOSEPOLICY_NONE,

  CURLCLOSEPOLICY_OLDEST,
  CURLCLOSEPOLICY_LEAST_RECENTLY_USED,
  CURLCLOSEPOLICY_LEAST_TRAFFIC,
  CURLCLOSEPOLICY_SLOWEST,
  CURLCLOSEPOLICY_CALLBACK,

  CURLCLOSEPOLICY_LAST
} curl_closepolicy;
# 1993 "/usr/include/curl/curl.h" 3 4
typedef enum {
  CURL_LOCK_DATA_NONE = 0,




  CURL_LOCK_DATA_SHARE,
  CURL_LOCK_DATA_COOKIE,
  CURL_LOCK_DATA_DNS,
  CURL_LOCK_DATA_SSL_SESSION,
  CURL_LOCK_DATA_CONNECT,
  CURL_LOCK_DATA_LAST
} curl_lock_data;


typedef enum {
  CURL_LOCK_ACCESS_NONE = 0,
  CURL_LOCK_ACCESS_SHARED = 1,
  CURL_LOCK_ACCESS_SINGLE = 2,
  CURL_LOCK_ACCESS_LAST
} curl_lock_access;

typedef void (*curl_lock_function)(CURL *handle,
                                   curl_lock_data data,
                                   curl_lock_access locktype,
                                   void *userptr);
typedef void (*curl_unlock_function)(CURL *handle,
                                     curl_lock_data data,
                                     void *userptr);

typedef void CURLSH;

typedef enum {
  CURLSHE_OK,
  CURLSHE_BAD_OPTION,
  CURLSHE_IN_USE,
  CURLSHE_INVALID,
  CURLSHE_NOMEM,
  CURLSHE_NOT_BUILT_IN,
  CURLSHE_LAST
} CURLSHcode;

typedef enum {
  CURLSHOPT_NONE,
  CURLSHOPT_SHARE,
  CURLSHOPT_UNSHARE,
  CURLSHOPT_LOCKFUNC,
  CURLSHOPT_UNLOCKFUNC,
  CURLSHOPT_USERDATA,

  CURLSHOPT_LAST
} CURLSHoption;

 CURLSH *curl_share_init(void);
 CURLSHcode curl_share_setopt(CURLSH *, CURLSHoption option, ...);
 CURLSHcode curl_share_cleanup(CURLSH *);





typedef enum {
  CURLVERSION_FIRST,
  CURLVERSION_SECOND,
  CURLVERSION_THIRD,
  CURLVERSION_FOURTH,
  CURLVERSION_LAST
} CURLversion;
# 2069 "/usr/include/curl/curl.h" 3 4
typedef struct {
  CURLversion age;
  const char *version;
  unsigned int version_num;
  const char *host;
  int features;
  const char *ssl_version;
  long ssl_version_num;
  const char *libz_version;

  const char * const *protocols;


  const char *ares;
  int ares_num;


  const char *libidn;




  int iconv_ver_num;

  const char *libssh_version;

} curl_version_info_data;
# 2122 "/usr/include/curl/curl.h" 3 4
 curl_version_info_data *curl_version_info(CURLversion);
# 2133 "/usr/include/curl/curl.h" 3 4
 const char *curl_easy_strerror(CURLcode);
# 2144 "/usr/include/curl/curl.h" 3 4
 const char *curl_share_strerror(CURLSHcode);
# 2155 "/usr/include/curl/curl.h" 3 4
 CURLcode curl_easy_pause(CURL *handle, int bitmask);
# 2172 "/usr/include/curl/curl.h" 3 4
# 1 "/usr/include/curl/easy.h" 1 3 4
# 28 "/usr/include/curl/easy.h" 3 4
 CURL *curl_easy_init(void);
 CURLcode curl_easy_setopt(CURL *curl, CURLoption option, ...);
 CURLcode curl_easy_perform(CURL *curl);
 void curl_easy_cleanup(CURL *curl);
# 46 "/usr/include/curl/easy.h" 3 4
 CURLcode curl_easy_getinfo(CURL *curl, CURLINFO info, ...);
# 61 "/usr/include/curl/easy.h" 3 4
 CURL* curl_easy_duphandle(CURL *curl);
# 74 "/usr/include/curl/easy.h" 3 4
 void curl_easy_reset(CURL *curl);
# 84 "/usr/include/curl/easy.h" 3 4
 CURLcode curl_easy_recv(CURL *curl, void *buffer, size_t buflen,
                                    size_t *n);
# 95 "/usr/include/curl/easy.h" 3 4
 CURLcode curl_easy_send(CURL *curl, const void *buffer,
                                    size_t buflen, size_t *n);
# 2173 "/usr/include/curl/curl.h" 2 3 4
# 1 "/usr/include/curl/multi.h" 1 3 4
# 49 "/usr/include/curl/multi.h" 3 4
# 1 "/usr/include/curl/curl.h" 1 3 4
# 50 "/usr/include/curl/multi.h" 2 3 4





typedef void CURLM;

typedef enum {
  CURLM_CALL_MULTI_PERFORM = -1,

  CURLM_OK,
  CURLM_BAD_HANDLE,
  CURLM_BAD_EASY_HANDLE,
  CURLM_OUT_OF_MEMORY,
  CURLM_INTERNAL_ERROR,
  CURLM_BAD_SOCKET,
  CURLM_UNKNOWN_OPTION,
  CURLM_LAST
} CURLMcode;






typedef enum {
  CURLMSG_NONE,
  CURLMSG_DONE,

  CURLMSG_LAST
} CURLMSG;

struct CURLMsg {
  CURLMSG msg;
  CURL *easy_handle;
  union {
    void *whatever;
    CURLcode result;
  } data;
};
typedef struct CURLMsg CURLMsg;
# 99 "/usr/include/curl/multi.h" 3 4
 CURLM *curl_multi_init(void);
# 108 "/usr/include/curl/multi.h" 3 4
 CURLMcode curl_multi_add_handle(CURLM *multi_handle,
                                            CURL *curl_handle);
# 118 "/usr/include/curl/multi.h" 3 4
 CURLMcode curl_multi_remove_handle(CURLM *multi_handle,
                                               CURL *curl_handle);
# 130 "/usr/include/curl/multi.h" 3 4
 CURLMcode curl_multi_fdset(CURLM *multi_handle,
                                       fd_set *read_fd_set,
                                       fd_set *write_fd_set,
                                       fd_set *exc_fd_set,
                                       int *max_fd);
# 152 "/usr/include/curl/multi.h" 3 4
 CURLMcode curl_multi_perform(CURLM *multi_handle,
                                         int *running_handles);
# 165 "/usr/include/curl/multi.h" 3 4
 CURLMcode curl_multi_cleanup(CURLM *multi_handle);
# 195 "/usr/include/curl/multi.h" 3 4
 CURLMsg *curl_multi_info_read(CURLM *multi_handle,
                                          int *msgs_in_queue);
# 207 "/usr/include/curl/multi.h" 3 4
 const char *curl_multi_strerror(CURLMcode);
# 230 "/usr/include/curl/multi.h" 3 4
typedef int (*curl_socket_callback)(CURL *easy,
                                    curl_socket_t s,
                                    int what,
                                    void *userp,

                                    void *socketp);
# 247 "/usr/include/curl/multi.h" 3 4
typedef int (*curl_multi_timer_callback)(CURLM *multi,
                                         long timeout_ms,
                                         void *userp);


 CURLMcode curl_multi_socket(CURLM *multi_handle, curl_socket_t s,
                                        int *running_handles);

 CURLMcode curl_multi_socket_action(CURLM *multi_handle,
                                               curl_socket_t s,
                                               int ev_bitmask,
                                               int *running_handles);

 CURLMcode curl_multi_socket_all(CURLM *multi_handle,
                                            int *running_handles);
# 279 "/usr/include/curl/multi.h" 3 4
 CURLMcode curl_multi_timeout(CURLM *multi_handle,
                                         long *milliseconds);
# 295 "/usr/include/curl/multi.h" 3 4
typedef enum {

  CURLMOPT_SOCKETFUNCTION = 20000 + 1,


  CURLMOPT_SOCKETDATA = 10000 + 2,


  CURLMOPT_PIPELINING = 0 + 3,


  CURLMOPT_TIMERFUNCTION = 20000 + 4,


  CURLMOPT_TIMERDATA = 10000 + 5,


  CURLMOPT_MAXCONNECTS = 0 + 6,

  CURLMOPT_LASTENTRY
} CURLMoption;
# 325 "/usr/include/curl/multi.h" 3 4
 CURLMcode curl_multi_setopt(CURLM *multi_handle,
                                        CURLMoption option, ...);
# 338 "/usr/include/curl/multi.h" 3 4
 CURLMcode curl_multi_assign(CURLM *multi_handle,
                                        curl_socket_t sockfd, void *sockp);
# 2174 "/usr/include/curl/curl.h" 2 3 4





# 1 "/usr/include/curl/typecheck-gcc.h" 1 3 4
# 147 "/usr/include/curl/typecheck-gcc.h" 3 4
static void __attribute__((warning("curl_easy_setopt expects a long argument for this option"))) __attribute__((unused)) __attribute__((noinline)) _curl_easy_setopt_err_long(void) { __asm__(""); }

static void __attribute__((warning("curl_easy_setopt expects a curl_off_t argument for this option"))) __attribute__((unused)) __attribute__((noinline)) _curl_easy_setopt_err_curl_off_t(void) { __asm__(""); }

static void __attribute__((warning("curl_easy_setopt expects a " "string (char* or char[]) argument for this option"))) __attribute__((unused)) __attribute__((noinline)) _curl_easy_setopt_err_string(void) { __asm__(""); }



static void __attribute__((warning("curl_easy_setopt expects a curl_write_callback argument for this option"))) __attribute__((unused)) __attribute__((noinline)) _curl_easy_setopt_err_write_callback(void) { __asm__(""); }

static void __attribute__((warning("curl_easy_setopt expects a curl_read_callback argument for this option"))) __attribute__((unused)) __attribute__((noinline)) _curl_easy_setopt_err_read_cb(void) { __asm__(""); }

static void __attribute__((warning("curl_easy_setopt expects a curl_ioctl_callback argument for this option"))) __attribute__((unused)) __attribute__((noinline)) _curl_easy_setopt_err_ioctl_cb(void) { __asm__(""); }

static void __attribute__((warning("curl_easy_setopt expects a curl_sockopt_callback argument for this option"))) __attribute__((unused)) __attribute__((noinline)) _curl_easy_setopt_err_sockopt_cb(void) { __asm__(""); }

static void __attribute__((warning("curl_easy_setopt expects a " "curl_opensocket_callback argument for this option"))) __attribute__((unused)) __attribute__((noinline)) _curl_easy_setopt_err_opensocket_cb(void) { __asm__(""); }



static void __attribute__((warning("curl_easy_setopt expects a curl_progress_callback argument for this option"))) __attribute__((unused)) __attribute__((noinline)) _curl_easy_setopt_err_progress_cb(void) { __asm__(""); }

static void __attribute__((warning("curl_easy_setopt expects a curl_debug_callback argument for this option"))) __attribute__((unused)) __attribute__((noinline)) _curl_easy_setopt_err_debug_cb(void) { __asm__(""); }

static void __attribute__((warning("curl_easy_setopt expects a curl_ssl_ctx_callback argument for this option"))) __attribute__((unused)) __attribute__((noinline)) _curl_easy_setopt_err_ssl_ctx_cb(void) { __asm__(""); }

static void __attribute__((warning("curl_easy_setopt expects a curl_conv_callback argument for this option"))) __attribute__((unused)) __attribute__((noinline)) _curl_easy_setopt_err_conv_cb(void) { __asm__(""); }

static void __attribute__((warning("curl_easy_setopt expects a curl_seek_callback argument for this option"))) __attribute__((unused)) __attribute__((noinline)) _curl_easy_setopt_err_seek_cb(void) { __asm__(""); }

static void __attribute__((warning("curl_easy_setopt expects a " "private data pointer as argument for this option"))) __attribute__((unused)) __attribute__((noinline)) _curl_easy_setopt_err_cb_data(void) { __asm__(""); }


static void __attribute__((warning("curl_easy_setopt expects a " "char buffer of CURL_ERROR_SIZE as argument for this option"))) __attribute__((unused)) __attribute__((noinline)) _curl_easy_setopt_err_error_buffer(void) { __asm__(""); }


static void __attribute__((warning("curl_easy_setopt expects a FILE* argument for this option"))) __attribute__((unused)) __attribute__((noinline)) _curl_easy_setopt_err_FILE(void) { __asm__(""); }

static void __attribute__((warning("curl_easy_setopt expects a void* or char* argument for this option"))) __attribute__((unused)) __attribute__((noinline)) _curl_easy_setopt_err_postfields(void) { __asm__(""); }

static void __attribute__((warning("curl_easy_setopt expects a struct curl_httppost* argument for this option"))) __attribute__((unused)) __attribute__((noinline)) _curl_easy_setopt_err_curl_httpost(void) { __asm__(""); }

static void __attribute__((warning("curl_easy_setopt expects a struct curl_slist* argument for this option"))) __attribute__((unused)) __attribute__((noinline)) _curl_easy_setopt_err_curl_slist(void) { __asm__(""); }

static void __attribute__((warning("curl_easy_setopt expects a CURLSH* argument for this option"))) __attribute__((unused)) __attribute__((noinline)) _curl_easy_setopt_err_CURLSH(void) { __asm__(""); }


static void __attribute__((warning("curl_easy_getinfo expects a pointer to char * for this info"))) __attribute__((unused)) __attribute__((noinline)) _curl_easy_getinfo_err_string(void) { __asm__(""); }

static void __attribute__((warning("curl_easy_getinfo expects a pointer to long for this info"))) __attribute__((unused)) __attribute__((noinline)) _curl_easy_getinfo_err_long(void) { __asm__(""); }

static void __attribute__((warning("curl_easy_getinfo expects a pointer to double for this info"))) __attribute__((unused)) __attribute__((noinline)) _curl_easy_getinfo_err_double(void) { __asm__(""); }

static void __attribute__((warning("curl_easy_getinfo expects a pointer to struct curl_slist * for this info"))) __attribute__((unused)) __attribute__((noinline)) _curl_easy_getinfo_err_curl_slist(void) { __asm__(""); }
# 439 "/usr/include/curl/typecheck-gcc.h" 3 4
typedef size_t (_curl_read_callback1)(char *, size_t, size_t, void*);
typedef size_t (_curl_read_callback2)(char *, size_t, size_t, const void*);
typedef size_t (_curl_read_callback3)(char *, size_t, size_t, FILE*);
typedef size_t (_curl_read_callback4)(void *, size_t, size_t, void*);
typedef size_t (_curl_read_callback5)(void *, size_t, size_t, const void*);
typedef size_t (_curl_read_callback6)(void *, size_t, size_t, FILE*);
# 457 "/usr/include/curl/typecheck-gcc.h" 3 4
typedef size_t (_curl_write_callback1)(const char *, size_t, size_t, void*);
typedef size_t (_curl_write_callback2)(const char *, size_t, size_t,
                                       const void*);
typedef size_t (_curl_write_callback3)(const char *, size_t, size_t, FILE*);
typedef size_t (_curl_write_callback4)(const void *, size_t, size_t, void*);
typedef size_t (_curl_write_callback5)(const void *, size_t, size_t,
                                       const void*);
typedef size_t (_curl_write_callback6)(const void *, size_t, size_t, FILE*);
# 474 "/usr/include/curl/typecheck-gcc.h" 3 4
typedef curlioerr (_curl_ioctl_callback1)(CURL *, int, void*);
typedef curlioerr (_curl_ioctl_callback2)(CURL *, int, const void*);
typedef curlioerr (_curl_ioctl_callback3)(CURL *, curliocmd, void*);
typedef curlioerr (_curl_ioctl_callback4)(CURL *, curliocmd, const void*);







typedef int (_curl_sockopt_callback1)(void *, curl_socket_t, curlsocktype);
typedef int (_curl_sockopt_callback2)(const void *, curl_socket_t,
                                      curlsocktype);
# 498 "/usr/include/curl/typecheck-gcc.h" 3 4
typedef curl_socket_t (_curl_opensocket_callback1)
  (void *, curlsocktype, struct curl_sockaddr *);
typedef curl_socket_t (_curl_opensocket_callback2)
  (void *, curlsocktype, const struct curl_sockaddr *);
typedef curl_socket_t (_curl_opensocket_callback3)
  (const void *, curlsocktype, struct curl_sockaddr *);
typedef curl_socket_t (_curl_opensocket_callback4)
  (const void *, curlsocktype, const struct curl_sockaddr *);







typedef int (_curl_progress_callback1)(void *,
    double, double, double, double);
typedef int (_curl_progress_callback2)(const void *,
    double, double, double, double);
# 530 "/usr/include/curl/typecheck-gcc.h" 3 4
typedef int (_curl_debug_callback1) (CURL *,
    curl_infotype, char *, size_t, void *);
typedef int (_curl_debug_callback2) (CURL *,
    curl_infotype, char *, size_t, const void *);
typedef int (_curl_debug_callback3) (CURL *,
    curl_infotype, const char *, size_t, void *);
typedef int (_curl_debug_callback4) (CURL *,
    curl_infotype, const char *, size_t, const void *);
typedef int (_curl_debug_callback5) (CURL *,
    curl_infotype, unsigned char *, size_t, void *);
typedef int (_curl_debug_callback6) (CURL *,
    curl_infotype, unsigned char *, size_t, const void *);
typedef int (_curl_debug_callback7) (CURL *,
    curl_infotype, const unsigned char *, size_t, void *);
typedef int (_curl_debug_callback8) (CURL *,
    curl_infotype, const unsigned char *, size_t, const void *);
# 560 "/usr/include/curl/typecheck-gcc.h" 3 4
typedef CURLcode (_curl_ssl_ctx_callback1)(CURL *, void *, void *);
typedef CURLcode (_curl_ssl_ctx_callback2)(CURL *, void *, const void *);
typedef CURLcode (_curl_ssl_ctx_callback3)(CURL *, const void *, void *);
typedef CURLcode (_curl_ssl_ctx_callback4)(CURL *, const void *, const void *);
# 574 "/usr/include/curl/typecheck-gcc.h" 3 4
typedef _curl_ssl_ctx_callback1 _curl_ssl_ctx_callback5;
typedef _curl_ssl_ctx_callback1 _curl_ssl_ctx_callback6;
typedef _curl_ssl_ctx_callback1 _curl_ssl_ctx_callback7;
typedef _curl_ssl_ctx_callback1 _curl_ssl_ctx_callback8;
# 588 "/usr/include/curl/typecheck-gcc.h" 3 4
typedef CURLcode (*_curl_conv_callback1)(char *, size_t length);
typedef CURLcode (*_curl_conv_callback2)(const char *, size_t length);
typedef CURLcode (*_curl_conv_callback3)(void *, size_t length);
typedef CURLcode (*_curl_conv_callback4)(const void *, size_t length);







typedef CURLcode (*_curl_seek_callback1)(void *, curl_off_t, int);
typedef CURLcode (*_curl_seek_callback2)(const void *, curl_off_t, int);
# 2180 "/usr/include/curl/curl.h" 2 3 4
# 31 "./inc/util.h" 2
# 1 "/usr/include/curl/multi.h" 1 3 4
# 32 "./inc/util.h" 2
# 74 "./inc/util.h"
int urlEncode(char *dest, const char *src, int maxSrcSize);


int64_t parseIso8601Time(const char *str);

uint64_t parseUnsignedInt(const char *str);




int base64Encode(const unsigned char *in, int inLen, char *out);



void HMAC_SHA1(unsigned char hmac[20], const unsigned char *key, int key_len,
               const unsigned char *message, int message_len);


uint64_t hash(const unsigned char *k, int length);



int is_blank(char c);
# 33 "./inc/response_headers_handler.h" 2


typedef struct ResponseHeadersHandler
{


    S3ResponseProperties responseProperties;


    int done;


    char responsePropertyStrings[5 * 129]; int responsePropertyStringsSize;


    char responseMetaDataStrings[((2048 / (sizeof("x-amz-meta-" "nv") - 1)) * sizeof("x-amz-meta-" "n: v"))]; int
 responseMetaDataStringsSize;


    S3NameValue responseMetaData[(2048 / (sizeof("x-amz-meta-" "nv") - 1))];
} ResponseHeadersHandler;


void response_headers_handler_initialize(ResponseHeadersHandler *handler);

void response_headers_handler_add(ResponseHeadersHandler *handler,
                                  char *data, int dataLen);

void response_headers_handler_done(ResponseHeadersHandler *handler,
                                   CURL *curl);
# 33 "./inc/request.h" 2



typedef enum
{
    HttpRequestTypeGET,
    HttpRequestTypeHEAD,
    HttpRequestTypePUT,
    HttpRequestTypeCOPY,
    HttpRequestTypeDELETE
} HttpRequestType;





typedef struct RequestParams
{

    HttpRequestType httpRequestType;


    S3BucketContext bucketContext;


    const char *key;


    const char *queryParams;


    const char *subResource;


    const char *copySourceBucketName;


    const char *copySourceKey;


    const S3GetConditions *getConditions;


    uint64_t startByte;


    uint64_t byteCount;


    const S3PutProperties *putProperties;


    S3ResponsePropertiesCallback *propertiesCallback;


    S3PutObjectDataCallback *toS3Callback;


    int64_t toS3CallbackTotalSize;



    S3GetObjectDataCallback *fromS3Callback;



    S3ResponseCompleteCallback *completeCallback;


    void *callbackData;
} RequestParams;




typedef struct Request
{



    struct Request *prev, *next;



    S3Status status;




    int httpResponseCode;


    struct curl_slist *headers;


    CURL *curl;


    char uri[((sizeof("https:///") - 1) + 255 + 255 + 1 + (3 * 1024) + (sizeof("?torrent" - 1)) + 1) + 1];


    S3ResponsePropertiesCallback *propertiesCallback;


    S3PutObjectDataCallback *toS3Callback;


    int64_t toS3CallbackBytesRemaining;



    S3GetObjectDataCallback *fromS3Callback;



    S3ResponseCompleteCallback *completeCallback;


    void *callbackData;


    ResponseHeadersHandler responseHeadersHandler;


    int propertiesCallbackMade;


    ErrorParser errorParser;
} Request;






S3Status request_api_initialize(const char *userAgentInfo, int flags,
                                const char *hostName);


void request_api_deinitialize();



void request_perform(const RequestParams *params, S3RequestContext *context);



void request_finish(Request *request);


S3Status request_curl_code_to_status(CURLcode code);
# 33 "./src/request.c" 2
# 1 "./inc/request_context.h" 1
# 32 "./inc/request_context.h"
struct S3RequestContext
{
    CURLM *curlm;

    struct Request *requests;
};
# 34 "./src/request.c" 2
# 1 "./inc/response_headers_handler.h" 1
# 35 "./src/request.c" 2
# 1 "./inc/util.h" 1
# 36 "./src/request.c" 2


# 1 "../time_it/time_it.h" 1





# 1 "/usr/include/sys/stat.h" 1 3 4
# 105 "/usr/include/sys/stat.h" 3 4


# 1 "/usr/include/bits/stat.h" 1 3 4
# 46 "/usr/include/bits/stat.h" 3 4
struct stat
  {
    __dev_t st_dev;




    __ino_t st_ino;







    __nlink_t st_nlink;
    __mode_t st_mode;

    __uid_t st_uid;
    __gid_t st_gid;

    int __pad0;

    __dev_t st_rdev;




    __off_t st_size;



    __blksize_t st_blksize;

    __blkcnt_t st_blocks;
# 91 "/usr/include/bits/stat.h" 3 4
    struct timespec st_atim;
    struct timespec st_mtim;
    struct timespec st_ctim;
# 106 "/usr/include/bits/stat.h" 3 4
    long int __unused[3];
# 115 "/usr/include/bits/stat.h" 3 4
  };
# 108 "/usr/include/sys/stat.h" 2 3 4
# 211 "/usr/include/sys/stat.h" 3 4
extern int stat (__const char *__restrict __file,
   struct stat *__restrict __buf) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));



extern int fstat (int __fd, struct stat *__buf) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));
# 240 "/usr/include/sys/stat.h" 3 4
extern int fstatat (int __fd, __const char *__restrict __file,
      struct stat *__restrict __buf, int __flag)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 3)));
# 265 "/usr/include/sys/stat.h" 3 4
extern int lstat (__const char *__restrict __file,
    struct stat *__restrict __buf) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));
# 286 "/usr/include/sys/stat.h" 3 4
extern int chmod (__const char *__file, __mode_t __mode)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));





extern int lchmod (__const char *__file, __mode_t __mode)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));




extern int fchmod (int __fd, __mode_t __mode) __attribute__ ((__nothrow__ , __leaf__));





extern int fchmodat (int __fd, __const char *__file, __mode_t __mode,
       int __flag)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2))) ;






extern __mode_t umask (__mode_t __mask) __attribute__ ((__nothrow__ , __leaf__));
# 323 "/usr/include/sys/stat.h" 3 4
extern int mkdir (__const char *__path, __mode_t __mode)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));





extern int mkdirat (int __fd, __const char *__path, __mode_t __mode)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));






extern int mknod (__const char *__path, __mode_t __mode, __dev_t __dev)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));





extern int mknodat (int __fd, __const char *__path, __mode_t __mode,
      __dev_t __dev) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));





extern int mkfifo (__const char *__path, __mode_t __mode)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));





extern int mkfifoat (int __fd, __const char *__path, __mode_t __mode)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));





extern int utimensat (int __fd, __const char *__path,
        __const struct timespec __times[2],
        int __flags)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));




extern int futimens (int __fd, __const struct timespec __times[2]) __attribute__ ((__nothrow__ , __leaf__));
# 401 "/usr/include/sys/stat.h" 3 4
extern int __fxstat (int __ver, int __fildes, struct stat *__stat_buf)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3)));
extern int __xstat (int __ver, __const char *__filename,
      struct stat *__stat_buf) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 3)));
extern int __lxstat (int __ver, __const char *__filename,
       struct stat *__stat_buf) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 3)));
extern int __fxstatat (int __ver, int __fildes, __const char *__filename,
         struct stat *__stat_buf, int __flag)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3, 4)));
# 444 "/usr/include/sys/stat.h" 3 4
extern int __xmknod (int __ver, __const char *__path, __mode_t __mode,
       __dev_t *__dev) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 4)));

extern int __xmknodat (int __ver, int __fd, __const char *__path,
         __mode_t __mode, __dev_t *__dev)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3, 5)));
# 536 "/usr/include/sys/stat.h" 3 4

# 7 "../time_it/time_it.h" 2







struct time_it_timer_data{
 double time;
 const char *func;
 unsigned int st_line;
 unsigned int en_line;
 const char *file;
 const char *comment;
};



typedef struct time_it_timer_struct timer;
struct time_it_timer_struct{
 char *meta;
 unsigned int idx;
 unsigned short tic_no_toc;
 struct timeval tv_start;
 struct timeval tv_stop;
 struct time_it_timer_data data[1024];
};

void time_it_insert_time(timer *t, double time, unsigned int st_line, unsigned int en_line, const char *func, const char *file, const char *comment);
void time_it_start_timer(timer *t, int st_line);
void time_it_stop_timer(timer *t, unsigned int en_line, const char *func, const char *file, const char *comment);
int time_it_write_csv(timer *t, const char *file_name, const char * mode);

extern timer time_it;
# 39 "./src/request.c" 2





static char userAgentG[256];

static pthread_mutex_t requestStackMutexG;

static Request *requestStackG[32];

static int requestStackCountG;

char defaultHostNameG[255];


typedef struct RequestComputedValues
{

    char *amzHeaders[(2048 / (sizeof("x-amz-meta-" "nv") - 1)) + 2];


    int amzHeadersCount;


    char amzHeadersRaw[((2048 / (sizeof("x-amz-meta-" "nv") - 1)) * sizeof("x-amz-meta-" "n: v")) + 256 + 1];


    char canonicalizedAmzHeaders[((2048 / (sizeof("x-amz-meta-" "nv") - 1)) * sizeof("x-amz-meta-" "n: v")) + 256 + 1]; int
 canonicalizedAmzHeadersSize;


    char urlEncodedKey[(3 * 1024) + 1];


    char canonicalizedResource[(1 + 255 + 1 + (3 * 1024) + (sizeof("?torrent") - 1) + 1) + 1];


    char cacheControlHeader[128];


    char contentTypeHeader[128];


    char md5Header[128];


    char contentDispositionHeader[128];


    char contentEncodingHeader[128];


    char expiresHeader[128];


    char ifModifiedSinceHeader[128];


    char ifUnmodifiedSinceHeader[128];


    char ifMatchHeader[128];


    char ifNoneMatchHeader[128];


    char rangeHeader[128];


    char authorizationHeader[128];
} RequestComputedValues;






static void request_headers_done(Request *request)
{
    if (request->propertiesCallbackMade) {
        return;
    }

    request->propertiesCallbackMade = 1;


    long httpResponseCode;
    request->httpResponseCode = 0;
    if (__extension__ ({ __typeof__ (CURLINFO_RESPONSE_CODE) _curl_info = CURLINFO_RESPONSE_CODE; if(__builtin_constant_p(_curl_info)) { if((0x100000 < (_curl_info) && (_curl_info) < 0x200000)) if(!(((__builtin_types_compatible_p(__typeof__(((&httpResponseCode))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&httpResponseCode))), char * *) || __builtin_types_compatible_p(__typeof__(((&httpResponseCode))), const char * *)) || __builtin_types_compatible_p(__typeof__((&httpResponseCode)), char * []))) _curl_easy_getinfo_err_string(); if((0x200000 < (_curl_info) && (_curl_info) < 0x300000)) if(!(((__builtin_types_compatible_p(__typeof__(((&httpResponseCode))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&httpResponseCode))), long *) || __builtin_types_compatible_p(__typeof__(((&httpResponseCode))), const long *)) || __builtin_types_compatible_p(__typeof__((&httpResponseCode)), long []))) _curl_easy_getinfo_err_long(); if((0x300000 < (_curl_info) && (_curl_info) < 0x400000)) if(!(((__builtin_types_compatible_p(__typeof__(((&httpResponseCode))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&httpResponseCode))), double *) || __builtin_types_compatible_p(__typeof__(((&httpResponseCode))), const double *)) || __builtin_types_compatible_p(__typeof__((&httpResponseCode)), double []))) _curl_easy_getinfo_err_double(); if((0x400000 < (_curl_info))) if(!(((__builtin_types_compatible_p(__typeof__(((&httpResponseCode))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&httpResponseCode))), struct curl_slist * *) || __builtin_types_compatible_p(__typeof__(((&httpResponseCode))), const struct curl_slist * *)) || __builtin_types_compatible_p(__typeof__((&httpResponseCode)), struct curl_slist * []))) _curl_easy_getinfo_err_curl_slist(); } curl_easy_getinfo(request->curl, _curl_info, &httpResponseCode); })
                                             != CURLE_OK) {

        request->status = S3StatusInternalError;
        return;
    }
    else {
        request->httpResponseCode = httpResponseCode;
    }

    response_headers_handler_done(&(request->responseHeadersHandler),
                                  request->curl);



    if (request->propertiesCallback &&
        (request->httpResponseCode >= 200) &&
        (request->httpResponseCode <= 299)) {
        request->status = (*(request->propertiesCallback))
            (&(request->responseHeadersHandler.responseProperties),
             request->callbackData);
    }
}


static size_t curl_header_func(void *ptr, size_t size, size_t nmemb,
                               void *data)
{
    Request *request = (Request *) data;

    int len = size * nmemb;

    response_headers_handler_add
        (&(request->responseHeadersHandler), (char *) ptr, len);

    return len;
}


static size_t curl_read_func(void *ptr, size_t size, size_t nmemb, void *data)
{
    Request *request = (Request *) data;

    int len = size * nmemb;

    request_headers_done(request);

    if (request->status != S3StatusOK) {
        return 0x10000000;
    }



    if (!request->toS3Callback || !request->toS3CallbackBytesRemaining) {
        return 0;
    }



    if (len > request->toS3CallbackBytesRemaining) {
        len = request->toS3CallbackBytesRemaining;
    }


    int ret = (*(request->toS3Callback))
        (len, (char *) ptr, request->callbackData);
    if (ret < 0) {
        request->status = S3StatusAbortedByCallback;
        return 0x10000000;
    }
    else {
        if (ret > request->toS3CallbackBytesRemaining) {
            ret = request->toS3CallbackBytesRemaining;
        }
        request->toS3CallbackBytesRemaining -= ret;
        return ret;
    }
}


static size_t curl_write_func(void *ptr, size_t size, size_t nmemb,
                              void *data)
{
    Request *request = (Request *) data;

    int len = size * nmemb;

    request_headers_done(request);

    if (request->status != S3StatusOK) {
        return 0;
    }


    if ((request->httpResponseCode < 200) ||
        (request->httpResponseCode > 299)) {
        request->status = error_parser_add
            (&(request->errorParser), (char *) ptr, len);
    }

    else if (request->fromS3Callback) {
        request->status = (*(request->fromS3Callback))
            (len, (char *) ptr, request->callbackData);
    }


    else {
        request->status = S3StatusInternalError;
    }

    return ((request->status == S3StatusOK) ? len : 0);
}
# 253 "./src/request.c"
static S3Status compose_amz_headers(const RequestParams *params,
                                    RequestComputedValues *values)
{
    const S3PutProperties *properties = params->putProperties;

    values->amzHeadersCount = 0;
    values->amzHeadersRaw[0] = 0;
    int len = 0;
# 302 "./src/request.c"
    if (properties) {
        int i;
        for (i = 0; i < properties->metaDataCount; i++) {
            const S3NameValue *property = &(properties->metaData[i]);
            char headerName[2048 - sizeof(": v")];
            int l = snprintf(headerName, sizeof(headerName),
                             "x-amz-meta-" "%s",
                             property->name);
            char *hn = headerName;
            do { values->amzHeaders[values->amzHeadersCount++] = &(values->amzHeadersRaw[len]); if ((len + l) >= (int) sizeof(values->amzHeadersRaw)) { return S3StatusMetaDataHeadersTooLong; } int todo = l; while (todo--) { if ((*(hn) >= 'A') && (*(hn) <= 'Z')) { values->amzHeadersRaw[len++] = 'a' + (*(hn) - 'A'); } else { values->amzHeadersRaw[len++] = *(hn); } (hn)++; } } while (0);

            do { if (0) { values->amzHeaders[values->amzHeadersCount++] = &(values->amzHeadersRaw[len]); } len += snprintf(&(values->amzHeadersRaw[len]), sizeof(values->amzHeadersRaw) - len, ": %s", property->value); if (len >= (int) sizeof(values->amzHeadersRaw)) { return S3StatusMetaDataHeadersTooLong; } while ((len > 0) && (values->amzHeadersRaw[len - 1] == ' ')) { len--; } values->amzHeadersRaw[len++] = 0; } while (0);
        }


        const char *cannedAclString;
        switch (params->putProperties->cannedAcl) {
        case S3CannedAclPrivate:
            cannedAclString = 0;
            break;
        case S3CannedAclPublicRead:
            cannedAclString = "public-read";
            break;
        case S3CannedAclPublicReadWrite:
            cannedAclString = "public-read-write";
            break;
        default:
            cannedAclString = "authenticated-read";
            break;
        }
        if (cannedAclString) {
            do { if (1) { values->amzHeaders[values->amzHeadersCount++] = &(values->amzHeadersRaw[len]); } len += snprintf(&(values->amzHeadersRaw[len]), sizeof(values->amzHeadersRaw) - len, "x-amz-acl: %s", cannedAclString); if (len >= (int) sizeof(values->amzHeadersRaw)) { return S3StatusMetaDataHeadersTooLong; } while ((len > 0) && (values->amzHeadersRaw[len - 1] == ' ')) { len--; } values->amzHeadersRaw[len++] = 0; } while (0);
        }
    }


    time_t now = time(((void *)0));
    char date[64];
    strftime(date, sizeof(date), "%a, %d %b %Y %H:%M:%S GMT", gmtime(&now));
    do { if (1) { values->amzHeaders[values->amzHeadersCount++] = &(values->amzHeadersRaw[len]); } len += snprintf(&(values->amzHeadersRaw[len]), sizeof(values->amzHeadersRaw) - len, "x-amz-date: %s", date); if (len >= (int) sizeof(values->amzHeadersRaw)) { return S3StatusMetaDataHeadersTooLong; } while ((len > 0) && (values->amzHeadersRaw[len - 1] == ' ')) { len--; } values->amzHeadersRaw[len++] = 0; } while (0);

    if (params->httpRequestType == HttpRequestTypeCOPY) {

        if (params->copySourceBucketName && params->copySourceBucketName[0] &&
            params->copySourceKey && params->copySourceKey[0]) {
            do { if (1) { values->amzHeaders[values->amzHeadersCount++] = &(values->amzHeadersRaw[len]); } len += snprintf(&(values->amzHeadersRaw[len]), sizeof(values->amzHeadersRaw) - len, "x-amz-copy-source: /%s/%s", params->copySourceBucketName, params->copySourceKey); if (len >= (int) sizeof(values->amzHeadersRaw)) { return S3StatusMetaDataHeadersTooLong; } while ((len > 0) && (values->amzHeadersRaw[len - 1] == ' ')) { len--; } values->amzHeadersRaw[len++] = 0; } while (0)

                                                 ;
        }

        if (params->putProperties) {
            do { if (1) { values->amzHeaders[values->amzHeadersCount++] = &(values->amzHeadersRaw[len]); } len += snprintf(&(values->amzHeadersRaw[len]), sizeof(values->amzHeadersRaw) - len, "%s", "x-amz-metadata-directive: REPLACE"); if (len >= (int) sizeof(values->amzHeadersRaw)) { return S3StatusMetaDataHeadersTooLong; } while ((len > 0) && (values->amzHeadersRaw[len - 1] == ' ')) { len--; } values->amzHeadersRaw[len++] = 0; } while (0);
        }
    }

    return S3StatusOK;
}



static S3Status compose_standard_headers(const RequestParams *params,
                                         RequestComputedValues *values)
{
# 427 "./src/request.c"
    do { if (params->putProperties && params->putProperties-> cacheControl && params->putProperties-> cacheControl[0]) { const char *val = params->putProperties-> cacheControl; while (*val && is_blank(*val)) { val++; } if (!*val) { return S3StatusBadCacheControl; } int len = snprintf(values-> cacheControlHeader, sizeof(values-> cacheControlHeader), "Cache-Control: %s", val); if (len >= (int) sizeof(values-> cacheControlHeader)) { return S3StatusCacheControlTooLong; } while (is_blank(values-> cacheControlHeader[len])) { len--; } values-> cacheControlHeader[len] = 0; } else { values-> cacheControlHeader[0] = 0; } } while (0)
                                                                       ;


    do { if (params->putProperties && params->putProperties-> contentType && params->putProperties-> contentType[0]) { const char *val = params->putProperties-> contentType; while (*val && is_blank(*val)) { val++; } if (!*val) { return S3StatusBadContentType; } int len = snprintf(values-> contentTypeHeader, sizeof(values-> contentTypeHeader), "Content-Type: %s", val); if (len >= (int) sizeof(values-> contentTypeHeader)) { return S3StatusContentTypeTooLong; } while (is_blank(values-> contentTypeHeader[len])) { len--; } values-> contentTypeHeader[len] = 0; } else { values-> contentTypeHeader[0] = 0; } } while (0)
                                                                     ;


    do { if (params->putProperties && params->putProperties-> md5 && params->putProperties-> md5[0]) { const char *val = params->putProperties-> md5; while (*val && is_blank(*val)) { val++; } if (!*val) { return S3StatusBadMD5; } int len = snprintf(values-> md5Header, sizeof(values-> md5Header), "Content-MD5: %s", val); if (len >= (int) sizeof(values-> md5Header)) { return S3StatusMD5TooLong; } while (is_blank(values-> md5Header[len])) { len--; } values-> md5Header[len] = 0; } else { values-> md5Header[0] = 0; } } while (0)
                                     ;


    do { if (params->putProperties && params->putProperties-> contentDispositionFilename && params->putProperties-> contentDispositionFilename[0]) { const char *val = params->putProperties-> contentDispositionFilename; while (*val && is_blank(*val)) { val++; } if (!*val) { return S3StatusBadContentDispositionFilename; } int len = snprintf(values-> contentDispositionHeader, sizeof(values-> contentDispositionHeader), "Content-Disposition: attachment; filename=\"%s\"", val); if (len >= (int) sizeof(values-> contentDispositionHeader)) { return S3StatusContentDispositionFilenameTooLong; } while (is_blank(values-> contentDispositionHeader[len])) { len--; } values-> contentDispositionHeader[len] = 0; } else { values-> contentDispositionHeader[0] = 0; } } while (0)


                                                            ;


    do { if (params->putProperties && params->putProperties-> contentEncoding && params->putProperties-> contentEncoding[0]) { const char *val = params->putProperties-> contentEncoding; while (*val && is_blank(*val)) { val++; } if (!*val) { return S3StatusBadContentEncoding; } int len = snprintf(values-> contentEncodingHeader, sizeof(values-> contentEncodingHeader), "Content-Encoding: %s", val); if (len >= (int) sizeof(values-> contentEncodingHeader)) { return S3StatusContentEncodingTooLong; } while (is_blank(values-> contentEncodingHeader[len])) { len--; } values-> contentEncodingHeader[len] = 0; } else { values-> contentEncodingHeader[0] = 0; } } while (0)

                                                 ;


    if (params->putProperties && (params->putProperties->expires >= 0)) {
        time_t t = (time_t) params->putProperties->expires;
        strftime(values->expiresHeader, sizeof(values->expiresHeader),
                 "Expires: %a, %d %b %Y %H:%M:%S UTC", gmtime(&t));
    }
    else {
        values->expiresHeader[0] = 0;
    }


    if (params->getConditions &&
        (params->getConditions->ifModifiedSince >= 0)) {
        time_t t = (time_t) params->getConditions->ifModifiedSince;
        strftime(values->ifModifiedSinceHeader,
                 sizeof(values->ifModifiedSinceHeader),
                 "If-Modified-Since: %a, %d %b %Y %H:%M:%S UTC", gmtime(&t));
    }
    else {
        values->ifModifiedSinceHeader[0] = 0;
    }


    if (params->getConditions &&
        (params->getConditions->ifNotModifiedSince >= 0)) {
        time_t t = (time_t) params->getConditions->ifNotModifiedSince;
        strftime(values->ifUnmodifiedSinceHeader,
                 sizeof(values->ifUnmodifiedSinceHeader),
                 "If-Unmodified-Since: %a, %d %b %Y %H:%M:%S UTC", gmtime(&t));
    }
    else {
        values->ifUnmodifiedSinceHeader[0] = 0;
    }


    do { if (params->getConditions && params->getConditions-> ifMatchETag && params->getConditions-> ifMatchETag[0]) { const char *val = params->getConditions-> ifMatchETag; while (*val && is_blank(*val)) { val++; } if (!*val) { return S3StatusBadIfMatchETag; } int len = snprintf(values-> ifMatchHeader, sizeof(values-> ifMatchHeader), "If-Match: %s", val); if (len >= (int) sizeof(values-> ifMatchHeader)) { return S3StatusIfMatchETagTooLong; } while (is_blank(values-> ifMatchHeader[len])) { len--; } values-> ifMatchHeader[len] = 0; } else { values-> ifMatchHeader[0] = 0; } } while (0)
                                                                     ;


    do { if (params->getConditions && params->getConditions-> ifNotMatchETag && params->getConditions-> ifNotMatchETag[0]) { const char *val = params->getConditions-> ifNotMatchETag; while (*val && is_blank(*val)) { val++; } if (!*val) { return S3StatusBadIfNotMatchETag; } int len = snprintf(values-> ifNoneMatchHeader, sizeof(values-> ifNoneMatchHeader), "If-None-Match: %s", val); if (len >= (int) sizeof(values-> ifNoneMatchHeader)) { return S3StatusIfNotMatchETagTooLong; } while (is_blank(values-> ifNoneMatchHeader[len])) { len--; } values-> ifNoneMatchHeader[len] = 0; } else { values-> ifNoneMatchHeader[0] = 0; } } while (0)

                                                ;


    if (params->startByte || params->byteCount) {
        if (params->byteCount) {
            snprintf(values->rangeHeader, sizeof(values->rangeHeader),
                     "Range: bytes=%llu-%llu",
                     (unsigned long long) params->startByte,
                     (unsigned long long) (params->startByte +
                                           params->byteCount - 1));
        }
        else {
            snprintf(values->rangeHeader, sizeof(values->rangeHeader),
                     "Range: bytes=%llu-",
                     (unsigned long long) params->startByte);
        }
    }
    else {
        values->rangeHeader[0] = 0;
    }

    return S3StatusOK;
}



static S3Status encode_key(const RequestParams *params,
                           RequestComputedValues *values)
{
    return (urlEncode(values->urlEncodedKey, params->key, 1024) ?
            S3StatusOK : S3StatusUriTooLong);
}





static int headerle(const char *header1, const char *header2)
{
    while (1) {
        if (*header1 == ':') {
            return (*header2 != ':');
        }
        else if (*header2 == ':') {
            return 0;
        }
        else if (*header2 < *header1) {
            return 0;
        }
        else if (*header2 > *header1) {
            return 1;
        }
        header1++, header2++;
    }
}
# 555 "./src/request.c"
static void header_gnome_sort(const char **headers, int size)
{
    int i = 0, last_highest = 0;

    while (i < size) {
        if ((i == 0) || headerle(headers[i - 1], headers[i])) {
            i = ++last_highest;
        }
        else {
            const char *tmp = headers[i];
            headers[i] = headers[i - 1];
            headers[--i] = tmp;
        }
    }
}



static void canonicalize_amz_headers(RequestComputedValues *values)
{

    const char *sortedHeaders[(2048 / (sizeof("x-amz-meta-" "nv") - 1))];

    memcpy(sortedHeaders, values->amzHeaders,
           (values->amzHeadersCount * sizeof(sortedHeaders[0])));


    header_gnome_sort(sortedHeaders, values->amzHeadersCount);





    int lastHeaderLen = 0, i;
    char *buffer = values->canonicalizedAmzHeaders;
    for (i = 0; i < values->amzHeadersCount; i++) {
        const char *header = sortedHeaders[i];
        const char *c = header;

        if ((i > 0) &&
            !strncmp(header, sortedHeaders[i - 1], lastHeaderLen)) {

            *(buffer - 1) = ',';

            c += (lastHeaderLen + 1);
        }

        else {

            while (*c != ' ') {
                *buffer++ = *c++;
            }

            lastHeaderLen = c - header;

            c++;
        }

        while (*c) {


            if ((*c == '\r') && (*(c + 1) == '\n') && is_blank(*(c + 2))) {
                c += 3;
                while (is_blank(*c)) {
                    c++;
                }




                while (is_blank(*(buffer - 1))) {
                    buffer--;
                }
                continue;
            }
            *buffer++ = *c++;
        }

        *buffer++ = '\n';
    }


    *buffer = 0;
}



static void canonicalize_resource(const char *bucketName,
                                  const char *subResource,
                                  const char *urlEncodedKey,
                                  char *buffer)
{
    int len = 0;

    *buffer = 0;



    if (bucketName && bucketName[0]) {
        buffer[len++] = '/';
        len += sprintf(&(buffer[len]), "%s", bucketName);
    }

    len += sprintf(&(buffer[len]), "%s", "/");

    if (urlEncodedKey && urlEncodedKey[0]) {
        len += sprintf(&(buffer[len]), "%s", urlEncodedKey);
    }

    if (subResource && subResource[0]) {
        len += sprintf(&(buffer[len]), "%s", "?");
        len += sprintf(&(buffer[len]), "%s", subResource);
    }
}



static const char *http_request_type_to_verb(HttpRequestType requestType)
{
    switch (requestType) {
    case HttpRequestTypeGET:
        return "GET";
    case HttpRequestTypeHEAD:
        return "HEAD";
    case HttpRequestTypePUT:
    case HttpRequestTypeCOPY:
        return "PUT";
    default:
        return "DELETE";
    }
}



static S3Status compose_auth_header(const RequestParams *params,
                                    RequestComputedValues *values)
{






    char signbuf[17 + 129 + 129 + 1 +
                 (sizeof(values->canonicalizedAmzHeaders) - 1) +
                 (sizeof(values->canonicalizedResource) - 1) + 1];
    int len = 0;





    len += snprintf(&(signbuf[len]), sizeof(signbuf) - len, "%s\n", http_request_type_to_verb(params->httpRequestType))
                                                                    ;



    len += snprintf(&(signbuf[len]), sizeof(signbuf) - len, "%s\n", values->md5Header[0] ? &(values->md5Header[sizeof("Content-MD5: ") - 1]) : "")
                                                                          ;

    len += snprintf(&(signbuf[len]), sizeof(signbuf) - len, "%s\n", values->contentTypeHeader[0] ? &(values->contentTypeHeader[sizeof("Content-Type: ") - 1]) : "")

                                                                         ;

    len += snprintf(&(signbuf[len]), sizeof(signbuf) - len, "%s", "\n");

    len += snprintf(&(signbuf[len]), sizeof(signbuf) - len, "%s", values->canonicalizedAmzHeaders);

    len += snprintf(&(signbuf[len]), sizeof(signbuf) - len, "%s", values->canonicalizedResource);


    unsigned char hmac[20];

    HMAC_SHA1(hmac, (unsigned char *) params->bucketContext.secretAccessKey,
              strlen(params->bucketContext.secretAccessKey),
              (unsigned char *) signbuf, len);


    char b64[((20 + 1) * 4) / 3];
    int b64Len = base64Encode(hmac, 20, b64);

    snprintf(values->authorizationHeader, sizeof(values->authorizationHeader),
             "Authorization: AWS %s:%.*s", params->bucketContext.accessKeyId,
             b64Len, b64);

    return S3StatusOK;
}



static S3Status compose_uri(char *buffer, int bufferSize,
                            const S3BucketContext *bucketContext,
                            const char *urlEncodedKey,
                            const char *subResource, const char *queryParams)
{
    int len = 0;
# 760 "./src/request.c"
    do { len += snprintf(&(buffer[len]), bufferSize - len, "http%s://", (bucketContext->protocol == S3ProtocolHTTP) ? "" : "s"); if (len >= bufferSize) { return S3StatusUriTooLong; } } while (0)
                                                                      ;

    const char *hostName =
        bucketContext->hostName ? bucketContext->hostName : defaultHostNameG;

    if (bucketContext->bucketName &&
        bucketContext->bucketName[0]) {
        if (bucketContext->uriStyle == S3UriStyleVirtualHost) {
            do { len += snprintf(&(buffer[len]), bufferSize - len, "%s.%s", bucketContext->bucketName, hostName); if (len >= bufferSize) { return S3StatusUriTooLong; } } while (0);
        }
        else {
            do { len += snprintf(&(buffer[len]), bufferSize - len, "%s/%s", hostName, bucketContext->bucketName); if (len >= bufferSize) { return S3StatusUriTooLong; } } while (0);
        }
    }
    else {
        do { len += snprintf(&(buffer[len]), bufferSize - len, "%s", hostName); if (len >= bufferSize) { return S3StatusUriTooLong; } } while (0);
    }

    do { len += snprintf(&(buffer[len]), bufferSize - len, "%s", "/"); if (len >= bufferSize) { return S3StatusUriTooLong; } } while (0);

    do { len += snprintf(&(buffer[len]), bufferSize - len, "%s", urlEncodedKey); if (len >= bufferSize) { return S3StatusUriTooLong; } } while (0);

    if (subResource && subResource[0]) {
        do { len += snprintf(&(buffer[len]), bufferSize - len, "?%s", subResource); if (len >= bufferSize) { return S3StatusUriTooLong; } } while (0);
    }

    if (queryParams) {
        do { len += snprintf(&(buffer[len]), bufferSize - len, "%s%s", (subResource && subResource[0]) ? "&" : "?", queryParams); if (len >= bufferSize) { return S3StatusUriTooLong; } } while (0)
                               ;
    }

    return S3StatusOK;
}



static S3Status setup_curl(Request *request,
                           const RequestParams *params,
                           const RequestComputedValues *values)
{
    CURLcode status;
# 813 "./src/request.c"
    if ((status = __extension__ ({ __typeof__ (CURLOPT_PRIVATE) _curl_opt = CURLOPT_PRIVATE; if(__builtin_constant_p(_curl_opt)) { if((0 < (_curl_opt) && (_curl_opt) < 10000)) if(!(__builtin_types_compatible_p(__typeof__(request), long) || __builtin_types_compatible_p(__typeof__(request), signed long) || __builtin_types_compatible_p(__typeof__(request), unsigned long) || __builtin_types_compatible_p(__typeof__(request), int) || __builtin_types_compatible_p(__typeof__(request), signed int) || __builtin_types_compatible_p(__typeof__(request), unsigned int) || __builtin_types_compatible_p(__typeof__(request), short) || __builtin_types_compatible_p(__typeof__(request), signed short) || __builtin_types_compatible_p(__typeof__(request), unsigned short) || __builtin_types_compatible_p(__typeof__(request), char) || __builtin_types_compatible_p(__typeof__(request), signed char) || __builtin_types_compatible_p(__typeof__(request), unsigned char))) _curl_easy_setopt_err_long(); if(((_curl_opt) > 30000)) if(!(__builtin_types_compatible_p(__typeof__(request), curl_off_t))) _curl_easy_setopt_err_curl_off_t(); if(((_curl_opt) == CURLOPT_URL || (_curl_opt) == CURLOPT_PROXY || (_curl_opt) == CURLOPT_INTERFACE || (_curl_opt) == CURLOPT_NETRC_FILE || (_curl_opt) == CURLOPT_USERPWD || (_curl_opt) == CURLOPT_USERNAME || (_curl_opt) == CURLOPT_PASSWORD || (_curl_opt) == CURLOPT_PROXYUSERPWD || (_curl_opt) == CURLOPT_PROXYUSERNAME || (_curl_opt) == CURLOPT_PROXYPASSWORD || (_curl_opt) == CURLOPT_NOPROXY || (_curl_opt) == CURLOPT_ACCEPT_ENCODING || (_curl_opt) == CURLOPT_REFERER || (_curl_opt) == CURLOPT_USERAGENT || (_curl_opt) == CURLOPT_COOKIE || (_curl_opt) == CURLOPT_COOKIEFILE || (_curl_opt) == CURLOPT_COOKIEJAR || (_curl_opt) == CURLOPT_COOKIELIST || (_curl_opt) == CURLOPT_FTPPORT || (_curl_opt) == CURLOPT_FTP_ALTERNATIVE_TO_USER || (_curl_opt) == CURLOPT_FTP_ACCOUNT || (_curl_opt) == CURLOPT_RANGE || (_curl_opt) == CURLOPT_CUSTOMREQUEST || (_curl_opt) == CURLOPT_SSLCERT || (_curl_opt) == CURLOPT_SSLCERTTYPE || (_curl_opt) == CURLOPT_SSLKEY || (_curl_opt) == CURLOPT_SSLKEYTYPE || (_curl_opt) == CURLOPT_KEYPASSWD || (_curl_opt) == CURLOPT_SSLENGINE || (_curl_opt) == CURLOPT_CAINFO || (_curl_opt) == CURLOPT_CAPATH || (_curl_opt) == CURLOPT_RANDOM_FILE || (_curl_opt) == CURLOPT_EGDSOCKET || (_curl_opt) == CURLOPT_SSL_CIPHER_LIST || (_curl_opt) == CURLOPT_KRBLEVEL || (_curl_opt) == CURLOPT_SSH_HOST_PUBLIC_KEY_MD5 || (_curl_opt) == CURLOPT_SSH_PUBLIC_KEYFILE || (_curl_opt) == CURLOPT_SSH_PRIVATE_KEYFILE || (_curl_opt) == CURLOPT_CRLFILE || (_curl_opt) == CURLOPT_ISSUERCERT || (_curl_opt) == CURLOPT_SOCKS5_GSSAPI_SERVICE || (_curl_opt) == CURLOPT_SSH_KNOWNHOSTS || (_curl_opt) == CURLOPT_MAIL_FROM || (_curl_opt) == CURLOPT_RTSP_SESSION_ID || (_curl_opt) == CURLOPT_RTSP_STREAM_URI || (_curl_opt) == CURLOPT_RTSP_TRANSPORT || 0)) if(!((((__builtin_types_compatible_p(__typeof__(((request))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((request))), char *) || __builtin_types_compatible_p(__typeof__(((request))), const char *)) || __builtin_types_compatible_p(__typeof__((request)), char [])) || (((__builtin_types_compatible_p(__typeof__(((request))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((request))), signed char *) || __builtin_types_compatible_p(__typeof__(((request))), const signed char *)) || __builtin_types_compatible_p(__typeof__((request)), signed char [])) || (((__builtin_types_compatible_p(__typeof__(((request))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((request))), unsigned char *) || __builtin_types_compatible_p(__typeof__(((request))), const unsigned char *)) || __builtin_types_compatible_p(__typeof__((request)), unsigned char [])))) _curl_easy_setopt_err_string(); if(((_curl_opt) == CURLOPT_HEADERFUNCTION || (_curl_opt) == CURLOPT_WRITEFUNCTION)) if(!(((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(request), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback6*))) || __builtin_types_compatible_p(__typeof__(request), __typeof__(fwrite)) || __builtin_types_compatible_p(__typeof__(request), curl_write_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_write_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_write_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_write_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_write_callback2*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_write_callback3) || __builtin_types_compatible_p(__typeof__((request)), _curl_write_callback3*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_write_callback4) || __builtin_types_compatible_p(__typeof__((request)), _curl_write_callback4*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_write_callback5) || __builtin_types_compatible_p(__typeof__((request)), _curl_write_callback5*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_write_callback6) || __builtin_types_compatible_p(__typeof__((request)), _curl_write_callback6*)))) _curl_easy_setopt_err_write_callback(); if((_curl_opt) == CURLOPT_READFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(request), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback6*)))) _curl_easy_setopt_err_read_cb(); if((_curl_opt) == CURLOPT_IOCTLFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), curl_ioctl_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ioctl_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_ioctl_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ioctl_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_ioctl_callback2*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ioctl_callback3) || __builtin_types_compatible_p(__typeof__((request)), _curl_ioctl_callback3*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ioctl_callback4) || __builtin_types_compatible_p(__typeof__((request)), _curl_ioctl_callback4*)))) _curl_easy_setopt_err_ioctl_cb(); if((_curl_opt) == CURLOPT_SOCKOPTFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), curl_sockopt_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_sockopt_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_sockopt_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_sockopt_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_sockopt_callback2*)))) _curl_easy_setopt_err_sockopt_cb(); if((_curl_opt) == CURLOPT_OPENSOCKETFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), curl_opensocket_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_opensocket_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_opensocket_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_opensocket_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_opensocket_callback2*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_opensocket_callback3) || __builtin_types_compatible_p(__typeof__((request)), _curl_opensocket_callback3*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_opensocket_callback4) || __builtin_types_compatible_p(__typeof__((request)), _curl_opensocket_callback4*)))) _curl_easy_setopt_err_opensocket_cb(); if((_curl_opt) == CURLOPT_PROGRESSFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), curl_progress_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_progress_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_progress_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_progress_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_progress_callback2*)))) _curl_easy_setopt_err_progress_cb(); if((_curl_opt) == CURLOPT_DEBUGFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), curl_debug_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback2*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback3) || __builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback3*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback4) || __builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback4*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback5) || __builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback5*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback6) || __builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback6*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback7) || __builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback7*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback8) || __builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback8*)))) _curl_easy_setopt_err_debug_cb(); if((_curl_opt) == CURLOPT_SSL_CTX_FUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), curl_ssl_ctx_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback2*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback3) || __builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback3*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback4) || __builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback4*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback5) || __builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback5*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback6) || __builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback6*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback7) || __builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback7*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback8) || __builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback8*)))) _curl_easy_setopt_err_ssl_ctx_cb(); if(((_curl_opt) == CURLOPT_CONV_TO_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_UTF8_FUNCTION)) if(!((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), curl_conv_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_conv_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_conv_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_conv_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_conv_callback2*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_conv_callback3) || __builtin_types_compatible_p(__typeof__((request)), _curl_conv_callback3*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_conv_callback4) || __builtin_types_compatible_p(__typeof__((request)), _curl_conv_callback4*)))) _curl_easy_setopt_err_conv_cb(); if((_curl_opt) == CURLOPT_SEEKFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), curl_seek_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_seek_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_seek_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_seek_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_seek_callback2*)))) _curl_easy_setopt_err_seek_cb(); if(((_curl_opt) == CURLOPT_FILE || (_curl_opt) == CURLOPT_INFILE || (_curl_opt) == CURLOPT_IOCTLDATA || (_curl_opt) == CURLOPT_SOCKOPTDATA || (_curl_opt) == CURLOPT_OPENSOCKETDATA || (_curl_opt) == CURLOPT_PROGRESSDATA || (_curl_opt) == CURLOPT_WRITEHEADER || (_curl_opt) == CURLOPT_DEBUGDATA || (_curl_opt) == CURLOPT_SSL_CTX_DATA || (_curl_opt) == CURLOPT_SEEKDATA || (_curl_opt) == CURLOPT_PRIVATE || (_curl_opt) == CURLOPT_SSH_KEYDATA || (_curl_opt) == CURLOPT_INTERLEAVEDATA || (_curl_opt) == CURLOPT_CHUNK_DATA || (_curl_opt) == CURLOPT_FNMATCH_DATA || 0)) if(!(sizeof(request) == sizeof(void*))) _curl_easy_setopt_err_cb_data(); if((_curl_opt) == CURLOPT_ERRORBUFFER) if(!((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), char *) || __builtin_types_compatible_p(__typeof__(request), char[]))) _curl_easy_setopt_err_error_buffer(); if((_curl_opt) == CURLOPT_STDERR) if(!(__builtin_types_compatible_p(__typeof__(request), FILE *))) _curl_easy_setopt_err_FILE(); if(((_curl_opt) == CURLOPT_POSTFIELDS || (_curl_opt) == CURLOPT_COPYPOSTFIELDS || 0)) if(!(((__builtin_types_compatible_p(__typeof__((request)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((request)), void *) || __builtin_types_compatible_p(__typeof__((request)), const void *)) || (((__builtin_types_compatible_p(__typeof__(((request))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((request))), char *) || __builtin_types_compatible_p(__typeof__(((request))), const char *)) || __builtin_types_compatible_p(__typeof__((request)), char [])))) _curl_easy_setopt_err_postfields(); if((_curl_opt) == CURLOPT_HTTPPOST) if(!(((__builtin_types_compatible_p(__typeof__(((request))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((request))), struct curl_httppost *) || __builtin_types_compatible_p(__typeof__(((request))), const struct curl_httppost *)) || __builtin_types_compatible_p(__typeof__((request)), struct curl_httppost []))) _curl_easy_setopt_err_curl_httpost(); if(((_curl_opt) == CURLOPT_HTTPHEADER || (_curl_opt) == CURLOPT_HTTP200ALIASES || (_curl_opt) == CURLOPT_QUOTE || (_curl_opt) == CURLOPT_POSTQUOTE || (_curl_opt) == CURLOPT_PREQUOTE || (_curl_opt) == CURLOPT_TELNETOPTIONS || (_curl_opt) == CURLOPT_MAIL_RCPT || 0)) if(!(((__builtin_types_compatible_p(__typeof__(((request))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((request))), struct curl_slist *) || __builtin_types_compatible_p(__typeof__(((request))), const struct curl_slist *)) || __builtin_types_compatible_p(__typeof__((request)), struct curl_slist []))) _curl_easy_setopt_err_curl_slist(); if((_curl_opt) == CURLOPT_SHARE) if(!((__builtin_types_compatible_p(__typeof__((request)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((request)), CURLSH *) || __builtin_types_compatible_p(__typeof__((request)), const CURLSH *))) _curl_easy_setopt_err_CURLSH(); } curl_easy_setopt(request->curl, _curl_opt, request); })) != CURLE_OK) { return S3StatusFailedToInitializeRequest; };


    if ((status = __extension__ ({ __typeof__ (CURLOPT_WRITEHEADER) _curl_opt = CURLOPT_WRITEHEADER; if(__builtin_constant_p(_curl_opt)) { if((0 < (_curl_opt) && (_curl_opt) < 10000)) if(!(__builtin_types_compatible_p(__typeof__(request), long) || __builtin_types_compatible_p(__typeof__(request), signed long) || __builtin_types_compatible_p(__typeof__(request), unsigned long) || __builtin_types_compatible_p(__typeof__(request), int) || __builtin_types_compatible_p(__typeof__(request), signed int) || __builtin_types_compatible_p(__typeof__(request), unsigned int) || __builtin_types_compatible_p(__typeof__(request), short) || __builtin_types_compatible_p(__typeof__(request), signed short) || __builtin_types_compatible_p(__typeof__(request), unsigned short) || __builtin_types_compatible_p(__typeof__(request), char) || __builtin_types_compatible_p(__typeof__(request), signed char) || __builtin_types_compatible_p(__typeof__(request), unsigned char))) _curl_easy_setopt_err_long(); if(((_curl_opt) > 30000)) if(!(__builtin_types_compatible_p(__typeof__(request), curl_off_t))) _curl_easy_setopt_err_curl_off_t(); if(((_curl_opt) == CURLOPT_URL || (_curl_opt) == CURLOPT_PROXY || (_curl_opt) == CURLOPT_INTERFACE || (_curl_opt) == CURLOPT_NETRC_FILE || (_curl_opt) == CURLOPT_USERPWD || (_curl_opt) == CURLOPT_USERNAME || (_curl_opt) == CURLOPT_PASSWORD || (_curl_opt) == CURLOPT_PROXYUSERPWD || (_curl_opt) == CURLOPT_PROXYUSERNAME || (_curl_opt) == CURLOPT_PROXYPASSWORD || (_curl_opt) == CURLOPT_NOPROXY || (_curl_opt) == CURLOPT_ACCEPT_ENCODING || (_curl_opt) == CURLOPT_REFERER || (_curl_opt) == CURLOPT_USERAGENT || (_curl_opt) == CURLOPT_COOKIE || (_curl_opt) == CURLOPT_COOKIEFILE || (_curl_opt) == CURLOPT_COOKIEJAR || (_curl_opt) == CURLOPT_COOKIELIST || (_curl_opt) == CURLOPT_FTPPORT || (_curl_opt) == CURLOPT_FTP_ALTERNATIVE_TO_USER || (_curl_opt) == CURLOPT_FTP_ACCOUNT || (_curl_opt) == CURLOPT_RANGE || (_curl_opt) == CURLOPT_CUSTOMREQUEST || (_curl_opt) == CURLOPT_SSLCERT || (_curl_opt) == CURLOPT_SSLCERTTYPE || (_curl_opt) == CURLOPT_SSLKEY || (_curl_opt) == CURLOPT_SSLKEYTYPE || (_curl_opt) == CURLOPT_KEYPASSWD || (_curl_opt) == CURLOPT_SSLENGINE || (_curl_opt) == CURLOPT_CAINFO || (_curl_opt) == CURLOPT_CAPATH || (_curl_opt) == CURLOPT_RANDOM_FILE || (_curl_opt) == CURLOPT_EGDSOCKET || (_curl_opt) == CURLOPT_SSL_CIPHER_LIST || (_curl_opt) == CURLOPT_KRBLEVEL || (_curl_opt) == CURLOPT_SSH_HOST_PUBLIC_KEY_MD5 || (_curl_opt) == CURLOPT_SSH_PUBLIC_KEYFILE || (_curl_opt) == CURLOPT_SSH_PRIVATE_KEYFILE || (_curl_opt) == CURLOPT_CRLFILE || (_curl_opt) == CURLOPT_ISSUERCERT || (_curl_opt) == CURLOPT_SOCKS5_GSSAPI_SERVICE || (_curl_opt) == CURLOPT_SSH_KNOWNHOSTS || (_curl_opt) == CURLOPT_MAIL_FROM || (_curl_opt) == CURLOPT_RTSP_SESSION_ID || (_curl_opt) == CURLOPT_RTSP_STREAM_URI || (_curl_opt) == CURLOPT_RTSP_TRANSPORT || 0)) if(!((((__builtin_types_compatible_p(__typeof__(((request))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((request))), char *) || __builtin_types_compatible_p(__typeof__(((request))), const char *)) || __builtin_types_compatible_p(__typeof__((request)), char [])) || (((__builtin_types_compatible_p(__typeof__(((request))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((request))), signed char *) || __builtin_types_compatible_p(__typeof__(((request))), const signed char *)) || __builtin_types_compatible_p(__typeof__((request)), signed char [])) || (((__builtin_types_compatible_p(__typeof__(((request))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((request))), unsigned char *) || __builtin_types_compatible_p(__typeof__(((request))), const unsigned char *)) || __builtin_types_compatible_p(__typeof__((request)), unsigned char [])))) _curl_easy_setopt_err_string(); if(((_curl_opt) == CURLOPT_HEADERFUNCTION || (_curl_opt) == CURLOPT_WRITEFUNCTION)) if(!(((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(request), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback6*))) || __builtin_types_compatible_p(__typeof__(request), __typeof__(fwrite)) || __builtin_types_compatible_p(__typeof__(request), curl_write_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_write_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_write_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_write_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_write_callback2*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_write_callback3) || __builtin_types_compatible_p(__typeof__((request)), _curl_write_callback3*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_write_callback4) || __builtin_types_compatible_p(__typeof__((request)), _curl_write_callback4*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_write_callback5) || __builtin_types_compatible_p(__typeof__((request)), _curl_write_callback5*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_write_callback6) || __builtin_types_compatible_p(__typeof__((request)), _curl_write_callback6*)))) _curl_easy_setopt_err_write_callback(); if((_curl_opt) == CURLOPT_READFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(request), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback6*)))) _curl_easy_setopt_err_read_cb(); if((_curl_opt) == CURLOPT_IOCTLFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), curl_ioctl_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ioctl_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_ioctl_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ioctl_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_ioctl_callback2*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ioctl_callback3) || __builtin_types_compatible_p(__typeof__((request)), _curl_ioctl_callback3*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ioctl_callback4) || __builtin_types_compatible_p(__typeof__((request)), _curl_ioctl_callback4*)))) _curl_easy_setopt_err_ioctl_cb(); if((_curl_opt) == CURLOPT_SOCKOPTFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), curl_sockopt_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_sockopt_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_sockopt_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_sockopt_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_sockopt_callback2*)))) _curl_easy_setopt_err_sockopt_cb(); if((_curl_opt) == CURLOPT_OPENSOCKETFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), curl_opensocket_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_opensocket_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_opensocket_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_opensocket_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_opensocket_callback2*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_opensocket_callback3) || __builtin_types_compatible_p(__typeof__((request)), _curl_opensocket_callback3*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_opensocket_callback4) || __builtin_types_compatible_p(__typeof__((request)), _curl_opensocket_callback4*)))) _curl_easy_setopt_err_opensocket_cb(); if((_curl_opt) == CURLOPT_PROGRESSFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), curl_progress_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_progress_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_progress_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_progress_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_progress_callback2*)))) _curl_easy_setopt_err_progress_cb(); if((_curl_opt) == CURLOPT_DEBUGFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), curl_debug_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback2*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback3) || __builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback3*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback4) || __builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback4*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback5) || __builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback5*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback6) || __builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback6*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback7) || __builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback7*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback8) || __builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback8*)))) _curl_easy_setopt_err_debug_cb(); if((_curl_opt) == CURLOPT_SSL_CTX_FUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), curl_ssl_ctx_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback2*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback3) || __builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback3*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback4) || __builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback4*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback5) || __builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback5*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback6) || __builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback6*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback7) || __builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback7*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback8) || __builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback8*)))) _curl_easy_setopt_err_ssl_ctx_cb(); if(((_curl_opt) == CURLOPT_CONV_TO_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_UTF8_FUNCTION)) if(!((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), curl_conv_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_conv_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_conv_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_conv_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_conv_callback2*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_conv_callback3) || __builtin_types_compatible_p(__typeof__((request)), _curl_conv_callback3*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_conv_callback4) || __builtin_types_compatible_p(__typeof__((request)), _curl_conv_callback4*)))) _curl_easy_setopt_err_conv_cb(); if((_curl_opt) == CURLOPT_SEEKFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), curl_seek_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_seek_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_seek_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_seek_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_seek_callback2*)))) _curl_easy_setopt_err_seek_cb(); if(((_curl_opt) == CURLOPT_FILE || (_curl_opt) == CURLOPT_INFILE || (_curl_opt) == CURLOPT_IOCTLDATA || (_curl_opt) == CURLOPT_SOCKOPTDATA || (_curl_opt) == CURLOPT_OPENSOCKETDATA || (_curl_opt) == CURLOPT_PROGRESSDATA || (_curl_opt) == CURLOPT_WRITEHEADER || (_curl_opt) == CURLOPT_DEBUGDATA || (_curl_opt) == CURLOPT_SSL_CTX_DATA || (_curl_opt) == CURLOPT_SEEKDATA || (_curl_opt) == CURLOPT_PRIVATE || (_curl_opt) == CURLOPT_SSH_KEYDATA || (_curl_opt) == CURLOPT_INTERLEAVEDATA || (_curl_opt) == CURLOPT_CHUNK_DATA || (_curl_opt) == CURLOPT_FNMATCH_DATA || 0)) if(!(sizeof(request) == sizeof(void*))) _curl_easy_setopt_err_cb_data(); if((_curl_opt) == CURLOPT_ERRORBUFFER) if(!((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), char *) || __builtin_types_compatible_p(__typeof__(request), char[]))) _curl_easy_setopt_err_error_buffer(); if((_curl_opt) == CURLOPT_STDERR) if(!(__builtin_types_compatible_p(__typeof__(request), FILE *))) _curl_easy_setopt_err_FILE(); if(((_curl_opt) == CURLOPT_POSTFIELDS || (_curl_opt) == CURLOPT_COPYPOSTFIELDS || 0)) if(!(((__builtin_types_compatible_p(__typeof__((request)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((request)), void *) || __builtin_types_compatible_p(__typeof__((request)), const void *)) || (((__builtin_types_compatible_p(__typeof__(((request))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((request))), char *) || __builtin_types_compatible_p(__typeof__(((request))), const char *)) || __builtin_types_compatible_p(__typeof__((request)), char [])))) _curl_easy_setopt_err_postfields(); if((_curl_opt) == CURLOPT_HTTPPOST) if(!(((__builtin_types_compatible_p(__typeof__(((request))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((request))), struct curl_httppost *) || __builtin_types_compatible_p(__typeof__(((request))), const struct curl_httppost *)) || __builtin_types_compatible_p(__typeof__((request)), struct curl_httppost []))) _curl_easy_setopt_err_curl_httpost(); if(((_curl_opt) == CURLOPT_HTTPHEADER || (_curl_opt) == CURLOPT_HTTP200ALIASES || (_curl_opt) == CURLOPT_QUOTE || (_curl_opt) == CURLOPT_POSTQUOTE || (_curl_opt) == CURLOPT_PREQUOTE || (_curl_opt) == CURLOPT_TELNETOPTIONS || (_curl_opt) == CURLOPT_MAIL_RCPT || 0)) if(!(((__builtin_types_compatible_p(__typeof__(((request))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((request))), struct curl_slist *) || __builtin_types_compatible_p(__typeof__(((request))), const struct curl_slist *)) || __builtin_types_compatible_p(__typeof__((request)), struct curl_slist []))) _curl_easy_setopt_err_curl_slist(); if((_curl_opt) == CURLOPT_SHARE) if(!((__builtin_types_compatible_p(__typeof__((request)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((request)), CURLSH *) || __builtin_types_compatible_p(__typeof__((request)), const CURLSH *))) _curl_easy_setopt_err_CURLSH(); } curl_easy_setopt(request->curl, _curl_opt, request); })) != CURLE_OK) { return S3StatusFailedToInitializeRequest; };
    if ((status = __extension__ ({ __typeof__ (CURLOPT_HEADERFUNCTION) _curl_opt = CURLOPT_HEADERFUNCTION; if(__builtin_constant_p(_curl_opt)) { if((0 < (_curl_opt) && (_curl_opt) < 10000)) if(!(__builtin_types_compatible_p(__typeof__(&curl_header_func), long) || __builtin_types_compatible_p(__typeof__(&curl_header_func), signed long) || __builtin_types_compatible_p(__typeof__(&curl_header_func), unsigned long) || __builtin_types_compatible_p(__typeof__(&curl_header_func), int) || __builtin_types_compatible_p(__typeof__(&curl_header_func), signed int) || __builtin_types_compatible_p(__typeof__(&curl_header_func), unsigned int) || __builtin_types_compatible_p(__typeof__(&curl_header_func), short) || __builtin_types_compatible_p(__typeof__(&curl_header_func), signed short) || __builtin_types_compatible_p(__typeof__(&curl_header_func), unsigned short) || __builtin_types_compatible_p(__typeof__(&curl_header_func), char) || __builtin_types_compatible_p(__typeof__(&curl_header_func), signed char) || __builtin_types_compatible_p(__typeof__(&curl_header_func), unsigned char))) _curl_easy_setopt_err_long(); if(((_curl_opt) > 30000)) if(!(__builtin_types_compatible_p(__typeof__(&curl_header_func), curl_off_t))) _curl_easy_setopt_err_curl_off_t(); if(((_curl_opt) == CURLOPT_URL || (_curl_opt) == CURLOPT_PROXY || (_curl_opt) == CURLOPT_INTERFACE || (_curl_opt) == CURLOPT_NETRC_FILE || (_curl_opt) == CURLOPT_USERPWD || (_curl_opt) == CURLOPT_USERNAME || (_curl_opt) == CURLOPT_PASSWORD || (_curl_opt) == CURLOPT_PROXYUSERPWD || (_curl_opt) == CURLOPT_PROXYUSERNAME || (_curl_opt) == CURLOPT_PROXYPASSWORD || (_curl_opt) == CURLOPT_NOPROXY || (_curl_opt) == CURLOPT_ACCEPT_ENCODING || (_curl_opt) == CURLOPT_REFERER || (_curl_opt) == CURLOPT_USERAGENT || (_curl_opt) == CURLOPT_COOKIE || (_curl_opt) == CURLOPT_COOKIEFILE || (_curl_opt) == CURLOPT_COOKIEJAR || (_curl_opt) == CURLOPT_COOKIELIST || (_curl_opt) == CURLOPT_FTPPORT || (_curl_opt) == CURLOPT_FTP_ALTERNATIVE_TO_USER || (_curl_opt) == CURLOPT_FTP_ACCOUNT || (_curl_opt) == CURLOPT_RANGE || (_curl_opt) == CURLOPT_CUSTOMREQUEST || (_curl_opt) == CURLOPT_SSLCERT || (_curl_opt) == CURLOPT_SSLCERTTYPE || (_curl_opt) == CURLOPT_SSLKEY || (_curl_opt) == CURLOPT_SSLKEYTYPE || (_curl_opt) == CURLOPT_KEYPASSWD || (_curl_opt) == CURLOPT_SSLENGINE || (_curl_opt) == CURLOPT_CAINFO || (_curl_opt) == CURLOPT_CAPATH || (_curl_opt) == CURLOPT_RANDOM_FILE || (_curl_opt) == CURLOPT_EGDSOCKET || (_curl_opt) == CURLOPT_SSL_CIPHER_LIST || (_curl_opt) == CURLOPT_KRBLEVEL || (_curl_opt) == CURLOPT_SSH_HOST_PUBLIC_KEY_MD5 || (_curl_opt) == CURLOPT_SSH_PUBLIC_KEYFILE || (_curl_opt) == CURLOPT_SSH_PRIVATE_KEYFILE || (_curl_opt) == CURLOPT_CRLFILE || (_curl_opt) == CURLOPT_ISSUERCERT || (_curl_opt) == CURLOPT_SOCKS5_GSSAPI_SERVICE || (_curl_opt) == CURLOPT_SSH_KNOWNHOSTS || (_curl_opt) == CURLOPT_MAIL_FROM || (_curl_opt) == CURLOPT_RTSP_SESSION_ID || (_curl_opt) == CURLOPT_RTSP_STREAM_URI || (_curl_opt) == CURLOPT_RTSP_TRANSPORT || 0)) if(!((((__builtin_types_compatible_p(__typeof__(((&curl_header_func))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&curl_header_func))), char *) || __builtin_types_compatible_p(__typeof__(((&curl_header_func))), const char *)) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), char [])) || (((__builtin_types_compatible_p(__typeof__(((&curl_header_func))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&curl_header_func))), signed char *) || __builtin_types_compatible_p(__typeof__(((&curl_header_func))), const signed char *)) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), signed char [])) || (((__builtin_types_compatible_p(__typeof__(((&curl_header_func))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&curl_header_func))), unsigned char *) || __builtin_types_compatible_p(__typeof__(((&curl_header_func))), const unsigned char *)) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), unsigned char [])))) _curl_easy_setopt_err_string(); if(((_curl_opt) == CURLOPT_HEADERFUNCTION || (_curl_opt) == CURLOPT_WRITEFUNCTION)) if(!(((__builtin_types_compatible_p(__typeof__(&curl_header_func), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&curl_header_func), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(&curl_header_func), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_read_callback6*))) || __builtin_types_compatible_p(__typeof__(&curl_header_func), __typeof__(fwrite)) || __builtin_types_compatible_p(__typeof__(&curl_header_func), curl_write_callback) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_write_callback1) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_write_callback1*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_write_callback2) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_write_callback2*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_write_callback3) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_write_callback3*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_write_callback4) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_write_callback4*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_write_callback5) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_write_callback5*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_write_callback6) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_write_callback6*)))) _curl_easy_setopt_err_write_callback(); if((_curl_opt) == CURLOPT_READFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(&curl_header_func), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&curl_header_func), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(&curl_header_func), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_read_callback6*)))) _curl_easy_setopt_err_read_cb(); if((_curl_opt) == CURLOPT_IOCTLFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(&curl_header_func), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&curl_header_func), curl_ioctl_callback) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_ioctl_callback1) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_ioctl_callback1*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_ioctl_callback2) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_ioctl_callback2*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_ioctl_callback3) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_ioctl_callback3*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_ioctl_callback4) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_ioctl_callback4*)))) _curl_easy_setopt_err_ioctl_cb(); if((_curl_opt) == CURLOPT_SOCKOPTFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(&curl_header_func), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&curl_header_func), curl_sockopt_callback) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_sockopt_callback1) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_sockopt_callback1*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_sockopt_callback2) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_sockopt_callback2*)))) _curl_easy_setopt_err_sockopt_cb(); if((_curl_opt) == CURLOPT_OPENSOCKETFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(&curl_header_func), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&curl_header_func), curl_opensocket_callback) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_opensocket_callback1) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_opensocket_callback1*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_opensocket_callback2) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_opensocket_callback2*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_opensocket_callback3) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_opensocket_callback3*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_opensocket_callback4) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_opensocket_callback4*)))) _curl_easy_setopt_err_opensocket_cb(); if((_curl_opt) == CURLOPT_PROGRESSFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(&curl_header_func), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&curl_header_func), curl_progress_callback) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_progress_callback1) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_progress_callback1*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_progress_callback2) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_progress_callback2*)))) _curl_easy_setopt_err_progress_cb(); if((_curl_opt) == CURLOPT_DEBUGFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(&curl_header_func), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&curl_header_func), curl_debug_callback) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_debug_callback1) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_debug_callback1*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_debug_callback2) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_debug_callback2*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_debug_callback3) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_debug_callback3*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_debug_callback4) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_debug_callback4*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_debug_callback5) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_debug_callback5*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_debug_callback6) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_debug_callback6*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_debug_callback7) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_debug_callback7*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_debug_callback8) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_debug_callback8*)))) _curl_easy_setopt_err_debug_cb(); if((_curl_opt) == CURLOPT_SSL_CTX_FUNCTION) if(!((__builtin_types_compatible_p(__typeof__(&curl_header_func), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&curl_header_func), curl_ssl_ctx_callback) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_ssl_ctx_callback1) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_ssl_ctx_callback1*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_ssl_ctx_callback2) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_ssl_ctx_callback2*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_ssl_ctx_callback3) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_ssl_ctx_callback3*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_ssl_ctx_callback4) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_ssl_ctx_callback4*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_ssl_ctx_callback5) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_ssl_ctx_callback5*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_ssl_ctx_callback6) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_ssl_ctx_callback6*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_ssl_ctx_callback7) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_ssl_ctx_callback7*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_ssl_ctx_callback8) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_ssl_ctx_callback8*)))) _curl_easy_setopt_err_ssl_ctx_cb(); if(((_curl_opt) == CURLOPT_CONV_TO_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_UTF8_FUNCTION)) if(!((__builtin_types_compatible_p(__typeof__(&curl_header_func), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&curl_header_func), curl_conv_callback) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_conv_callback1) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_conv_callback1*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_conv_callback2) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_conv_callback2*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_conv_callback3) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_conv_callback3*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_conv_callback4) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_conv_callback4*)))) _curl_easy_setopt_err_conv_cb(); if((_curl_opt) == CURLOPT_SEEKFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(&curl_header_func), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&curl_header_func), curl_seek_callback) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_seek_callback1) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_seek_callback1*)) || (__builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_seek_callback2) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), _curl_seek_callback2*)))) _curl_easy_setopt_err_seek_cb(); if(((_curl_opt) == CURLOPT_FILE || (_curl_opt) == CURLOPT_INFILE || (_curl_opt) == CURLOPT_IOCTLDATA || (_curl_opt) == CURLOPT_SOCKOPTDATA || (_curl_opt) == CURLOPT_OPENSOCKETDATA || (_curl_opt) == CURLOPT_PROGRESSDATA || (_curl_opt) == CURLOPT_WRITEHEADER || (_curl_opt) == CURLOPT_DEBUGDATA || (_curl_opt) == CURLOPT_SSL_CTX_DATA || (_curl_opt) == CURLOPT_SEEKDATA || (_curl_opt) == CURLOPT_PRIVATE || (_curl_opt) == CURLOPT_SSH_KEYDATA || (_curl_opt) == CURLOPT_INTERLEAVEDATA || (_curl_opt) == CURLOPT_CHUNK_DATA || (_curl_opt) == CURLOPT_FNMATCH_DATA || 0)) if(!(sizeof(&curl_header_func) == sizeof(void*))) _curl_easy_setopt_err_cb_data(); if((_curl_opt) == CURLOPT_ERRORBUFFER) if(!((__builtin_types_compatible_p(__typeof__(&curl_header_func), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&curl_header_func), char *) || __builtin_types_compatible_p(__typeof__(&curl_header_func), char[]))) _curl_easy_setopt_err_error_buffer(); if((_curl_opt) == CURLOPT_STDERR) if(!(__builtin_types_compatible_p(__typeof__(&curl_header_func), FILE *))) _curl_easy_setopt_err_FILE(); if(((_curl_opt) == CURLOPT_POSTFIELDS || (_curl_opt) == CURLOPT_COPYPOSTFIELDS || 0)) if(!(((__builtin_types_compatible_p(__typeof__((&curl_header_func)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), void *) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), const void *)) || (((__builtin_types_compatible_p(__typeof__(((&curl_header_func))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&curl_header_func))), char *) || __builtin_types_compatible_p(__typeof__(((&curl_header_func))), const char *)) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), char [])))) _curl_easy_setopt_err_postfields(); if((_curl_opt) == CURLOPT_HTTPPOST) if(!(((__builtin_types_compatible_p(__typeof__(((&curl_header_func))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&curl_header_func))), struct curl_httppost *) || __builtin_types_compatible_p(__typeof__(((&curl_header_func))), const struct curl_httppost *)) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), struct curl_httppost []))) _curl_easy_setopt_err_curl_httpost(); if(((_curl_opt) == CURLOPT_HTTPHEADER || (_curl_opt) == CURLOPT_HTTP200ALIASES || (_curl_opt) == CURLOPT_QUOTE || (_curl_opt) == CURLOPT_POSTQUOTE || (_curl_opt) == CURLOPT_PREQUOTE || (_curl_opt) == CURLOPT_TELNETOPTIONS || (_curl_opt) == CURLOPT_MAIL_RCPT || 0)) if(!(((__builtin_types_compatible_p(__typeof__(((&curl_header_func))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&curl_header_func))), struct curl_slist *) || __builtin_types_compatible_p(__typeof__(((&curl_header_func))), const struct curl_slist *)) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), struct curl_slist []))) _curl_easy_setopt_err_curl_slist(); if((_curl_opt) == CURLOPT_SHARE) if(!((__builtin_types_compatible_p(__typeof__((&curl_header_func)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), CURLSH *) || __builtin_types_compatible_p(__typeof__((&curl_header_func)), const CURLSH *))) _curl_easy_setopt_err_CURLSH(); } curl_easy_setopt(request->curl, _curl_opt, &curl_header_func); })) != CURLE_OK) { return S3StatusFailedToInitializeRequest; };


    if ((status = __extension__ ({ __typeof__ (CURLOPT_READFUNCTION) _curl_opt = CURLOPT_READFUNCTION; if(__builtin_constant_p(_curl_opt)) { if((0 < (_curl_opt) && (_curl_opt) < 10000)) if(!(__builtin_types_compatible_p(__typeof__(&curl_read_func), long) || __builtin_types_compatible_p(__typeof__(&curl_read_func), signed long) || __builtin_types_compatible_p(__typeof__(&curl_read_func), unsigned long) || __builtin_types_compatible_p(__typeof__(&curl_read_func), int) || __builtin_types_compatible_p(__typeof__(&curl_read_func), signed int) || __builtin_types_compatible_p(__typeof__(&curl_read_func), unsigned int) || __builtin_types_compatible_p(__typeof__(&curl_read_func), short) || __builtin_types_compatible_p(__typeof__(&curl_read_func), signed short) || __builtin_types_compatible_p(__typeof__(&curl_read_func), unsigned short) || __builtin_types_compatible_p(__typeof__(&curl_read_func), char) || __builtin_types_compatible_p(__typeof__(&curl_read_func), signed char) || __builtin_types_compatible_p(__typeof__(&curl_read_func), unsigned char))) _curl_easy_setopt_err_long(); if(((_curl_opt) > 30000)) if(!(__builtin_types_compatible_p(__typeof__(&curl_read_func), curl_off_t))) _curl_easy_setopt_err_curl_off_t(); if(((_curl_opt) == CURLOPT_URL || (_curl_opt) == CURLOPT_PROXY || (_curl_opt) == CURLOPT_INTERFACE || (_curl_opt) == CURLOPT_NETRC_FILE || (_curl_opt) == CURLOPT_USERPWD || (_curl_opt) == CURLOPT_USERNAME || (_curl_opt) == CURLOPT_PASSWORD || (_curl_opt) == CURLOPT_PROXYUSERPWD || (_curl_opt) == CURLOPT_PROXYUSERNAME || (_curl_opt) == CURLOPT_PROXYPASSWORD || (_curl_opt) == CURLOPT_NOPROXY || (_curl_opt) == CURLOPT_ACCEPT_ENCODING || (_curl_opt) == CURLOPT_REFERER || (_curl_opt) == CURLOPT_USERAGENT || (_curl_opt) == CURLOPT_COOKIE || (_curl_opt) == CURLOPT_COOKIEFILE || (_curl_opt) == CURLOPT_COOKIEJAR || (_curl_opt) == CURLOPT_COOKIELIST || (_curl_opt) == CURLOPT_FTPPORT || (_curl_opt) == CURLOPT_FTP_ALTERNATIVE_TO_USER || (_curl_opt) == CURLOPT_FTP_ACCOUNT || (_curl_opt) == CURLOPT_RANGE || (_curl_opt) == CURLOPT_CUSTOMREQUEST || (_curl_opt) == CURLOPT_SSLCERT || (_curl_opt) == CURLOPT_SSLCERTTYPE || (_curl_opt) == CURLOPT_SSLKEY || (_curl_opt) == CURLOPT_SSLKEYTYPE || (_curl_opt) == CURLOPT_KEYPASSWD || (_curl_opt) == CURLOPT_SSLENGINE || (_curl_opt) == CURLOPT_CAINFO || (_curl_opt) == CURLOPT_CAPATH || (_curl_opt) == CURLOPT_RANDOM_FILE || (_curl_opt) == CURLOPT_EGDSOCKET || (_curl_opt) == CURLOPT_SSL_CIPHER_LIST || (_curl_opt) == CURLOPT_KRBLEVEL || (_curl_opt) == CURLOPT_SSH_HOST_PUBLIC_KEY_MD5 || (_curl_opt) == CURLOPT_SSH_PUBLIC_KEYFILE || (_curl_opt) == CURLOPT_SSH_PRIVATE_KEYFILE || (_curl_opt) == CURLOPT_CRLFILE || (_curl_opt) == CURLOPT_ISSUERCERT || (_curl_opt) == CURLOPT_SOCKS5_GSSAPI_SERVICE || (_curl_opt) == CURLOPT_SSH_KNOWNHOSTS || (_curl_opt) == CURLOPT_MAIL_FROM || (_curl_opt) == CURLOPT_RTSP_SESSION_ID || (_curl_opt) == CURLOPT_RTSP_STREAM_URI || (_curl_opt) == CURLOPT_RTSP_TRANSPORT || 0)) if(!((((__builtin_types_compatible_p(__typeof__(((&curl_read_func))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&curl_read_func))), char *) || __builtin_types_compatible_p(__typeof__(((&curl_read_func))), const char *)) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), char [])) || (((__builtin_types_compatible_p(__typeof__(((&curl_read_func))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&curl_read_func))), signed char *) || __builtin_types_compatible_p(__typeof__(((&curl_read_func))), const signed char *)) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), signed char [])) || (((__builtin_types_compatible_p(__typeof__(((&curl_read_func))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&curl_read_func))), unsigned char *) || __builtin_types_compatible_p(__typeof__(((&curl_read_func))), const unsigned char *)) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), unsigned char [])))) _curl_easy_setopt_err_string(); if(((_curl_opt) == CURLOPT_HEADERFUNCTION || (_curl_opt) == CURLOPT_WRITEFUNCTION)) if(!(((__builtin_types_compatible_p(__typeof__(&curl_read_func), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&curl_read_func), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(&curl_read_func), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_read_callback6*))) || __builtin_types_compatible_p(__typeof__(&curl_read_func), __typeof__(fwrite)) || __builtin_types_compatible_p(__typeof__(&curl_read_func), curl_write_callback) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_write_callback1) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_write_callback1*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_write_callback2) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_write_callback2*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_write_callback3) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_write_callback3*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_write_callback4) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_write_callback4*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_write_callback5) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_write_callback5*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_write_callback6) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_write_callback6*)))) _curl_easy_setopt_err_write_callback(); if((_curl_opt) == CURLOPT_READFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(&curl_read_func), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&curl_read_func), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(&curl_read_func), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_read_callback6*)))) _curl_easy_setopt_err_read_cb(); if((_curl_opt) == CURLOPT_IOCTLFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(&curl_read_func), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&curl_read_func), curl_ioctl_callback) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_ioctl_callback1) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_ioctl_callback1*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_ioctl_callback2) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_ioctl_callback2*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_ioctl_callback3) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_ioctl_callback3*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_ioctl_callback4) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_ioctl_callback4*)))) _curl_easy_setopt_err_ioctl_cb(); if((_curl_opt) == CURLOPT_SOCKOPTFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(&curl_read_func), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&curl_read_func), curl_sockopt_callback) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_sockopt_callback1) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_sockopt_callback1*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_sockopt_callback2) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_sockopt_callback2*)))) _curl_easy_setopt_err_sockopt_cb(); if((_curl_opt) == CURLOPT_OPENSOCKETFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(&curl_read_func), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&curl_read_func), curl_opensocket_callback) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_opensocket_callback1) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_opensocket_callback1*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_opensocket_callback2) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_opensocket_callback2*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_opensocket_callback3) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_opensocket_callback3*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_opensocket_callback4) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_opensocket_callback4*)))) _curl_easy_setopt_err_opensocket_cb(); if((_curl_opt) == CURLOPT_PROGRESSFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(&curl_read_func), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&curl_read_func), curl_progress_callback) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_progress_callback1) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_progress_callback1*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_progress_callback2) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_progress_callback2*)))) _curl_easy_setopt_err_progress_cb(); if((_curl_opt) == CURLOPT_DEBUGFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(&curl_read_func), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&curl_read_func), curl_debug_callback) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_debug_callback1) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_debug_callback1*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_debug_callback2) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_debug_callback2*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_debug_callback3) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_debug_callback3*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_debug_callback4) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_debug_callback4*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_debug_callback5) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_debug_callback5*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_debug_callback6) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_debug_callback6*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_debug_callback7) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_debug_callback7*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_debug_callback8) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_debug_callback8*)))) _curl_easy_setopt_err_debug_cb(); if((_curl_opt) == CURLOPT_SSL_CTX_FUNCTION) if(!((__builtin_types_compatible_p(__typeof__(&curl_read_func), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&curl_read_func), curl_ssl_ctx_callback) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_ssl_ctx_callback1) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_ssl_ctx_callback1*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_ssl_ctx_callback2) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_ssl_ctx_callback2*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_ssl_ctx_callback3) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_ssl_ctx_callback3*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_ssl_ctx_callback4) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_ssl_ctx_callback4*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_ssl_ctx_callback5) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_ssl_ctx_callback5*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_ssl_ctx_callback6) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_ssl_ctx_callback6*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_ssl_ctx_callback7) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_ssl_ctx_callback7*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_ssl_ctx_callback8) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_ssl_ctx_callback8*)))) _curl_easy_setopt_err_ssl_ctx_cb(); if(((_curl_opt) == CURLOPT_CONV_TO_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_UTF8_FUNCTION)) if(!((__builtin_types_compatible_p(__typeof__(&curl_read_func), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&curl_read_func), curl_conv_callback) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_conv_callback1) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_conv_callback1*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_conv_callback2) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_conv_callback2*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_conv_callback3) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_conv_callback3*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_conv_callback4) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_conv_callback4*)))) _curl_easy_setopt_err_conv_cb(); if((_curl_opt) == CURLOPT_SEEKFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(&curl_read_func), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&curl_read_func), curl_seek_callback) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_seek_callback1) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_seek_callback1*)) || (__builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_seek_callback2) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), _curl_seek_callback2*)))) _curl_easy_setopt_err_seek_cb(); if(((_curl_opt) == CURLOPT_FILE || (_curl_opt) == CURLOPT_INFILE || (_curl_opt) == CURLOPT_IOCTLDATA || (_curl_opt) == CURLOPT_SOCKOPTDATA || (_curl_opt) == CURLOPT_OPENSOCKETDATA || (_curl_opt) == CURLOPT_PROGRESSDATA || (_curl_opt) == CURLOPT_WRITEHEADER || (_curl_opt) == CURLOPT_DEBUGDATA || (_curl_opt) == CURLOPT_SSL_CTX_DATA || (_curl_opt) == CURLOPT_SEEKDATA || (_curl_opt) == CURLOPT_PRIVATE || (_curl_opt) == CURLOPT_SSH_KEYDATA || (_curl_opt) == CURLOPT_INTERLEAVEDATA || (_curl_opt) == CURLOPT_CHUNK_DATA || (_curl_opt) == CURLOPT_FNMATCH_DATA || 0)) if(!(sizeof(&curl_read_func) == sizeof(void*))) _curl_easy_setopt_err_cb_data(); if((_curl_opt) == CURLOPT_ERRORBUFFER) if(!((__builtin_types_compatible_p(__typeof__(&curl_read_func), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&curl_read_func), char *) || __builtin_types_compatible_p(__typeof__(&curl_read_func), char[]))) _curl_easy_setopt_err_error_buffer(); if((_curl_opt) == CURLOPT_STDERR) if(!(__builtin_types_compatible_p(__typeof__(&curl_read_func), FILE *))) _curl_easy_setopt_err_FILE(); if(((_curl_opt) == CURLOPT_POSTFIELDS || (_curl_opt) == CURLOPT_COPYPOSTFIELDS || 0)) if(!(((__builtin_types_compatible_p(__typeof__((&curl_read_func)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), void *) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), const void *)) || (((__builtin_types_compatible_p(__typeof__(((&curl_read_func))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&curl_read_func))), char *) || __builtin_types_compatible_p(__typeof__(((&curl_read_func))), const char *)) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), char [])))) _curl_easy_setopt_err_postfields(); if((_curl_opt) == CURLOPT_HTTPPOST) if(!(((__builtin_types_compatible_p(__typeof__(((&curl_read_func))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&curl_read_func))), struct curl_httppost *) || __builtin_types_compatible_p(__typeof__(((&curl_read_func))), const struct curl_httppost *)) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), struct curl_httppost []))) _curl_easy_setopt_err_curl_httpost(); if(((_curl_opt) == CURLOPT_HTTPHEADER || (_curl_opt) == CURLOPT_HTTP200ALIASES || (_curl_opt) == CURLOPT_QUOTE || (_curl_opt) == CURLOPT_POSTQUOTE || (_curl_opt) == CURLOPT_PREQUOTE || (_curl_opt) == CURLOPT_TELNETOPTIONS || (_curl_opt) == CURLOPT_MAIL_RCPT || 0)) if(!(((__builtin_types_compatible_p(__typeof__(((&curl_read_func))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&curl_read_func))), struct curl_slist *) || __builtin_types_compatible_p(__typeof__(((&curl_read_func))), const struct curl_slist *)) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), struct curl_slist []))) _curl_easy_setopt_err_curl_slist(); if((_curl_opt) == CURLOPT_SHARE) if(!((__builtin_types_compatible_p(__typeof__((&curl_read_func)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), CURLSH *) || __builtin_types_compatible_p(__typeof__((&curl_read_func)), const CURLSH *))) _curl_easy_setopt_err_CURLSH(); } curl_easy_setopt(request->curl, _curl_opt, &curl_read_func); })) != CURLE_OK) { return S3StatusFailedToInitializeRequest; };
    if ((status = __extension__ ({ __typeof__ (CURLOPT_INFILE) _curl_opt = CURLOPT_INFILE; if(__builtin_constant_p(_curl_opt)) { if((0 < (_curl_opt) && (_curl_opt) < 10000)) if(!(__builtin_types_compatible_p(__typeof__(request), long) || __builtin_types_compatible_p(__typeof__(request), signed long) || __builtin_types_compatible_p(__typeof__(request), unsigned long) || __builtin_types_compatible_p(__typeof__(request), int) || __builtin_types_compatible_p(__typeof__(request), signed int) || __builtin_types_compatible_p(__typeof__(request), unsigned int) || __builtin_types_compatible_p(__typeof__(request), short) || __builtin_types_compatible_p(__typeof__(request), signed short) || __builtin_types_compatible_p(__typeof__(request), unsigned short) || __builtin_types_compatible_p(__typeof__(request), char) || __builtin_types_compatible_p(__typeof__(request), signed char) || __builtin_types_compatible_p(__typeof__(request), unsigned char))) _curl_easy_setopt_err_long(); if(((_curl_opt) > 30000)) if(!(__builtin_types_compatible_p(__typeof__(request), curl_off_t))) _curl_easy_setopt_err_curl_off_t(); if(((_curl_opt) == CURLOPT_URL || (_curl_opt) == CURLOPT_PROXY || (_curl_opt) == CURLOPT_INTERFACE || (_curl_opt) == CURLOPT_NETRC_FILE || (_curl_opt) == CURLOPT_USERPWD || (_curl_opt) == CURLOPT_USERNAME || (_curl_opt) == CURLOPT_PASSWORD || (_curl_opt) == CURLOPT_PROXYUSERPWD || (_curl_opt) == CURLOPT_PROXYUSERNAME || (_curl_opt) == CURLOPT_PROXYPASSWORD || (_curl_opt) == CURLOPT_NOPROXY || (_curl_opt) == CURLOPT_ACCEPT_ENCODING || (_curl_opt) == CURLOPT_REFERER || (_curl_opt) == CURLOPT_USERAGENT || (_curl_opt) == CURLOPT_COOKIE || (_curl_opt) == CURLOPT_COOKIEFILE || (_curl_opt) == CURLOPT_COOKIEJAR || (_curl_opt) == CURLOPT_COOKIELIST || (_curl_opt) == CURLOPT_FTPPORT || (_curl_opt) == CURLOPT_FTP_ALTERNATIVE_TO_USER || (_curl_opt) == CURLOPT_FTP_ACCOUNT || (_curl_opt) == CURLOPT_RANGE || (_curl_opt) == CURLOPT_CUSTOMREQUEST || (_curl_opt) == CURLOPT_SSLCERT || (_curl_opt) == CURLOPT_SSLCERTTYPE || (_curl_opt) == CURLOPT_SSLKEY || (_curl_opt) == CURLOPT_SSLKEYTYPE || (_curl_opt) == CURLOPT_KEYPASSWD || (_curl_opt) == CURLOPT_SSLENGINE || (_curl_opt) == CURLOPT_CAINFO || (_curl_opt) == CURLOPT_CAPATH || (_curl_opt) == CURLOPT_RANDOM_FILE || (_curl_opt) == CURLOPT_EGDSOCKET || (_curl_opt) == CURLOPT_SSL_CIPHER_LIST || (_curl_opt) == CURLOPT_KRBLEVEL || (_curl_opt) == CURLOPT_SSH_HOST_PUBLIC_KEY_MD5 || (_curl_opt) == CURLOPT_SSH_PUBLIC_KEYFILE || (_curl_opt) == CURLOPT_SSH_PRIVATE_KEYFILE || (_curl_opt) == CURLOPT_CRLFILE || (_curl_opt) == CURLOPT_ISSUERCERT || (_curl_opt) == CURLOPT_SOCKS5_GSSAPI_SERVICE || (_curl_opt) == CURLOPT_SSH_KNOWNHOSTS || (_curl_opt) == CURLOPT_MAIL_FROM || (_curl_opt) == CURLOPT_RTSP_SESSION_ID || (_curl_opt) == CURLOPT_RTSP_STREAM_URI || (_curl_opt) == CURLOPT_RTSP_TRANSPORT || 0)) if(!((((__builtin_types_compatible_p(__typeof__(((request))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((request))), char *) || __builtin_types_compatible_p(__typeof__(((request))), const char *)) || __builtin_types_compatible_p(__typeof__((request)), char [])) || (((__builtin_types_compatible_p(__typeof__(((request))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((request))), signed char *) || __builtin_types_compatible_p(__typeof__(((request))), const signed char *)) || __builtin_types_compatible_p(__typeof__((request)), signed char [])) || (((__builtin_types_compatible_p(__typeof__(((request))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((request))), unsigned char *) || __builtin_types_compatible_p(__typeof__(((request))), const unsigned char *)) || __builtin_types_compatible_p(__typeof__((request)), unsigned char [])))) _curl_easy_setopt_err_string(); if(((_curl_opt) == CURLOPT_HEADERFUNCTION || (_curl_opt) == CURLOPT_WRITEFUNCTION)) if(!(((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(request), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback6*))) || __builtin_types_compatible_p(__typeof__(request), __typeof__(fwrite)) || __builtin_types_compatible_p(__typeof__(request), curl_write_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_write_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_write_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_write_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_write_callback2*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_write_callback3) || __builtin_types_compatible_p(__typeof__((request)), _curl_write_callback3*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_write_callback4) || __builtin_types_compatible_p(__typeof__((request)), _curl_write_callback4*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_write_callback5) || __builtin_types_compatible_p(__typeof__((request)), _curl_write_callback5*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_write_callback6) || __builtin_types_compatible_p(__typeof__((request)), _curl_write_callback6*)))) _curl_easy_setopt_err_write_callback(); if((_curl_opt) == CURLOPT_READFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(request), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback6*)))) _curl_easy_setopt_err_read_cb(); if((_curl_opt) == CURLOPT_IOCTLFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), curl_ioctl_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ioctl_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_ioctl_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ioctl_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_ioctl_callback2*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ioctl_callback3) || __builtin_types_compatible_p(__typeof__((request)), _curl_ioctl_callback3*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ioctl_callback4) || __builtin_types_compatible_p(__typeof__((request)), _curl_ioctl_callback4*)))) _curl_easy_setopt_err_ioctl_cb(); if((_curl_opt) == CURLOPT_SOCKOPTFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), curl_sockopt_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_sockopt_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_sockopt_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_sockopt_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_sockopt_callback2*)))) _curl_easy_setopt_err_sockopt_cb(); if((_curl_opt) == CURLOPT_OPENSOCKETFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), curl_opensocket_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_opensocket_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_opensocket_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_opensocket_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_opensocket_callback2*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_opensocket_callback3) || __builtin_types_compatible_p(__typeof__((request)), _curl_opensocket_callback3*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_opensocket_callback4) || __builtin_types_compatible_p(__typeof__((request)), _curl_opensocket_callback4*)))) _curl_easy_setopt_err_opensocket_cb(); if((_curl_opt) == CURLOPT_PROGRESSFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), curl_progress_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_progress_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_progress_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_progress_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_progress_callback2*)))) _curl_easy_setopt_err_progress_cb(); if((_curl_opt) == CURLOPT_DEBUGFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), curl_debug_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback2*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback3) || __builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback3*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback4) || __builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback4*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback5) || __builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback5*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback6) || __builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback6*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback7) || __builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback7*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback8) || __builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback8*)))) _curl_easy_setopt_err_debug_cb(); if((_curl_opt) == CURLOPT_SSL_CTX_FUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), curl_ssl_ctx_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback2*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback3) || __builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback3*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback4) || __builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback4*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback5) || __builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback5*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback6) || __builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback6*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback7) || __builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback7*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback8) || __builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback8*)))) _curl_easy_setopt_err_ssl_ctx_cb(); if(((_curl_opt) == CURLOPT_CONV_TO_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_UTF8_FUNCTION)) if(!((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), curl_conv_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_conv_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_conv_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_conv_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_conv_callback2*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_conv_callback3) || __builtin_types_compatible_p(__typeof__((request)), _curl_conv_callback3*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_conv_callback4) || __builtin_types_compatible_p(__typeof__((request)), _curl_conv_callback4*)))) _curl_easy_setopt_err_conv_cb(); if((_curl_opt) == CURLOPT_SEEKFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), curl_seek_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_seek_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_seek_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_seek_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_seek_callback2*)))) _curl_easy_setopt_err_seek_cb(); if(((_curl_opt) == CURLOPT_FILE || (_curl_opt) == CURLOPT_INFILE || (_curl_opt) == CURLOPT_IOCTLDATA || (_curl_opt) == CURLOPT_SOCKOPTDATA || (_curl_opt) == CURLOPT_OPENSOCKETDATA || (_curl_opt) == CURLOPT_PROGRESSDATA || (_curl_opt) == CURLOPT_WRITEHEADER || (_curl_opt) == CURLOPT_DEBUGDATA || (_curl_opt) == CURLOPT_SSL_CTX_DATA || (_curl_opt) == CURLOPT_SEEKDATA || (_curl_opt) == CURLOPT_PRIVATE || (_curl_opt) == CURLOPT_SSH_KEYDATA || (_curl_opt) == CURLOPT_INTERLEAVEDATA || (_curl_opt) == CURLOPT_CHUNK_DATA || (_curl_opt) == CURLOPT_FNMATCH_DATA || 0)) if(!(sizeof(request) == sizeof(void*))) _curl_easy_setopt_err_cb_data(); if((_curl_opt) == CURLOPT_ERRORBUFFER) if(!((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), char *) || __builtin_types_compatible_p(__typeof__(request), char[]))) _curl_easy_setopt_err_error_buffer(); if((_curl_opt) == CURLOPT_STDERR) if(!(__builtin_types_compatible_p(__typeof__(request), FILE *))) _curl_easy_setopt_err_FILE(); if(((_curl_opt) == CURLOPT_POSTFIELDS || (_curl_opt) == CURLOPT_COPYPOSTFIELDS || 0)) if(!(((__builtin_types_compatible_p(__typeof__((request)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((request)), void *) || __builtin_types_compatible_p(__typeof__((request)), const void *)) || (((__builtin_types_compatible_p(__typeof__(((request))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((request))), char *) || __builtin_types_compatible_p(__typeof__(((request))), const char *)) || __builtin_types_compatible_p(__typeof__((request)), char [])))) _curl_easy_setopt_err_postfields(); if((_curl_opt) == CURLOPT_HTTPPOST) if(!(((__builtin_types_compatible_p(__typeof__(((request))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((request))), struct curl_httppost *) || __builtin_types_compatible_p(__typeof__(((request))), const struct curl_httppost *)) || __builtin_types_compatible_p(__typeof__((request)), struct curl_httppost []))) _curl_easy_setopt_err_curl_httpost(); if(((_curl_opt) == CURLOPT_HTTPHEADER || (_curl_opt) == CURLOPT_HTTP200ALIASES || (_curl_opt) == CURLOPT_QUOTE || (_curl_opt) == CURLOPT_POSTQUOTE || (_curl_opt) == CURLOPT_PREQUOTE || (_curl_opt) == CURLOPT_TELNETOPTIONS || (_curl_opt) == CURLOPT_MAIL_RCPT || 0)) if(!(((__builtin_types_compatible_p(__typeof__(((request))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((request))), struct curl_slist *) || __builtin_types_compatible_p(__typeof__(((request))), const struct curl_slist *)) || __builtin_types_compatible_p(__typeof__((request)), struct curl_slist []))) _curl_easy_setopt_err_curl_slist(); if((_curl_opt) == CURLOPT_SHARE) if(!((__builtin_types_compatible_p(__typeof__((request)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((request)), CURLSH *) || __builtin_types_compatible_p(__typeof__((request)), const CURLSH *))) _curl_easy_setopt_err_CURLSH(); } curl_easy_setopt(request->curl, _curl_opt, request); })) != CURLE_OK) { return S3StatusFailedToInitializeRequest; };


    if ((status = __extension__ ({ __typeof__ (CURLOPT_WRITEFUNCTION) _curl_opt = CURLOPT_WRITEFUNCTION; if(__builtin_constant_p(_curl_opt)) { if((0 < (_curl_opt) && (_curl_opt) < 10000)) if(!(__builtin_types_compatible_p(__typeof__(&curl_write_func), long) || __builtin_types_compatible_p(__typeof__(&curl_write_func), signed long) || __builtin_types_compatible_p(__typeof__(&curl_write_func), unsigned long) || __builtin_types_compatible_p(__typeof__(&curl_write_func), int) || __builtin_types_compatible_p(__typeof__(&curl_write_func), signed int) || __builtin_types_compatible_p(__typeof__(&curl_write_func), unsigned int) || __builtin_types_compatible_p(__typeof__(&curl_write_func), short) || __builtin_types_compatible_p(__typeof__(&curl_write_func), signed short) || __builtin_types_compatible_p(__typeof__(&curl_write_func), unsigned short) || __builtin_types_compatible_p(__typeof__(&curl_write_func), char) || __builtin_types_compatible_p(__typeof__(&curl_write_func), signed char) || __builtin_types_compatible_p(__typeof__(&curl_write_func), unsigned char))) _curl_easy_setopt_err_long(); if(((_curl_opt) > 30000)) if(!(__builtin_types_compatible_p(__typeof__(&curl_write_func), curl_off_t))) _curl_easy_setopt_err_curl_off_t(); if(((_curl_opt) == CURLOPT_URL || (_curl_opt) == CURLOPT_PROXY || (_curl_opt) == CURLOPT_INTERFACE || (_curl_opt) == CURLOPT_NETRC_FILE || (_curl_opt) == CURLOPT_USERPWD || (_curl_opt) == CURLOPT_USERNAME || (_curl_opt) == CURLOPT_PASSWORD || (_curl_opt) == CURLOPT_PROXYUSERPWD || (_curl_opt) == CURLOPT_PROXYUSERNAME || (_curl_opt) == CURLOPT_PROXYPASSWORD || (_curl_opt) == CURLOPT_NOPROXY || (_curl_opt) == CURLOPT_ACCEPT_ENCODING || (_curl_opt) == CURLOPT_REFERER || (_curl_opt) == CURLOPT_USERAGENT || (_curl_opt) == CURLOPT_COOKIE || (_curl_opt) == CURLOPT_COOKIEFILE || (_curl_opt) == CURLOPT_COOKIEJAR || (_curl_opt) == CURLOPT_COOKIELIST || (_curl_opt) == CURLOPT_FTPPORT || (_curl_opt) == CURLOPT_FTP_ALTERNATIVE_TO_USER || (_curl_opt) == CURLOPT_FTP_ACCOUNT || (_curl_opt) == CURLOPT_RANGE || (_curl_opt) == CURLOPT_CUSTOMREQUEST || (_curl_opt) == CURLOPT_SSLCERT || (_curl_opt) == CURLOPT_SSLCERTTYPE || (_curl_opt) == CURLOPT_SSLKEY || (_curl_opt) == CURLOPT_SSLKEYTYPE || (_curl_opt) == CURLOPT_KEYPASSWD || (_curl_opt) == CURLOPT_SSLENGINE || (_curl_opt) == CURLOPT_CAINFO || (_curl_opt) == CURLOPT_CAPATH || (_curl_opt) == CURLOPT_RANDOM_FILE || (_curl_opt) == CURLOPT_EGDSOCKET || (_curl_opt) == CURLOPT_SSL_CIPHER_LIST || (_curl_opt) == CURLOPT_KRBLEVEL || (_curl_opt) == CURLOPT_SSH_HOST_PUBLIC_KEY_MD5 || (_curl_opt) == CURLOPT_SSH_PUBLIC_KEYFILE || (_curl_opt) == CURLOPT_SSH_PRIVATE_KEYFILE || (_curl_opt) == CURLOPT_CRLFILE || (_curl_opt) == CURLOPT_ISSUERCERT || (_curl_opt) == CURLOPT_SOCKS5_GSSAPI_SERVICE || (_curl_opt) == CURLOPT_SSH_KNOWNHOSTS || (_curl_opt) == CURLOPT_MAIL_FROM || (_curl_opt) == CURLOPT_RTSP_SESSION_ID || (_curl_opt) == CURLOPT_RTSP_STREAM_URI || (_curl_opt) == CURLOPT_RTSP_TRANSPORT || 0)) if(!((((__builtin_types_compatible_p(__typeof__(((&curl_write_func))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&curl_write_func))), char *) || __builtin_types_compatible_p(__typeof__(((&curl_write_func))), const char *)) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), char [])) || (((__builtin_types_compatible_p(__typeof__(((&curl_write_func))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&curl_write_func))), signed char *) || __builtin_types_compatible_p(__typeof__(((&curl_write_func))), const signed char *)) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), signed char [])) || (((__builtin_types_compatible_p(__typeof__(((&curl_write_func))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&curl_write_func))), unsigned char *) || __builtin_types_compatible_p(__typeof__(((&curl_write_func))), const unsigned char *)) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), unsigned char [])))) _curl_easy_setopt_err_string(); if(((_curl_opt) == CURLOPT_HEADERFUNCTION || (_curl_opt) == CURLOPT_WRITEFUNCTION)) if(!(((__builtin_types_compatible_p(__typeof__(&curl_write_func), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&curl_write_func), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(&curl_write_func), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_read_callback6*))) || __builtin_types_compatible_p(__typeof__(&curl_write_func), __typeof__(fwrite)) || __builtin_types_compatible_p(__typeof__(&curl_write_func), curl_write_callback) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_write_callback1) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_write_callback1*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_write_callback2) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_write_callback2*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_write_callback3) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_write_callback3*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_write_callback4) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_write_callback4*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_write_callback5) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_write_callback5*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_write_callback6) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_write_callback6*)))) _curl_easy_setopt_err_write_callback(); if((_curl_opt) == CURLOPT_READFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(&curl_write_func), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&curl_write_func), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(&curl_write_func), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_read_callback6*)))) _curl_easy_setopt_err_read_cb(); if((_curl_opt) == CURLOPT_IOCTLFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(&curl_write_func), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&curl_write_func), curl_ioctl_callback) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_ioctl_callback1) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_ioctl_callback1*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_ioctl_callback2) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_ioctl_callback2*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_ioctl_callback3) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_ioctl_callback3*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_ioctl_callback4) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_ioctl_callback4*)))) _curl_easy_setopt_err_ioctl_cb(); if((_curl_opt) == CURLOPT_SOCKOPTFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(&curl_write_func), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&curl_write_func), curl_sockopt_callback) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_sockopt_callback1) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_sockopt_callback1*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_sockopt_callback2) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_sockopt_callback2*)))) _curl_easy_setopt_err_sockopt_cb(); if((_curl_opt) == CURLOPT_OPENSOCKETFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(&curl_write_func), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&curl_write_func), curl_opensocket_callback) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_opensocket_callback1) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_opensocket_callback1*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_opensocket_callback2) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_opensocket_callback2*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_opensocket_callback3) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_opensocket_callback3*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_opensocket_callback4) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_opensocket_callback4*)))) _curl_easy_setopt_err_opensocket_cb(); if((_curl_opt) == CURLOPT_PROGRESSFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(&curl_write_func), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&curl_write_func), curl_progress_callback) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_progress_callback1) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_progress_callback1*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_progress_callback2) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_progress_callback2*)))) _curl_easy_setopt_err_progress_cb(); if((_curl_opt) == CURLOPT_DEBUGFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(&curl_write_func), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&curl_write_func), curl_debug_callback) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_debug_callback1) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_debug_callback1*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_debug_callback2) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_debug_callback2*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_debug_callback3) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_debug_callback3*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_debug_callback4) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_debug_callback4*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_debug_callback5) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_debug_callback5*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_debug_callback6) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_debug_callback6*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_debug_callback7) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_debug_callback7*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_debug_callback8) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_debug_callback8*)))) _curl_easy_setopt_err_debug_cb(); if((_curl_opt) == CURLOPT_SSL_CTX_FUNCTION) if(!((__builtin_types_compatible_p(__typeof__(&curl_write_func), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&curl_write_func), curl_ssl_ctx_callback) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_ssl_ctx_callback1) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_ssl_ctx_callback1*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_ssl_ctx_callback2) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_ssl_ctx_callback2*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_ssl_ctx_callback3) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_ssl_ctx_callback3*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_ssl_ctx_callback4) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_ssl_ctx_callback4*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_ssl_ctx_callback5) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_ssl_ctx_callback5*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_ssl_ctx_callback6) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_ssl_ctx_callback6*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_ssl_ctx_callback7) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_ssl_ctx_callback7*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_ssl_ctx_callback8) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_ssl_ctx_callback8*)))) _curl_easy_setopt_err_ssl_ctx_cb(); if(((_curl_opt) == CURLOPT_CONV_TO_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_UTF8_FUNCTION)) if(!((__builtin_types_compatible_p(__typeof__(&curl_write_func), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&curl_write_func), curl_conv_callback) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_conv_callback1) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_conv_callback1*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_conv_callback2) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_conv_callback2*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_conv_callback3) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_conv_callback3*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_conv_callback4) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_conv_callback4*)))) _curl_easy_setopt_err_conv_cb(); if((_curl_opt) == CURLOPT_SEEKFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(&curl_write_func), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&curl_write_func), curl_seek_callback) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_seek_callback1) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_seek_callback1*)) || (__builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_seek_callback2) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), _curl_seek_callback2*)))) _curl_easy_setopt_err_seek_cb(); if(((_curl_opt) == CURLOPT_FILE || (_curl_opt) == CURLOPT_INFILE || (_curl_opt) == CURLOPT_IOCTLDATA || (_curl_opt) == CURLOPT_SOCKOPTDATA || (_curl_opt) == CURLOPT_OPENSOCKETDATA || (_curl_opt) == CURLOPT_PROGRESSDATA || (_curl_opt) == CURLOPT_WRITEHEADER || (_curl_opt) == CURLOPT_DEBUGDATA || (_curl_opt) == CURLOPT_SSL_CTX_DATA || (_curl_opt) == CURLOPT_SEEKDATA || (_curl_opt) == CURLOPT_PRIVATE || (_curl_opt) == CURLOPT_SSH_KEYDATA || (_curl_opt) == CURLOPT_INTERLEAVEDATA || (_curl_opt) == CURLOPT_CHUNK_DATA || (_curl_opt) == CURLOPT_FNMATCH_DATA || 0)) if(!(sizeof(&curl_write_func) == sizeof(void*))) _curl_easy_setopt_err_cb_data(); if((_curl_opt) == CURLOPT_ERRORBUFFER) if(!((__builtin_types_compatible_p(__typeof__(&curl_write_func), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&curl_write_func), char *) || __builtin_types_compatible_p(__typeof__(&curl_write_func), char[]))) _curl_easy_setopt_err_error_buffer(); if((_curl_opt) == CURLOPT_STDERR) if(!(__builtin_types_compatible_p(__typeof__(&curl_write_func), FILE *))) _curl_easy_setopt_err_FILE(); if(((_curl_opt) == CURLOPT_POSTFIELDS || (_curl_opt) == CURLOPT_COPYPOSTFIELDS || 0)) if(!(((__builtin_types_compatible_p(__typeof__((&curl_write_func)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), void *) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), const void *)) || (((__builtin_types_compatible_p(__typeof__(((&curl_write_func))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&curl_write_func))), char *) || __builtin_types_compatible_p(__typeof__(((&curl_write_func))), const char *)) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), char [])))) _curl_easy_setopt_err_postfields(); if((_curl_opt) == CURLOPT_HTTPPOST) if(!(((__builtin_types_compatible_p(__typeof__(((&curl_write_func))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&curl_write_func))), struct curl_httppost *) || __builtin_types_compatible_p(__typeof__(((&curl_write_func))), const struct curl_httppost *)) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), struct curl_httppost []))) _curl_easy_setopt_err_curl_httpost(); if(((_curl_opt) == CURLOPT_HTTPHEADER || (_curl_opt) == CURLOPT_HTTP200ALIASES || (_curl_opt) == CURLOPT_QUOTE || (_curl_opt) == CURLOPT_POSTQUOTE || (_curl_opt) == CURLOPT_PREQUOTE || (_curl_opt) == CURLOPT_TELNETOPTIONS || (_curl_opt) == CURLOPT_MAIL_RCPT || 0)) if(!(((__builtin_types_compatible_p(__typeof__(((&curl_write_func))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&curl_write_func))), struct curl_slist *) || __builtin_types_compatible_p(__typeof__(((&curl_write_func))), const struct curl_slist *)) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), struct curl_slist []))) _curl_easy_setopt_err_curl_slist(); if((_curl_opt) == CURLOPT_SHARE) if(!((__builtin_types_compatible_p(__typeof__((&curl_write_func)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), CURLSH *) || __builtin_types_compatible_p(__typeof__((&curl_write_func)), const CURLSH *))) _curl_easy_setopt_err_CURLSH(); } curl_easy_setopt(request->curl, _curl_opt, &curl_write_func); })) != CURLE_OK) { return S3StatusFailedToInitializeRequest; };
    if ((status = __extension__ ({ __typeof__ (CURLOPT_FILE) _curl_opt = CURLOPT_FILE; if(__builtin_constant_p(_curl_opt)) { if((0 < (_curl_opt) && (_curl_opt) < 10000)) if(!(__builtin_types_compatible_p(__typeof__(request), long) || __builtin_types_compatible_p(__typeof__(request), signed long) || __builtin_types_compatible_p(__typeof__(request), unsigned long) || __builtin_types_compatible_p(__typeof__(request), int) || __builtin_types_compatible_p(__typeof__(request), signed int) || __builtin_types_compatible_p(__typeof__(request), unsigned int) || __builtin_types_compatible_p(__typeof__(request), short) || __builtin_types_compatible_p(__typeof__(request), signed short) || __builtin_types_compatible_p(__typeof__(request), unsigned short) || __builtin_types_compatible_p(__typeof__(request), char) || __builtin_types_compatible_p(__typeof__(request), signed char) || __builtin_types_compatible_p(__typeof__(request), unsigned char))) _curl_easy_setopt_err_long(); if(((_curl_opt) > 30000)) if(!(__builtin_types_compatible_p(__typeof__(request), curl_off_t))) _curl_easy_setopt_err_curl_off_t(); if(((_curl_opt) == CURLOPT_URL || (_curl_opt) == CURLOPT_PROXY || (_curl_opt) == CURLOPT_INTERFACE || (_curl_opt) == CURLOPT_NETRC_FILE || (_curl_opt) == CURLOPT_USERPWD || (_curl_opt) == CURLOPT_USERNAME || (_curl_opt) == CURLOPT_PASSWORD || (_curl_opt) == CURLOPT_PROXYUSERPWD || (_curl_opt) == CURLOPT_PROXYUSERNAME || (_curl_opt) == CURLOPT_PROXYPASSWORD || (_curl_opt) == CURLOPT_NOPROXY || (_curl_opt) == CURLOPT_ACCEPT_ENCODING || (_curl_opt) == CURLOPT_REFERER || (_curl_opt) == CURLOPT_USERAGENT || (_curl_opt) == CURLOPT_COOKIE || (_curl_opt) == CURLOPT_COOKIEFILE || (_curl_opt) == CURLOPT_COOKIEJAR || (_curl_opt) == CURLOPT_COOKIELIST || (_curl_opt) == CURLOPT_FTPPORT || (_curl_opt) == CURLOPT_FTP_ALTERNATIVE_TO_USER || (_curl_opt) == CURLOPT_FTP_ACCOUNT || (_curl_opt) == CURLOPT_RANGE || (_curl_opt) == CURLOPT_CUSTOMREQUEST || (_curl_opt) == CURLOPT_SSLCERT || (_curl_opt) == CURLOPT_SSLCERTTYPE || (_curl_opt) == CURLOPT_SSLKEY || (_curl_opt) == CURLOPT_SSLKEYTYPE || (_curl_opt) == CURLOPT_KEYPASSWD || (_curl_opt) == CURLOPT_SSLENGINE || (_curl_opt) == CURLOPT_CAINFO || (_curl_opt) == CURLOPT_CAPATH || (_curl_opt) == CURLOPT_RANDOM_FILE || (_curl_opt) == CURLOPT_EGDSOCKET || (_curl_opt) == CURLOPT_SSL_CIPHER_LIST || (_curl_opt) == CURLOPT_KRBLEVEL || (_curl_opt) == CURLOPT_SSH_HOST_PUBLIC_KEY_MD5 || (_curl_opt) == CURLOPT_SSH_PUBLIC_KEYFILE || (_curl_opt) == CURLOPT_SSH_PRIVATE_KEYFILE || (_curl_opt) == CURLOPT_CRLFILE || (_curl_opt) == CURLOPT_ISSUERCERT || (_curl_opt) == CURLOPT_SOCKS5_GSSAPI_SERVICE || (_curl_opt) == CURLOPT_SSH_KNOWNHOSTS || (_curl_opt) == CURLOPT_MAIL_FROM || (_curl_opt) == CURLOPT_RTSP_SESSION_ID || (_curl_opt) == CURLOPT_RTSP_STREAM_URI || (_curl_opt) == CURLOPT_RTSP_TRANSPORT || 0)) if(!((((__builtin_types_compatible_p(__typeof__(((request))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((request))), char *) || __builtin_types_compatible_p(__typeof__(((request))), const char *)) || __builtin_types_compatible_p(__typeof__((request)), char [])) || (((__builtin_types_compatible_p(__typeof__(((request))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((request))), signed char *) || __builtin_types_compatible_p(__typeof__(((request))), const signed char *)) || __builtin_types_compatible_p(__typeof__((request)), signed char [])) || (((__builtin_types_compatible_p(__typeof__(((request))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((request))), unsigned char *) || __builtin_types_compatible_p(__typeof__(((request))), const unsigned char *)) || __builtin_types_compatible_p(__typeof__((request)), unsigned char [])))) _curl_easy_setopt_err_string(); if(((_curl_opt) == CURLOPT_HEADERFUNCTION || (_curl_opt) == CURLOPT_WRITEFUNCTION)) if(!(((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(request), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback6*))) || __builtin_types_compatible_p(__typeof__(request), __typeof__(fwrite)) || __builtin_types_compatible_p(__typeof__(request), curl_write_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_write_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_write_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_write_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_write_callback2*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_write_callback3) || __builtin_types_compatible_p(__typeof__((request)), _curl_write_callback3*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_write_callback4) || __builtin_types_compatible_p(__typeof__((request)), _curl_write_callback4*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_write_callback5) || __builtin_types_compatible_p(__typeof__((request)), _curl_write_callback5*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_write_callback6) || __builtin_types_compatible_p(__typeof__((request)), _curl_write_callback6*)))) _curl_easy_setopt_err_write_callback(); if((_curl_opt) == CURLOPT_READFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(request), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((request)), _curl_read_callback6*)))) _curl_easy_setopt_err_read_cb(); if((_curl_opt) == CURLOPT_IOCTLFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), curl_ioctl_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ioctl_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_ioctl_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ioctl_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_ioctl_callback2*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ioctl_callback3) || __builtin_types_compatible_p(__typeof__((request)), _curl_ioctl_callback3*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ioctl_callback4) || __builtin_types_compatible_p(__typeof__((request)), _curl_ioctl_callback4*)))) _curl_easy_setopt_err_ioctl_cb(); if((_curl_opt) == CURLOPT_SOCKOPTFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), curl_sockopt_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_sockopt_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_sockopt_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_sockopt_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_sockopt_callback2*)))) _curl_easy_setopt_err_sockopt_cb(); if((_curl_opt) == CURLOPT_OPENSOCKETFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), curl_opensocket_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_opensocket_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_opensocket_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_opensocket_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_opensocket_callback2*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_opensocket_callback3) || __builtin_types_compatible_p(__typeof__((request)), _curl_opensocket_callback3*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_opensocket_callback4) || __builtin_types_compatible_p(__typeof__((request)), _curl_opensocket_callback4*)))) _curl_easy_setopt_err_opensocket_cb(); if((_curl_opt) == CURLOPT_PROGRESSFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), curl_progress_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_progress_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_progress_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_progress_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_progress_callback2*)))) _curl_easy_setopt_err_progress_cb(); if((_curl_opt) == CURLOPT_DEBUGFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), curl_debug_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback2*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback3) || __builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback3*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback4) || __builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback4*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback5) || __builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback5*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback6) || __builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback6*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback7) || __builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback7*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback8) || __builtin_types_compatible_p(__typeof__((request)), _curl_debug_callback8*)))) _curl_easy_setopt_err_debug_cb(); if((_curl_opt) == CURLOPT_SSL_CTX_FUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), curl_ssl_ctx_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback2*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback3) || __builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback3*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback4) || __builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback4*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback5) || __builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback5*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback6) || __builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback6*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback7) || __builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback7*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback8) || __builtin_types_compatible_p(__typeof__((request)), _curl_ssl_ctx_callback8*)))) _curl_easy_setopt_err_ssl_ctx_cb(); if(((_curl_opt) == CURLOPT_CONV_TO_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_UTF8_FUNCTION)) if(!((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), curl_conv_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_conv_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_conv_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_conv_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_conv_callback2*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_conv_callback3) || __builtin_types_compatible_p(__typeof__((request)), _curl_conv_callback3*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_conv_callback4) || __builtin_types_compatible_p(__typeof__((request)), _curl_conv_callback4*)))) _curl_easy_setopt_err_conv_cb(); if((_curl_opt) == CURLOPT_SEEKFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), curl_seek_callback) || (__builtin_types_compatible_p(__typeof__((request)), _curl_seek_callback1) || __builtin_types_compatible_p(__typeof__((request)), _curl_seek_callback1*)) || (__builtin_types_compatible_p(__typeof__((request)), _curl_seek_callback2) || __builtin_types_compatible_p(__typeof__((request)), _curl_seek_callback2*)))) _curl_easy_setopt_err_seek_cb(); if(((_curl_opt) == CURLOPT_FILE || (_curl_opt) == CURLOPT_INFILE || (_curl_opt) == CURLOPT_IOCTLDATA || (_curl_opt) == CURLOPT_SOCKOPTDATA || (_curl_opt) == CURLOPT_OPENSOCKETDATA || (_curl_opt) == CURLOPT_PROGRESSDATA || (_curl_opt) == CURLOPT_WRITEHEADER || (_curl_opt) == CURLOPT_DEBUGDATA || (_curl_opt) == CURLOPT_SSL_CTX_DATA || (_curl_opt) == CURLOPT_SEEKDATA || (_curl_opt) == CURLOPT_PRIVATE || (_curl_opt) == CURLOPT_SSH_KEYDATA || (_curl_opt) == CURLOPT_INTERLEAVEDATA || (_curl_opt) == CURLOPT_CHUNK_DATA || (_curl_opt) == CURLOPT_FNMATCH_DATA || 0)) if(!(sizeof(request) == sizeof(void*))) _curl_easy_setopt_err_cb_data(); if((_curl_opt) == CURLOPT_ERRORBUFFER) if(!((__builtin_types_compatible_p(__typeof__(request), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request), char *) || __builtin_types_compatible_p(__typeof__(request), char[]))) _curl_easy_setopt_err_error_buffer(); if((_curl_opt) == CURLOPT_STDERR) if(!(__builtin_types_compatible_p(__typeof__(request), FILE *))) _curl_easy_setopt_err_FILE(); if(((_curl_opt) == CURLOPT_POSTFIELDS || (_curl_opt) == CURLOPT_COPYPOSTFIELDS || 0)) if(!(((__builtin_types_compatible_p(__typeof__((request)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((request)), void *) || __builtin_types_compatible_p(__typeof__((request)), const void *)) || (((__builtin_types_compatible_p(__typeof__(((request))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((request))), char *) || __builtin_types_compatible_p(__typeof__(((request))), const char *)) || __builtin_types_compatible_p(__typeof__((request)), char [])))) _curl_easy_setopt_err_postfields(); if((_curl_opt) == CURLOPT_HTTPPOST) if(!(((__builtin_types_compatible_p(__typeof__(((request))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((request))), struct curl_httppost *) || __builtin_types_compatible_p(__typeof__(((request))), const struct curl_httppost *)) || __builtin_types_compatible_p(__typeof__((request)), struct curl_httppost []))) _curl_easy_setopt_err_curl_httpost(); if(((_curl_opt) == CURLOPT_HTTPHEADER || (_curl_opt) == CURLOPT_HTTP200ALIASES || (_curl_opt) == CURLOPT_QUOTE || (_curl_opt) == CURLOPT_POSTQUOTE || (_curl_opt) == CURLOPT_PREQUOTE || (_curl_opt) == CURLOPT_TELNETOPTIONS || (_curl_opt) == CURLOPT_MAIL_RCPT || 0)) if(!(((__builtin_types_compatible_p(__typeof__(((request))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((request))), struct curl_slist *) || __builtin_types_compatible_p(__typeof__(((request))), const struct curl_slist *)) || __builtin_types_compatible_p(__typeof__((request)), struct curl_slist []))) _curl_easy_setopt_err_curl_slist(); if((_curl_opt) == CURLOPT_SHARE) if(!((__builtin_types_compatible_p(__typeof__((request)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((request)), CURLSH *) || __builtin_types_compatible_p(__typeof__((request)), const CURLSH *))) _curl_easy_setopt_err_CURLSH(); } curl_easy_setopt(request->curl, _curl_opt, request); })) != CURLE_OK) { return S3StatusFailedToInitializeRequest; };



    if ((status = __extension__ ({ __typeof__ (CURLOPT_FILETIME) _curl_opt = CURLOPT_FILETIME; if(__builtin_constant_p(_curl_opt)) { if((0 < (_curl_opt) && (_curl_opt) < 10000)) if(!(__builtin_types_compatible_p(__typeof__(1), long) || __builtin_types_compatible_p(__typeof__(1), signed long) || __builtin_types_compatible_p(__typeof__(1), unsigned long) || __builtin_types_compatible_p(__typeof__(1), int) || __builtin_types_compatible_p(__typeof__(1), signed int) || __builtin_types_compatible_p(__typeof__(1), unsigned int) || __builtin_types_compatible_p(__typeof__(1), short) || __builtin_types_compatible_p(__typeof__(1), signed short) || __builtin_types_compatible_p(__typeof__(1), unsigned short) || __builtin_types_compatible_p(__typeof__(1), char) || __builtin_types_compatible_p(__typeof__(1), signed char) || __builtin_types_compatible_p(__typeof__(1), unsigned char))) _curl_easy_setopt_err_long(); if(((_curl_opt) > 30000)) if(!(__builtin_types_compatible_p(__typeof__(1), curl_off_t))) _curl_easy_setopt_err_curl_off_t(); if(((_curl_opt) == CURLOPT_URL || (_curl_opt) == CURLOPT_PROXY || (_curl_opt) == CURLOPT_INTERFACE || (_curl_opt) == CURLOPT_NETRC_FILE || (_curl_opt) == CURLOPT_USERPWD || (_curl_opt) == CURLOPT_USERNAME || (_curl_opt) == CURLOPT_PASSWORD || (_curl_opt) == CURLOPT_PROXYUSERPWD || (_curl_opt) == CURLOPT_PROXYUSERNAME || (_curl_opt) == CURLOPT_PROXYPASSWORD || (_curl_opt) == CURLOPT_NOPROXY || (_curl_opt) == CURLOPT_ACCEPT_ENCODING || (_curl_opt) == CURLOPT_REFERER || (_curl_opt) == CURLOPT_USERAGENT || (_curl_opt) == CURLOPT_COOKIE || (_curl_opt) == CURLOPT_COOKIEFILE || (_curl_opt) == CURLOPT_COOKIEJAR || (_curl_opt) == CURLOPT_COOKIELIST || (_curl_opt) == CURLOPT_FTPPORT || (_curl_opt) == CURLOPT_FTP_ALTERNATIVE_TO_USER || (_curl_opt) == CURLOPT_FTP_ACCOUNT || (_curl_opt) == CURLOPT_RANGE || (_curl_opt) == CURLOPT_CUSTOMREQUEST || (_curl_opt) == CURLOPT_SSLCERT || (_curl_opt) == CURLOPT_SSLCERTTYPE || (_curl_opt) == CURLOPT_SSLKEY || (_curl_opt) == CURLOPT_SSLKEYTYPE || (_curl_opt) == CURLOPT_KEYPASSWD || (_curl_opt) == CURLOPT_SSLENGINE || (_curl_opt) == CURLOPT_CAINFO || (_curl_opt) == CURLOPT_CAPATH || (_curl_opt) == CURLOPT_RANDOM_FILE || (_curl_opt) == CURLOPT_EGDSOCKET || (_curl_opt) == CURLOPT_SSL_CIPHER_LIST || (_curl_opt) == CURLOPT_KRBLEVEL || (_curl_opt) == CURLOPT_SSH_HOST_PUBLIC_KEY_MD5 || (_curl_opt) == CURLOPT_SSH_PUBLIC_KEYFILE || (_curl_opt) == CURLOPT_SSH_PRIVATE_KEYFILE || (_curl_opt) == CURLOPT_CRLFILE || (_curl_opt) == CURLOPT_ISSUERCERT || (_curl_opt) == CURLOPT_SOCKS5_GSSAPI_SERVICE || (_curl_opt) == CURLOPT_SSH_KNOWNHOSTS || (_curl_opt) == CURLOPT_MAIL_FROM || (_curl_opt) == CURLOPT_RTSP_SESSION_ID || (_curl_opt) == CURLOPT_RTSP_STREAM_URI || (_curl_opt) == CURLOPT_RTSP_TRANSPORT || 0)) if(!((((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), char *) || __builtin_types_compatible_p(__typeof__(((1))), const char *)) || __builtin_types_compatible_p(__typeof__((1)), char [])) || (((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), signed char *) || __builtin_types_compatible_p(__typeof__(((1))), const signed char *)) || __builtin_types_compatible_p(__typeof__((1)), signed char [])) || (((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), unsigned char *) || __builtin_types_compatible_p(__typeof__(((1))), const unsigned char *)) || __builtin_types_compatible_p(__typeof__((1)), unsigned char [])))) _curl_easy_setopt_err_string(); if(((_curl_opt) == CURLOPT_HEADERFUNCTION || (_curl_opt) == CURLOPT_WRITEFUNCTION)) if(!(((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(1), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback6*))) || __builtin_types_compatible_p(__typeof__(1), __typeof__(fwrite)) || __builtin_types_compatible_p(__typeof__(1), curl_write_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback4*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback5) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback5*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback6) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback6*)))) _curl_easy_setopt_err_write_callback(); if((_curl_opt) == CURLOPT_READFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(1), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback6*)))) _curl_easy_setopt_err_read_cb(); if((_curl_opt) == CURLOPT_IOCTLFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_ioctl_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback4*)))) _curl_easy_setopt_err_ioctl_cb(); if((_curl_opt) == CURLOPT_SOCKOPTFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_sockopt_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_sockopt_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_sockopt_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_sockopt_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_sockopt_callback2*)))) _curl_easy_setopt_err_sockopt_cb(); if((_curl_opt) == CURLOPT_OPENSOCKETFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_opensocket_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback4*)))) _curl_easy_setopt_err_opensocket_cb(); if((_curl_opt) == CURLOPT_PROGRESSFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_progress_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_progress_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_progress_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_progress_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_progress_callback2*)))) _curl_easy_setopt_err_progress_cb(); if((_curl_opt) == CURLOPT_DEBUGFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_debug_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback4*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback5) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback5*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback6) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback6*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback7) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback7*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback8) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback8*)))) _curl_easy_setopt_err_debug_cb(); if((_curl_opt) == CURLOPT_SSL_CTX_FUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_ssl_ctx_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback4*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback5) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback5*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback6) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback6*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback7) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback7*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback8) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback8*)))) _curl_easy_setopt_err_ssl_ctx_cb(); if(((_curl_opt) == CURLOPT_CONV_TO_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_UTF8_FUNCTION)) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_conv_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback4*)))) _curl_easy_setopt_err_conv_cb(); if((_curl_opt) == CURLOPT_SEEKFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_seek_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_seek_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_seek_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_seek_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_seek_callback2*)))) _curl_easy_setopt_err_seek_cb(); if(((_curl_opt) == CURLOPT_FILE || (_curl_opt) == CURLOPT_INFILE || (_curl_opt) == CURLOPT_IOCTLDATA || (_curl_opt) == CURLOPT_SOCKOPTDATA || (_curl_opt) == CURLOPT_OPENSOCKETDATA || (_curl_opt) == CURLOPT_PROGRESSDATA || (_curl_opt) == CURLOPT_WRITEHEADER || (_curl_opt) == CURLOPT_DEBUGDATA || (_curl_opt) == CURLOPT_SSL_CTX_DATA || (_curl_opt) == CURLOPT_SEEKDATA || (_curl_opt) == CURLOPT_PRIVATE || (_curl_opt) == CURLOPT_SSH_KEYDATA || (_curl_opt) == CURLOPT_INTERLEAVEDATA || (_curl_opt) == CURLOPT_CHUNK_DATA || (_curl_opt) == CURLOPT_FNMATCH_DATA || 0)) if(!(sizeof(1) == sizeof(void*))) _curl_easy_setopt_err_cb_data(); if((_curl_opt) == CURLOPT_ERRORBUFFER) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), char *) || __builtin_types_compatible_p(__typeof__(1), char[]))) _curl_easy_setopt_err_error_buffer(); if((_curl_opt) == CURLOPT_STDERR) if(!(__builtin_types_compatible_p(__typeof__(1), FILE *))) _curl_easy_setopt_err_FILE(); if(((_curl_opt) == CURLOPT_POSTFIELDS || (_curl_opt) == CURLOPT_COPYPOSTFIELDS || 0)) if(!(((__builtin_types_compatible_p(__typeof__((1)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((1)), void *) || __builtin_types_compatible_p(__typeof__((1)), const void *)) || (((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), char *) || __builtin_types_compatible_p(__typeof__(((1))), const char *)) || __builtin_types_compatible_p(__typeof__((1)), char [])))) _curl_easy_setopt_err_postfields(); if((_curl_opt) == CURLOPT_HTTPPOST) if(!(((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), struct curl_httppost *) || __builtin_types_compatible_p(__typeof__(((1))), const struct curl_httppost *)) || __builtin_types_compatible_p(__typeof__((1)), struct curl_httppost []))) _curl_easy_setopt_err_curl_httpost(); if(((_curl_opt) == CURLOPT_HTTPHEADER || (_curl_opt) == CURLOPT_HTTP200ALIASES || (_curl_opt) == CURLOPT_QUOTE || (_curl_opt) == CURLOPT_POSTQUOTE || (_curl_opt) == CURLOPT_PREQUOTE || (_curl_opt) == CURLOPT_TELNETOPTIONS || (_curl_opt) == CURLOPT_MAIL_RCPT || 0)) if(!(((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), struct curl_slist *) || __builtin_types_compatible_p(__typeof__(((1))), const struct curl_slist *)) || __builtin_types_compatible_p(__typeof__((1)), struct curl_slist []))) _curl_easy_setopt_err_curl_slist(); if((_curl_opt) == CURLOPT_SHARE) if(!((__builtin_types_compatible_p(__typeof__((1)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((1)), CURLSH *) || __builtin_types_compatible_p(__typeof__((1)), const CURLSH *))) _curl_easy_setopt_err_CURLSH(); } curl_easy_setopt(request->curl, _curl_opt, 1); })) != CURLE_OK) { return S3StatusFailedToInitializeRequest; };





    if ((status = __extension__ ({ __typeof__ (CURLOPT_NOSIGNAL) _curl_opt = CURLOPT_NOSIGNAL; if(__builtin_constant_p(_curl_opt)) { if((0 < (_curl_opt) && (_curl_opt) < 10000)) if(!(__builtin_types_compatible_p(__typeof__(1), long) || __builtin_types_compatible_p(__typeof__(1), signed long) || __builtin_types_compatible_p(__typeof__(1), unsigned long) || __builtin_types_compatible_p(__typeof__(1), int) || __builtin_types_compatible_p(__typeof__(1), signed int) || __builtin_types_compatible_p(__typeof__(1), unsigned int) || __builtin_types_compatible_p(__typeof__(1), short) || __builtin_types_compatible_p(__typeof__(1), signed short) || __builtin_types_compatible_p(__typeof__(1), unsigned short) || __builtin_types_compatible_p(__typeof__(1), char) || __builtin_types_compatible_p(__typeof__(1), signed char) || __builtin_types_compatible_p(__typeof__(1), unsigned char))) _curl_easy_setopt_err_long(); if(((_curl_opt) > 30000)) if(!(__builtin_types_compatible_p(__typeof__(1), curl_off_t))) _curl_easy_setopt_err_curl_off_t(); if(((_curl_opt) == CURLOPT_URL || (_curl_opt) == CURLOPT_PROXY || (_curl_opt) == CURLOPT_INTERFACE || (_curl_opt) == CURLOPT_NETRC_FILE || (_curl_opt) == CURLOPT_USERPWD || (_curl_opt) == CURLOPT_USERNAME || (_curl_opt) == CURLOPT_PASSWORD || (_curl_opt) == CURLOPT_PROXYUSERPWD || (_curl_opt) == CURLOPT_PROXYUSERNAME || (_curl_opt) == CURLOPT_PROXYPASSWORD || (_curl_opt) == CURLOPT_NOPROXY || (_curl_opt) == CURLOPT_ACCEPT_ENCODING || (_curl_opt) == CURLOPT_REFERER || (_curl_opt) == CURLOPT_USERAGENT || (_curl_opt) == CURLOPT_COOKIE || (_curl_opt) == CURLOPT_COOKIEFILE || (_curl_opt) == CURLOPT_COOKIEJAR || (_curl_opt) == CURLOPT_COOKIELIST || (_curl_opt) == CURLOPT_FTPPORT || (_curl_opt) == CURLOPT_FTP_ALTERNATIVE_TO_USER || (_curl_opt) == CURLOPT_FTP_ACCOUNT || (_curl_opt) == CURLOPT_RANGE || (_curl_opt) == CURLOPT_CUSTOMREQUEST || (_curl_opt) == CURLOPT_SSLCERT || (_curl_opt) == CURLOPT_SSLCERTTYPE || (_curl_opt) == CURLOPT_SSLKEY || (_curl_opt) == CURLOPT_SSLKEYTYPE || (_curl_opt) == CURLOPT_KEYPASSWD || (_curl_opt) == CURLOPT_SSLENGINE || (_curl_opt) == CURLOPT_CAINFO || (_curl_opt) == CURLOPT_CAPATH || (_curl_opt) == CURLOPT_RANDOM_FILE || (_curl_opt) == CURLOPT_EGDSOCKET || (_curl_opt) == CURLOPT_SSL_CIPHER_LIST || (_curl_opt) == CURLOPT_KRBLEVEL || (_curl_opt) == CURLOPT_SSH_HOST_PUBLIC_KEY_MD5 || (_curl_opt) == CURLOPT_SSH_PUBLIC_KEYFILE || (_curl_opt) == CURLOPT_SSH_PRIVATE_KEYFILE || (_curl_opt) == CURLOPT_CRLFILE || (_curl_opt) == CURLOPT_ISSUERCERT || (_curl_opt) == CURLOPT_SOCKS5_GSSAPI_SERVICE || (_curl_opt) == CURLOPT_SSH_KNOWNHOSTS || (_curl_opt) == CURLOPT_MAIL_FROM || (_curl_opt) == CURLOPT_RTSP_SESSION_ID || (_curl_opt) == CURLOPT_RTSP_STREAM_URI || (_curl_opt) == CURLOPT_RTSP_TRANSPORT || 0)) if(!((((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), char *) || __builtin_types_compatible_p(__typeof__(((1))), const char *)) || __builtin_types_compatible_p(__typeof__((1)), char [])) || (((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), signed char *) || __builtin_types_compatible_p(__typeof__(((1))), const signed char *)) || __builtin_types_compatible_p(__typeof__((1)), signed char [])) || (((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), unsigned char *) || __builtin_types_compatible_p(__typeof__(((1))), const unsigned char *)) || __builtin_types_compatible_p(__typeof__((1)), unsigned char [])))) _curl_easy_setopt_err_string(); if(((_curl_opt) == CURLOPT_HEADERFUNCTION || (_curl_opt) == CURLOPT_WRITEFUNCTION)) if(!(((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(1), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback6*))) || __builtin_types_compatible_p(__typeof__(1), __typeof__(fwrite)) || __builtin_types_compatible_p(__typeof__(1), curl_write_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback4*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback5) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback5*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback6) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback6*)))) _curl_easy_setopt_err_write_callback(); if((_curl_opt) == CURLOPT_READFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(1), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback6*)))) _curl_easy_setopt_err_read_cb(); if((_curl_opt) == CURLOPT_IOCTLFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_ioctl_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback4*)))) _curl_easy_setopt_err_ioctl_cb(); if((_curl_opt) == CURLOPT_SOCKOPTFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_sockopt_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_sockopt_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_sockopt_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_sockopt_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_sockopt_callback2*)))) _curl_easy_setopt_err_sockopt_cb(); if((_curl_opt) == CURLOPT_OPENSOCKETFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_opensocket_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback4*)))) _curl_easy_setopt_err_opensocket_cb(); if((_curl_opt) == CURLOPT_PROGRESSFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_progress_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_progress_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_progress_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_progress_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_progress_callback2*)))) _curl_easy_setopt_err_progress_cb(); if((_curl_opt) == CURLOPT_DEBUGFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_debug_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback4*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback5) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback5*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback6) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback6*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback7) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback7*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback8) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback8*)))) _curl_easy_setopt_err_debug_cb(); if((_curl_opt) == CURLOPT_SSL_CTX_FUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_ssl_ctx_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback4*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback5) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback5*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback6) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback6*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback7) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback7*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback8) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback8*)))) _curl_easy_setopt_err_ssl_ctx_cb(); if(((_curl_opt) == CURLOPT_CONV_TO_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_UTF8_FUNCTION)) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_conv_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback4*)))) _curl_easy_setopt_err_conv_cb(); if((_curl_opt) == CURLOPT_SEEKFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_seek_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_seek_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_seek_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_seek_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_seek_callback2*)))) _curl_easy_setopt_err_seek_cb(); if(((_curl_opt) == CURLOPT_FILE || (_curl_opt) == CURLOPT_INFILE || (_curl_opt) == CURLOPT_IOCTLDATA || (_curl_opt) == CURLOPT_SOCKOPTDATA || (_curl_opt) == CURLOPT_OPENSOCKETDATA || (_curl_opt) == CURLOPT_PROGRESSDATA || (_curl_opt) == CURLOPT_WRITEHEADER || (_curl_opt) == CURLOPT_DEBUGDATA || (_curl_opt) == CURLOPT_SSL_CTX_DATA || (_curl_opt) == CURLOPT_SEEKDATA || (_curl_opt) == CURLOPT_PRIVATE || (_curl_opt) == CURLOPT_SSH_KEYDATA || (_curl_opt) == CURLOPT_INTERLEAVEDATA || (_curl_opt) == CURLOPT_CHUNK_DATA || (_curl_opt) == CURLOPT_FNMATCH_DATA || 0)) if(!(sizeof(1) == sizeof(void*))) _curl_easy_setopt_err_cb_data(); if((_curl_opt) == CURLOPT_ERRORBUFFER) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), char *) || __builtin_types_compatible_p(__typeof__(1), char[]))) _curl_easy_setopt_err_error_buffer(); if((_curl_opt) == CURLOPT_STDERR) if(!(__builtin_types_compatible_p(__typeof__(1), FILE *))) _curl_easy_setopt_err_FILE(); if(((_curl_opt) == CURLOPT_POSTFIELDS || (_curl_opt) == CURLOPT_COPYPOSTFIELDS || 0)) if(!(((__builtin_types_compatible_p(__typeof__((1)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((1)), void *) || __builtin_types_compatible_p(__typeof__((1)), const void *)) || (((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), char *) || __builtin_types_compatible_p(__typeof__(((1))), const char *)) || __builtin_types_compatible_p(__typeof__((1)), char [])))) _curl_easy_setopt_err_postfields(); if((_curl_opt) == CURLOPT_HTTPPOST) if(!(((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), struct curl_httppost *) || __builtin_types_compatible_p(__typeof__(((1))), const struct curl_httppost *)) || __builtin_types_compatible_p(__typeof__((1)), struct curl_httppost []))) _curl_easy_setopt_err_curl_httpost(); if(((_curl_opt) == CURLOPT_HTTPHEADER || (_curl_opt) == CURLOPT_HTTP200ALIASES || (_curl_opt) == CURLOPT_QUOTE || (_curl_opt) == CURLOPT_POSTQUOTE || (_curl_opt) == CURLOPT_PREQUOTE || (_curl_opt) == CURLOPT_TELNETOPTIONS || (_curl_opt) == CURLOPT_MAIL_RCPT || 0)) if(!(((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), struct curl_slist *) || __builtin_types_compatible_p(__typeof__(((1))), const struct curl_slist *)) || __builtin_types_compatible_p(__typeof__((1)), struct curl_slist []))) _curl_easy_setopt_err_curl_slist(); if((_curl_opt) == CURLOPT_SHARE) if(!((__builtin_types_compatible_p(__typeof__((1)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((1)), CURLSH *) || __builtin_types_compatible_p(__typeof__((1)), const CURLSH *))) _curl_easy_setopt_err_CURLSH(); } curl_easy_setopt(request->curl, _curl_opt, 1); })) != CURLE_OK) { return S3StatusFailedToInitializeRequest; };


    if ((status = __extension__ ({ __typeof__ (CURLOPT_NOPROGRESS) _curl_opt = CURLOPT_NOPROGRESS; if(__builtin_constant_p(_curl_opt)) { if((0 < (_curl_opt) && (_curl_opt) < 10000)) if(!(__builtin_types_compatible_p(__typeof__(1), long) || __builtin_types_compatible_p(__typeof__(1), signed long) || __builtin_types_compatible_p(__typeof__(1), unsigned long) || __builtin_types_compatible_p(__typeof__(1), int) || __builtin_types_compatible_p(__typeof__(1), signed int) || __builtin_types_compatible_p(__typeof__(1), unsigned int) || __builtin_types_compatible_p(__typeof__(1), short) || __builtin_types_compatible_p(__typeof__(1), signed short) || __builtin_types_compatible_p(__typeof__(1), unsigned short) || __builtin_types_compatible_p(__typeof__(1), char) || __builtin_types_compatible_p(__typeof__(1), signed char) || __builtin_types_compatible_p(__typeof__(1), unsigned char))) _curl_easy_setopt_err_long(); if(((_curl_opt) > 30000)) if(!(__builtin_types_compatible_p(__typeof__(1), curl_off_t))) _curl_easy_setopt_err_curl_off_t(); if(((_curl_opt) == CURLOPT_URL || (_curl_opt) == CURLOPT_PROXY || (_curl_opt) == CURLOPT_INTERFACE || (_curl_opt) == CURLOPT_NETRC_FILE || (_curl_opt) == CURLOPT_USERPWD || (_curl_opt) == CURLOPT_USERNAME || (_curl_opt) == CURLOPT_PASSWORD || (_curl_opt) == CURLOPT_PROXYUSERPWD || (_curl_opt) == CURLOPT_PROXYUSERNAME || (_curl_opt) == CURLOPT_PROXYPASSWORD || (_curl_opt) == CURLOPT_NOPROXY || (_curl_opt) == CURLOPT_ACCEPT_ENCODING || (_curl_opt) == CURLOPT_REFERER || (_curl_opt) == CURLOPT_USERAGENT || (_curl_opt) == CURLOPT_COOKIE || (_curl_opt) == CURLOPT_COOKIEFILE || (_curl_opt) == CURLOPT_COOKIEJAR || (_curl_opt) == CURLOPT_COOKIELIST || (_curl_opt) == CURLOPT_FTPPORT || (_curl_opt) == CURLOPT_FTP_ALTERNATIVE_TO_USER || (_curl_opt) == CURLOPT_FTP_ACCOUNT || (_curl_opt) == CURLOPT_RANGE || (_curl_opt) == CURLOPT_CUSTOMREQUEST || (_curl_opt) == CURLOPT_SSLCERT || (_curl_opt) == CURLOPT_SSLCERTTYPE || (_curl_opt) == CURLOPT_SSLKEY || (_curl_opt) == CURLOPT_SSLKEYTYPE || (_curl_opt) == CURLOPT_KEYPASSWD || (_curl_opt) == CURLOPT_SSLENGINE || (_curl_opt) == CURLOPT_CAINFO || (_curl_opt) == CURLOPT_CAPATH || (_curl_opt) == CURLOPT_RANDOM_FILE || (_curl_opt) == CURLOPT_EGDSOCKET || (_curl_opt) == CURLOPT_SSL_CIPHER_LIST || (_curl_opt) == CURLOPT_KRBLEVEL || (_curl_opt) == CURLOPT_SSH_HOST_PUBLIC_KEY_MD5 || (_curl_opt) == CURLOPT_SSH_PUBLIC_KEYFILE || (_curl_opt) == CURLOPT_SSH_PRIVATE_KEYFILE || (_curl_opt) == CURLOPT_CRLFILE || (_curl_opt) == CURLOPT_ISSUERCERT || (_curl_opt) == CURLOPT_SOCKS5_GSSAPI_SERVICE || (_curl_opt) == CURLOPT_SSH_KNOWNHOSTS || (_curl_opt) == CURLOPT_MAIL_FROM || (_curl_opt) == CURLOPT_RTSP_SESSION_ID || (_curl_opt) == CURLOPT_RTSP_STREAM_URI || (_curl_opt) == CURLOPT_RTSP_TRANSPORT || 0)) if(!((((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), char *) || __builtin_types_compatible_p(__typeof__(((1))), const char *)) || __builtin_types_compatible_p(__typeof__((1)), char [])) || (((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), signed char *) || __builtin_types_compatible_p(__typeof__(((1))), const signed char *)) || __builtin_types_compatible_p(__typeof__((1)), signed char [])) || (((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), unsigned char *) || __builtin_types_compatible_p(__typeof__(((1))), const unsigned char *)) || __builtin_types_compatible_p(__typeof__((1)), unsigned char [])))) _curl_easy_setopt_err_string(); if(((_curl_opt) == CURLOPT_HEADERFUNCTION || (_curl_opt) == CURLOPT_WRITEFUNCTION)) if(!(((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(1), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback6*))) || __builtin_types_compatible_p(__typeof__(1), __typeof__(fwrite)) || __builtin_types_compatible_p(__typeof__(1), curl_write_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback4*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback5) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback5*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback6) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback6*)))) _curl_easy_setopt_err_write_callback(); if((_curl_opt) == CURLOPT_READFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(1), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback6*)))) _curl_easy_setopt_err_read_cb(); if((_curl_opt) == CURLOPT_IOCTLFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_ioctl_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback4*)))) _curl_easy_setopt_err_ioctl_cb(); if((_curl_opt) == CURLOPT_SOCKOPTFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_sockopt_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_sockopt_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_sockopt_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_sockopt_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_sockopt_callback2*)))) _curl_easy_setopt_err_sockopt_cb(); if((_curl_opt) == CURLOPT_OPENSOCKETFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_opensocket_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback4*)))) _curl_easy_setopt_err_opensocket_cb(); if((_curl_opt) == CURLOPT_PROGRESSFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_progress_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_progress_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_progress_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_progress_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_progress_callback2*)))) _curl_easy_setopt_err_progress_cb(); if((_curl_opt) == CURLOPT_DEBUGFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_debug_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback4*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback5) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback5*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback6) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback6*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback7) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback7*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback8) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback8*)))) _curl_easy_setopt_err_debug_cb(); if((_curl_opt) == CURLOPT_SSL_CTX_FUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_ssl_ctx_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback4*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback5) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback5*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback6) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback6*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback7) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback7*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback8) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback8*)))) _curl_easy_setopt_err_ssl_ctx_cb(); if(((_curl_opt) == CURLOPT_CONV_TO_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_UTF8_FUNCTION)) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_conv_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback4*)))) _curl_easy_setopt_err_conv_cb(); if((_curl_opt) == CURLOPT_SEEKFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_seek_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_seek_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_seek_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_seek_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_seek_callback2*)))) _curl_easy_setopt_err_seek_cb(); if(((_curl_opt) == CURLOPT_FILE || (_curl_opt) == CURLOPT_INFILE || (_curl_opt) == CURLOPT_IOCTLDATA || (_curl_opt) == CURLOPT_SOCKOPTDATA || (_curl_opt) == CURLOPT_OPENSOCKETDATA || (_curl_opt) == CURLOPT_PROGRESSDATA || (_curl_opt) == CURLOPT_WRITEHEADER || (_curl_opt) == CURLOPT_DEBUGDATA || (_curl_opt) == CURLOPT_SSL_CTX_DATA || (_curl_opt) == CURLOPT_SEEKDATA || (_curl_opt) == CURLOPT_PRIVATE || (_curl_opt) == CURLOPT_SSH_KEYDATA || (_curl_opt) == CURLOPT_INTERLEAVEDATA || (_curl_opt) == CURLOPT_CHUNK_DATA || (_curl_opt) == CURLOPT_FNMATCH_DATA || 0)) if(!(sizeof(1) == sizeof(void*))) _curl_easy_setopt_err_cb_data(); if((_curl_opt) == CURLOPT_ERRORBUFFER) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), char *) || __builtin_types_compatible_p(__typeof__(1), char[]))) _curl_easy_setopt_err_error_buffer(); if((_curl_opt) == CURLOPT_STDERR) if(!(__builtin_types_compatible_p(__typeof__(1), FILE *))) _curl_easy_setopt_err_FILE(); if(((_curl_opt) == CURLOPT_POSTFIELDS || (_curl_opt) == CURLOPT_COPYPOSTFIELDS || 0)) if(!(((__builtin_types_compatible_p(__typeof__((1)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((1)), void *) || __builtin_types_compatible_p(__typeof__((1)), const void *)) || (((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), char *) || __builtin_types_compatible_p(__typeof__(((1))), const char *)) || __builtin_types_compatible_p(__typeof__((1)), char [])))) _curl_easy_setopt_err_postfields(); if((_curl_opt) == CURLOPT_HTTPPOST) if(!(((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), struct curl_httppost *) || __builtin_types_compatible_p(__typeof__(((1))), const struct curl_httppost *)) || __builtin_types_compatible_p(__typeof__((1)), struct curl_httppost []))) _curl_easy_setopt_err_curl_httpost(); if(((_curl_opt) == CURLOPT_HTTPHEADER || (_curl_opt) == CURLOPT_HTTP200ALIASES || (_curl_opt) == CURLOPT_QUOTE || (_curl_opt) == CURLOPT_POSTQUOTE || (_curl_opt) == CURLOPT_PREQUOTE || (_curl_opt) == CURLOPT_TELNETOPTIONS || (_curl_opt) == CURLOPT_MAIL_RCPT || 0)) if(!(((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), struct curl_slist *) || __builtin_types_compatible_p(__typeof__(((1))), const struct curl_slist *)) || __builtin_types_compatible_p(__typeof__((1)), struct curl_slist []))) _curl_easy_setopt_err_curl_slist(); if((_curl_opt) == CURLOPT_SHARE) if(!((__builtin_types_compatible_p(__typeof__((1)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((1)), CURLSH *) || __builtin_types_compatible_p(__typeof__((1)), const CURLSH *))) _curl_easy_setopt_err_CURLSH(); } curl_easy_setopt(request->curl, _curl_opt, 1); })) != CURLE_OK) { return S3StatusFailedToInitializeRequest; };
# 847 "./src/request.c"
    if ((status = __extension__ ({ __typeof__ (CURLOPT_TCP_NODELAY) _curl_opt = CURLOPT_TCP_NODELAY; if(__builtin_constant_p(_curl_opt)) { if((0 < (_curl_opt) && (_curl_opt) < 10000)) if(!(__builtin_types_compatible_p(__typeof__(1), long) || __builtin_types_compatible_p(__typeof__(1), signed long) || __builtin_types_compatible_p(__typeof__(1), unsigned long) || __builtin_types_compatible_p(__typeof__(1), int) || __builtin_types_compatible_p(__typeof__(1), signed int) || __builtin_types_compatible_p(__typeof__(1), unsigned int) || __builtin_types_compatible_p(__typeof__(1), short) || __builtin_types_compatible_p(__typeof__(1), signed short) || __builtin_types_compatible_p(__typeof__(1), unsigned short) || __builtin_types_compatible_p(__typeof__(1), char) || __builtin_types_compatible_p(__typeof__(1), signed char) || __builtin_types_compatible_p(__typeof__(1), unsigned char))) _curl_easy_setopt_err_long(); if(((_curl_opt) > 30000)) if(!(__builtin_types_compatible_p(__typeof__(1), curl_off_t))) _curl_easy_setopt_err_curl_off_t(); if(((_curl_opt) == CURLOPT_URL || (_curl_opt) == CURLOPT_PROXY || (_curl_opt) == CURLOPT_INTERFACE || (_curl_opt) == CURLOPT_NETRC_FILE || (_curl_opt) == CURLOPT_USERPWD || (_curl_opt) == CURLOPT_USERNAME || (_curl_opt) == CURLOPT_PASSWORD || (_curl_opt) == CURLOPT_PROXYUSERPWD || (_curl_opt) == CURLOPT_PROXYUSERNAME || (_curl_opt) == CURLOPT_PROXYPASSWORD || (_curl_opt) == CURLOPT_NOPROXY || (_curl_opt) == CURLOPT_ACCEPT_ENCODING || (_curl_opt) == CURLOPT_REFERER || (_curl_opt) == CURLOPT_USERAGENT || (_curl_opt) == CURLOPT_COOKIE || (_curl_opt) == CURLOPT_COOKIEFILE || (_curl_opt) == CURLOPT_COOKIEJAR || (_curl_opt) == CURLOPT_COOKIELIST || (_curl_opt) == CURLOPT_FTPPORT || (_curl_opt) == CURLOPT_FTP_ALTERNATIVE_TO_USER || (_curl_opt) == CURLOPT_FTP_ACCOUNT || (_curl_opt) == CURLOPT_RANGE || (_curl_opt) == CURLOPT_CUSTOMREQUEST || (_curl_opt) == CURLOPT_SSLCERT || (_curl_opt) == CURLOPT_SSLCERTTYPE || (_curl_opt) == CURLOPT_SSLKEY || (_curl_opt) == CURLOPT_SSLKEYTYPE || (_curl_opt) == CURLOPT_KEYPASSWD || (_curl_opt) == CURLOPT_SSLENGINE || (_curl_opt) == CURLOPT_CAINFO || (_curl_opt) == CURLOPT_CAPATH || (_curl_opt) == CURLOPT_RANDOM_FILE || (_curl_opt) == CURLOPT_EGDSOCKET || (_curl_opt) == CURLOPT_SSL_CIPHER_LIST || (_curl_opt) == CURLOPT_KRBLEVEL || (_curl_opt) == CURLOPT_SSH_HOST_PUBLIC_KEY_MD5 || (_curl_opt) == CURLOPT_SSH_PUBLIC_KEYFILE || (_curl_opt) == CURLOPT_SSH_PRIVATE_KEYFILE || (_curl_opt) == CURLOPT_CRLFILE || (_curl_opt) == CURLOPT_ISSUERCERT || (_curl_opt) == CURLOPT_SOCKS5_GSSAPI_SERVICE || (_curl_opt) == CURLOPT_SSH_KNOWNHOSTS || (_curl_opt) == CURLOPT_MAIL_FROM || (_curl_opt) == CURLOPT_RTSP_SESSION_ID || (_curl_opt) == CURLOPT_RTSP_STREAM_URI || (_curl_opt) == CURLOPT_RTSP_TRANSPORT || 0)) if(!((((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), char *) || __builtin_types_compatible_p(__typeof__(((1))), const char *)) || __builtin_types_compatible_p(__typeof__((1)), char [])) || (((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), signed char *) || __builtin_types_compatible_p(__typeof__(((1))), const signed char *)) || __builtin_types_compatible_p(__typeof__((1)), signed char [])) || (((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), unsigned char *) || __builtin_types_compatible_p(__typeof__(((1))), const unsigned char *)) || __builtin_types_compatible_p(__typeof__((1)), unsigned char [])))) _curl_easy_setopt_err_string(); if(((_curl_opt) == CURLOPT_HEADERFUNCTION || (_curl_opt) == CURLOPT_WRITEFUNCTION)) if(!(((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(1), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback6*))) || __builtin_types_compatible_p(__typeof__(1), __typeof__(fwrite)) || __builtin_types_compatible_p(__typeof__(1), curl_write_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback4*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback5) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback5*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback6) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback6*)))) _curl_easy_setopt_err_write_callback(); if((_curl_opt) == CURLOPT_READFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(1), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback6*)))) _curl_easy_setopt_err_read_cb(); if((_curl_opt) == CURLOPT_IOCTLFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_ioctl_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback4*)))) _curl_easy_setopt_err_ioctl_cb(); if((_curl_opt) == CURLOPT_SOCKOPTFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_sockopt_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_sockopt_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_sockopt_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_sockopt_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_sockopt_callback2*)))) _curl_easy_setopt_err_sockopt_cb(); if((_curl_opt) == CURLOPT_OPENSOCKETFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_opensocket_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback4*)))) _curl_easy_setopt_err_opensocket_cb(); if((_curl_opt) == CURLOPT_PROGRESSFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_progress_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_progress_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_progress_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_progress_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_progress_callback2*)))) _curl_easy_setopt_err_progress_cb(); if((_curl_opt) == CURLOPT_DEBUGFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_debug_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback4*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback5) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback5*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback6) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback6*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback7) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback7*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback8) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback8*)))) _curl_easy_setopt_err_debug_cb(); if((_curl_opt) == CURLOPT_SSL_CTX_FUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_ssl_ctx_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback4*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback5) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback5*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback6) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback6*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback7) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback7*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback8) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback8*)))) _curl_easy_setopt_err_ssl_ctx_cb(); if(((_curl_opt) == CURLOPT_CONV_TO_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_UTF8_FUNCTION)) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_conv_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback4*)))) _curl_easy_setopt_err_conv_cb(); if((_curl_opt) == CURLOPT_SEEKFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_seek_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_seek_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_seek_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_seek_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_seek_callback2*)))) _curl_easy_setopt_err_seek_cb(); if(((_curl_opt) == CURLOPT_FILE || (_curl_opt) == CURLOPT_INFILE || (_curl_opt) == CURLOPT_IOCTLDATA || (_curl_opt) == CURLOPT_SOCKOPTDATA || (_curl_opt) == CURLOPT_OPENSOCKETDATA || (_curl_opt) == CURLOPT_PROGRESSDATA || (_curl_opt) == CURLOPT_WRITEHEADER || (_curl_opt) == CURLOPT_DEBUGDATA || (_curl_opt) == CURLOPT_SSL_CTX_DATA || (_curl_opt) == CURLOPT_SEEKDATA || (_curl_opt) == CURLOPT_PRIVATE || (_curl_opt) == CURLOPT_SSH_KEYDATA || (_curl_opt) == CURLOPT_INTERLEAVEDATA || (_curl_opt) == CURLOPT_CHUNK_DATA || (_curl_opt) == CURLOPT_FNMATCH_DATA || 0)) if(!(sizeof(1) == sizeof(void*))) _curl_easy_setopt_err_cb_data(); if((_curl_opt) == CURLOPT_ERRORBUFFER) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), char *) || __builtin_types_compatible_p(__typeof__(1), char[]))) _curl_easy_setopt_err_error_buffer(); if((_curl_opt) == CURLOPT_STDERR) if(!(__builtin_types_compatible_p(__typeof__(1), FILE *))) _curl_easy_setopt_err_FILE(); if(((_curl_opt) == CURLOPT_POSTFIELDS || (_curl_opt) == CURLOPT_COPYPOSTFIELDS || 0)) if(!(((__builtin_types_compatible_p(__typeof__((1)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((1)), void *) || __builtin_types_compatible_p(__typeof__((1)), const void *)) || (((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), char *) || __builtin_types_compatible_p(__typeof__(((1))), const char *)) || __builtin_types_compatible_p(__typeof__((1)), char [])))) _curl_easy_setopt_err_postfields(); if((_curl_opt) == CURLOPT_HTTPPOST) if(!(((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), struct curl_httppost *) || __builtin_types_compatible_p(__typeof__(((1))), const struct curl_httppost *)) || __builtin_types_compatible_p(__typeof__((1)), struct curl_httppost []))) _curl_easy_setopt_err_curl_httpost(); if(((_curl_opt) == CURLOPT_HTTPHEADER || (_curl_opt) == CURLOPT_HTTP200ALIASES || (_curl_opt) == CURLOPT_QUOTE || (_curl_opt) == CURLOPT_POSTQUOTE || (_curl_opt) == CURLOPT_PREQUOTE || (_curl_opt) == CURLOPT_TELNETOPTIONS || (_curl_opt) == CURLOPT_MAIL_RCPT || 0)) if(!(((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), struct curl_slist *) || __builtin_types_compatible_p(__typeof__(((1))), const struct curl_slist *)) || __builtin_types_compatible_p(__typeof__((1)), struct curl_slist []))) _curl_easy_setopt_err_curl_slist(); if((_curl_opt) == CURLOPT_SHARE) if(!((__builtin_types_compatible_p(__typeof__((1)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((1)), CURLSH *) || __builtin_types_compatible_p(__typeof__((1)), const CURLSH *))) _curl_easy_setopt_err_CURLSH(); } curl_easy_setopt(request->curl, _curl_opt, 1); })) != CURLE_OK) { return S3StatusFailedToInitializeRequest; };


    if ((status = __extension__ ({ __typeof__ (CURLOPT_NETRC) _curl_opt = CURLOPT_NETRC; if(__builtin_constant_p(_curl_opt)) { if((0 < (_curl_opt) && (_curl_opt) < 10000)) if(!(__builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), long) || __builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), signed long) || __builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), unsigned long) || __builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), int) || __builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), signed int) || __builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), unsigned int) || __builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), short) || __builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), signed short) || __builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), unsigned short) || __builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), char) || __builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), signed char) || __builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), unsigned char))) _curl_easy_setopt_err_long(); if(((_curl_opt) > 30000)) if(!(__builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), curl_off_t))) _curl_easy_setopt_err_curl_off_t(); if(((_curl_opt) == CURLOPT_URL || (_curl_opt) == CURLOPT_PROXY || (_curl_opt) == CURLOPT_INTERFACE || (_curl_opt) == CURLOPT_NETRC_FILE || (_curl_opt) == CURLOPT_USERPWD || (_curl_opt) == CURLOPT_USERNAME || (_curl_opt) == CURLOPT_PASSWORD || (_curl_opt) == CURLOPT_PROXYUSERPWD || (_curl_opt) == CURLOPT_PROXYUSERNAME || (_curl_opt) == CURLOPT_PROXYPASSWORD || (_curl_opt) == CURLOPT_NOPROXY || (_curl_opt) == CURLOPT_ACCEPT_ENCODING || (_curl_opt) == CURLOPT_REFERER || (_curl_opt) == CURLOPT_USERAGENT || (_curl_opt) == CURLOPT_COOKIE || (_curl_opt) == CURLOPT_COOKIEFILE || (_curl_opt) == CURLOPT_COOKIEJAR || (_curl_opt) == CURLOPT_COOKIELIST || (_curl_opt) == CURLOPT_FTPPORT || (_curl_opt) == CURLOPT_FTP_ALTERNATIVE_TO_USER || (_curl_opt) == CURLOPT_FTP_ACCOUNT || (_curl_opt) == CURLOPT_RANGE || (_curl_opt) == CURLOPT_CUSTOMREQUEST || (_curl_opt) == CURLOPT_SSLCERT || (_curl_opt) == CURLOPT_SSLCERTTYPE || (_curl_opt) == CURLOPT_SSLKEY || (_curl_opt) == CURLOPT_SSLKEYTYPE || (_curl_opt) == CURLOPT_KEYPASSWD || (_curl_opt) == CURLOPT_SSLENGINE || (_curl_opt) == CURLOPT_CAINFO || (_curl_opt) == CURLOPT_CAPATH || (_curl_opt) == CURLOPT_RANDOM_FILE || (_curl_opt) == CURLOPT_EGDSOCKET || (_curl_opt) == CURLOPT_SSL_CIPHER_LIST || (_curl_opt) == CURLOPT_KRBLEVEL || (_curl_opt) == CURLOPT_SSH_HOST_PUBLIC_KEY_MD5 || (_curl_opt) == CURLOPT_SSH_PUBLIC_KEYFILE || (_curl_opt) == CURLOPT_SSH_PRIVATE_KEYFILE || (_curl_opt) == CURLOPT_CRLFILE || (_curl_opt) == CURLOPT_ISSUERCERT || (_curl_opt) == CURLOPT_SOCKS5_GSSAPI_SERVICE || (_curl_opt) == CURLOPT_SSH_KNOWNHOSTS || (_curl_opt) == CURLOPT_MAIL_FROM || (_curl_opt) == CURLOPT_RTSP_SESSION_ID || (_curl_opt) == CURLOPT_RTSP_STREAM_URI || (_curl_opt) == CURLOPT_RTSP_TRANSPORT || 0)) if(!((((__builtin_types_compatible_p(__typeof__(((CURL_NETRC_IGNORED))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((CURL_NETRC_IGNORED))), char *) || __builtin_types_compatible_p(__typeof__(((CURL_NETRC_IGNORED))), const char *)) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), char [])) || (((__builtin_types_compatible_p(__typeof__(((CURL_NETRC_IGNORED))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((CURL_NETRC_IGNORED))), signed char *) || __builtin_types_compatible_p(__typeof__(((CURL_NETRC_IGNORED))), const signed char *)) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), signed char [])) || (((__builtin_types_compatible_p(__typeof__(((CURL_NETRC_IGNORED))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((CURL_NETRC_IGNORED))), unsigned char *) || __builtin_types_compatible_p(__typeof__(((CURL_NETRC_IGNORED))), const unsigned char *)) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), unsigned char [])))) _curl_easy_setopt_err_string(); if(((_curl_opt) == CURLOPT_HEADERFUNCTION || (_curl_opt) == CURLOPT_WRITEFUNCTION)) if(!(((__builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_read_callback6*))) || __builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), __typeof__(fwrite)) || __builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), curl_write_callback) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_write_callback1) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_write_callback1*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_write_callback2) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_write_callback2*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_write_callback3) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_write_callback3*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_write_callback4) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_write_callback4*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_write_callback5) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_write_callback5*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_write_callback6) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_write_callback6*)))) _curl_easy_setopt_err_write_callback(); if((_curl_opt) == CURLOPT_READFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_read_callback6*)))) _curl_easy_setopt_err_read_cb(); if((_curl_opt) == CURLOPT_IOCTLFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), curl_ioctl_callback) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_ioctl_callback1) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_ioctl_callback1*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_ioctl_callback2) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_ioctl_callback2*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_ioctl_callback3) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_ioctl_callback3*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_ioctl_callback4) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_ioctl_callback4*)))) _curl_easy_setopt_err_ioctl_cb(); if((_curl_opt) == CURLOPT_SOCKOPTFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), curl_sockopt_callback) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_sockopt_callback1) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_sockopt_callback1*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_sockopt_callback2) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_sockopt_callback2*)))) _curl_easy_setopt_err_sockopt_cb(); if((_curl_opt) == CURLOPT_OPENSOCKETFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), curl_opensocket_callback) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_opensocket_callback1) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_opensocket_callback1*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_opensocket_callback2) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_opensocket_callback2*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_opensocket_callback3) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_opensocket_callback3*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_opensocket_callback4) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_opensocket_callback4*)))) _curl_easy_setopt_err_opensocket_cb(); if((_curl_opt) == CURLOPT_PROGRESSFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), curl_progress_callback) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_progress_callback1) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_progress_callback1*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_progress_callback2) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_progress_callback2*)))) _curl_easy_setopt_err_progress_cb(); if((_curl_opt) == CURLOPT_DEBUGFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), curl_debug_callback) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_debug_callback1) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_debug_callback1*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_debug_callback2) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_debug_callback2*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_debug_callback3) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_debug_callback3*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_debug_callback4) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_debug_callback4*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_debug_callback5) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_debug_callback5*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_debug_callback6) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_debug_callback6*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_debug_callback7) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_debug_callback7*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_debug_callback8) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_debug_callback8*)))) _curl_easy_setopt_err_debug_cb(); if((_curl_opt) == CURLOPT_SSL_CTX_FUNCTION) if(!((__builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), curl_ssl_ctx_callback) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_ssl_ctx_callback1) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_ssl_ctx_callback1*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_ssl_ctx_callback2) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_ssl_ctx_callback2*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_ssl_ctx_callback3) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_ssl_ctx_callback3*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_ssl_ctx_callback4) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_ssl_ctx_callback4*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_ssl_ctx_callback5) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_ssl_ctx_callback5*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_ssl_ctx_callback6) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_ssl_ctx_callback6*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_ssl_ctx_callback7) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_ssl_ctx_callback7*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_ssl_ctx_callback8) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_ssl_ctx_callback8*)))) _curl_easy_setopt_err_ssl_ctx_cb(); if(((_curl_opt) == CURLOPT_CONV_TO_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_UTF8_FUNCTION)) if(!((__builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), curl_conv_callback) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_conv_callback1) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_conv_callback1*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_conv_callback2) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_conv_callback2*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_conv_callback3) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_conv_callback3*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_conv_callback4) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_conv_callback4*)))) _curl_easy_setopt_err_conv_cb(); if((_curl_opt) == CURLOPT_SEEKFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), curl_seek_callback) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_seek_callback1) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_seek_callback1*)) || (__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_seek_callback2) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), _curl_seek_callback2*)))) _curl_easy_setopt_err_seek_cb(); if(((_curl_opt) == CURLOPT_FILE || (_curl_opt) == CURLOPT_INFILE || (_curl_opt) == CURLOPT_IOCTLDATA || (_curl_opt) == CURLOPT_SOCKOPTDATA || (_curl_opt) == CURLOPT_OPENSOCKETDATA || (_curl_opt) == CURLOPT_PROGRESSDATA || (_curl_opt) == CURLOPT_WRITEHEADER || (_curl_opt) == CURLOPT_DEBUGDATA || (_curl_opt) == CURLOPT_SSL_CTX_DATA || (_curl_opt) == CURLOPT_SEEKDATA || (_curl_opt) == CURLOPT_PRIVATE || (_curl_opt) == CURLOPT_SSH_KEYDATA || (_curl_opt) == CURLOPT_INTERLEAVEDATA || (_curl_opt) == CURLOPT_CHUNK_DATA || (_curl_opt) == CURLOPT_FNMATCH_DATA || 0)) if(!(sizeof(CURL_NETRC_IGNORED) == sizeof(void*))) _curl_easy_setopt_err_cb_data(); if((_curl_opt) == CURLOPT_ERRORBUFFER) if(!((__builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), char *) || __builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), char[]))) _curl_easy_setopt_err_error_buffer(); if((_curl_opt) == CURLOPT_STDERR) if(!(__builtin_types_compatible_p(__typeof__(CURL_NETRC_IGNORED), FILE *))) _curl_easy_setopt_err_FILE(); if(((_curl_opt) == CURLOPT_POSTFIELDS || (_curl_opt) == CURLOPT_COPYPOSTFIELDS || 0)) if(!(((__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), void *) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), const void *)) || (((__builtin_types_compatible_p(__typeof__(((CURL_NETRC_IGNORED))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((CURL_NETRC_IGNORED))), char *) || __builtin_types_compatible_p(__typeof__(((CURL_NETRC_IGNORED))), const char *)) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), char [])))) _curl_easy_setopt_err_postfields(); if((_curl_opt) == CURLOPT_HTTPPOST) if(!(((__builtin_types_compatible_p(__typeof__(((CURL_NETRC_IGNORED))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((CURL_NETRC_IGNORED))), struct curl_httppost *) || __builtin_types_compatible_p(__typeof__(((CURL_NETRC_IGNORED))), const struct curl_httppost *)) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), struct curl_httppost []))) _curl_easy_setopt_err_curl_httpost(); if(((_curl_opt) == CURLOPT_HTTPHEADER || (_curl_opt) == CURLOPT_HTTP200ALIASES || (_curl_opt) == CURLOPT_QUOTE || (_curl_opt) == CURLOPT_POSTQUOTE || (_curl_opt) == CURLOPT_PREQUOTE || (_curl_opt) == CURLOPT_TELNETOPTIONS || (_curl_opt) == CURLOPT_MAIL_RCPT || 0)) if(!(((__builtin_types_compatible_p(__typeof__(((CURL_NETRC_IGNORED))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((CURL_NETRC_IGNORED))), struct curl_slist *) || __builtin_types_compatible_p(__typeof__(((CURL_NETRC_IGNORED))), const struct curl_slist *)) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), struct curl_slist []))) _curl_easy_setopt_err_curl_slist(); if((_curl_opt) == CURLOPT_SHARE) if(!((__builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), CURLSH *) || __builtin_types_compatible_p(__typeof__((CURL_NETRC_IGNORED)), const CURLSH *))) _curl_easy_setopt_err_CURLSH(); } curl_easy_setopt(request->curl, _curl_opt, CURL_NETRC_IGNORED); })) != CURLE_OK) { return S3StatusFailedToInitializeRequest; };




    if ((status = __extension__ ({ __typeof__ (CURLOPT_SSL_VERIFYPEER) _curl_opt = CURLOPT_SSL_VERIFYPEER; if(__builtin_constant_p(_curl_opt)) { if((0 < (_curl_opt) && (_curl_opt) < 10000)) if(!(__builtin_types_compatible_p(__typeof__(0), long) || __builtin_types_compatible_p(__typeof__(0), signed long) || __builtin_types_compatible_p(__typeof__(0), unsigned long) || __builtin_types_compatible_p(__typeof__(0), int) || __builtin_types_compatible_p(__typeof__(0), signed int) || __builtin_types_compatible_p(__typeof__(0), unsigned int) || __builtin_types_compatible_p(__typeof__(0), short) || __builtin_types_compatible_p(__typeof__(0), signed short) || __builtin_types_compatible_p(__typeof__(0), unsigned short) || __builtin_types_compatible_p(__typeof__(0), char) || __builtin_types_compatible_p(__typeof__(0), signed char) || __builtin_types_compatible_p(__typeof__(0), unsigned char))) _curl_easy_setopt_err_long(); if(((_curl_opt) > 30000)) if(!(__builtin_types_compatible_p(__typeof__(0), curl_off_t))) _curl_easy_setopt_err_curl_off_t(); if(((_curl_opt) == CURLOPT_URL || (_curl_opt) == CURLOPT_PROXY || (_curl_opt) == CURLOPT_INTERFACE || (_curl_opt) == CURLOPT_NETRC_FILE || (_curl_opt) == CURLOPT_USERPWD || (_curl_opt) == CURLOPT_USERNAME || (_curl_opt) == CURLOPT_PASSWORD || (_curl_opt) == CURLOPT_PROXYUSERPWD || (_curl_opt) == CURLOPT_PROXYUSERNAME || (_curl_opt) == CURLOPT_PROXYPASSWORD || (_curl_opt) == CURLOPT_NOPROXY || (_curl_opt) == CURLOPT_ACCEPT_ENCODING || (_curl_opt) == CURLOPT_REFERER || (_curl_opt) == CURLOPT_USERAGENT || (_curl_opt) == CURLOPT_COOKIE || (_curl_opt) == CURLOPT_COOKIEFILE || (_curl_opt) == CURLOPT_COOKIEJAR || (_curl_opt) == CURLOPT_COOKIELIST || (_curl_opt) == CURLOPT_FTPPORT || (_curl_opt) == CURLOPT_FTP_ALTERNATIVE_TO_USER || (_curl_opt) == CURLOPT_FTP_ACCOUNT || (_curl_opt) == CURLOPT_RANGE || (_curl_opt) == CURLOPT_CUSTOMREQUEST || (_curl_opt) == CURLOPT_SSLCERT || (_curl_opt) == CURLOPT_SSLCERTTYPE || (_curl_opt) == CURLOPT_SSLKEY || (_curl_opt) == CURLOPT_SSLKEYTYPE || (_curl_opt) == CURLOPT_KEYPASSWD || (_curl_opt) == CURLOPT_SSLENGINE || (_curl_opt) == CURLOPT_CAINFO || (_curl_opt) == CURLOPT_CAPATH || (_curl_opt) == CURLOPT_RANDOM_FILE || (_curl_opt) == CURLOPT_EGDSOCKET || (_curl_opt) == CURLOPT_SSL_CIPHER_LIST || (_curl_opt) == CURLOPT_KRBLEVEL || (_curl_opt) == CURLOPT_SSH_HOST_PUBLIC_KEY_MD5 || (_curl_opt) == CURLOPT_SSH_PUBLIC_KEYFILE || (_curl_opt) == CURLOPT_SSH_PRIVATE_KEYFILE || (_curl_opt) == CURLOPT_CRLFILE || (_curl_opt) == CURLOPT_ISSUERCERT || (_curl_opt) == CURLOPT_SOCKS5_GSSAPI_SERVICE || (_curl_opt) == CURLOPT_SSH_KNOWNHOSTS || (_curl_opt) == CURLOPT_MAIL_FROM || (_curl_opt) == CURLOPT_RTSP_SESSION_ID || (_curl_opt) == CURLOPT_RTSP_STREAM_URI || (_curl_opt) == CURLOPT_RTSP_TRANSPORT || 0)) if(!((((__builtin_types_compatible_p(__typeof__(((0))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((0))), char *) || __builtin_types_compatible_p(__typeof__(((0))), const char *)) || __builtin_types_compatible_p(__typeof__((0)), char [])) || (((__builtin_types_compatible_p(__typeof__(((0))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((0))), signed char *) || __builtin_types_compatible_p(__typeof__(((0))), const signed char *)) || __builtin_types_compatible_p(__typeof__((0)), signed char [])) || (((__builtin_types_compatible_p(__typeof__(((0))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((0))), unsigned char *) || __builtin_types_compatible_p(__typeof__(((0))), const unsigned char *)) || __builtin_types_compatible_p(__typeof__((0)), unsigned char [])))) _curl_easy_setopt_err_string(); if(((_curl_opt) == CURLOPT_HEADERFUNCTION || (_curl_opt) == CURLOPT_WRITEFUNCTION)) if(!(((__builtin_types_compatible_p(__typeof__(0), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(0), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(0), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((0)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((0)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((0)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((0)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((0)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((0)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((0)), _curl_read_callback6*))) || __builtin_types_compatible_p(__typeof__(0), __typeof__(fwrite)) || __builtin_types_compatible_p(__typeof__(0), curl_write_callback) || (__builtin_types_compatible_p(__typeof__((0)), _curl_write_callback1) || __builtin_types_compatible_p(__typeof__((0)), _curl_write_callback1*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_write_callback2) || __builtin_types_compatible_p(__typeof__((0)), _curl_write_callback2*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_write_callback3) || __builtin_types_compatible_p(__typeof__((0)), _curl_write_callback3*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_write_callback4) || __builtin_types_compatible_p(__typeof__((0)), _curl_write_callback4*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_write_callback5) || __builtin_types_compatible_p(__typeof__((0)), _curl_write_callback5*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_write_callback6) || __builtin_types_compatible_p(__typeof__((0)), _curl_write_callback6*)))) _curl_easy_setopt_err_write_callback(); if((_curl_opt) == CURLOPT_READFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(0), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(0), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(0), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((0)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((0)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((0)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((0)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((0)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((0)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((0)), _curl_read_callback6*)))) _curl_easy_setopt_err_read_cb(); if((_curl_opt) == CURLOPT_IOCTLFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(0), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(0), curl_ioctl_callback) || (__builtin_types_compatible_p(__typeof__((0)), _curl_ioctl_callback1) || __builtin_types_compatible_p(__typeof__((0)), _curl_ioctl_callback1*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_ioctl_callback2) || __builtin_types_compatible_p(__typeof__((0)), _curl_ioctl_callback2*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_ioctl_callback3) || __builtin_types_compatible_p(__typeof__((0)), _curl_ioctl_callback3*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_ioctl_callback4) || __builtin_types_compatible_p(__typeof__((0)), _curl_ioctl_callback4*)))) _curl_easy_setopt_err_ioctl_cb(); if((_curl_opt) == CURLOPT_SOCKOPTFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(0), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(0), curl_sockopt_callback) || (__builtin_types_compatible_p(__typeof__((0)), _curl_sockopt_callback1) || __builtin_types_compatible_p(__typeof__((0)), _curl_sockopt_callback1*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_sockopt_callback2) || __builtin_types_compatible_p(__typeof__((0)), _curl_sockopt_callback2*)))) _curl_easy_setopt_err_sockopt_cb(); if((_curl_opt) == CURLOPT_OPENSOCKETFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(0), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(0), curl_opensocket_callback) || (__builtin_types_compatible_p(__typeof__((0)), _curl_opensocket_callback1) || __builtin_types_compatible_p(__typeof__((0)), _curl_opensocket_callback1*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_opensocket_callback2) || __builtin_types_compatible_p(__typeof__((0)), _curl_opensocket_callback2*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_opensocket_callback3) || __builtin_types_compatible_p(__typeof__((0)), _curl_opensocket_callback3*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_opensocket_callback4) || __builtin_types_compatible_p(__typeof__((0)), _curl_opensocket_callback4*)))) _curl_easy_setopt_err_opensocket_cb(); if((_curl_opt) == CURLOPT_PROGRESSFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(0), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(0), curl_progress_callback) || (__builtin_types_compatible_p(__typeof__((0)), _curl_progress_callback1) || __builtin_types_compatible_p(__typeof__((0)), _curl_progress_callback1*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_progress_callback2) || __builtin_types_compatible_p(__typeof__((0)), _curl_progress_callback2*)))) _curl_easy_setopt_err_progress_cb(); if((_curl_opt) == CURLOPT_DEBUGFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(0), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(0), curl_debug_callback) || (__builtin_types_compatible_p(__typeof__((0)), _curl_debug_callback1) || __builtin_types_compatible_p(__typeof__((0)), _curl_debug_callback1*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_debug_callback2) || __builtin_types_compatible_p(__typeof__((0)), _curl_debug_callback2*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_debug_callback3) || __builtin_types_compatible_p(__typeof__((0)), _curl_debug_callback3*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_debug_callback4) || __builtin_types_compatible_p(__typeof__((0)), _curl_debug_callback4*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_debug_callback5) || __builtin_types_compatible_p(__typeof__((0)), _curl_debug_callback5*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_debug_callback6) || __builtin_types_compatible_p(__typeof__((0)), _curl_debug_callback6*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_debug_callback7) || __builtin_types_compatible_p(__typeof__((0)), _curl_debug_callback7*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_debug_callback8) || __builtin_types_compatible_p(__typeof__((0)), _curl_debug_callback8*)))) _curl_easy_setopt_err_debug_cb(); if((_curl_opt) == CURLOPT_SSL_CTX_FUNCTION) if(!((__builtin_types_compatible_p(__typeof__(0), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(0), curl_ssl_ctx_callback) || (__builtin_types_compatible_p(__typeof__((0)), _curl_ssl_ctx_callback1) || __builtin_types_compatible_p(__typeof__((0)), _curl_ssl_ctx_callback1*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_ssl_ctx_callback2) || __builtin_types_compatible_p(__typeof__((0)), _curl_ssl_ctx_callback2*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_ssl_ctx_callback3) || __builtin_types_compatible_p(__typeof__((0)), _curl_ssl_ctx_callback3*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_ssl_ctx_callback4) || __builtin_types_compatible_p(__typeof__((0)), _curl_ssl_ctx_callback4*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_ssl_ctx_callback5) || __builtin_types_compatible_p(__typeof__((0)), _curl_ssl_ctx_callback5*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_ssl_ctx_callback6) || __builtin_types_compatible_p(__typeof__((0)), _curl_ssl_ctx_callback6*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_ssl_ctx_callback7) || __builtin_types_compatible_p(__typeof__((0)), _curl_ssl_ctx_callback7*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_ssl_ctx_callback8) || __builtin_types_compatible_p(__typeof__((0)), _curl_ssl_ctx_callback8*)))) _curl_easy_setopt_err_ssl_ctx_cb(); if(((_curl_opt) == CURLOPT_CONV_TO_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_UTF8_FUNCTION)) if(!((__builtin_types_compatible_p(__typeof__(0), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(0), curl_conv_callback) || (__builtin_types_compatible_p(__typeof__((0)), _curl_conv_callback1) || __builtin_types_compatible_p(__typeof__((0)), _curl_conv_callback1*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_conv_callback2) || __builtin_types_compatible_p(__typeof__((0)), _curl_conv_callback2*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_conv_callback3) || __builtin_types_compatible_p(__typeof__((0)), _curl_conv_callback3*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_conv_callback4) || __builtin_types_compatible_p(__typeof__((0)), _curl_conv_callback4*)))) _curl_easy_setopt_err_conv_cb(); if((_curl_opt) == CURLOPT_SEEKFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(0), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(0), curl_seek_callback) || (__builtin_types_compatible_p(__typeof__((0)), _curl_seek_callback1) || __builtin_types_compatible_p(__typeof__((0)), _curl_seek_callback1*)) || (__builtin_types_compatible_p(__typeof__((0)), _curl_seek_callback2) || __builtin_types_compatible_p(__typeof__((0)), _curl_seek_callback2*)))) _curl_easy_setopt_err_seek_cb(); if(((_curl_opt) == CURLOPT_FILE || (_curl_opt) == CURLOPT_INFILE || (_curl_opt) == CURLOPT_IOCTLDATA || (_curl_opt) == CURLOPT_SOCKOPTDATA || (_curl_opt) == CURLOPT_OPENSOCKETDATA || (_curl_opt) == CURLOPT_PROGRESSDATA || (_curl_opt) == CURLOPT_WRITEHEADER || (_curl_opt) == CURLOPT_DEBUGDATA || (_curl_opt) == CURLOPT_SSL_CTX_DATA || (_curl_opt) == CURLOPT_SEEKDATA || (_curl_opt) == CURLOPT_PRIVATE || (_curl_opt) == CURLOPT_SSH_KEYDATA || (_curl_opt) == CURLOPT_INTERLEAVEDATA || (_curl_opt) == CURLOPT_CHUNK_DATA || (_curl_opt) == CURLOPT_FNMATCH_DATA || 0)) if(!(sizeof(0) == sizeof(void*))) _curl_easy_setopt_err_cb_data(); if((_curl_opt) == CURLOPT_ERRORBUFFER) if(!((__builtin_types_compatible_p(__typeof__(0), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(0), char *) || __builtin_types_compatible_p(__typeof__(0), char[]))) _curl_easy_setopt_err_error_buffer(); if((_curl_opt) == CURLOPT_STDERR) if(!(__builtin_types_compatible_p(__typeof__(0), FILE *))) _curl_easy_setopt_err_FILE(); if(((_curl_opt) == CURLOPT_POSTFIELDS || (_curl_opt) == CURLOPT_COPYPOSTFIELDS || 0)) if(!(((__builtin_types_compatible_p(__typeof__((0)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((0)), void *) || __builtin_types_compatible_p(__typeof__((0)), const void *)) || (((__builtin_types_compatible_p(__typeof__(((0))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((0))), char *) || __builtin_types_compatible_p(__typeof__(((0))), const char *)) || __builtin_types_compatible_p(__typeof__((0)), char [])))) _curl_easy_setopt_err_postfields(); if((_curl_opt) == CURLOPT_HTTPPOST) if(!(((__builtin_types_compatible_p(__typeof__(((0))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((0))), struct curl_httppost *) || __builtin_types_compatible_p(__typeof__(((0))), const struct curl_httppost *)) || __builtin_types_compatible_p(__typeof__((0)), struct curl_httppost []))) _curl_easy_setopt_err_curl_httpost(); if(((_curl_opt) == CURLOPT_HTTPHEADER || (_curl_opt) == CURLOPT_HTTP200ALIASES || (_curl_opt) == CURLOPT_QUOTE || (_curl_opt) == CURLOPT_POSTQUOTE || (_curl_opt) == CURLOPT_PREQUOTE || (_curl_opt) == CURLOPT_TELNETOPTIONS || (_curl_opt) == CURLOPT_MAIL_RCPT || 0)) if(!(((__builtin_types_compatible_p(__typeof__(((0))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((0))), struct curl_slist *) || __builtin_types_compatible_p(__typeof__(((0))), const struct curl_slist *)) || __builtin_types_compatible_p(__typeof__((0)), struct curl_slist []))) _curl_easy_setopt_err_curl_slist(); if((_curl_opt) == CURLOPT_SHARE) if(!((__builtin_types_compatible_p(__typeof__((0)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((0)), CURLSH *) || __builtin_types_compatible_p(__typeof__((0)), const CURLSH *))) _curl_easy_setopt_err_CURLSH(); } curl_easy_setopt(request->curl, _curl_opt, 0); })) != CURLE_OK) { return S3StatusFailedToInitializeRequest; };


    if ((status = __extension__ ({ __typeof__ (CURLOPT_FOLLOWLOCATION) _curl_opt = CURLOPT_FOLLOWLOCATION; if(__builtin_constant_p(_curl_opt)) { if((0 < (_curl_opt) && (_curl_opt) < 10000)) if(!(__builtin_types_compatible_p(__typeof__(1), long) || __builtin_types_compatible_p(__typeof__(1), signed long) || __builtin_types_compatible_p(__typeof__(1), unsigned long) || __builtin_types_compatible_p(__typeof__(1), int) || __builtin_types_compatible_p(__typeof__(1), signed int) || __builtin_types_compatible_p(__typeof__(1), unsigned int) || __builtin_types_compatible_p(__typeof__(1), short) || __builtin_types_compatible_p(__typeof__(1), signed short) || __builtin_types_compatible_p(__typeof__(1), unsigned short) || __builtin_types_compatible_p(__typeof__(1), char) || __builtin_types_compatible_p(__typeof__(1), signed char) || __builtin_types_compatible_p(__typeof__(1), unsigned char))) _curl_easy_setopt_err_long(); if(((_curl_opt) > 30000)) if(!(__builtin_types_compatible_p(__typeof__(1), curl_off_t))) _curl_easy_setopt_err_curl_off_t(); if(((_curl_opt) == CURLOPT_URL || (_curl_opt) == CURLOPT_PROXY || (_curl_opt) == CURLOPT_INTERFACE || (_curl_opt) == CURLOPT_NETRC_FILE || (_curl_opt) == CURLOPT_USERPWD || (_curl_opt) == CURLOPT_USERNAME || (_curl_opt) == CURLOPT_PASSWORD || (_curl_opt) == CURLOPT_PROXYUSERPWD || (_curl_opt) == CURLOPT_PROXYUSERNAME || (_curl_opt) == CURLOPT_PROXYPASSWORD || (_curl_opt) == CURLOPT_NOPROXY || (_curl_opt) == CURLOPT_ACCEPT_ENCODING || (_curl_opt) == CURLOPT_REFERER || (_curl_opt) == CURLOPT_USERAGENT || (_curl_opt) == CURLOPT_COOKIE || (_curl_opt) == CURLOPT_COOKIEFILE || (_curl_opt) == CURLOPT_COOKIEJAR || (_curl_opt) == CURLOPT_COOKIELIST || (_curl_opt) == CURLOPT_FTPPORT || (_curl_opt) == CURLOPT_FTP_ALTERNATIVE_TO_USER || (_curl_opt) == CURLOPT_FTP_ACCOUNT || (_curl_opt) == CURLOPT_RANGE || (_curl_opt) == CURLOPT_CUSTOMREQUEST || (_curl_opt) == CURLOPT_SSLCERT || (_curl_opt) == CURLOPT_SSLCERTTYPE || (_curl_opt) == CURLOPT_SSLKEY || (_curl_opt) == CURLOPT_SSLKEYTYPE || (_curl_opt) == CURLOPT_KEYPASSWD || (_curl_opt) == CURLOPT_SSLENGINE || (_curl_opt) == CURLOPT_CAINFO || (_curl_opt) == CURLOPT_CAPATH || (_curl_opt) == CURLOPT_RANDOM_FILE || (_curl_opt) == CURLOPT_EGDSOCKET || (_curl_opt) == CURLOPT_SSL_CIPHER_LIST || (_curl_opt) == CURLOPT_KRBLEVEL || (_curl_opt) == CURLOPT_SSH_HOST_PUBLIC_KEY_MD5 || (_curl_opt) == CURLOPT_SSH_PUBLIC_KEYFILE || (_curl_opt) == CURLOPT_SSH_PRIVATE_KEYFILE || (_curl_opt) == CURLOPT_CRLFILE || (_curl_opt) == CURLOPT_ISSUERCERT || (_curl_opt) == CURLOPT_SOCKS5_GSSAPI_SERVICE || (_curl_opt) == CURLOPT_SSH_KNOWNHOSTS || (_curl_opt) == CURLOPT_MAIL_FROM || (_curl_opt) == CURLOPT_RTSP_SESSION_ID || (_curl_opt) == CURLOPT_RTSP_STREAM_URI || (_curl_opt) == CURLOPT_RTSP_TRANSPORT || 0)) if(!((((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), char *) || __builtin_types_compatible_p(__typeof__(((1))), const char *)) || __builtin_types_compatible_p(__typeof__((1)), char [])) || (((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), signed char *) || __builtin_types_compatible_p(__typeof__(((1))), const signed char *)) || __builtin_types_compatible_p(__typeof__((1)), signed char [])) || (((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), unsigned char *) || __builtin_types_compatible_p(__typeof__(((1))), const unsigned char *)) || __builtin_types_compatible_p(__typeof__((1)), unsigned char [])))) _curl_easy_setopt_err_string(); if(((_curl_opt) == CURLOPT_HEADERFUNCTION || (_curl_opt) == CURLOPT_WRITEFUNCTION)) if(!(((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(1), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback6*))) || __builtin_types_compatible_p(__typeof__(1), __typeof__(fwrite)) || __builtin_types_compatible_p(__typeof__(1), curl_write_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback4*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback5) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback5*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback6) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback6*)))) _curl_easy_setopt_err_write_callback(); if((_curl_opt) == CURLOPT_READFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(1), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback6*)))) _curl_easy_setopt_err_read_cb(); if((_curl_opt) == CURLOPT_IOCTLFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_ioctl_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback4*)))) _curl_easy_setopt_err_ioctl_cb(); if((_curl_opt) == CURLOPT_SOCKOPTFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_sockopt_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_sockopt_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_sockopt_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_sockopt_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_sockopt_callback2*)))) _curl_easy_setopt_err_sockopt_cb(); if((_curl_opt) == CURLOPT_OPENSOCKETFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_opensocket_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback4*)))) _curl_easy_setopt_err_opensocket_cb(); if((_curl_opt) == CURLOPT_PROGRESSFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_progress_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_progress_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_progress_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_progress_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_progress_callback2*)))) _curl_easy_setopt_err_progress_cb(); if((_curl_opt) == CURLOPT_DEBUGFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_debug_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback4*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback5) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback5*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback6) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback6*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback7) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback7*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback8) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback8*)))) _curl_easy_setopt_err_debug_cb(); if((_curl_opt) == CURLOPT_SSL_CTX_FUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_ssl_ctx_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback4*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback5) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback5*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback6) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback6*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback7) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback7*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback8) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback8*)))) _curl_easy_setopt_err_ssl_ctx_cb(); if(((_curl_opt) == CURLOPT_CONV_TO_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_UTF8_FUNCTION)) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_conv_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback4*)))) _curl_easy_setopt_err_conv_cb(); if((_curl_opt) == CURLOPT_SEEKFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_seek_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_seek_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_seek_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_seek_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_seek_callback2*)))) _curl_easy_setopt_err_seek_cb(); if(((_curl_opt) == CURLOPT_FILE || (_curl_opt) == CURLOPT_INFILE || (_curl_opt) == CURLOPT_IOCTLDATA || (_curl_opt) == CURLOPT_SOCKOPTDATA || (_curl_opt) == CURLOPT_OPENSOCKETDATA || (_curl_opt) == CURLOPT_PROGRESSDATA || (_curl_opt) == CURLOPT_WRITEHEADER || (_curl_opt) == CURLOPT_DEBUGDATA || (_curl_opt) == CURLOPT_SSL_CTX_DATA || (_curl_opt) == CURLOPT_SEEKDATA || (_curl_opt) == CURLOPT_PRIVATE || (_curl_opt) == CURLOPT_SSH_KEYDATA || (_curl_opt) == CURLOPT_INTERLEAVEDATA || (_curl_opt) == CURLOPT_CHUNK_DATA || (_curl_opt) == CURLOPT_FNMATCH_DATA || 0)) if(!(sizeof(1) == sizeof(void*))) _curl_easy_setopt_err_cb_data(); if((_curl_opt) == CURLOPT_ERRORBUFFER) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), char *) || __builtin_types_compatible_p(__typeof__(1), char[]))) _curl_easy_setopt_err_error_buffer(); if((_curl_opt) == CURLOPT_STDERR) if(!(__builtin_types_compatible_p(__typeof__(1), FILE *))) _curl_easy_setopt_err_FILE(); if(((_curl_opt) == CURLOPT_POSTFIELDS || (_curl_opt) == CURLOPT_COPYPOSTFIELDS || 0)) if(!(((__builtin_types_compatible_p(__typeof__((1)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((1)), void *) || __builtin_types_compatible_p(__typeof__((1)), const void *)) || (((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), char *) || __builtin_types_compatible_p(__typeof__(((1))), const char *)) || __builtin_types_compatible_p(__typeof__((1)), char [])))) _curl_easy_setopt_err_postfields(); if((_curl_opt) == CURLOPT_HTTPPOST) if(!(((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), struct curl_httppost *) || __builtin_types_compatible_p(__typeof__(((1))), const struct curl_httppost *)) || __builtin_types_compatible_p(__typeof__((1)), struct curl_httppost []))) _curl_easy_setopt_err_curl_httpost(); if(((_curl_opt) == CURLOPT_HTTPHEADER || (_curl_opt) == CURLOPT_HTTP200ALIASES || (_curl_opt) == CURLOPT_QUOTE || (_curl_opt) == CURLOPT_POSTQUOTE || (_curl_opt) == CURLOPT_PREQUOTE || (_curl_opt) == CURLOPT_TELNETOPTIONS || (_curl_opt) == CURLOPT_MAIL_RCPT || 0)) if(!(((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), struct curl_slist *) || __builtin_types_compatible_p(__typeof__(((1))), const struct curl_slist *)) || __builtin_types_compatible_p(__typeof__((1)), struct curl_slist []))) _curl_easy_setopt_err_curl_slist(); if((_curl_opt) == CURLOPT_SHARE) if(!((__builtin_types_compatible_p(__typeof__((1)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((1)), CURLSH *) || __builtin_types_compatible_p(__typeof__((1)), const CURLSH *))) _curl_easy_setopt_err_CURLSH(); } curl_easy_setopt(request->curl, _curl_opt, 1); })) != CURLE_OK) { return S3StatusFailedToInitializeRequest; };


    if ((status = __extension__ ({ __typeof__ (CURLOPT_MAXREDIRS) _curl_opt = CURLOPT_MAXREDIRS; if(__builtin_constant_p(_curl_opt)) { if((0 < (_curl_opt) && (_curl_opt) < 10000)) if(!(__builtin_types_compatible_p(__typeof__(10), long) || __builtin_types_compatible_p(__typeof__(10), signed long) || __builtin_types_compatible_p(__typeof__(10), unsigned long) || __builtin_types_compatible_p(__typeof__(10), int) || __builtin_types_compatible_p(__typeof__(10), signed int) || __builtin_types_compatible_p(__typeof__(10), unsigned int) || __builtin_types_compatible_p(__typeof__(10), short) || __builtin_types_compatible_p(__typeof__(10), signed short) || __builtin_types_compatible_p(__typeof__(10), unsigned short) || __builtin_types_compatible_p(__typeof__(10), char) || __builtin_types_compatible_p(__typeof__(10), signed char) || __builtin_types_compatible_p(__typeof__(10), unsigned char))) _curl_easy_setopt_err_long(); if(((_curl_opt) > 30000)) if(!(__builtin_types_compatible_p(__typeof__(10), curl_off_t))) _curl_easy_setopt_err_curl_off_t(); if(((_curl_opt) == CURLOPT_URL || (_curl_opt) == CURLOPT_PROXY || (_curl_opt) == CURLOPT_INTERFACE || (_curl_opt) == CURLOPT_NETRC_FILE || (_curl_opt) == CURLOPT_USERPWD || (_curl_opt) == CURLOPT_USERNAME || (_curl_opt) == CURLOPT_PASSWORD || (_curl_opt) == CURLOPT_PROXYUSERPWD || (_curl_opt) == CURLOPT_PROXYUSERNAME || (_curl_opt) == CURLOPT_PROXYPASSWORD || (_curl_opt) == CURLOPT_NOPROXY || (_curl_opt) == CURLOPT_ACCEPT_ENCODING || (_curl_opt) == CURLOPT_REFERER || (_curl_opt) == CURLOPT_USERAGENT || (_curl_opt) == CURLOPT_COOKIE || (_curl_opt) == CURLOPT_COOKIEFILE || (_curl_opt) == CURLOPT_COOKIEJAR || (_curl_opt) == CURLOPT_COOKIELIST || (_curl_opt) == CURLOPT_FTPPORT || (_curl_opt) == CURLOPT_FTP_ALTERNATIVE_TO_USER || (_curl_opt) == CURLOPT_FTP_ACCOUNT || (_curl_opt) == CURLOPT_RANGE || (_curl_opt) == CURLOPT_CUSTOMREQUEST || (_curl_opt) == CURLOPT_SSLCERT || (_curl_opt) == CURLOPT_SSLCERTTYPE || (_curl_opt) == CURLOPT_SSLKEY || (_curl_opt) == CURLOPT_SSLKEYTYPE || (_curl_opt) == CURLOPT_KEYPASSWD || (_curl_opt) == CURLOPT_SSLENGINE || (_curl_opt) == CURLOPT_CAINFO || (_curl_opt) == CURLOPT_CAPATH || (_curl_opt) == CURLOPT_RANDOM_FILE || (_curl_opt) == CURLOPT_EGDSOCKET || (_curl_opt) == CURLOPT_SSL_CIPHER_LIST || (_curl_opt) == CURLOPT_KRBLEVEL || (_curl_opt) == CURLOPT_SSH_HOST_PUBLIC_KEY_MD5 || (_curl_opt) == CURLOPT_SSH_PUBLIC_KEYFILE || (_curl_opt) == CURLOPT_SSH_PRIVATE_KEYFILE || (_curl_opt) == CURLOPT_CRLFILE || (_curl_opt) == CURLOPT_ISSUERCERT || (_curl_opt) == CURLOPT_SOCKS5_GSSAPI_SERVICE || (_curl_opt) == CURLOPT_SSH_KNOWNHOSTS || (_curl_opt) == CURLOPT_MAIL_FROM || (_curl_opt) == CURLOPT_RTSP_SESSION_ID || (_curl_opt) == CURLOPT_RTSP_STREAM_URI || (_curl_opt) == CURLOPT_RTSP_TRANSPORT || 0)) if(!((((__builtin_types_compatible_p(__typeof__(((10))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((10))), char *) || __builtin_types_compatible_p(__typeof__(((10))), const char *)) || __builtin_types_compatible_p(__typeof__((10)), char [])) || (((__builtin_types_compatible_p(__typeof__(((10))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((10))), signed char *) || __builtin_types_compatible_p(__typeof__(((10))), const signed char *)) || __builtin_types_compatible_p(__typeof__((10)), signed char [])) || (((__builtin_types_compatible_p(__typeof__(((10))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((10))), unsigned char *) || __builtin_types_compatible_p(__typeof__(((10))), const unsigned char *)) || __builtin_types_compatible_p(__typeof__((10)), unsigned char [])))) _curl_easy_setopt_err_string(); if(((_curl_opt) == CURLOPT_HEADERFUNCTION || (_curl_opt) == CURLOPT_WRITEFUNCTION)) if(!(((__builtin_types_compatible_p(__typeof__(10), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(10), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(10), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((10)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((10)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((10)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((10)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((10)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((10)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((10)), _curl_read_callback6*))) || __builtin_types_compatible_p(__typeof__(10), __typeof__(fwrite)) || __builtin_types_compatible_p(__typeof__(10), curl_write_callback) || (__builtin_types_compatible_p(__typeof__((10)), _curl_write_callback1) || __builtin_types_compatible_p(__typeof__((10)), _curl_write_callback1*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_write_callback2) || __builtin_types_compatible_p(__typeof__((10)), _curl_write_callback2*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_write_callback3) || __builtin_types_compatible_p(__typeof__((10)), _curl_write_callback3*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_write_callback4) || __builtin_types_compatible_p(__typeof__((10)), _curl_write_callback4*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_write_callback5) || __builtin_types_compatible_p(__typeof__((10)), _curl_write_callback5*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_write_callback6) || __builtin_types_compatible_p(__typeof__((10)), _curl_write_callback6*)))) _curl_easy_setopt_err_write_callback(); if((_curl_opt) == CURLOPT_READFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(10), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(10), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(10), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((10)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((10)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((10)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((10)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((10)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((10)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((10)), _curl_read_callback6*)))) _curl_easy_setopt_err_read_cb(); if((_curl_opt) == CURLOPT_IOCTLFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(10), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(10), curl_ioctl_callback) || (__builtin_types_compatible_p(__typeof__((10)), _curl_ioctl_callback1) || __builtin_types_compatible_p(__typeof__((10)), _curl_ioctl_callback1*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_ioctl_callback2) || __builtin_types_compatible_p(__typeof__((10)), _curl_ioctl_callback2*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_ioctl_callback3) || __builtin_types_compatible_p(__typeof__((10)), _curl_ioctl_callback3*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_ioctl_callback4) || __builtin_types_compatible_p(__typeof__((10)), _curl_ioctl_callback4*)))) _curl_easy_setopt_err_ioctl_cb(); if((_curl_opt) == CURLOPT_SOCKOPTFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(10), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(10), curl_sockopt_callback) || (__builtin_types_compatible_p(__typeof__((10)), _curl_sockopt_callback1) || __builtin_types_compatible_p(__typeof__((10)), _curl_sockopt_callback1*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_sockopt_callback2) || __builtin_types_compatible_p(__typeof__((10)), _curl_sockopt_callback2*)))) _curl_easy_setopt_err_sockopt_cb(); if((_curl_opt) == CURLOPT_OPENSOCKETFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(10), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(10), curl_opensocket_callback) || (__builtin_types_compatible_p(__typeof__((10)), _curl_opensocket_callback1) || __builtin_types_compatible_p(__typeof__((10)), _curl_opensocket_callback1*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_opensocket_callback2) || __builtin_types_compatible_p(__typeof__((10)), _curl_opensocket_callback2*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_opensocket_callback3) || __builtin_types_compatible_p(__typeof__((10)), _curl_opensocket_callback3*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_opensocket_callback4) || __builtin_types_compatible_p(__typeof__((10)), _curl_opensocket_callback4*)))) _curl_easy_setopt_err_opensocket_cb(); if((_curl_opt) == CURLOPT_PROGRESSFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(10), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(10), curl_progress_callback) || (__builtin_types_compatible_p(__typeof__((10)), _curl_progress_callback1) || __builtin_types_compatible_p(__typeof__((10)), _curl_progress_callback1*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_progress_callback2) || __builtin_types_compatible_p(__typeof__((10)), _curl_progress_callback2*)))) _curl_easy_setopt_err_progress_cb(); if((_curl_opt) == CURLOPT_DEBUGFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(10), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(10), curl_debug_callback) || (__builtin_types_compatible_p(__typeof__((10)), _curl_debug_callback1) || __builtin_types_compatible_p(__typeof__((10)), _curl_debug_callback1*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_debug_callback2) || __builtin_types_compatible_p(__typeof__((10)), _curl_debug_callback2*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_debug_callback3) || __builtin_types_compatible_p(__typeof__((10)), _curl_debug_callback3*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_debug_callback4) || __builtin_types_compatible_p(__typeof__((10)), _curl_debug_callback4*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_debug_callback5) || __builtin_types_compatible_p(__typeof__((10)), _curl_debug_callback5*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_debug_callback6) || __builtin_types_compatible_p(__typeof__((10)), _curl_debug_callback6*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_debug_callback7) || __builtin_types_compatible_p(__typeof__((10)), _curl_debug_callback7*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_debug_callback8) || __builtin_types_compatible_p(__typeof__((10)), _curl_debug_callback8*)))) _curl_easy_setopt_err_debug_cb(); if((_curl_opt) == CURLOPT_SSL_CTX_FUNCTION) if(!((__builtin_types_compatible_p(__typeof__(10), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(10), curl_ssl_ctx_callback) || (__builtin_types_compatible_p(__typeof__((10)), _curl_ssl_ctx_callback1) || __builtin_types_compatible_p(__typeof__((10)), _curl_ssl_ctx_callback1*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_ssl_ctx_callback2) || __builtin_types_compatible_p(__typeof__((10)), _curl_ssl_ctx_callback2*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_ssl_ctx_callback3) || __builtin_types_compatible_p(__typeof__((10)), _curl_ssl_ctx_callback3*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_ssl_ctx_callback4) || __builtin_types_compatible_p(__typeof__((10)), _curl_ssl_ctx_callback4*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_ssl_ctx_callback5) || __builtin_types_compatible_p(__typeof__((10)), _curl_ssl_ctx_callback5*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_ssl_ctx_callback6) || __builtin_types_compatible_p(__typeof__((10)), _curl_ssl_ctx_callback6*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_ssl_ctx_callback7) || __builtin_types_compatible_p(__typeof__((10)), _curl_ssl_ctx_callback7*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_ssl_ctx_callback8) || __builtin_types_compatible_p(__typeof__((10)), _curl_ssl_ctx_callback8*)))) _curl_easy_setopt_err_ssl_ctx_cb(); if(((_curl_opt) == CURLOPT_CONV_TO_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_UTF8_FUNCTION)) if(!((__builtin_types_compatible_p(__typeof__(10), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(10), curl_conv_callback) || (__builtin_types_compatible_p(__typeof__((10)), _curl_conv_callback1) || __builtin_types_compatible_p(__typeof__((10)), _curl_conv_callback1*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_conv_callback2) || __builtin_types_compatible_p(__typeof__((10)), _curl_conv_callback2*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_conv_callback3) || __builtin_types_compatible_p(__typeof__((10)), _curl_conv_callback3*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_conv_callback4) || __builtin_types_compatible_p(__typeof__((10)), _curl_conv_callback4*)))) _curl_easy_setopt_err_conv_cb(); if((_curl_opt) == CURLOPT_SEEKFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(10), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(10), curl_seek_callback) || (__builtin_types_compatible_p(__typeof__((10)), _curl_seek_callback1) || __builtin_types_compatible_p(__typeof__((10)), _curl_seek_callback1*)) || (__builtin_types_compatible_p(__typeof__((10)), _curl_seek_callback2) || __builtin_types_compatible_p(__typeof__((10)), _curl_seek_callback2*)))) _curl_easy_setopt_err_seek_cb(); if(((_curl_opt) == CURLOPT_FILE || (_curl_opt) == CURLOPT_INFILE || (_curl_opt) == CURLOPT_IOCTLDATA || (_curl_opt) == CURLOPT_SOCKOPTDATA || (_curl_opt) == CURLOPT_OPENSOCKETDATA || (_curl_opt) == CURLOPT_PROGRESSDATA || (_curl_opt) == CURLOPT_WRITEHEADER || (_curl_opt) == CURLOPT_DEBUGDATA || (_curl_opt) == CURLOPT_SSL_CTX_DATA || (_curl_opt) == CURLOPT_SEEKDATA || (_curl_opt) == CURLOPT_PRIVATE || (_curl_opt) == CURLOPT_SSH_KEYDATA || (_curl_opt) == CURLOPT_INTERLEAVEDATA || (_curl_opt) == CURLOPT_CHUNK_DATA || (_curl_opt) == CURLOPT_FNMATCH_DATA || 0)) if(!(sizeof(10) == sizeof(void*))) _curl_easy_setopt_err_cb_data(); if((_curl_opt) == CURLOPT_ERRORBUFFER) if(!((__builtin_types_compatible_p(__typeof__(10), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(10), char *) || __builtin_types_compatible_p(__typeof__(10), char[]))) _curl_easy_setopt_err_error_buffer(); if((_curl_opt) == CURLOPT_STDERR) if(!(__builtin_types_compatible_p(__typeof__(10), FILE *))) _curl_easy_setopt_err_FILE(); if(((_curl_opt) == CURLOPT_POSTFIELDS || (_curl_opt) == CURLOPT_COPYPOSTFIELDS || 0)) if(!(((__builtin_types_compatible_p(__typeof__((10)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((10)), void *) || __builtin_types_compatible_p(__typeof__((10)), const void *)) || (((__builtin_types_compatible_p(__typeof__(((10))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((10))), char *) || __builtin_types_compatible_p(__typeof__(((10))), const char *)) || __builtin_types_compatible_p(__typeof__((10)), char [])))) _curl_easy_setopt_err_postfields(); if((_curl_opt) == CURLOPT_HTTPPOST) if(!(((__builtin_types_compatible_p(__typeof__(((10))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((10))), struct curl_httppost *) || __builtin_types_compatible_p(__typeof__(((10))), const struct curl_httppost *)) || __builtin_types_compatible_p(__typeof__((10)), struct curl_httppost []))) _curl_easy_setopt_err_curl_httpost(); if(((_curl_opt) == CURLOPT_HTTPHEADER || (_curl_opt) == CURLOPT_HTTP200ALIASES || (_curl_opt) == CURLOPT_QUOTE || (_curl_opt) == CURLOPT_POSTQUOTE || (_curl_opt) == CURLOPT_PREQUOTE || (_curl_opt) == CURLOPT_TELNETOPTIONS || (_curl_opt) == CURLOPT_MAIL_RCPT || 0)) if(!(((__builtin_types_compatible_p(__typeof__(((10))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((10))), struct curl_slist *) || __builtin_types_compatible_p(__typeof__(((10))), const struct curl_slist *)) || __builtin_types_compatible_p(__typeof__((10)), struct curl_slist []))) _curl_easy_setopt_err_curl_slist(); if((_curl_opt) == CURLOPT_SHARE) if(!((__builtin_types_compatible_p(__typeof__((10)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((10)), CURLSH *) || __builtin_types_compatible_p(__typeof__((10)), const CURLSH *))) _curl_easy_setopt_err_CURLSH(); } curl_easy_setopt(request->curl, _curl_opt, 10); })) != CURLE_OK) { return S3StatusFailedToInitializeRequest; };


    if ((status = __extension__ ({ __typeof__ (CURLOPT_USERAGENT) _curl_opt = CURLOPT_USERAGENT; if(__builtin_constant_p(_curl_opt)) { if((0 < (_curl_opt) && (_curl_opt) < 10000)) if(!(__builtin_types_compatible_p(__typeof__(userAgentG), long) || __builtin_types_compatible_p(__typeof__(userAgentG), signed long) || __builtin_types_compatible_p(__typeof__(userAgentG), unsigned long) || __builtin_types_compatible_p(__typeof__(userAgentG), int) || __builtin_types_compatible_p(__typeof__(userAgentG), signed int) || __builtin_types_compatible_p(__typeof__(userAgentG), unsigned int) || __builtin_types_compatible_p(__typeof__(userAgentG), short) || __builtin_types_compatible_p(__typeof__(userAgentG), signed short) || __builtin_types_compatible_p(__typeof__(userAgentG), unsigned short) || __builtin_types_compatible_p(__typeof__(userAgentG), char) || __builtin_types_compatible_p(__typeof__(userAgentG), signed char) || __builtin_types_compatible_p(__typeof__(userAgentG), unsigned char))) _curl_easy_setopt_err_long(); if(((_curl_opt) > 30000)) if(!(__builtin_types_compatible_p(__typeof__(userAgentG), curl_off_t))) _curl_easy_setopt_err_curl_off_t(); if(((_curl_opt) == CURLOPT_URL || (_curl_opt) == CURLOPT_PROXY || (_curl_opt) == CURLOPT_INTERFACE || (_curl_opt) == CURLOPT_NETRC_FILE || (_curl_opt) == CURLOPT_USERPWD || (_curl_opt) == CURLOPT_USERNAME || (_curl_opt) == CURLOPT_PASSWORD || (_curl_opt) == CURLOPT_PROXYUSERPWD || (_curl_opt) == CURLOPT_PROXYUSERNAME || (_curl_opt) == CURLOPT_PROXYPASSWORD || (_curl_opt) == CURLOPT_NOPROXY || (_curl_opt) == CURLOPT_ACCEPT_ENCODING || (_curl_opt) == CURLOPT_REFERER || (_curl_opt) == CURLOPT_USERAGENT || (_curl_opt) == CURLOPT_COOKIE || (_curl_opt) == CURLOPT_COOKIEFILE || (_curl_opt) == CURLOPT_COOKIEJAR || (_curl_opt) == CURLOPT_COOKIELIST || (_curl_opt) == CURLOPT_FTPPORT || (_curl_opt) == CURLOPT_FTP_ALTERNATIVE_TO_USER || (_curl_opt) == CURLOPT_FTP_ACCOUNT || (_curl_opt) == CURLOPT_RANGE || (_curl_opt) == CURLOPT_CUSTOMREQUEST || (_curl_opt) == CURLOPT_SSLCERT || (_curl_opt) == CURLOPT_SSLCERTTYPE || (_curl_opt) == CURLOPT_SSLKEY || (_curl_opt) == CURLOPT_SSLKEYTYPE || (_curl_opt) == CURLOPT_KEYPASSWD || (_curl_opt) == CURLOPT_SSLENGINE || (_curl_opt) == CURLOPT_CAINFO || (_curl_opt) == CURLOPT_CAPATH || (_curl_opt) == CURLOPT_RANDOM_FILE || (_curl_opt) == CURLOPT_EGDSOCKET || (_curl_opt) == CURLOPT_SSL_CIPHER_LIST || (_curl_opt) == CURLOPT_KRBLEVEL || (_curl_opt) == CURLOPT_SSH_HOST_PUBLIC_KEY_MD5 || (_curl_opt) == CURLOPT_SSH_PUBLIC_KEYFILE || (_curl_opt) == CURLOPT_SSH_PRIVATE_KEYFILE || (_curl_opt) == CURLOPT_CRLFILE || (_curl_opt) == CURLOPT_ISSUERCERT || (_curl_opt) == CURLOPT_SOCKS5_GSSAPI_SERVICE || (_curl_opt) == CURLOPT_SSH_KNOWNHOSTS || (_curl_opt) == CURLOPT_MAIL_FROM || (_curl_opt) == CURLOPT_RTSP_SESSION_ID || (_curl_opt) == CURLOPT_RTSP_STREAM_URI || (_curl_opt) == CURLOPT_RTSP_TRANSPORT || 0)) if(!((((__builtin_types_compatible_p(__typeof__(((userAgentG))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((userAgentG))), char *) || __builtin_types_compatible_p(__typeof__(((userAgentG))), const char *)) || __builtin_types_compatible_p(__typeof__((userAgentG)), char [])) || (((__builtin_types_compatible_p(__typeof__(((userAgentG))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((userAgentG))), signed char *) || __builtin_types_compatible_p(__typeof__(((userAgentG))), const signed char *)) || __builtin_types_compatible_p(__typeof__((userAgentG)), signed char [])) || (((__builtin_types_compatible_p(__typeof__(((userAgentG))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((userAgentG))), unsigned char *) || __builtin_types_compatible_p(__typeof__(((userAgentG))), const unsigned char *)) || __builtin_types_compatible_p(__typeof__((userAgentG)), unsigned char [])))) _curl_easy_setopt_err_string(); if(((_curl_opt) == CURLOPT_HEADERFUNCTION || (_curl_opt) == CURLOPT_WRITEFUNCTION)) if(!(((__builtin_types_compatible_p(__typeof__(userAgentG), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(userAgentG), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(userAgentG), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_read_callback6*))) || __builtin_types_compatible_p(__typeof__(userAgentG), __typeof__(fwrite)) || __builtin_types_compatible_p(__typeof__(userAgentG), curl_write_callback) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_write_callback1) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_write_callback1*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_write_callback2) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_write_callback2*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_write_callback3) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_write_callback3*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_write_callback4) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_write_callback4*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_write_callback5) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_write_callback5*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_write_callback6) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_write_callback6*)))) _curl_easy_setopt_err_write_callback(); if((_curl_opt) == CURLOPT_READFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(userAgentG), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(userAgentG), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(userAgentG), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_read_callback6*)))) _curl_easy_setopt_err_read_cb(); if((_curl_opt) == CURLOPT_IOCTLFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(userAgentG), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(userAgentG), curl_ioctl_callback) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_ioctl_callback1) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_ioctl_callback1*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_ioctl_callback2) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_ioctl_callback2*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_ioctl_callback3) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_ioctl_callback3*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_ioctl_callback4) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_ioctl_callback4*)))) _curl_easy_setopt_err_ioctl_cb(); if((_curl_opt) == CURLOPT_SOCKOPTFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(userAgentG), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(userAgentG), curl_sockopt_callback) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_sockopt_callback1) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_sockopt_callback1*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_sockopt_callback2) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_sockopt_callback2*)))) _curl_easy_setopt_err_sockopt_cb(); if((_curl_opt) == CURLOPT_OPENSOCKETFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(userAgentG), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(userAgentG), curl_opensocket_callback) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_opensocket_callback1) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_opensocket_callback1*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_opensocket_callback2) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_opensocket_callback2*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_opensocket_callback3) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_opensocket_callback3*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_opensocket_callback4) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_opensocket_callback4*)))) _curl_easy_setopt_err_opensocket_cb(); if((_curl_opt) == CURLOPT_PROGRESSFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(userAgentG), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(userAgentG), curl_progress_callback) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_progress_callback1) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_progress_callback1*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_progress_callback2) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_progress_callback2*)))) _curl_easy_setopt_err_progress_cb(); if((_curl_opt) == CURLOPT_DEBUGFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(userAgentG), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(userAgentG), curl_debug_callback) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_debug_callback1) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_debug_callback1*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_debug_callback2) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_debug_callback2*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_debug_callback3) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_debug_callback3*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_debug_callback4) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_debug_callback4*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_debug_callback5) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_debug_callback5*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_debug_callback6) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_debug_callback6*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_debug_callback7) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_debug_callback7*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_debug_callback8) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_debug_callback8*)))) _curl_easy_setopt_err_debug_cb(); if((_curl_opt) == CURLOPT_SSL_CTX_FUNCTION) if(!((__builtin_types_compatible_p(__typeof__(userAgentG), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(userAgentG), curl_ssl_ctx_callback) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_ssl_ctx_callback1) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_ssl_ctx_callback1*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_ssl_ctx_callback2) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_ssl_ctx_callback2*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_ssl_ctx_callback3) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_ssl_ctx_callback3*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_ssl_ctx_callback4) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_ssl_ctx_callback4*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_ssl_ctx_callback5) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_ssl_ctx_callback5*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_ssl_ctx_callback6) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_ssl_ctx_callback6*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_ssl_ctx_callback7) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_ssl_ctx_callback7*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_ssl_ctx_callback8) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_ssl_ctx_callback8*)))) _curl_easy_setopt_err_ssl_ctx_cb(); if(((_curl_opt) == CURLOPT_CONV_TO_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_UTF8_FUNCTION)) if(!((__builtin_types_compatible_p(__typeof__(userAgentG), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(userAgentG), curl_conv_callback) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_conv_callback1) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_conv_callback1*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_conv_callback2) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_conv_callback2*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_conv_callback3) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_conv_callback3*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_conv_callback4) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_conv_callback4*)))) _curl_easy_setopt_err_conv_cb(); if((_curl_opt) == CURLOPT_SEEKFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(userAgentG), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(userAgentG), curl_seek_callback) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_seek_callback1) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_seek_callback1*)) || (__builtin_types_compatible_p(__typeof__((userAgentG)), _curl_seek_callback2) || __builtin_types_compatible_p(__typeof__((userAgentG)), _curl_seek_callback2*)))) _curl_easy_setopt_err_seek_cb(); if(((_curl_opt) == CURLOPT_FILE || (_curl_opt) == CURLOPT_INFILE || (_curl_opt) == CURLOPT_IOCTLDATA || (_curl_opt) == CURLOPT_SOCKOPTDATA || (_curl_opt) == CURLOPT_OPENSOCKETDATA || (_curl_opt) == CURLOPT_PROGRESSDATA || (_curl_opt) == CURLOPT_WRITEHEADER || (_curl_opt) == CURLOPT_DEBUGDATA || (_curl_opt) == CURLOPT_SSL_CTX_DATA || (_curl_opt) == CURLOPT_SEEKDATA || (_curl_opt) == CURLOPT_PRIVATE || (_curl_opt) == CURLOPT_SSH_KEYDATA || (_curl_opt) == CURLOPT_INTERLEAVEDATA || (_curl_opt) == CURLOPT_CHUNK_DATA || (_curl_opt) == CURLOPT_FNMATCH_DATA || 0)) if(!(sizeof(userAgentG) == sizeof(void*))) _curl_easy_setopt_err_cb_data(); if((_curl_opt) == CURLOPT_ERRORBUFFER) if(!((__builtin_types_compatible_p(__typeof__(userAgentG), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(userAgentG), char *) || __builtin_types_compatible_p(__typeof__(userAgentG), char[]))) _curl_easy_setopt_err_error_buffer(); if((_curl_opt) == CURLOPT_STDERR) if(!(__builtin_types_compatible_p(__typeof__(userAgentG), FILE *))) _curl_easy_setopt_err_FILE(); if(((_curl_opt) == CURLOPT_POSTFIELDS || (_curl_opt) == CURLOPT_COPYPOSTFIELDS || 0)) if(!(((__builtin_types_compatible_p(__typeof__((userAgentG)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((userAgentG)), void *) || __builtin_types_compatible_p(__typeof__((userAgentG)), const void *)) || (((__builtin_types_compatible_p(__typeof__(((userAgentG))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((userAgentG))), char *) || __builtin_types_compatible_p(__typeof__(((userAgentG))), const char *)) || __builtin_types_compatible_p(__typeof__((userAgentG)), char [])))) _curl_easy_setopt_err_postfields(); if((_curl_opt) == CURLOPT_HTTPPOST) if(!(((__builtin_types_compatible_p(__typeof__(((userAgentG))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((userAgentG))), struct curl_httppost *) || __builtin_types_compatible_p(__typeof__(((userAgentG))), const struct curl_httppost *)) || __builtin_types_compatible_p(__typeof__((userAgentG)), struct curl_httppost []))) _curl_easy_setopt_err_curl_httpost(); if(((_curl_opt) == CURLOPT_HTTPHEADER || (_curl_opt) == CURLOPT_HTTP200ALIASES || (_curl_opt) == CURLOPT_QUOTE || (_curl_opt) == CURLOPT_POSTQUOTE || (_curl_opt) == CURLOPT_PREQUOTE || (_curl_opt) == CURLOPT_TELNETOPTIONS || (_curl_opt) == CURLOPT_MAIL_RCPT || 0)) if(!(((__builtin_types_compatible_p(__typeof__(((userAgentG))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((userAgentG))), struct curl_slist *) || __builtin_types_compatible_p(__typeof__(((userAgentG))), const struct curl_slist *)) || __builtin_types_compatible_p(__typeof__((userAgentG)), struct curl_slist []))) _curl_easy_setopt_err_curl_slist(); if((_curl_opt) == CURLOPT_SHARE) if(!((__builtin_types_compatible_p(__typeof__((userAgentG)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((userAgentG)), CURLSH *) || __builtin_types_compatible_p(__typeof__((userAgentG)), const CURLSH *))) _curl_easy_setopt_err_CURLSH(); } curl_easy_setopt(request->curl, _curl_opt, userAgentG); })) != CURLE_OK) { return S3StatusFailedToInitializeRequest; };





    if ((status = __extension__ ({ __typeof__ (CURLOPT_LOW_SPEED_LIMIT) _curl_opt = CURLOPT_LOW_SPEED_LIMIT; if(__builtin_constant_p(_curl_opt)) { if((0 < (_curl_opt) && (_curl_opt) < 10000)) if(!(__builtin_types_compatible_p(__typeof__(1024), long) || __builtin_types_compatible_p(__typeof__(1024), signed long) || __builtin_types_compatible_p(__typeof__(1024), unsigned long) || __builtin_types_compatible_p(__typeof__(1024), int) || __builtin_types_compatible_p(__typeof__(1024), signed int) || __builtin_types_compatible_p(__typeof__(1024), unsigned int) || __builtin_types_compatible_p(__typeof__(1024), short) || __builtin_types_compatible_p(__typeof__(1024), signed short) || __builtin_types_compatible_p(__typeof__(1024), unsigned short) || __builtin_types_compatible_p(__typeof__(1024), char) || __builtin_types_compatible_p(__typeof__(1024), signed char) || __builtin_types_compatible_p(__typeof__(1024), unsigned char))) _curl_easy_setopt_err_long(); if(((_curl_opt) > 30000)) if(!(__builtin_types_compatible_p(__typeof__(1024), curl_off_t))) _curl_easy_setopt_err_curl_off_t(); if(((_curl_opt) == CURLOPT_URL || (_curl_opt) == CURLOPT_PROXY || (_curl_opt) == CURLOPT_INTERFACE || (_curl_opt) == CURLOPT_NETRC_FILE || (_curl_opt) == CURLOPT_USERPWD || (_curl_opt) == CURLOPT_USERNAME || (_curl_opt) == CURLOPT_PASSWORD || (_curl_opt) == CURLOPT_PROXYUSERPWD || (_curl_opt) == CURLOPT_PROXYUSERNAME || (_curl_opt) == CURLOPT_PROXYPASSWORD || (_curl_opt) == CURLOPT_NOPROXY || (_curl_opt) == CURLOPT_ACCEPT_ENCODING || (_curl_opt) == CURLOPT_REFERER || (_curl_opt) == CURLOPT_USERAGENT || (_curl_opt) == CURLOPT_COOKIE || (_curl_opt) == CURLOPT_COOKIEFILE || (_curl_opt) == CURLOPT_COOKIEJAR || (_curl_opt) == CURLOPT_COOKIELIST || (_curl_opt) == CURLOPT_FTPPORT || (_curl_opt) == CURLOPT_FTP_ALTERNATIVE_TO_USER || (_curl_opt) == CURLOPT_FTP_ACCOUNT || (_curl_opt) == CURLOPT_RANGE || (_curl_opt) == CURLOPT_CUSTOMREQUEST || (_curl_opt) == CURLOPT_SSLCERT || (_curl_opt) == CURLOPT_SSLCERTTYPE || (_curl_opt) == CURLOPT_SSLKEY || (_curl_opt) == CURLOPT_SSLKEYTYPE || (_curl_opt) == CURLOPT_KEYPASSWD || (_curl_opt) == CURLOPT_SSLENGINE || (_curl_opt) == CURLOPT_CAINFO || (_curl_opt) == CURLOPT_CAPATH || (_curl_opt) == CURLOPT_RANDOM_FILE || (_curl_opt) == CURLOPT_EGDSOCKET || (_curl_opt) == CURLOPT_SSL_CIPHER_LIST || (_curl_opt) == CURLOPT_KRBLEVEL || (_curl_opt) == CURLOPT_SSH_HOST_PUBLIC_KEY_MD5 || (_curl_opt) == CURLOPT_SSH_PUBLIC_KEYFILE || (_curl_opt) == CURLOPT_SSH_PRIVATE_KEYFILE || (_curl_opt) == CURLOPT_CRLFILE || (_curl_opt) == CURLOPT_ISSUERCERT || (_curl_opt) == CURLOPT_SOCKS5_GSSAPI_SERVICE || (_curl_opt) == CURLOPT_SSH_KNOWNHOSTS || (_curl_opt) == CURLOPT_MAIL_FROM || (_curl_opt) == CURLOPT_RTSP_SESSION_ID || (_curl_opt) == CURLOPT_RTSP_STREAM_URI || (_curl_opt) == CURLOPT_RTSP_TRANSPORT || 0)) if(!((((__builtin_types_compatible_p(__typeof__(((1024))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1024))), char *) || __builtin_types_compatible_p(__typeof__(((1024))), const char *)) || __builtin_types_compatible_p(__typeof__((1024)), char [])) || (((__builtin_types_compatible_p(__typeof__(((1024))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1024))), signed char *) || __builtin_types_compatible_p(__typeof__(((1024))), const signed char *)) || __builtin_types_compatible_p(__typeof__((1024)), signed char [])) || (((__builtin_types_compatible_p(__typeof__(((1024))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1024))), unsigned char *) || __builtin_types_compatible_p(__typeof__(((1024))), const unsigned char *)) || __builtin_types_compatible_p(__typeof__((1024)), unsigned char [])))) _curl_easy_setopt_err_string(); if(((_curl_opt) == CURLOPT_HEADERFUNCTION || (_curl_opt) == CURLOPT_WRITEFUNCTION)) if(!(((__builtin_types_compatible_p(__typeof__(1024), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1024), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(1024), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((1024)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((1024)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((1024)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((1024)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((1024)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((1024)), _curl_read_callback6*))) || __builtin_types_compatible_p(__typeof__(1024), __typeof__(fwrite)) || __builtin_types_compatible_p(__typeof__(1024), curl_write_callback) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_write_callback1) || __builtin_types_compatible_p(__typeof__((1024)), _curl_write_callback1*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_write_callback2) || __builtin_types_compatible_p(__typeof__((1024)), _curl_write_callback2*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_write_callback3) || __builtin_types_compatible_p(__typeof__((1024)), _curl_write_callback3*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_write_callback4) || __builtin_types_compatible_p(__typeof__((1024)), _curl_write_callback4*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_write_callback5) || __builtin_types_compatible_p(__typeof__((1024)), _curl_write_callback5*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_write_callback6) || __builtin_types_compatible_p(__typeof__((1024)), _curl_write_callback6*)))) _curl_easy_setopt_err_write_callback(); if((_curl_opt) == CURLOPT_READFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1024), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1024), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(1024), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((1024)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((1024)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((1024)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((1024)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((1024)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((1024)), _curl_read_callback6*)))) _curl_easy_setopt_err_read_cb(); if((_curl_opt) == CURLOPT_IOCTLFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1024), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1024), curl_ioctl_callback) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_ioctl_callback1) || __builtin_types_compatible_p(__typeof__((1024)), _curl_ioctl_callback1*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_ioctl_callback2) || __builtin_types_compatible_p(__typeof__((1024)), _curl_ioctl_callback2*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_ioctl_callback3) || __builtin_types_compatible_p(__typeof__((1024)), _curl_ioctl_callback3*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_ioctl_callback4) || __builtin_types_compatible_p(__typeof__((1024)), _curl_ioctl_callback4*)))) _curl_easy_setopt_err_ioctl_cb(); if((_curl_opt) == CURLOPT_SOCKOPTFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1024), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1024), curl_sockopt_callback) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_sockopt_callback1) || __builtin_types_compatible_p(__typeof__((1024)), _curl_sockopt_callback1*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_sockopt_callback2) || __builtin_types_compatible_p(__typeof__((1024)), _curl_sockopt_callback2*)))) _curl_easy_setopt_err_sockopt_cb(); if((_curl_opt) == CURLOPT_OPENSOCKETFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1024), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1024), curl_opensocket_callback) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_opensocket_callback1) || __builtin_types_compatible_p(__typeof__((1024)), _curl_opensocket_callback1*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_opensocket_callback2) || __builtin_types_compatible_p(__typeof__((1024)), _curl_opensocket_callback2*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_opensocket_callback3) || __builtin_types_compatible_p(__typeof__((1024)), _curl_opensocket_callback3*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_opensocket_callback4) || __builtin_types_compatible_p(__typeof__((1024)), _curl_opensocket_callback4*)))) _curl_easy_setopt_err_opensocket_cb(); if((_curl_opt) == CURLOPT_PROGRESSFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1024), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1024), curl_progress_callback) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_progress_callback1) || __builtin_types_compatible_p(__typeof__((1024)), _curl_progress_callback1*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_progress_callback2) || __builtin_types_compatible_p(__typeof__((1024)), _curl_progress_callback2*)))) _curl_easy_setopt_err_progress_cb(); if((_curl_opt) == CURLOPT_DEBUGFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1024), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1024), curl_debug_callback) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_debug_callback1) || __builtin_types_compatible_p(__typeof__((1024)), _curl_debug_callback1*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_debug_callback2) || __builtin_types_compatible_p(__typeof__((1024)), _curl_debug_callback2*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_debug_callback3) || __builtin_types_compatible_p(__typeof__((1024)), _curl_debug_callback3*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_debug_callback4) || __builtin_types_compatible_p(__typeof__((1024)), _curl_debug_callback4*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_debug_callback5) || __builtin_types_compatible_p(__typeof__((1024)), _curl_debug_callback5*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_debug_callback6) || __builtin_types_compatible_p(__typeof__((1024)), _curl_debug_callback6*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_debug_callback7) || __builtin_types_compatible_p(__typeof__((1024)), _curl_debug_callback7*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_debug_callback8) || __builtin_types_compatible_p(__typeof__((1024)), _curl_debug_callback8*)))) _curl_easy_setopt_err_debug_cb(); if((_curl_opt) == CURLOPT_SSL_CTX_FUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1024), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1024), curl_ssl_ctx_callback) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_ssl_ctx_callback1) || __builtin_types_compatible_p(__typeof__((1024)), _curl_ssl_ctx_callback1*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_ssl_ctx_callback2) || __builtin_types_compatible_p(__typeof__((1024)), _curl_ssl_ctx_callback2*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_ssl_ctx_callback3) || __builtin_types_compatible_p(__typeof__((1024)), _curl_ssl_ctx_callback3*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_ssl_ctx_callback4) || __builtin_types_compatible_p(__typeof__((1024)), _curl_ssl_ctx_callback4*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_ssl_ctx_callback5) || __builtin_types_compatible_p(__typeof__((1024)), _curl_ssl_ctx_callback5*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_ssl_ctx_callback6) || __builtin_types_compatible_p(__typeof__((1024)), _curl_ssl_ctx_callback6*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_ssl_ctx_callback7) || __builtin_types_compatible_p(__typeof__((1024)), _curl_ssl_ctx_callback7*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_ssl_ctx_callback8) || __builtin_types_compatible_p(__typeof__((1024)), _curl_ssl_ctx_callback8*)))) _curl_easy_setopt_err_ssl_ctx_cb(); if(((_curl_opt) == CURLOPT_CONV_TO_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_UTF8_FUNCTION)) if(!((__builtin_types_compatible_p(__typeof__(1024), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1024), curl_conv_callback) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_conv_callback1) || __builtin_types_compatible_p(__typeof__((1024)), _curl_conv_callback1*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_conv_callback2) || __builtin_types_compatible_p(__typeof__((1024)), _curl_conv_callback2*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_conv_callback3) || __builtin_types_compatible_p(__typeof__((1024)), _curl_conv_callback3*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_conv_callback4) || __builtin_types_compatible_p(__typeof__((1024)), _curl_conv_callback4*)))) _curl_easy_setopt_err_conv_cb(); if((_curl_opt) == CURLOPT_SEEKFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1024), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1024), curl_seek_callback) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_seek_callback1) || __builtin_types_compatible_p(__typeof__((1024)), _curl_seek_callback1*)) || (__builtin_types_compatible_p(__typeof__((1024)), _curl_seek_callback2) || __builtin_types_compatible_p(__typeof__((1024)), _curl_seek_callback2*)))) _curl_easy_setopt_err_seek_cb(); if(((_curl_opt) == CURLOPT_FILE || (_curl_opt) == CURLOPT_INFILE || (_curl_opt) == CURLOPT_IOCTLDATA || (_curl_opt) == CURLOPT_SOCKOPTDATA || (_curl_opt) == CURLOPT_OPENSOCKETDATA || (_curl_opt) == CURLOPT_PROGRESSDATA || (_curl_opt) == CURLOPT_WRITEHEADER || (_curl_opt) == CURLOPT_DEBUGDATA || (_curl_opt) == CURLOPT_SSL_CTX_DATA || (_curl_opt) == CURLOPT_SEEKDATA || (_curl_opt) == CURLOPT_PRIVATE || (_curl_opt) == CURLOPT_SSH_KEYDATA || (_curl_opt) == CURLOPT_INTERLEAVEDATA || (_curl_opt) == CURLOPT_CHUNK_DATA || (_curl_opt) == CURLOPT_FNMATCH_DATA || 0)) if(!(sizeof(1024) == sizeof(void*))) _curl_easy_setopt_err_cb_data(); if((_curl_opt) == CURLOPT_ERRORBUFFER) if(!((__builtin_types_compatible_p(__typeof__(1024), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1024), char *) || __builtin_types_compatible_p(__typeof__(1024), char[]))) _curl_easy_setopt_err_error_buffer(); if((_curl_opt) == CURLOPT_STDERR) if(!(__builtin_types_compatible_p(__typeof__(1024), FILE *))) _curl_easy_setopt_err_FILE(); if(((_curl_opt) == CURLOPT_POSTFIELDS || (_curl_opt) == CURLOPT_COPYPOSTFIELDS || 0)) if(!(((__builtin_types_compatible_p(__typeof__((1024)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((1024)), void *) || __builtin_types_compatible_p(__typeof__((1024)), const void *)) || (((__builtin_types_compatible_p(__typeof__(((1024))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1024))), char *) || __builtin_types_compatible_p(__typeof__(((1024))), const char *)) || __builtin_types_compatible_p(__typeof__((1024)), char [])))) _curl_easy_setopt_err_postfields(); if((_curl_opt) == CURLOPT_HTTPPOST) if(!(((__builtin_types_compatible_p(__typeof__(((1024))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1024))), struct curl_httppost *) || __builtin_types_compatible_p(__typeof__(((1024))), const struct curl_httppost *)) || __builtin_types_compatible_p(__typeof__((1024)), struct curl_httppost []))) _curl_easy_setopt_err_curl_httpost(); if(((_curl_opt) == CURLOPT_HTTPHEADER || (_curl_opt) == CURLOPT_HTTP200ALIASES || (_curl_opt) == CURLOPT_QUOTE || (_curl_opt) == CURLOPT_POSTQUOTE || (_curl_opt) == CURLOPT_PREQUOTE || (_curl_opt) == CURLOPT_TELNETOPTIONS || (_curl_opt) == CURLOPT_MAIL_RCPT || 0)) if(!(((__builtin_types_compatible_p(__typeof__(((1024))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1024))), struct curl_slist *) || __builtin_types_compatible_p(__typeof__(((1024))), const struct curl_slist *)) || __builtin_types_compatible_p(__typeof__((1024)), struct curl_slist []))) _curl_easy_setopt_err_curl_slist(); if((_curl_opt) == CURLOPT_SHARE) if(!((__builtin_types_compatible_p(__typeof__((1024)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((1024)), CURLSH *) || __builtin_types_compatible_p(__typeof__((1024)), const CURLSH *))) _curl_easy_setopt_err_CURLSH(); } curl_easy_setopt(request->curl, _curl_opt, 1024); })) != CURLE_OK) { return S3StatusFailedToInitializeRequest; };
    if ((status = __extension__ ({ __typeof__ (CURLOPT_LOW_SPEED_TIME) _curl_opt = CURLOPT_LOW_SPEED_TIME; if(__builtin_constant_p(_curl_opt)) { if((0 < (_curl_opt) && (_curl_opt) < 10000)) if(!(__builtin_types_compatible_p(__typeof__(15), long) || __builtin_types_compatible_p(__typeof__(15), signed long) || __builtin_types_compatible_p(__typeof__(15), unsigned long) || __builtin_types_compatible_p(__typeof__(15), int) || __builtin_types_compatible_p(__typeof__(15), signed int) || __builtin_types_compatible_p(__typeof__(15), unsigned int) || __builtin_types_compatible_p(__typeof__(15), short) || __builtin_types_compatible_p(__typeof__(15), signed short) || __builtin_types_compatible_p(__typeof__(15), unsigned short) || __builtin_types_compatible_p(__typeof__(15), char) || __builtin_types_compatible_p(__typeof__(15), signed char) || __builtin_types_compatible_p(__typeof__(15), unsigned char))) _curl_easy_setopt_err_long(); if(((_curl_opt) > 30000)) if(!(__builtin_types_compatible_p(__typeof__(15), curl_off_t))) _curl_easy_setopt_err_curl_off_t(); if(((_curl_opt) == CURLOPT_URL || (_curl_opt) == CURLOPT_PROXY || (_curl_opt) == CURLOPT_INTERFACE || (_curl_opt) == CURLOPT_NETRC_FILE || (_curl_opt) == CURLOPT_USERPWD || (_curl_opt) == CURLOPT_USERNAME || (_curl_opt) == CURLOPT_PASSWORD || (_curl_opt) == CURLOPT_PROXYUSERPWD || (_curl_opt) == CURLOPT_PROXYUSERNAME || (_curl_opt) == CURLOPT_PROXYPASSWORD || (_curl_opt) == CURLOPT_NOPROXY || (_curl_opt) == CURLOPT_ACCEPT_ENCODING || (_curl_opt) == CURLOPT_REFERER || (_curl_opt) == CURLOPT_USERAGENT || (_curl_opt) == CURLOPT_COOKIE || (_curl_opt) == CURLOPT_COOKIEFILE || (_curl_opt) == CURLOPT_COOKIEJAR || (_curl_opt) == CURLOPT_COOKIELIST || (_curl_opt) == CURLOPT_FTPPORT || (_curl_opt) == CURLOPT_FTP_ALTERNATIVE_TO_USER || (_curl_opt) == CURLOPT_FTP_ACCOUNT || (_curl_opt) == CURLOPT_RANGE || (_curl_opt) == CURLOPT_CUSTOMREQUEST || (_curl_opt) == CURLOPT_SSLCERT || (_curl_opt) == CURLOPT_SSLCERTTYPE || (_curl_opt) == CURLOPT_SSLKEY || (_curl_opt) == CURLOPT_SSLKEYTYPE || (_curl_opt) == CURLOPT_KEYPASSWD || (_curl_opt) == CURLOPT_SSLENGINE || (_curl_opt) == CURLOPT_CAINFO || (_curl_opt) == CURLOPT_CAPATH || (_curl_opt) == CURLOPT_RANDOM_FILE || (_curl_opt) == CURLOPT_EGDSOCKET || (_curl_opt) == CURLOPT_SSL_CIPHER_LIST || (_curl_opt) == CURLOPT_KRBLEVEL || (_curl_opt) == CURLOPT_SSH_HOST_PUBLIC_KEY_MD5 || (_curl_opt) == CURLOPT_SSH_PUBLIC_KEYFILE || (_curl_opt) == CURLOPT_SSH_PRIVATE_KEYFILE || (_curl_opt) == CURLOPT_CRLFILE || (_curl_opt) == CURLOPT_ISSUERCERT || (_curl_opt) == CURLOPT_SOCKS5_GSSAPI_SERVICE || (_curl_opt) == CURLOPT_SSH_KNOWNHOSTS || (_curl_opt) == CURLOPT_MAIL_FROM || (_curl_opt) == CURLOPT_RTSP_SESSION_ID || (_curl_opt) == CURLOPT_RTSP_STREAM_URI || (_curl_opt) == CURLOPT_RTSP_TRANSPORT || 0)) if(!((((__builtin_types_compatible_p(__typeof__(((15))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((15))), char *) || __builtin_types_compatible_p(__typeof__(((15))), const char *)) || __builtin_types_compatible_p(__typeof__((15)), char [])) || (((__builtin_types_compatible_p(__typeof__(((15))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((15))), signed char *) || __builtin_types_compatible_p(__typeof__(((15))), const signed char *)) || __builtin_types_compatible_p(__typeof__((15)), signed char [])) || (((__builtin_types_compatible_p(__typeof__(((15))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((15))), unsigned char *) || __builtin_types_compatible_p(__typeof__(((15))), const unsigned char *)) || __builtin_types_compatible_p(__typeof__((15)), unsigned char [])))) _curl_easy_setopt_err_string(); if(((_curl_opt) == CURLOPT_HEADERFUNCTION || (_curl_opt) == CURLOPT_WRITEFUNCTION)) if(!(((__builtin_types_compatible_p(__typeof__(15), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(15), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(15), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((15)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((15)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((15)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((15)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((15)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((15)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((15)), _curl_read_callback6*))) || __builtin_types_compatible_p(__typeof__(15), __typeof__(fwrite)) || __builtin_types_compatible_p(__typeof__(15), curl_write_callback) || (__builtin_types_compatible_p(__typeof__((15)), _curl_write_callback1) || __builtin_types_compatible_p(__typeof__((15)), _curl_write_callback1*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_write_callback2) || __builtin_types_compatible_p(__typeof__((15)), _curl_write_callback2*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_write_callback3) || __builtin_types_compatible_p(__typeof__((15)), _curl_write_callback3*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_write_callback4) || __builtin_types_compatible_p(__typeof__((15)), _curl_write_callback4*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_write_callback5) || __builtin_types_compatible_p(__typeof__((15)), _curl_write_callback5*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_write_callback6) || __builtin_types_compatible_p(__typeof__((15)), _curl_write_callback6*)))) _curl_easy_setopt_err_write_callback(); if((_curl_opt) == CURLOPT_READFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(15), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(15), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(15), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((15)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((15)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((15)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((15)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((15)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((15)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((15)), _curl_read_callback6*)))) _curl_easy_setopt_err_read_cb(); if((_curl_opt) == CURLOPT_IOCTLFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(15), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(15), curl_ioctl_callback) || (__builtin_types_compatible_p(__typeof__((15)), _curl_ioctl_callback1) || __builtin_types_compatible_p(__typeof__((15)), _curl_ioctl_callback1*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_ioctl_callback2) || __builtin_types_compatible_p(__typeof__((15)), _curl_ioctl_callback2*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_ioctl_callback3) || __builtin_types_compatible_p(__typeof__((15)), _curl_ioctl_callback3*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_ioctl_callback4) || __builtin_types_compatible_p(__typeof__((15)), _curl_ioctl_callback4*)))) _curl_easy_setopt_err_ioctl_cb(); if((_curl_opt) == CURLOPT_SOCKOPTFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(15), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(15), curl_sockopt_callback) || (__builtin_types_compatible_p(__typeof__((15)), _curl_sockopt_callback1) || __builtin_types_compatible_p(__typeof__((15)), _curl_sockopt_callback1*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_sockopt_callback2) || __builtin_types_compatible_p(__typeof__((15)), _curl_sockopt_callback2*)))) _curl_easy_setopt_err_sockopt_cb(); if((_curl_opt) == CURLOPT_OPENSOCKETFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(15), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(15), curl_opensocket_callback) || (__builtin_types_compatible_p(__typeof__((15)), _curl_opensocket_callback1) || __builtin_types_compatible_p(__typeof__((15)), _curl_opensocket_callback1*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_opensocket_callback2) || __builtin_types_compatible_p(__typeof__((15)), _curl_opensocket_callback2*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_opensocket_callback3) || __builtin_types_compatible_p(__typeof__((15)), _curl_opensocket_callback3*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_opensocket_callback4) || __builtin_types_compatible_p(__typeof__((15)), _curl_opensocket_callback4*)))) _curl_easy_setopt_err_opensocket_cb(); if((_curl_opt) == CURLOPT_PROGRESSFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(15), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(15), curl_progress_callback) || (__builtin_types_compatible_p(__typeof__((15)), _curl_progress_callback1) || __builtin_types_compatible_p(__typeof__((15)), _curl_progress_callback1*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_progress_callback2) || __builtin_types_compatible_p(__typeof__((15)), _curl_progress_callback2*)))) _curl_easy_setopt_err_progress_cb(); if((_curl_opt) == CURLOPT_DEBUGFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(15), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(15), curl_debug_callback) || (__builtin_types_compatible_p(__typeof__((15)), _curl_debug_callback1) || __builtin_types_compatible_p(__typeof__((15)), _curl_debug_callback1*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_debug_callback2) || __builtin_types_compatible_p(__typeof__((15)), _curl_debug_callback2*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_debug_callback3) || __builtin_types_compatible_p(__typeof__((15)), _curl_debug_callback3*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_debug_callback4) || __builtin_types_compatible_p(__typeof__((15)), _curl_debug_callback4*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_debug_callback5) || __builtin_types_compatible_p(__typeof__((15)), _curl_debug_callback5*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_debug_callback6) || __builtin_types_compatible_p(__typeof__((15)), _curl_debug_callback6*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_debug_callback7) || __builtin_types_compatible_p(__typeof__((15)), _curl_debug_callback7*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_debug_callback8) || __builtin_types_compatible_p(__typeof__((15)), _curl_debug_callback8*)))) _curl_easy_setopt_err_debug_cb(); if((_curl_opt) == CURLOPT_SSL_CTX_FUNCTION) if(!((__builtin_types_compatible_p(__typeof__(15), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(15), curl_ssl_ctx_callback) || (__builtin_types_compatible_p(__typeof__((15)), _curl_ssl_ctx_callback1) || __builtin_types_compatible_p(__typeof__((15)), _curl_ssl_ctx_callback1*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_ssl_ctx_callback2) || __builtin_types_compatible_p(__typeof__((15)), _curl_ssl_ctx_callback2*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_ssl_ctx_callback3) || __builtin_types_compatible_p(__typeof__((15)), _curl_ssl_ctx_callback3*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_ssl_ctx_callback4) || __builtin_types_compatible_p(__typeof__((15)), _curl_ssl_ctx_callback4*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_ssl_ctx_callback5) || __builtin_types_compatible_p(__typeof__((15)), _curl_ssl_ctx_callback5*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_ssl_ctx_callback6) || __builtin_types_compatible_p(__typeof__((15)), _curl_ssl_ctx_callback6*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_ssl_ctx_callback7) || __builtin_types_compatible_p(__typeof__((15)), _curl_ssl_ctx_callback7*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_ssl_ctx_callback8) || __builtin_types_compatible_p(__typeof__((15)), _curl_ssl_ctx_callback8*)))) _curl_easy_setopt_err_ssl_ctx_cb(); if(((_curl_opt) == CURLOPT_CONV_TO_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_UTF8_FUNCTION)) if(!((__builtin_types_compatible_p(__typeof__(15), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(15), curl_conv_callback) || (__builtin_types_compatible_p(__typeof__((15)), _curl_conv_callback1) || __builtin_types_compatible_p(__typeof__((15)), _curl_conv_callback1*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_conv_callback2) || __builtin_types_compatible_p(__typeof__((15)), _curl_conv_callback2*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_conv_callback3) || __builtin_types_compatible_p(__typeof__((15)), _curl_conv_callback3*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_conv_callback4) || __builtin_types_compatible_p(__typeof__((15)), _curl_conv_callback4*)))) _curl_easy_setopt_err_conv_cb(); if((_curl_opt) == CURLOPT_SEEKFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(15), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(15), curl_seek_callback) || (__builtin_types_compatible_p(__typeof__((15)), _curl_seek_callback1) || __builtin_types_compatible_p(__typeof__((15)), _curl_seek_callback1*)) || (__builtin_types_compatible_p(__typeof__((15)), _curl_seek_callback2) || __builtin_types_compatible_p(__typeof__((15)), _curl_seek_callback2*)))) _curl_easy_setopt_err_seek_cb(); if(((_curl_opt) == CURLOPT_FILE || (_curl_opt) == CURLOPT_INFILE || (_curl_opt) == CURLOPT_IOCTLDATA || (_curl_opt) == CURLOPT_SOCKOPTDATA || (_curl_opt) == CURLOPT_OPENSOCKETDATA || (_curl_opt) == CURLOPT_PROGRESSDATA || (_curl_opt) == CURLOPT_WRITEHEADER || (_curl_opt) == CURLOPT_DEBUGDATA || (_curl_opt) == CURLOPT_SSL_CTX_DATA || (_curl_opt) == CURLOPT_SEEKDATA || (_curl_opt) == CURLOPT_PRIVATE || (_curl_opt) == CURLOPT_SSH_KEYDATA || (_curl_opt) == CURLOPT_INTERLEAVEDATA || (_curl_opt) == CURLOPT_CHUNK_DATA || (_curl_opt) == CURLOPT_FNMATCH_DATA || 0)) if(!(sizeof(15) == sizeof(void*))) _curl_easy_setopt_err_cb_data(); if((_curl_opt) == CURLOPT_ERRORBUFFER) if(!((__builtin_types_compatible_p(__typeof__(15), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(15), char *) || __builtin_types_compatible_p(__typeof__(15), char[]))) _curl_easy_setopt_err_error_buffer(); if((_curl_opt) == CURLOPT_STDERR) if(!(__builtin_types_compatible_p(__typeof__(15), FILE *))) _curl_easy_setopt_err_FILE(); if(((_curl_opt) == CURLOPT_POSTFIELDS || (_curl_opt) == CURLOPT_COPYPOSTFIELDS || 0)) if(!(((__builtin_types_compatible_p(__typeof__((15)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((15)), void *) || __builtin_types_compatible_p(__typeof__((15)), const void *)) || (((__builtin_types_compatible_p(__typeof__(((15))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((15))), char *) || __builtin_types_compatible_p(__typeof__(((15))), const char *)) || __builtin_types_compatible_p(__typeof__((15)), char [])))) _curl_easy_setopt_err_postfields(); if((_curl_opt) == CURLOPT_HTTPPOST) if(!(((__builtin_types_compatible_p(__typeof__(((15))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((15))), struct curl_httppost *) || __builtin_types_compatible_p(__typeof__(((15))), const struct curl_httppost *)) || __builtin_types_compatible_p(__typeof__((15)), struct curl_httppost []))) _curl_easy_setopt_err_curl_httpost(); if(((_curl_opt) == CURLOPT_HTTPHEADER || (_curl_opt) == CURLOPT_HTTP200ALIASES || (_curl_opt) == CURLOPT_QUOTE || (_curl_opt) == CURLOPT_POSTQUOTE || (_curl_opt) == CURLOPT_PREQUOTE || (_curl_opt) == CURLOPT_TELNETOPTIONS || (_curl_opt) == CURLOPT_MAIL_RCPT || 0)) if(!(((__builtin_types_compatible_p(__typeof__(((15))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((15))), struct curl_slist *) || __builtin_types_compatible_p(__typeof__(((15))), const struct curl_slist *)) || __builtin_types_compatible_p(__typeof__((15)), struct curl_slist []))) _curl_easy_setopt_err_curl_slist(); if((_curl_opt) == CURLOPT_SHARE) if(!((__builtin_types_compatible_p(__typeof__((15)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((15)), CURLSH *) || __builtin_types_compatible_p(__typeof__((15)), const CURLSH *))) _curl_easy_setopt_err_CURLSH(); } curl_easy_setopt(request->curl, _curl_opt, 15); })) != CURLE_OK) { return S3StatusFailedToInitializeRequest; };
# 881 "./src/request.c"
    if (params->httpRequestType == HttpRequestTypePUT) {
        char header[256];
        snprintf(header, sizeof(header), "Content-Length: %llu",
                 (unsigned long long) params->toS3CallbackTotalSize);
        request->headers = curl_slist_append(request->headers, header);
        request->headers = curl_slist_append(request->headers,
                                             "Transfer-Encoding:");
    }
    else if (params->httpRequestType == HttpRequestTypeCOPY) {
        request->headers = curl_slist_append(request->headers,
                                             "Transfer-Encoding:");
    }

    if (values-> cacheControlHeader [0]) { request->headers = curl_slist_append(request->headers, values-> cacheControlHeader); };
    if (values-> contentTypeHeader [0]) { request->headers = curl_slist_append(request->headers, values-> contentTypeHeader); };
    if (values-> md5Header [0]) { request->headers = curl_slist_append(request->headers, values-> md5Header); };
    if (values-> contentDispositionHeader [0]) { request->headers = curl_slist_append(request->headers, values-> contentDispositionHeader); };
    if (values-> contentEncodingHeader [0]) { request->headers = curl_slist_append(request->headers, values-> contentEncodingHeader); };
    if (values-> expiresHeader [0]) { request->headers = curl_slist_append(request->headers, values-> expiresHeader); };
    if (values-> ifModifiedSinceHeader [0]) { request->headers = curl_slist_append(request->headers, values-> ifModifiedSinceHeader); };
    if (values-> ifUnmodifiedSinceHeader [0]) { request->headers = curl_slist_append(request->headers, values-> ifUnmodifiedSinceHeader); };
    if (values-> ifMatchHeader [0]) { request->headers = curl_slist_append(request->headers, values-> ifMatchHeader); };
    if (values-> ifNoneMatchHeader [0]) { request->headers = curl_slist_append(request->headers, values-> ifNoneMatchHeader); };
    if (values-> rangeHeader [0]) { request->headers = curl_slist_append(request->headers, values-> rangeHeader); };
    if (values-> authorizationHeader [0]) { request->headers = curl_slist_append(request->headers, values-> authorizationHeader); };


    int i;
    for (i = 0; i < values->amzHeadersCount; i++) {
        request->headers =
            curl_slist_append(request->headers, values->amzHeaders[i]);
    }


    if ((status = __extension__ ({ __typeof__ (CURLOPT_HTTPHEADER) _curl_opt = CURLOPT_HTTPHEADER; if(__builtin_constant_p(_curl_opt)) { if((0 < (_curl_opt) && (_curl_opt) < 10000)) if(!(__builtin_types_compatible_p(__typeof__(request->headers), long) || __builtin_types_compatible_p(__typeof__(request->headers), signed long) || __builtin_types_compatible_p(__typeof__(request->headers), unsigned long) || __builtin_types_compatible_p(__typeof__(request->headers), int) || __builtin_types_compatible_p(__typeof__(request->headers), signed int) || __builtin_types_compatible_p(__typeof__(request->headers), unsigned int) || __builtin_types_compatible_p(__typeof__(request->headers), short) || __builtin_types_compatible_p(__typeof__(request->headers), signed short) || __builtin_types_compatible_p(__typeof__(request->headers), unsigned short) || __builtin_types_compatible_p(__typeof__(request->headers), char) || __builtin_types_compatible_p(__typeof__(request->headers), signed char) || __builtin_types_compatible_p(__typeof__(request->headers), unsigned char))) _curl_easy_setopt_err_long(); if(((_curl_opt) > 30000)) if(!(__builtin_types_compatible_p(__typeof__(request->headers), curl_off_t))) _curl_easy_setopt_err_curl_off_t(); if(((_curl_opt) == CURLOPT_URL || (_curl_opt) == CURLOPT_PROXY || (_curl_opt) == CURLOPT_INTERFACE || (_curl_opt) == CURLOPT_NETRC_FILE || (_curl_opt) == CURLOPT_USERPWD || (_curl_opt) == CURLOPT_USERNAME || (_curl_opt) == CURLOPT_PASSWORD || (_curl_opt) == CURLOPT_PROXYUSERPWD || (_curl_opt) == CURLOPT_PROXYUSERNAME || (_curl_opt) == CURLOPT_PROXYPASSWORD || (_curl_opt) == CURLOPT_NOPROXY || (_curl_opt) == CURLOPT_ACCEPT_ENCODING || (_curl_opt) == CURLOPT_REFERER || (_curl_opt) == CURLOPT_USERAGENT || (_curl_opt) == CURLOPT_COOKIE || (_curl_opt) == CURLOPT_COOKIEFILE || (_curl_opt) == CURLOPT_COOKIEJAR || (_curl_opt) == CURLOPT_COOKIELIST || (_curl_opt) == CURLOPT_FTPPORT || (_curl_opt) == CURLOPT_FTP_ALTERNATIVE_TO_USER || (_curl_opt) == CURLOPT_FTP_ACCOUNT || (_curl_opt) == CURLOPT_RANGE || (_curl_opt) == CURLOPT_CUSTOMREQUEST || (_curl_opt) == CURLOPT_SSLCERT || (_curl_opt) == CURLOPT_SSLCERTTYPE || (_curl_opt) == CURLOPT_SSLKEY || (_curl_opt) == CURLOPT_SSLKEYTYPE || (_curl_opt) == CURLOPT_KEYPASSWD || (_curl_opt) == CURLOPT_SSLENGINE || (_curl_opt) == CURLOPT_CAINFO || (_curl_opt) == CURLOPT_CAPATH || (_curl_opt) == CURLOPT_RANDOM_FILE || (_curl_opt) == CURLOPT_EGDSOCKET || (_curl_opt) == CURLOPT_SSL_CIPHER_LIST || (_curl_opt) == CURLOPT_KRBLEVEL || (_curl_opt) == CURLOPT_SSH_HOST_PUBLIC_KEY_MD5 || (_curl_opt) == CURLOPT_SSH_PUBLIC_KEYFILE || (_curl_opt) == CURLOPT_SSH_PRIVATE_KEYFILE || (_curl_opt) == CURLOPT_CRLFILE || (_curl_opt) == CURLOPT_ISSUERCERT || (_curl_opt) == CURLOPT_SOCKS5_GSSAPI_SERVICE || (_curl_opt) == CURLOPT_SSH_KNOWNHOSTS || (_curl_opt) == CURLOPT_MAIL_FROM || (_curl_opt) == CURLOPT_RTSP_SESSION_ID || (_curl_opt) == CURLOPT_RTSP_STREAM_URI || (_curl_opt) == CURLOPT_RTSP_TRANSPORT || 0)) if(!((((__builtin_types_compatible_p(__typeof__(((request->headers))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((request->headers))), char *) || __builtin_types_compatible_p(__typeof__(((request->headers))), const char *)) || __builtin_types_compatible_p(__typeof__((request->headers)), char [])) || (((__builtin_types_compatible_p(__typeof__(((request->headers))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((request->headers))), signed char *) || __builtin_types_compatible_p(__typeof__(((request->headers))), const signed char *)) || __builtin_types_compatible_p(__typeof__((request->headers)), signed char [])) || (((__builtin_types_compatible_p(__typeof__(((request->headers))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((request->headers))), unsigned char *) || __builtin_types_compatible_p(__typeof__(((request->headers))), const unsigned char *)) || __builtin_types_compatible_p(__typeof__((request->headers)), unsigned char [])))) _curl_easy_setopt_err_string(); if(((_curl_opt) == CURLOPT_HEADERFUNCTION || (_curl_opt) == CURLOPT_WRITEFUNCTION)) if(!(((__builtin_types_compatible_p(__typeof__(request->headers), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request->headers), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(request->headers), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_read_callback6*))) || __builtin_types_compatible_p(__typeof__(request->headers), __typeof__(fwrite)) || __builtin_types_compatible_p(__typeof__(request->headers), curl_write_callback) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_write_callback1) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_write_callback1*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_write_callback2) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_write_callback2*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_write_callback3) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_write_callback3*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_write_callback4) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_write_callback4*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_write_callback5) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_write_callback5*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_write_callback6) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_write_callback6*)))) _curl_easy_setopt_err_write_callback(); if((_curl_opt) == CURLOPT_READFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request->headers), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request->headers), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(request->headers), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_read_callback6*)))) _curl_easy_setopt_err_read_cb(); if((_curl_opt) == CURLOPT_IOCTLFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request->headers), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request->headers), curl_ioctl_callback) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_ioctl_callback1) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_ioctl_callback1*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_ioctl_callback2) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_ioctl_callback2*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_ioctl_callback3) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_ioctl_callback3*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_ioctl_callback4) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_ioctl_callback4*)))) _curl_easy_setopt_err_ioctl_cb(); if((_curl_opt) == CURLOPT_SOCKOPTFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request->headers), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request->headers), curl_sockopt_callback) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_sockopt_callback1) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_sockopt_callback1*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_sockopt_callback2) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_sockopt_callback2*)))) _curl_easy_setopt_err_sockopt_cb(); if((_curl_opt) == CURLOPT_OPENSOCKETFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request->headers), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request->headers), curl_opensocket_callback) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_opensocket_callback1) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_opensocket_callback1*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_opensocket_callback2) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_opensocket_callback2*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_opensocket_callback3) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_opensocket_callback3*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_opensocket_callback4) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_opensocket_callback4*)))) _curl_easy_setopt_err_opensocket_cb(); if((_curl_opt) == CURLOPT_PROGRESSFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request->headers), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request->headers), curl_progress_callback) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_progress_callback1) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_progress_callback1*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_progress_callback2) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_progress_callback2*)))) _curl_easy_setopt_err_progress_cb(); if((_curl_opt) == CURLOPT_DEBUGFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request->headers), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request->headers), curl_debug_callback) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_debug_callback1) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_debug_callback1*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_debug_callback2) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_debug_callback2*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_debug_callback3) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_debug_callback3*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_debug_callback4) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_debug_callback4*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_debug_callback5) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_debug_callback5*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_debug_callback6) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_debug_callback6*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_debug_callback7) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_debug_callback7*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_debug_callback8) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_debug_callback8*)))) _curl_easy_setopt_err_debug_cb(); if((_curl_opt) == CURLOPT_SSL_CTX_FUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request->headers), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request->headers), curl_ssl_ctx_callback) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_ssl_ctx_callback1) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_ssl_ctx_callback1*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_ssl_ctx_callback2) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_ssl_ctx_callback2*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_ssl_ctx_callback3) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_ssl_ctx_callback3*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_ssl_ctx_callback4) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_ssl_ctx_callback4*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_ssl_ctx_callback5) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_ssl_ctx_callback5*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_ssl_ctx_callback6) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_ssl_ctx_callback6*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_ssl_ctx_callback7) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_ssl_ctx_callback7*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_ssl_ctx_callback8) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_ssl_ctx_callback8*)))) _curl_easy_setopt_err_ssl_ctx_cb(); if(((_curl_opt) == CURLOPT_CONV_TO_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_UTF8_FUNCTION)) if(!((__builtin_types_compatible_p(__typeof__(request->headers), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request->headers), curl_conv_callback) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_conv_callback1) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_conv_callback1*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_conv_callback2) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_conv_callback2*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_conv_callback3) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_conv_callback3*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_conv_callback4) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_conv_callback4*)))) _curl_easy_setopt_err_conv_cb(); if((_curl_opt) == CURLOPT_SEEKFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request->headers), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request->headers), curl_seek_callback) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_seek_callback1) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_seek_callback1*)) || (__builtin_types_compatible_p(__typeof__((request->headers)), _curl_seek_callback2) || __builtin_types_compatible_p(__typeof__((request->headers)), _curl_seek_callback2*)))) _curl_easy_setopt_err_seek_cb(); if(((_curl_opt) == CURLOPT_FILE || (_curl_opt) == CURLOPT_INFILE || (_curl_opt) == CURLOPT_IOCTLDATA || (_curl_opt) == CURLOPT_SOCKOPTDATA || (_curl_opt) == CURLOPT_OPENSOCKETDATA || (_curl_opt) == CURLOPT_PROGRESSDATA || (_curl_opt) == CURLOPT_WRITEHEADER || (_curl_opt) == CURLOPT_DEBUGDATA || (_curl_opt) == CURLOPT_SSL_CTX_DATA || (_curl_opt) == CURLOPT_SEEKDATA || (_curl_opt) == CURLOPT_PRIVATE || (_curl_opt) == CURLOPT_SSH_KEYDATA || (_curl_opt) == CURLOPT_INTERLEAVEDATA || (_curl_opt) == CURLOPT_CHUNK_DATA || (_curl_opt) == CURLOPT_FNMATCH_DATA || 0)) if(!(sizeof(request->headers) == sizeof(void*))) _curl_easy_setopt_err_cb_data(); if((_curl_opt) == CURLOPT_ERRORBUFFER) if(!((__builtin_types_compatible_p(__typeof__(request->headers), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request->headers), char *) || __builtin_types_compatible_p(__typeof__(request->headers), char[]))) _curl_easy_setopt_err_error_buffer(); if((_curl_opt) == CURLOPT_STDERR) if(!(__builtin_types_compatible_p(__typeof__(request->headers), FILE *))) _curl_easy_setopt_err_FILE(); if(((_curl_opt) == CURLOPT_POSTFIELDS || (_curl_opt) == CURLOPT_COPYPOSTFIELDS || 0)) if(!(((__builtin_types_compatible_p(__typeof__((request->headers)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((request->headers)), void *) || __builtin_types_compatible_p(__typeof__((request->headers)), const void *)) || (((__builtin_types_compatible_p(__typeof__(((request->headers))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((request->headers))), char *) || __builtin_types_compatible_p(__typeof__(((request->headers))), const char *)) || __builtin_types_compatible_p(__typeof__((request->headers)), char [])))) _curl_easy_setopt_err_postfields(); if((_curl_opt) == CURLOPT_HTTPPOST) if(!(((__builtin_types_compatible_p(__typeof__(((request->headers))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((request->headers))), struct curl_httppost *) || __builtin_types_compatible_p(__typeof__(((request->headers))), const struct curl_httppost *)) || __builtin_types_compatible_p(__typeof__((request->headers)), struct curl_httppost []))) _curl_easy_setopt_err_curl_httpost(); if(((_curl_opt) == CURLOPT_HTTPHEADER || (_curl_opt) == CURLOPT_HTTP200ALIASES || (_curl_opt) == CURLOPT_QUOTE || (_curl_opt) == CURLOPT_POSTQUOTE || (_curl_opt) == CURLOPT_PREQUOTE || (_curl_opt) == CURLOPT_TELNETOPTIONS || (_curl_opt) == CURLOPT_MAIL_RCPT || 0)) if(!(((__builtin_types_compatible_p(__typeof__(((request->headers))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((request->headers))), struct curl_slist *) || __builtin_types_compatible_p(__typeof__(((request->headers))), const struct curl_slist *)) || __builtin_types_compatible_p(__typeof__((request->headers)), struct curl_slist []))) _curl_easy_setopt_err_curl_slist(); if((_curl_opt) == CURLOPT_SHARE) if(!((__builtin_types_compatible_p(__typeof__((request->headers)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((request->headers)), CURLSH *) || __builtin_types_compatible_p(__typeof__((request->headers)), const CURLSH *))) _curl_easy_setopt_err_CURLSH(); } curl_easy_setopt(request->curl, _curl_opt, request->headers); })) != CURLE_OK) { return S3StatusFailedToInitializeRequest; };


    if ((status = __extension__ ({ __typeof__ (CURLOPT_URL) _curl_opt = CURLOPT_URL; if(__builtin_constant_p(_curl_opt)) { if((0 < (_curl_opt) && (_curl_opt) < 10000)) if(!(__builtin_types_compatible_p(__typeof__(request->uri), long) || __builtin_types_compatible_p(__typeof__(request->uri), signed long) || __builtin_types_compatible_p(__typeof__(request->uri), unsigned long) || __builtin_types_compatible_p(__typeof__(request->uri), int) || __builtin_types_compatible_p(__typeof__(request->uri), signed int) || __builtin_types_compatible_p(__typeof__(request->uri), unsigned int) || __builtin_types_compatible_p(__typeof__(request->uri), short) || __builtin_types_compatible_p(__typeof__(request->uri), signed short) || __builtin_types_compatible_p(__typeof__(request->uri), unsigned short) || __builtin_types_compatible_p(__typeof__(request->uri), char) || __builtin_types_compatible_p(__typeof__(request->uri), signed char) || __builtin_types_compatible_p(__typeof__(request->uri), unsigned char))) _curl_easy_setopt_err_long(); if(((_curl_opt) > 30000)) if(!(__builtin_types_compatible_p(__typeof__(request->uri), curl_off_t))) _curl_easy_setopt_err_curl_off_t(); if(((_curl_opt) == CURLOPT_URL || (_curl_opt) == CURLOPT_PROXY || (_curl_opt) == CURLOPT_INTERFACE || (_curl_opt) == CURLOPT_NETRC_FILE || (_curl_opt) == CURLOPT_USERPWD || (_curl_opt) == CURLOPT_USERNAME || (_curl_opt) == CURLOPT_PASSWORD || (_curl_opt) == CURLOPT_PROXYUSERPWD || (_curl_opt) == CURLOPT_PROXYUSERNAME || (_curl_opt) == CURLOPT_PROXYPASSWORD || (_curl_opt) == CURLOPT_NOPROXY || (_curl_opt) == CURLOPT_ACCEPT_ENCODING || (_curl_opt) == CURLOPT_REFERER || (_curl_opt) == CURLOPT_USERAGENT || (_curl_opt) == CURLOPT_COOKIE || (_curl_opt) == CURLOPT_COOKIEFILE || (_curl_opt) == CURLOPT_COOKIEJAR || (_curl_opt) == CURLOPT_COOKIELIST || (_curl_opt) == CURLOPT_FTPPORT || (_curl_opt) == CURLOPT_FTP_ALTERNATIVE_TO_USER || (_curl_opt) == CURLOPT_FTP_ACCOUNT || (_curl_opt) == CURLOPT_RANGE || (_curl_opt) == CURLOPT_CUSTOMREQUEST || (_curl_opt) == CURLOPT_SSLCERT || (_curl_opt) == CURLOPT_SSLCERTTYPE || (_curl_opt) == CURLOPT_SSLKEY || (_curl_opt) == CURLOPT_SSLKEYTYPE || (_curl_opt) == CURLOPT_KEYPASSWD || (_curl_opt) == CURLOPT_SSLENGINE || (_curl_opt) == CURLOPT_CAINFO || (_curl_opt) == CURLOPT_CAPATH || (_curl_opt) == CURLOPT_RANDOM_FILE || (_curl_opt) == CURLOPT_EGDSOCKET || (_curl_opt) == CURLOPT_SSL_CIPHER_LIST || (_curl_opt) == CURLOPT_KRBLEVEL || (_curl_opt) == CURLOPT_SSH_HOST_PUBLIC_KEY_MD5 || (_curl_opt) == CURLOPT_SSH_PUBLIC_KEYFILE || (_curl_opt) == CURLOPT_SSH_PRIVATE_KEYFILE || (_curl_opt) == CURLOPT_CRLFILE || (_curl_opt) == CURLOPT_ISSUERCERT || (_curl_opt) == CURLOPT_SOCKS5_GSSAPI_SERVICE || (_curl_opt) == CURLOPT_SSH_KNOWNHOSTS || (_curl_opt) == CURLOPT_MAIL_FROM || (_curl_opt) == CURLOPT_RTSP_SESSION_ID || (_curl_opt) == CURLOPT_RTSP_STREAM_URI || (_curl_opt) == CURLOPT_RTSP_TRANSPORT || 0)) if(!((((__builtin_types_compatible_p(__typeof__(((request->uri))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((request->uri))), char *) || __builtin_types_compatible_p(__typeof__(((request->uri))), const char *)) || __builtin_types_compatible_p(__typeof__((request->uri)), char [])) || (((__builtin_types_compatible_p(__typeof__(((request->uri))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((request->uri))), signed char *) || __builtin_types_compatible_p(__typeof__(((request->uri))), const signed char *)) || __builtin_types_compatible_p(__typeof__((request->uri)), signed char [])) || (((__builtin_types_compatible_p(__typeof__(((request->uri))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((request->uri))), unsigned char *) || __builtin_types_compatible_p(__typeof__(((request->uri))), const unsigned char *)) || __builtin_types_compatible_p(__typeof__((request->uri)), unsigned char [])))) _curl_easy_setopt_err_string(); if(((_curl_opt) == CURLOPT_HEADERFUNCTION || (_curl_opt) == CURLOPT_WRITEFUNCTION)) if(!(((__builtin_types_compatible_p(__typeof__(request->uri), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request->uri), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(request->uri), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_read_callback6*))) || __builtin_types_compatible_p(__typeof__(request->uri), __typeof__(fwrite)) || __builtin_types_compatible_p(__typeof__(request->uri), curl_write_callback) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_write_callback1) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_write_callback1*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_write_callback2) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_write_callback2*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_write_callback3) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_write_callback3*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_write_callback4) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_write_callback4*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_write_callback5) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_write_callback5*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_write_callback6) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_write_callback6*)))) _curl_easy_setopt_err_write_callback(); if((_curl_opt) == CURLOPT_READFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request->uri), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request->uri), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(request->uri), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_read_callback6*)))) _curl_easy_setopt_err_read_cb(); if((_curl_opt) == CURLOPT_IOCTLFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request->uri), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request->uri), curl_ioctl_callback) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_ioctl_callback1) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_ioctl_callback1*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_ioctl_callback2) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_ioctl_callback2*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_ioctl_callback3) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_ioctl_callback3*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_ioctl_callback4) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_ioctl_callback4*)))) _curl_easy_setopt_err_ioctl_cb(); if((_curl_opt) == CURLOPT_SOCKOPTFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request->uri), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request->uri), curl_sockopt_callback) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_sockopt_callback1) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_sockopt_callback1*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_sockopt_callback2) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_sockopt_callback2*)))) _curl_easy_setopt_err_sockopt_cb(); if((_curl_opt) == CURLOPT_OPENSOCKETFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request->uri), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request->uri), curl_opensocket_callback) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_opensocket_callback1) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_opensocket_callback1*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_opensocket_callback2) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_opensocket_callback2*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_opensocket_callback3) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_opensocket_callback3*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_opensocket_callback4) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_opensocket_callback4*)))) _curl_easy_setopt_err_opensocket_cb(); if((_curl_opt) == CURLOPT_PROGRESSFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request->uri), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request->uri), curl_progress_callback) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_progress_callback1) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_progress_callback1*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_progress_callback2) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_progress_callback2*)))) _curl_easy_setopt_err_progress_cb(); if((_curl_opt) == CURLOPT_DEBUGFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request->uri), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request->uri), curl_debug_callback) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_debug_callback1) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_debug_callback1*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_debug_callback2) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_debug_callback2*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_debug_callback3) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_debug_callback3*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_debug_callback4) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_debug_callback4*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_debug_callback5) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_debug_callback5*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_debug_callback6) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_debug_callback6*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_debug_callback7) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_debug_callback7*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_debug_callback8) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_debug_callback8*)))) _curl_easy_setopt_err_debug_cb(); if((_curl_opt) == CURLOPT_SSL_CTX_FUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request->uri), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request->uri), curl_ssl_ctx_callback) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_ssl_ctx_callback1) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_ssl_ctx_callback1*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_ssl_ctx_callback2) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_ssl_ctx_callback2*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_ssl_ctx_callback3) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_ssl_ctx_callback3*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_ssl_ctx_callback4) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_ssl_ctx_callback4*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_ssl_ctx_callback5) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_ssl_ctx_callback5*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_ssl_ctx_callback6) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_ssl_ctx_callback6*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_ssl_ctx_callback7) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_ssl_ctx_callback7*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_ssl_ctx_callback8) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_ssl_ctx_callback8*)))) _curl_easy_setopt_err_ssl_ctx_cb(); if(((_curl_opt) == CURLOPT_CONV_TO_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_UTF8_FUNCTION)) if(!((__builtin_types_compatible_p(__typeof__(request->uri), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request->uri), curl_conv_callback) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_conv_callback1) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_conv_callback1*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_conv_callback2) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_conv_callback2*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_conv_callback3) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_conv_callback3*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_conv_callback4) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_conv_callback4*)))) _curl_easy_setopt_err_conv_cb(); if((_curl_opt) == CURLOPT_SEEKFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(request->uri), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request->uri), curl_seek_callback) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_seek_callback1) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_seek_callback1*)) || (__builtin_types_compatible_p(__typeof__((request->uri)), _curl_seek_callback2) || __builtin_types_compatible_p(__typeof__((request->uri)), _curl_seek_callback2*)))) _curl_easy_setopt_err_seek_cb(); if(((_curl_opt) == CURLOPT_FILE || (_curl_opt) == CURLOPT_INFILE || (_curl_opt) == CURLOPT_IOCTLDATA || (_curl_opt) == CURLOPT_SOCKOPTDATA || (_curl_opt) == CURLOPT_OPENSOCKETDATA || (_curl_opt) == CURLOPT_PROGRESSDATA || (_curl_opt) == CURLOPT_WRITEHEADER || (_curl_opt) == CURLOPT_DEBUGDATA || (_curl_opt) == CURLOPT_SSL_CTX_DATA || (_curl_opt) == CURLOPT_SEEKDATA || (_curl_opt) == CURLOPT_PRIVATE || (_curl_opt) == CURLOPT_SSH_KEYDATA || (_curl_opt) == CURLOPT_INTERLEAVEDATA || (_curl_opt) == CURLOPT_CHUNK_DATA || (_curl_opt) == CURLOPT_FNMATCH_DATA || 0)) if(!(sizeof(request->uri) == sizeof(void*))) _curl_easy_setopt_err_cb_data(); if((_curl_opt) == CURLOPT_ERRORBUFFER) if(!((__builtin_types_compatible_p(__typeof__(request->uri), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(request->uri), char *) || __builtin_types_compatible_p(__typeof__(request->uri), char[]))) _curl_easy_setopt_err_error_buffer(); if((_curl_opt) == CURLOPT_STDERR) if(!(__builtin_types_compatible_p(__typeof__(request->uri), FILE *))) _curl_easy_setopt_err_FILE(); if(((_curl_opt) == CURLOPT_POSTFIELDS || (_curl_opt) == CURLOPT_COPYPOSTFIELDS || 0)) if(!(((__builtin_types_compatible_p(__typeof__((request->uri)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((request->uri)), void *) || __builtin_types_compatible_p(__typeof__((request->uri)), const void *)) || (((__builtin_types_compatible_p(__typeof__(((request->uri))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((request->uri))), char *) || __builtin_types_compatible_p(__typeof__(((request->uri))), const char *)) || __builtin_types_compatible_p(__typeof__((request->uri)), char [])))) _curl_easy_setopt_err_postfields(); if((_curl_opt) == CURLOPT_HTTPPOST) if(!(((__builtin_types_compatible_p(__typeof__(((request->uri))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((request->uri))), struct curl_httppost *) || __builtin_types_compatible_p(__typeof__(((request->uri))), const struct curl_httppost *)) || __builtin_types_compatible_p(__typeof__((request->uri)), struct curl_httppost []))) _curl_easy_setopt_err_curl_httpost(); if(((_curl_opt) == CURLOPT_HTTPHEADER || (_curl_opt) == CURLOPT_HTTP200ALIASES || (_curl_opt) == CURLOPT_QUOTE || (_curl_opt) == CURLOPT_POSTQUOTE || (_curl_opt) == CURLOPT_PREQUOTE || (_curl_opt) == CURLOPT_TELNETOPTIONS || (_curl_opt) == CURLOPT_MAIL_RCPT || 0)) if(!(((__builtin_types_compatible_p(__typeof__(((request->uri))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((request->uri))), struct curl_slist *) || __builtin_types_compatible_p(__typeof__(((request->uri))), const struct curl_slist *)) || __builtin_types_compatible_p(__typeof__((request->uri)), struct curl_slist []))) _curl_easy_setopt_err_curl_slist(); if((_curl_opt) == CURLOPT_SHARE) if(!((__builtin_types_compatible_p(__typeof__((request->uri)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((request->uri)), CURLSH *) || __builtin_types_compatible_p(__typeof__((request->uri)), const CURLSH *))) _curl_easy_setopt_err_CURLSH(); } curl_easy_setopt(request->curl, _curl_opt, request->uri); })) != CURLE_OK) { return S3StatusFailedToInitializeRequest; };


    switch (params->httpRequestType) {
    case HttpRequestTypeHEAD:
    if ((status = __extension__ ({ __typeof__ (CURLOPT_NOBODY) _curl_opt = CURLOPT_NOBODY; if(__builtin_constant_p(_curl_opt)) { if((0 < (_curl_opt) && (_curl_opt) < 10000)) if(!(__builtin_types_compatible_p(__typeof__(1), long) || __builtin_types_compatible_p(__typeof__(1), signed long) || __builtin_types_compatible_p(__typeof__(1), unsigned long) || __builtin_types_compatible_p(__typeof__(1), int) || __builtin_types_compatible_p(__typeof__(1), signed int) || __builtin_types_compatible_p(__typeof__(1), unsigned int) || __builtin_types_compatible_p(__typeof__(1), short) || __builtin_types_compatible_p(__typeof__(1), signed short) || __builtin_types_compatible_p(__typeof__(1), unsigned short) || __builtin_types_compatible_p(__typeof__(1), char) || __builtin_types_compatible_p(__typeof__(1), signed char) || __builtin_types_compatible_p(__typeof__(1), unsigned char))) _curl_easy_setopt_err_long(); if(((_curl_opt) > 30000)) if(!(__builtin_types_compatible_p(__typeof__(1), curl_off_t))) _curl_easy_setopt_err_curl_off_t(); if(((_curl_opt) == CURLOPT_URL || (_curl_opt) == CURLOPT_PROXY || (_curl_opt) == CURLOPT_INTERFACE || (_curl_opt) == CURLOPT_NETRC_FILE || (_curl_opt) == CURLOPT_USERPWD || (_curl_opt) == CURLOPT_USERNAME || (_curl_opt) == CURLOPT_PASSWORD || (_curl_opt) == CURLOPT_PROXYUSERPWD || (_curl_opt) == CURLOPT_PROXYUSERNAME || (_curl_opt) == CURLOPT_PROXYPASSWORD || (_curl_opt) == CURLOPT_NOPROXY || (_curl_opt) == CURLOPT_ACCEPT_ENCODING || (_curl_opt) == CURLOPT_REFERER || (_curl_opt) == CURLOPT_USERAGENT || (_curl_opt) == CURLOPT_COOKIE || (_curl_opt) == CURLOPT_COOKIEFILE || (_curl_opt) == CURLOPT_COOKIEJAR || (_curl_opt) == CURLOPT_COOKIELIST || (_curl_opt) == CURLOPT_FTPPORT || (_curl_opt) == CURLOPT_FTP_ALTERNATIVE_TO_USER || (_curl_opt) == CURLOPT_FTP_ACCOUNT || (_curl_opt) == CURLOPT_RANGE || (_curl_opt) == CURLOPT_CUSTOMREQUEST || (_curl_opt) == CURLOPT_SSLCERT || (_curl_opt) == CURLOPT_SSLCERTTYPE || (_curl_opt) == CURLOPT_SSLKEY || (_curl_opt) == CURLOPT_SSLKEYTYPE || (_curl_opt) == CURLOPT_KEYPASSWD || (_curl_opt) == CURLOPT_SSLENGINE || (_curl_opt) == CURLOPT_CAINFO || (_curl_opt) == CURLOPT_CAPATH || (_curl_opt) == CURLOPT_RANDOM_FILE || (_curl_opt) == CURLOPT_EGDSOCKET || (_curl_opt) == CURLOPT_SSL_CIPHER_LIST || (_curl_opt) == CURLOPT_KRBLEVEL || (_curl_opt) == CURLOPT_SSH_HOST_PUBLIC_KEY_MD5 || (_curl_opt) == CURLOPT_SSH_PUBLIC_KEYFILE || (_curl_opt) == CURLOPT_SSH_PRIVATE_KEYFILE || (_curl_opt) == CURLOPT_CRLFILE || (_curl_opt) == CURLOPT_ISSUERCERT || (_curl_opt) == CURLOPT_SOCKS5_GSSAPI_SERVICE || (_curl_opt) == CURLOPT_SSH_KNOWNHOSTS || (_curl_opt) == CURLOPT_MAIL_FROM || (_curl_opt) == CURLOPT_RTSP_SESSION_ID || (_curl_opt) == CURLOPT_RTSP_STREAM_URI || (_curl_opt) == CURLOPT_RTSP_TRANSPORT || 0)) if(!((((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), char *) || __builtin_types_compatible_p(__typeof__(((1))), const char *)) || __builtin_types_compatible_p(__typeof__((1)), char [])) || (((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), signed char *) || __builtin_types_compatible_p(__typeof__(((1))), const signed char *)) || __builtin_types_compatible_p(__typeof__((1)), signed char [])) || (((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), unsigned char *) || __builtin_types_compatible_p(__typeof__(((1))), const unsigned char *)) || __builtin_types_compatible_p(__typeof__((1)), unsigned char [])))) _curl_easy_setopt_err_string(); if(((_curl_opt) == CURLOPT_HEADERFUNCTION || (_curl_opt) == CURLOPT_WRITEFUNCTION)) if(!(((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(1), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback6*))) || __builtin_types_compatible_p(__typeof__(1), __typeof__(fwrite)) || __builtin_types_compatible_p(__typeof__(1), curl_write_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback4*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback5) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback5*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback6) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback6*)))) _curl_easy_setopt_err_write_callback(); if((_curl_opt) == CURLOPT_READFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(1), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback6*)))) _curl_easy_setopt_err_read_cb(); if((_curl_opt) == CURLOPT_IOCTLFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_ioctl_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback4*)))) _curl_easy_setopt_err_ioctl_cb(); if((_curl_opt) == CURLOPT_SOCKOPTFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_sockopt_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_sockopt_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_sockopt_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_sockopt_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_sockopt_callback2*)))) _curl_easy_setopt_err_sockopt_cb(); if((_curl_opt) == CURLOPT_OPENSOCKETFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_opensocket_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback4*)))) _curl_easy_setopt_err_opensocket_cb(); if((_curl_opt) == CURLOPT_PROGRESSFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_progress_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_progress_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_progress_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_progress_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_progress_callback2*)))) _curl_easy_setopt_err_progress_cb(); if((_curl_opt) == CURLOPT_DEBUGFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_debug_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback4*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback5) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback5*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback6) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback6*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback7) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback7*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback8) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback8*)))) _curl_easy_setopt_err_debug_cb(); if((_curl_opt) == CURLOPT_SSL_CTX_FUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_ssl_ctx_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback4*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback5) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback5*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback6) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback6*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback7) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback7*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback8) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback8*)))) _curl_easy_setopt_err_ssl_ctx_cb(); if(((_curl_opt) == CURLOPT_CONV_TO_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_UTF8_FUNCTION)) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_conv_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback4*)))) _curl_easy_setopt_err_conv_cb(); if((_curl_opt) == CURLOPT_SEEKFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_seek_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_seek_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_seek_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_seek_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_seek_callback2*)))) _curl_easy_setopt_err_seek_cb(); if(((_curl_opt) == CURLOPT_FILE || (_curl_opt) == CURLOPT_INFILE || (_curl_opt) == CURLOPT_IOCTLDATA || (_curl_opt) == CURLOPT_SOCKOPTDATA || (_curl_opt) == CURLOPT_OPENSOCKETDATA || (_curl_opt) == CURLOPT_PROGRESSDATA || (_curl_opt) == CURLOPT_WRITEHEADER || (_curl_opt) == CURLOPT_DEBUGDATA || (_curl_opt) == CURLOPT_SSL_CTX_DATA || (_curl_opt) == CURLOPT_SEEKDATA || (_curl_opt) == CURLOPT_PRIVATE || (_curl_opt) == CURLOPT_SSH_KEYDATA || (_curl_opt) == CURLOPT_INTERLEAVEDATA || (_curl_opt) == CURLOPT_CHUNK_DATA || (_curl_opt) == CURLOPT_FNMATCH_DATA || 0)) if(!(sizeof(1) == sizeof(void*))) _curl_easy_setopt_err_cb_data(); if((_curl_opt) == CURLOPT_ERRORBUFFER) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), char *) || __builtin_types_compatible_p(__typeof__(1), char[]))) _curl_easy_setopt_err_error_buffer(); if((_curl_opt) == CURLOPT_STDERR) if(!(__builtin_types_compatible_p(__typeof__(1), FILE *))) _curl_easy_setopt_err_FILE(); if(((_curl_opt) == CURLOPT_POSTFIELDS || (_curl_opt) == CURLOPT_COPYPOSTFIELDS || 0)) if(!(((__builtin_types_compatible_p(__typeof__((1)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((1)), void *) || __builtin_types_compatible_p(__typeof__((1)), const void *)) || (((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), char *) || __builtin_types_compatible_p(__typeof__(((1))), const char *)) || __builtin_types_compatible_p(__typeof__((1)), char [])))) _curl_easy_setopt_err_postfields(); if((_curl_opt) == CURLOPT_HTTPPOST) if(!(((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), struct curl_httppost *) || __builtin_types_compatible_p(__typeof__(((1))), const struct curl_httppost *)) || __builtin_types_compatible_p(__typeof__((1)), struct curl_httppost []))) _curl_easy_setopt_err_curl_httpost(); if(((_curl_opt) == CURLOPT_HTTPHEADER || (_curl_opt) == CURLOPT_HTTP200ALIASES || (_curl_opt) == CURLOPT_QUOTE || (_curl_opt) == CURLOPT_POSTQUOTE || (_curl_opt) == CURLOPT_PREQUOTE || (_curl_opt) == CURLOPT_TELNETOPTIONS || (_curl_opt) == CURLOPT_MAIL_RCPT || 0)) if(!(((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), struct curl_slist *) || __builtin_types_compatible_p(__typeof__(((1))), const struct curl_slist *)) || __builtin_types_compatible_p(__typeof__((1)), struct curl_slist []))) _curl_easy_setopt_err_curl_slist(); if((_curl_opt) == CURLOPT_SHARE) if(!((__builtin_types_compatible_p(__typeof__((1)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((1)), CURLSH *) || __builtin_types_compatible_p(__typeof__((1)), const CURLSH *))) _curl_easy_setopt_err_CURLSH(); } curl_easy_setopt(request->curl, _curl_opt, 1); })) != CURLE_OK) { return S3StatusFailedToInitializeRequest; };
        break;
    case HttpRequestTypePUT:
    case HttpRequestTypeCOPY:
        if ((status = __extension__ ({ __typeof__ (CURLOPT_UPLOAD) _curl_opt = CURLOPT_UPLOAD; if(__builtin_constant_p(_curl_opt)) { if((0 < (_curl_opt) && (_curl_opt) < 10000)) if(!(__builtin_types_compatible_p(__typeof__(1), long) || __builtin_types_compatible_p(__typeof__(1), signed long) || __builtin_types_compatible_p(__typeof__(1), unsigned long) || __builtin_types_compatible_p(__typeof__(1), int) || __builtin_types_compatible_p(__typeof__(1), signed int) || __builtin_types_compatible_p(__typeof__(1), unsigned int) || __builtin_types_compatible_p(__typeof__(1), short) || __builtin_types_compatible_p(__typeof__(1), signed short) || __builtin_types_compatible_p(__typeof__(1), unsigned short) || __builtin_types_compatible_p(__typeof__(1), char) || __builtin_types_compatible_p(__typeof__(1), signed char) || __builtin_types_compatible_p(__typeof__(1), unsigned char))) _curl_easy_setopt_err_long(); if(((_curl_opt) > 30000)) if(!(__builtin_types_compatible_p(__typeof__(1), curl_off_t))) _curl_easy_setopt_err_curl_off_t(); if(((_curl_opt) == CURLOPT_URL || (_curl_opt) == CURLOPT_PROXY || (_curl_opt) == CURLOPT_INTERFACE || (_curl_opt) == CURLOPT_NETRC_FILE || (_curl_opt) == CURLOPT_USERPWD || (_curl_opt) == CURLOPT_USERNAME || (_curl_opt) == CURLOPT_PASSWORD || (_curl_opt) == CURLOPT_PROXYUSERPWD || (_curl_opt) == CURLOPT_PROXYUSERNAME || (_curl_opt) == CURLOPT_PROXYPASSWORD || (_curl_opt) == CURLOPT_NOPROXY || (_curl_opt) == CURLOPT_ACCEPT_ENCODING || (_curl_opt) == CURLOPT_REFERER || (_curl_opt) == CURLOPT_USERAGENT || (_curl_opt) == CURLOPT_COOKIE || (_curl_opt) == CURLOPT_COOKIEFILE || (_curl_opt) == CURLOPT_COOKIEJAR || (_curl_opt) == CURLOPT_COOKIELIST || (_curl_opt) == CURLOPT_FTPPORT || (_curl_opt) == CURLOPT_FTP_ALTERNATIVE_TO_USER || (_curl_opt) == CURLOPT_FTP_ACCOUNT || (_curl_opt) == CURLOPT_RANGE || (_curl_opt) == CURLOPT_CUSTOMREQUEST || (_curl_opt) == CURLOPT_SSLCERT || (_curl_opt) == CURLOPT_SSLCERTTYPE || (_curl_opt) == CURLOPT_SSLKEY || (_curl_opt) == CURLOPT_SSLKEYTYPE || (_curl_opt) == CURLOPT_KEYPASSWD || (_curl_opt) == CURLOPT_SSLENGINE || (_curl_opt) == CURLOPT_CAINFO || (_curl_opt) == CURLOPT_CAPATH || (_curl_opt) == CURLOPT_RANDOM_FILE || (_curl_opt) == CURLOPT_EGDSOCKET || (_curl_opt) == CURLOPT_SSL_CIPHER_LIST || (_curl_opt) == CURLOPT_KRBLEVEL || (_curl_opt) == CURLOPT_SSH_HOST_PUBLIC_KEY_MD5 || (_curl_opt) == CURLOPT_SSH_PUBLIC_KEYFILE || (_curl_opt) == CURLOPT_SSH_PRIVATE_KEYFILE || (_curl_opt) == CURLOPT_CRLFILE || (_curl_opt) == CURLOPT_ISSUERCERT || (_curl_opt) == CURLOPT_SOCKS5_GSSAPI_SERVICE || (_curl_opt) == CURLOPT_SSH_KNOWNHOSTS || (_curl_opt) == CURLOPT_MAIL_FROM || (_curl_opt) == CURLOPT_RTSP_SESSION_ID || (_curl_opt) == CURLOPT_RTSP_STREAM_URI || (_curl_opt) == CURLOPT_RTSP_TRANSPORT || 0)) if(!((((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), char *) || __builtin_types_compatible_p(__typeof__(((1))), const char *)) || __builtin_types_compatible_p(__typeof__((1)), char [])) || (((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), signed char *) || __builtin_types_compatible_p(__typeof__(((1))), const signed char *)) || __builtin_types_compatible_p(__typeof__((1)), signed char [])) || (((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), unsigned char *) || __builtin_types_compatible_p(__typeof__(((1))), const unsigned char *)) || __builtin_types_compatible_p(__typeof__((1)), unsigned char [])))) _curl_easy_setopt_err_string(); if(((_curl_opt) == CURLOPT_HEADERFUNCTION || (_curl_opt) == CURLOPT_WRITEFUNCTION)) if(!(((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(1), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback6*))) || __builtin_types_compatible_p(__typeof__(1), __typeof__(fwrite)) || __builtin_types_compatible_p(__typeof__(1), curl_write_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback4*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback5) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback5*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback6) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback6*)))) _curl_easy_setopt_err_write_callback(); if((_curl_opt) == CURLOPT_READFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(1), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback6*)))) _curl_easy_setopt_err_read_cb(); if((_curl_opt) == CURLOPT_IOCTLFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_ioctl_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback4*)))) _curl_easy_setopt_err_ioctl_cb(); if((_curl_opt) == CURLOPT_SOCKOPTFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_sockopt_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_sockopt_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_sockopt_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_sockopt_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_sockopt_callback2*)))) _curl_easy_setopt_err_sockopt_cb(); if((_curl_opt) == CURLOPT_OPENSOCKETFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_opensocket_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback4*)))) _curl_easy_setopt_err_opensocket_cb(); if((_curl_opt) == CURLOPT_PROGRESSFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_progress_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_progress_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_progress_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_progress_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_progress_callback2*)))) _curl_easy_setopt_err_progress_cb(); if((_curl_opt) == CURLOPT_DEBUGFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_debug_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback4*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback5) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback5*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback6) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback6*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback7) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback7*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback8) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback8*)))) _curl_easy_setopt_err_debug_cb(); if((_curl_opt) == CURLOPT_SSL_CTX_FUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_ssl_ctx_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback4*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback5) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback5*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback6) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback6*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback7) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback7*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback8) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback8*)))) _curl_easy_setopt_err_ssl_ctx_cb(); if(((_curl_opt) == CURLOPT_CONV_TO_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_UTF8_FUNCTION)) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_conv_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback4*)))) _curl_easy_setopt_err_conv_cb(); if((_curl_opt) == CURLOPT_SEEKFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_seek_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_seek_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_seek_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_seek_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_seek_callback2*)))) _curl_easy_setopt_err_seek_cb(); if(((_curl_opt) == CURLOPT_FILE || (_curl_opt) == CURLOPT_INFILE || (_curl_opt) == CURLOPT_IOCTLDATA || (_curl_opt) == CURLOPT_SOCKOPTDATA || (_curl_opt) == CURLOPT_OPENSOCKETDATA || (_curl_opt) == CURLOPT_PROGRESSDATA || (_curl_opt) == CURLOPT_WRITEHEADER || (_curl_opt) == CURLOPT_DEBUGDATA || (_curl_opt) == CURLOPT_SSL_CTX_DATA || (_curl_opt) == CURLOPT_SEEKDATA || (_curl_opt) == CURLOPT_PRIVATE || (_curl_opt) == CURLOPT_SSH_KEYDATA || (_curl_opt) == CURLOPT_INTERLEAVEDATA || (_curl_opt) == CURLOPT_CHUNK_DATA || (_curl_opt) == CURLOPT_FNMATCH_DATA || 0)) if(!(sizeof(1) == sizeof(void*))) _curl_easy_setopt_err_cb_data(); if((_curl_opt) == CURLOPT_ERRORBUFFER) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), char *) || __builtin_types_compatible_p(__typeof__(1), char[]))) _curl_easy_setopt_err_error_buffer(); if((_curl_opt) == CURLOPT_STDERR) if(!(__builtin_types_compatible_p(__typeof__(1), FILE *))) _curl_easy_setopt_err_FILE(); if(((_curl_opt) == CURLOPT_POSTFIELDS || (_curl_opt) == CURLOPT_COPYPOSTFIELDS || 0)) if(!(((__builtin_types_compatible_p(__typeof__((1)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((1)), void *) || __builtin_types_compatible_p(__typeof__((1)), const void *)) || (((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), char *) || __builtin_types_compatible_p(__typeof__(((1))), const char *)) || __builtin_types_compatible_p(__typeof__((1)), char [])))) _curl_easy_setopt_err_postfields(); if((_curl_opt) == CURLOPT_HTTPPOST) if(!(((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), struct curl_httppost *) || __builtin_types_compatible_p(__typeof__(((1))), const struct curl_httppost *)) || __builtin_types_compatible_p(__typeof__((1)), struct curl_httppost []))) _curl_easy_setopt_err_curl_httpost(); if(((_curl_opt) == CURLOPT_HTTPHEADER || (_curl_opt) == CURLOPT_HTTP200ALIASES || (_curl_opt) == CURLOPT_QUOTE || (_curl_opt) == CURLOPT_POSTQUOTE || (_curl_opt) == CURLOPT_PREQUOTE || (_curl_opt) == CURLOPT_TELNETOPTIONS || (_curl_opt) == CURLOPT_MAIL_RCPT || 0)) if(!(((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), struct curl_slist *) || __builtin_types_compatible_p(__typeof__(((1))), const struct curl_slist *)) || __builtin_types_compatible_p(__typeof__((1)), struct curl_slist []))) _curl_easy_setopt_err_curl_slist(); if((_curl_opt) == CURLOPT_SHARE) if(!((__builtin_types_compatible_p(__typeof__((1)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((1)), CURLSH *) || __builtin_types_compatible_p(__typeof__((1)), const CURLSH *))) _curl_easy_setopt_err_CURLSH(); } curl_easy_setopt(request->curl, _curl_opt, 1); })) != CURLE_OK) { return S3StatusFailedToInitializeRequest; };
        break;
    case HttpRequestTypeDELETE:
    if ((status = __extension__ ({ __typeof__ (CURLOPT_CUSTOMREQUEST) _curl_opt = CURLOPT_CUSTOMREQUEST; if(__builtin_constant_p(_curl_opt)) { if((0 < (_curl_opt) && (_curl_opt) < 10000)) if(!(__builtin_types_compatible_p(__typeof__("DELETE"), long) || __builtin_types_compatible_p(__typeof__("DELETE"), signed long) || __builtin_types_compatible_p(__typeof__("DELETE"), unsigned long) || __builtin_types_compatible_p(__typeof__("DELETE"), int) || __builtin_types_compatible_p(__typeof__("DELETE"), signed int) || __builtin_types_compatible_p(__typeof__("DELETE"), unsigned int) || __builtin_types_compatible_p(__typeof__("DELETE"), short) || __builtin_types_compatible_p(__typeof__("DELETE"), signed short) || __builtin_types_compatible_p(__typeof__("DELETE"), unsigned short) || __builtin_types_compatible_p(__typeof__("DELETE"), char) || __builtin_types_compatible_p(__typeof__("DELETE"), signed char) || __builtin_types_compatible_p(__typeof__("DELETE"), unsigned char))) _curl_easy_setopt_err_long(); if(((_curl_opt) > 30000)) if(!(__builtin_types_compatible_p(__typeof__("DELETE"), curl_off_t))) _curl_easy_setopt_err_curl_off_t(); if(((_curl_opt) == CURLOPT_URL || (_curl_opt) == CURLOPT_PROXY || (_curl_opt) == CURLOPT_INTERFACE || (_curl_opt) == CURLOPT_NETRC_FILE || (_curl_opt) == CURLOPT_USERPWD || (_curl_opt) == CURLOPT_USERNAME || (_curl_opt) == CURLOPT_PASSWORD || (_curl_opt) == CURLOPT_PROXYUSERPWD || (_curl_opt) == CURLOPT_PROXYUSERNAME || (_curl_opt) == CURLOPT_PROXYPASSWORD || (_curl_opt) == CURLOPT_NOPROXY || (_curl_opt) == CURLOPT_ACCEPT_ENCODING || (_curl_opt) == CURLOPT_REFERER || (_curl_opt) == CURLOPT_USERAGENT || (_curl_opt) == CURLOPT_COOKIE || (_curl_opt) == CURLOPT_COOKIEFILE || (_curl_opt) == CURLOPT_COOKIEJAR || (_curl_opt) == CURLOPT_COOKIELIST || (_curl_opt) == CURLOPT_FTPPORT || (_curl_opt) == CURLOPT_FTP_ALTERNATIVE_TO_USER || (_curl_opt) == CURLOPT_FTP_ACCOUNT || (_curl_opt) == CURLOPT_RANGE || (_curl_opt) == CURLOPT_CUSTOMREQUEST || (_curl_opt) == CURLOPT_SSLCERT || (_curl_opt) == CURLOPT_SSLCERTTYPE || (_curl_opt) == CURLOPT_SSLKEY || (_curl_opt) == CURLOPT_SSLKEYTYPE || (_curl_opt) == CURLOPT_KEYPASSWD || (_curl_opt) == CURLOPT_SSLENGINE || (_curl_opt) == CURLOPT_CAINFO || (_curl_opt) == CURLOPT_CAPATH || (_curl_opt) == CURLOPT_RANDOM_FILE || (_curl_opt) == CURLOPT_EGDSOCKET || (_curl_opt) == CURLOPT_SSL_CIPHER_LIST || (_curl_opt) == CURLOPT_KRBLEVEL || (_curl_opt) == CURLOPT_SSH_HOST_PUBLIC_KEY_MD5 || (_curl_opt) == CURLOPT_SSH_PUBLIC_KEYFILE || (_curl_opt) == CURLOPT_SSH_PRIVATE_KEYFILE || (_curl_opt) == CURLOPT_CRLFILE || (_curl_opt) == CURLOPT_ISSUERCERT || (_curl_opt) == CURLOPT_SOCKS5_GSSAPI_SERVICE || (_curl_opt) == CURLOPT_SSH_KNOWNHOSTS || (_curl_opt) == CURLOPT_MAIL_FROM || (_curl_opt) == CURLOPT_RTSP_SESSION_ID || (_curl_opt) == CURLOPT_RTSP_STREAM_URI || (_curl_opt) == CURLOPT_RTSP_TRANSPORT || 0)) if(!((((__builtin_types_compatible_p(__typeof__((("DELETE"))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((("DELETE"))), char *) || __builtin_types_compatible_p(__typeof__((("DELETE"))), const char *)) || __builtin_types_compatible_p(__typeof__(("DELETE")), char [])) || (((__builtin_types_compatible_p(__typeof__((("DELETE"))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((("DELETE"))), signed char *) || __builtin_types_compatible_p(__typeof__((("DELETE"))), const signed char *)) || __builtin_types_compatible_p(__typeof__(("DELETE")), signed char [])) || (((__builtin_types_compatible_p(__typeof__((("DELETE"))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((("DELETE"))), unsigned char *) || __builtin_types_compatible_p(__typeof__((("DELETE"))), const unsigned char *)) || __builtin_types_compatible_p(__typeof__(("DELETE")), unsigned char [])))) _curl_easy_setopt_err_string(); if(((_curl_opt) == CURLOPT_HEADERFUNCTION || (_curl_opt) == CURLOPT_WRITEFUNCTION)) if(!(((__builtin_types_compatible_p(__typeof__("DELETE"), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__("DELETE"), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__("DELETE"), curl_read_callback) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_read_callback6*))) || __builtin_types_compatible_p(__typeof__("DELETE"), __typeof__(fwrite)) || __builtin_types_compatible_p(__typeof__("DELETE"), curl_write_callback) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_write_callback1) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_write_callback1*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_write_callback2) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_write_callback2*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_write_callback3) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_write_callback3*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_write_callback4) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_write_callback4*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_write_callback5) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_write_callback5*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_write_callback6) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_write_callback6*)))) _curl_easy_setopt_err_write_callback(); if((_curl_opt) == CURLOPT_READFUNCTION) if(!((__builtin_types_compatible_p(__typeof__("DELETE"), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__("DELETE"), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__("DELETE"), curl_read_callback) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_read_callback6*)))) _curl_easy_setopt_err_read_cb(); if((_curl_opt) == CURLOPT_IOCTLFUNCTION) if(!((__builtin_types_compatible_p(__typeof__("DELETE"), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__("DELETE"), curl_ioctl_callback) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_ioctl_callback1) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_ioctl_callback1*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_ioctl_callback2) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_ioctl_callback2*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_ioctl_callback3) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_ioctl_callback3*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_ioctl_callback4) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_ioctl_callback4*)))) _curl_easy_setopt_err_ioctl_cb(); if((_curl_opt) == CURLOPT_SOCKOPTFUNCTION) if(!((__builtin_types_compatible_p(__typeof__("DELETE"), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__("DELETE"), curl_sockopt_callback) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_sockopt_callback1) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_sockopt_callback1*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_sockopt_callback2) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_sockopt_callback2*)))) _curl_easy_setopt_err_sockopt_cb(); if((_curl_opt) == CURLOPT_OPENSOCKETFUNCTION) if(!((__builtin_types_compatible_p(__typeof__("DELETE"), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__("DELETE"), curl_opensocket_callback) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_opensocket_callback1) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_opensocket_callback1*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_opensocket_callback2) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_opensocket_callback2*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_opensocket_callback3) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_opensocket_callback3*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_opensocket_callback4) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_opensocket_callback4*)))) _curl_easy_setopt_err_opensocket_cb(); if((_curl_opt) == CURLOPT_PROGRESSFUNCTION) if(!((__builtin_types_compatible_p(__typeof__("DELETE"), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__("DELETE"), curl_progress_callback) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_progress_callback1) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_progress_callback1*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_progress_callback2) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_progress_callback2*)))) _curl_easy_setopt_err_progress_cb(); if((_curl_opt) == CURLOPT_DEBUGFUNCTION) if(!((__builtin_types_compatible_p(__typeof__("DELETE"), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__("DELETE"), curl_debug_callback) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_debug_callback1) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_debug_callback1*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_debug_callback2) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_debug_callback2*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_debug_callback3) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_debug_callback3*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_debug_callback4) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_debug_callback4*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_debug_callback5) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_debug_callback5*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_debug_callback6) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_debug_callback6*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_debug_callback7) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_debug_callback7*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_debug_callback8) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_debug_callback8*)))) _curl_easy_setopt_err_debug_cb(); if((_curl_opt) == CURLOPT_SSL_CTX_FUNCTION) if(!((__builtin_types_compatible_p(__typeof__("DELETE"), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__("DELETE"), curl_ssl_ctx_callback) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_ssl_ctx_callback1) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_ssl_ctx_callback1*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_ssl_ctx_callback2) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_ssl_ctx_callback2*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_ssl_ctx_callback3) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_ssl_ctx_callback3*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_ssl_ctx_callback4) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_ssl_ctx_callback4*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_ssl_ctx_callback5) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_ssl_ctx_callback5*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_ssl_ctx_callback6) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_ssl_ctx_callback6*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_ssl_ctx_callback7) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_ssl_ctx_callback7*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_ssl_ctx_callback8) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_ssl_ctx_callback8*)))) _curl_easy_setopt_err_ssl_ctx_cb(); if(((_curl_opt) == CURLOPT_CONV_TO_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_UTF8_FUNCTION)) if(!((__builtin_types_compatible_p(__typeof__("DELETE"), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__("DELETE"), curl_conv_callback) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_conv_callback1) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_conv_callback1*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_conv_callback2) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_conv_callback2*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_conv_callback3) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_conv_callback3*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_conv_callback4) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_conv_callback4*)))) _curl_easy_setopt_err_conv_cb(); if((_curl_opt) == CURLOPT_SEEKFUNCTION) if(!((__builtin_types_compatible_p(__typeof__("DELETE"), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__("DELETE"), curl_seek_callback) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_seek_callback1) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_seek_callback1*)) || (__builtin_types_compatible_p(__typeof__(("DELETE")), _curl_seek_callback2) || __builtin_types_compatible_p(__typeof__(("DELETE")), _curl_seek_callback2*)))) _curl_easy_setopt_err_seek_cb(); if(((_curl_opt) == CURLOPT_FILE || (_curl_opt) == CURLOPT_INFILE || (_curl_opt) == CURLOPT_IOCTLDATA || (_curl_opt) == CURLOPT_SOCKOPTDATA || (_curl_opt) == CURLOPT_OPENSOCKETDATA || (_curl_opt) == CURLOPT_PROGRESSDATA || (_curl_opt) == CURLOPT_WRITEHEADER || (_curl_opt) == CURLOPT_DEBUGDATA || (_curl_opt) == CURLOPT_SSL_CTX_DATA || (_curl_opt) == CURLOPT_SEEKDATA || (_curl_opt) == CURLOPT_PRIVATE || (_curl_opt) == CURLOPT_SSH_KEYDATA || (_curl_opt) == CURLOPT_INTERLEAVEDATA || (_curl_opt) == CURLOPT_CHUNK_DATA || (_curl_opt) == CURLOPT_FNMATCH_DATA || 0)) if(!(sizeof("DELETE") == sizeof(void*))) _curl_easy_setopt_err_cb_data(); if((_curl_opt) == CURLOPT_ERRORBUFFER) if(!((__builtin_types_compatible_p(__typeof__("DELETE"), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__("DELETE"), char *) || __builtin_types_compatible_p(__typeof__("DELETE"), char[]))) _curl_easy_setopt_err_error_buffer(); if((_curl_opt) == CURLOPT_STDERR) if(!(__builtin_types_compatible_p(__typeof__("DELETE"), FILE *))) _curl_easy_setopt_err_FILE(); if(((_curl_opt) == CURLOPT_POSTFIELDS || (_curl_opt) == CURLOPT_COPYPOSTFIELDS || 0)) if(!(((__builtin_types_compatible_p(__typeof__(("DELETE")), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(("DELETE")), void *) || __builtin_types_compatible_p(__typeof__(("DELETE")), const void *)) || (((__builtin_types_compatible_p(__typeof__((("DELETE"))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((("DELETE"))), char *) || __builtin_types_compatible_p(__typeof__((("DELETE"))), const char *)) || __builtin_types_compatible_p(__typeof__(("DELETE")), char [])))) _curl_easy_setopt_err_postfields(); if((_curl_opt) == CURLOPT_HTTPPOST) if(!(((__builtin_types_compatible_p(__typeof__((("DELETE"))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((("DELETE"))), struct curl_httppost *) || __builtin_types_compatible_p(__typeof__((("DELETE"))), const struct curl_httppost *)) || __builtin_types_compatible_p(__typeof__(("DELETE")), struct curl_httppost []))) _curl_easy_setopt_err_curl_httpost(); if(((_curl_opt) == CURLOPT_HTTPHEADER || (_curl_opt) == CURLOPT_HTTP200ALIASES || (_curl_opt) == CURLOPT_QUOTE || (_curl_opt) == CURLOPT_POSTQUOTE || (_curl_opt) == CURLOPT_PREQUOTE || (_curl_opt) == CURLOPT_TELNETOPTIONS || (_curl_opt) == CURLOPT_MAIL_RCPT || 0)) if(!(((__builtin_types_compatible_p(__typeof__((("DELETE"))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((("DELETE"))), struct curl_slist *) || __builtin_types_compatible_p(__typeof__((("DELETE"))), const struct curl_slist *)) || __builtin_types_compatible_p(__typeof__(("DELETE")), struct curl_slist []))) _curl_easy_setopt_err_curl_slist(); if((_curl_opt) == CURLOPT_SHARE) if(!((__builtin_types_compatible_p(__typeof__(("DELETE")), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(("DELETE")), CURLSH *) || __builtin_types_compatible_p(__typeof__(("DELETE")), const CURLSH *))) _curl_easy_setopt_err_CURLSH(); } curl_easy_setopt(request->curl, _curl_opt, "DELETE"); })) != CURLE_OK) { return S3StatusFailedToInitializeRequest; };
        break;
    default:
        break;
    }

    return S3StatusOK;
}


static void request_deinitialize(Request *request)
{
    if (request->headers) {
        curl_slist_free_all(request->headers);
    }

    error_parser_deinitialize(&(request->errorParser));





    curl_easy_reset(request->curl);
}


static S3Status request_get(const RequestParams *params,
                            const RequestComputedValues *values,
                            Request **reqReturn)
{
    Request *request = 0;



    pthread_mutex_lock(&requestStackMutexG);

    if (requestStackCountG) {
        request = requestStackG[--requestStackCountG];
    }

    pthread_mutex_unlock(&requestStackMutexG);


    if (request) {
        request_deinitialize(request);
    }

    else {
        if (!(request = (Request *) malloc(sizeof(Request)))) {
            return S3StatusOutOfMemory;
        }
        if (!(request->curl = curl_easy_init())) {
            free(request);
            return S3StatusFailedToInitializeRequest;
        }
    }


    request->prev = 0;
    request->next = 0;



    request->status = S3StatusOK;

    S3Status status;


    request->headers = 0;


    if ((status = compose_uri
         (request->uri, sizeof(request->uri),
          &(params->bucketContext), values->urlEncodedKey,
          params->subResource, params->queryParams)) != S3StatusOK) {
        curl_easy_cleanup(request->curl);
        free(request);
        return status;
    }


    if ((status = setup_curl(request, params, values)) != S3StatusOK) {
        curl_easy_cleanup(request->curl);
        free(request);
        return status;
    }

    request->propertiesCallback = params->propertiesCallback;

    request->toS3Callback = params->toS3Callback;

    request->toS3CallbackBytesRemaining = params->toS3CallbackTotalSize;

    request->fromS3Callback = params->fromS3Callback;

    request->completeCallback = params->completeCallback;

    request->callbackData = params->callbackData;

    response_headers_handler_initialize(&(request->responseHeadersHandler));

    request->propertiesCallbackMade = 0;

    error_parser_initialize(&(request->errorParser));

    *reqReturn = request;

    return S3StatusOK;
}


static void request_destroy(Request *request)
{
    request_deinitialize(request);
    curl_easy_cleanup(request->curl);
    free(request);
}


static void request_release(Request *request)
{
    pthread_mutex_lock(&requestStackMutexG);


    if (requestStackCountG == 32) {
        pthread_mutex_unlock(&requestStackMutexG);
        request_destroy(request);
    }




    else {
        requestStackG[requestStackCountG++] = request;
        pthread_mutex_unlock(&requestStackMutexG);
    }
}


S3Status request_api_initialize(const char *userAgentInfo, int flags,
                                const char *defaultHostName)
{
    if (curl_global_init(((1<<0)|(1<<1)) &
                         ~((flags & 1) ? 0 : (1<<1)))
        != CURLE_OK) {
        return S3StatusInternalError;
    }

    if (!defaultHostName) {
        defaultHostName = "s3.amazonaws.com";
    }

    if (snprintf(defaultHostNameG, 255,
                 "%s", defaultHostName) >= 255) {
        return S3StatusUriTooLong;
    }

    pthread_mutex_init(&requestStackMutexG, 0);

    requestStackCountG = 0;

    if (!userAgentInfo || !*userAgentInfo) {
        userAgentInfo = "Unknown";
    }

    char platform[96];
    struct utsname utsn;
    if (uname(&utsn)) {
        strncpy(platform, "Unknown", sizeof(platform));

        platform[sizeof(platform) - 1] = 0;
    }
    else {
        snprintf(platform, sizeof(platform), "%s%s%s", utsn.sysname,
                 utsn.machine[0] ? " " : "", utsn.machine);
    }

    snprintf(userAgentG, sizeof(userAgentG),
             "Mozilla/4.0 (Compatible; %s; libs3 %s.%s; %s)",
             userAgentInfo, LIBS3_VER_MAJOR, LIBS3_VER_MINOR, platform);

    return S3StatusOK;
}


void request_api_deinitialize()
{
    pthread_mutex_destroy(&requestStackMutexG);

    while (requestStackCountG--) {
        request_destroy(requestStackG[requestStackCountG]);
    }
}

static int header_handler(CURL *handle, curl_infotype type, char *data, size_t size, void *userdata)
{
 static unsigned int count_get = 0;
 static unsigned int count_put = 0;
 static unsigned int count_copy = 0;
 static unsigned int count_post = 0;
 static unsigned int count_list = 0;
 if(type == CURLINFO_HEADER_OUT) {
  if(strncmp(data, "GET", 3) == 0) count_get++;

  if(strncmp(data, "PUT", 3) == 0) count_put++;
  if(strncmp(data, "COPY", 4) == 0) count_copy++;
  if(strncmp(data, "POST", 4) == 0) count_post++;
  if(strncmp(data, "LIST", 4) == 0) count_list++;



  (void)(handle);
  (void)(userdata);
  (void)(size);





 }
 return 0;
}

void request_perform(const RequestParams *params, S3RequestContext *context)
{
    Request *request;
    S3Status status;






    RequestComputedValues computed;


    if (params->bucketContext.bucketName &&
        ((status = S3_validate_bucket_name
          (params->bucketContext.bucketName,
           params->bucketContext.uriStyle)) != S3StatusOK)) {
        (*(params->completeCallback))(status, 0, params->callbackData); return;
    }


    if ((status = compose_amz_headers(params, &computed)) != S3StatusOK) {
        (*(params->completeCallback))(status, 0, params->callbackData); return;
    }


    if ((status = compose_standard_headers
         (params, &computed)) != S3StatusOK) {
        (*(params->completeCallback))(status, 0, params->callbackData); return;
    }


    if ((status = encode_key(params, &computed)) != S3StatusOK) {
        (*(params->completeCallback))(status, 0, params->callbackData); return;
    }


    canonicalize_amz_headers(&computed);


    canonicalize_resource(params->bucketContext.bucketName,
                          params->subResource, computed.urlEncodedKey,
                          computed.canonicalizedResource);


    if ((status = compose_auth_header(params, &computed)) != S3StatusOK) {
        (*(params->completeCallback))(status, 0, params->callbackData); return;
    }


    if ((status = request_get(params, &computed, &request)) != S3StatusOK) {
        (*(params->completeCallback))(status, 0, params->callbackData); return;
    }

 __extension__ ({ __typeof__ (CURLOPT_VERBOSE) _curl_opt = CURLOPT_VERBOSE; if(__builtin_constant_p(_curl_opt)) { if((0 < (_curl_opt) && (_curl_opt) < 10000)) if(!(__builtin_types_compatible_p(__typeof__(1), long) || __builtin_types_compatible_p(__typeof__(1), signed long) || __builtin_types_compatible_p(__typeof__(1), unsigned long) || __builtin_types_compatible_p(__typeof__(1), int) || __builtin_types_compatible_p(__typeof__(1), signed int) || __builtin_types_compatible_p(__typeof__(1), unsigned int) || __builtin_types_compatible_p(__typeof__(1), short) || __builtin_types_compatible_p(__typeof__(1), signed short) || __builtin_types_compatible_p(__typeof__(1), unsigned short) || __builtin_types_compatible_p(__typeof__(1), char) || __builtin_types_compatible_p(__typeof__(1), signed char) || __builtin_types_compatible_p(__typeof__(1), unsigned char))) _curl_easy_setopt_err_long(); if(((_curl_opt) > 30000)) if(!(__builtin_types_compatible_p(__typeof__(1), curl_off_t))) _curl_easy_setopt_err_curl_off_t(); if(((_curl_opt) == CURLOPT_URL || (_curl_opt) == CURLOPT_PROXY || (_curl_opt) == CURLOPT_INTERFACE || (_curl_opt) == CURLOPT_NETRC_FILE || (_curl_opt) == CURLOPT_USERPWD || (_curl_opt) == CURLOPT_USERNAME || (_curl_opt) == CURLOPT_PASSWORD || (_curl_opt) == CURLOPT_PROXYUSERPWD || (_curl_opt) == CURLOPT_PROXYUSERNAME || (_curl_opt) == CURLOPT_PROXYPASSWORD || (_curl_opt) == CURLOPT_NOPROXY || (_curl_opt) == CURLOPT_ACCEPT_ENCODING || (_curl_opt) == CURLOPT_REFERER || (_curl_opt) == CURLOPT_USERAGENT || (_curl_opt) == CURLOPT_COOKIE || (_curl_opt) == CURLOPT_COOKIEFILE || (_curl_opt) == CURLOPT_COOKIEJAR || (_curl_opt) == CURLOPT_COOKIELIST || (_curl_opt) == CURLOPT_FTPPORT || (_curl_opt) == CURLOPT_FTP_ALTERNATIVE_TO_USER || (_curl_opt) == CURLOPT_FTP_ACCOUNT || (_curl_opt) == CURLOPT_RANGE || (_curl_opt) == CURLOPT_CUSTOMREQUEST || (_curl_opt) == CURLOPT_SSLCERT || (_curl_opt) == CURLOPT_SSLCERTTYPE || (_curl_opt) == CURLOPT_SSLKEY || (_curl_opt) == CURLOPT_SSLKEYTYPE || (_curl_opt) == CURLOPT_KEYPASSWD || (_curl_opt) == CURLOPT_SSLENGINE || (_curl_opt) == CURLOPT_CAINFO || (_curl_opt) == CURLOPT_CAPATH || (_curl_opt) == CURLOPT_RANDOM_FILE || (_curl_opt) == CURLOPT_EGDSOCKET || (_curl_opt) == CURLOPT_SSL_CIPHER_LIST || (_curl_opt) == CURLOPT_KRBLEVEL || (_curl_opt) == CURLOPT_SSH_HOST_PUBLIC_KEY_MD5 || (_curl_opt) == CURLOPT_SSH_PUBLIC_KEYFILE || (_curl_opt) == CURLOPT_SSH_PRIVATE_KEYFILE || (_curl_opt) == CURLOPT_CRLFILE || (_curl_opt) == CURLOPT_ISSUERCERT || (_curl_opt) == CURLOPT_SOCKS5_GSSAPI_SERVICE || (_curl_opt) == CURLOPT_SSH_KNOWNHOSTS || (_curl_opt) == CURLOPT_MAIL_FROM || (_curl_opt) == CURLOPT_RTSP_SESSION_ID || (_curl_opt) == CURLOPT_RTSP_STREAM_URI || (_curl_opt) == CURLOPT_RTSP_TRANSPORT || 0)) if(!((((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), char *) || __builtin_types_compatible_p(__typeof__(((1))), const char *)) || __builtin_types_compatible_p(__typeof__((1)), char [])) || (((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), signed char *) || __builtin_types_compatible_p(__typeof__(((1))), const signed char *)) || __builtin_types_compatible_p(__typeof__((1)), signed char [])) || (((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), unsigned char *) || __builtin_types_compatible_p(__typeof__(((1))), const unsigned char *)) || __builtin_types_compatible_p(__typeof__((1)), unsigned char [])))) _curl_easy_setopt_err_string(); if(((_curl_opt) == CURLOPT_HEADERFUNCTION || (_curl_opt) == CURLOPT_WRITEFUNCTION)) if(!(((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(1), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback6*))) || __builtin_types_compatible_p(__typeof__(1), __typeof__(fwrite)) || __builtin_types_compatible_p(__typeof__(1), curl_write_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback4*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback5) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback5*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_write_callback6) || __builtin_types_compatible_p(__typeof__((1)), _curl_write_callback6*)))) _curl_easy_setopt_err_write_callback(); if((_curl_opt) == CURLOPT_READFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(1), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((1)), _curl_read_callback6*)))) _curl_easy_setopt_err_read_cb(); if((_curl_opt) == CURLOPT_IOCTLFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_ioctl_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_ioctl_callback4*)))) _curl_easy_setopt_err_ioctl_cb(); if((_curl_opt) == CURLOPT_SOCKOPTFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_sockopt_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_sockopt_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_sockopt_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_sockopt_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_sockopt_callback2*)))) _curl_easy_setopt_err_sockopt_cb(); if((_curl_opt) == CURLOPT_OPENSOCKETFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_opensocket_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_opensocket_callback4*)))) _curl_easy_setopt_err_opensocket_cb(); if((_curl_opt) == CURLOPT_PROGRESSFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_progress_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_progress_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_progress_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_progress_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_progress_callback2*)))) _curl_easy_setopt_err_progress_cb(); if((_curl_opt) == CURLOPT_DEBUGFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_debug_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback4*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback5) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback5*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback6) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback6*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback7) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback7*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback8) || __builtin_types_compatible_p(__typeof__((1)), _curl_debug_callback8*)))) _curl_easy_setopt_err_debug_cb(); if((_curl_opt) == CURLOPT_SSL_CTX_FUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_ssl_ctx_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback4*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback5) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback5*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback6) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback6*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback7) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback7*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback8) || __builtin_types_compatible_p(__typeof__((1)), _curl_ssl_ctx_callback8*)))) _curl_easy_setopt_err_ssl_ctx_cb(); if(((_curl_opt) == CURLOPT_CONV_TO_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_UTF8_FUNCTION)) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_conv_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback2*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback3) || __builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback3*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback4) || __builtin_types_compatible_p(__typeof__((1)), _curl_conv_callback4*)))) _curl_easy_setopt_err_conv_cb(); if((_curl_opt) == CURLOPT_SEEKFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), curl_seek_callback) || (__builtin_types_compatible_p(__typeof__((1)), _curl_seek_callback1) || __builtin_types_compatible_p(__typeof__((1)), _curl_seek_callback1*)) || (__builtin_types_compatible_p(__typeof__((1)), _curl_seek_callback2) || __builtin_types_compatible_p(__typeof__((1)), _curl_seek_callback2*)))) _curl_easy_setopt_err_seek_cb(); if(((_curl_opt) == CURLOPT_FILE || (_curl_opt) == CURLOPT_INFILE || (_curl_opt) == CURLOPT_IOCTLDATA || (_curl_opt) == CURLOPT_SOCKOPTDATA || (_curl_opt) == CURLOPT_OPENSOCKETDATA || (_curl_opt) == CURLOPT_PROGRESSDATA || (_curl_opt) == CURLOPT_WRITEHEADER || (_curl_opt) == CURLOPT_DEBUGDATA || (_curl_opt) == CURLOPT_SSL_CTX_DATA || (_curl_opt) == CURLOPT_SEEKDATA || (_curl_opt) == CURLOPT_PRIVATE || (_curl_opt) == CURLOPT_SSH_KEYDATA || (_curl_opt) == CURLOPT_INTERLEAVEDATA || (_curl_opt) == CURLOPT_CHUNK_DATA || (_curl_opt) == CURLOPT_FNMATCH_DATA || 0)) if(!(sizeof(1) == sizeof(void*))) _curl_easy_setopt_err_cb_data(); if((_curl_opt) == CURLOPT_ERRORBUFFER) if(!((__builtin_types_compatible_p(__typeof__(1), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(1), char *) || __builtin_types_compatible_p(__typeof__(1), char[]))) _curl_easy_setopt_err_error_buffer(); if((_curl_opt) == CURLOPT_STDERR) if(!(__builtin_types_compatible_p(__typeof__(1), FILE *))) _curl_easy_setopt_err_FILE(); if(((_curl_opt) == CURLOPT_POSTFIELDS || (_curl_opt) == CURLOPT_COPYPOSTFIELDS || 0)) if(!(((__builtin_types_compatible_p(__typeof__((1)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((1)), void *) || __builtin_types_compatible_p(__typeof__((1)), const void *)) || (((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), char *) || __builtin_types_compatible_p(__typeof__(((1))), const char *)) || __builtin_types_compatible_p(__typeof__((1)), char [])))) _curl_easy_setopt_err_postfields(); if((_curl_opt) == CURLOPT_HTTPPOST) if(!(((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), struct curl_httppost *) || __builtin_types_compatible_p(__typeof__(((1))), const struct curl_httppost *)) || __builtin_types_compatible_p(__typeof__((1)), struct curl_httppost []))) _curl_easy_setopt_err_curl_httpost(); if(((_curl_opt) == CURLOPT_HTTPHEADER || (_curl_opt) == CURLOPT_HTTP200ALIASES || (_curl_opt) == CURLOPT_QUOTE || (_curl_opt) == CURLOPT_POSTQUOTE || (_curl_opt) == CURLOPT_PREQUOTE || (_curl_opt) == CURLOPT_TELNETOPTIONS || (_curl_opt) == CURLOPT_MAIL_RCPT || 0)) if(!(((__builtin_types_compatible_p(__typeof__(((1))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((1))), struct curl_slist *) || __builtin_types_compatible_p(__typeof__(((1))), const struct curl_slist *)) || __builtin_types_compatible_p(__typeof__((1)), struct curl_slist []))) _curl_easy_setopt_err_curl_slist(); if((_curl_opt) == CURLOPT_SHARE) if(!((__builtin_types_compatible_p(__typeof__((1)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((1)), CURLSH *) || __builtin_types_compatible_p(__typeof__((1)), const CURLSH *))) _curl_easy_setopt_err_CURLSH(); } curl_easy_setopt(request->curl, _curl_opt, 1); });
 __extension__ ({ __typeof__ (CURLOPT_DEBUGFUNCTION) _curl_opt = CURLOPT_DEBUGFUNCTION; if(__builtin_constant_p(_curl_opt)) { if((0 < (_curl_opt) && (_curl_opt) < 10000)) if(!(__builtin_types_compatible_p(__typeof__(header_handler), long) || __builtin_types_compatible_p(__typeof__(header_handler), signed long) || __builtin_types_compatible_p(__typeof__(header_handler), unsigned long) || __builtin_types_compatible_p(__typeof__(header_handler), int) || __builtin_types_compatible_p(__typeof__(header_handler), signed int) || __builtin_types_compatible_p(__typeof__(header_handler), unsigned int) || __builtin_types_compatible_p(__typeof__(header_handler), short) || __builtin_types_compatible_p(__typeof__(header_handler), signed short) || __builtin_types_compatible_p(__typeof__(header_handler), unsigned short) || __builtin_types_compatible_p(__typeof__(header_handler), char) || __builtin_types_compatible_p(__typeof__(header_handler), signed char) || __builtin_types_compatible_p(__typeof__(header_handler), unsigned char))) _curl_easy_setopt_err_long(); if(((_curl_opt) > 30000)) if(!(__builtin_types_compatible_p(__typeof__(header_handler), curl_off_t))) _curl_easy_setopt_err_curl_off_t(); if(((_curl_opt) == CURLOPT_URL || (_curl_opt) == CURLOPT_PROXY || (_curl_opt) == CURLOPT_INTERFACE || (_curl_opt) == CURLOPT_NETRC_FILE || (_curl_opt) == CURLOPT_USERPWD || (_curl_opt) == CURLOPT_USERNAME || (_curl_opt) == CURLOPT_PASSWORD || (_curl_opt) == CURLOPT_PROXYUSERPWD || (_curl_opt) == CURLOPT_PROXYUSERNAME || (_curl_opt) == CURLOPT_PROXYPASSWORD || (_curl_opt) == CURLOPT_NOPROXY || (_curl_opt) == CURLOPT_ACCEPT_ENCODING || (_curl_opt) == CURLOPT_REFERER || (_curl_opt) == CURLOPT_USERAGENT || (_curl_opt) == CURLOPT_COOKIE || (_curl_opt) == CURLOPT_COOKIEFILE || (_curl_opt) == CURLOPT_COOKIEJAR || (_curl_opt) == CURLOPT_COOKIELIST || (_curl_opt) == CURLOPT_FTPPORT || (_curl_opt) == CURLOPT_FTP_ALTERNATIVE_TO_USER || (_curl_opt) == CURLOPT_FTP_ACCOUNT || (_curl_opt) == CURLOPT_RANGE || (_curl_opt) == CURLOPT_CUSTOMREQUEST || (_curl_opt) == CURLOPT_SSLCERT || (_curl_opt) == CURLOPT_SSLCERTTYPE || (_curl_opt) == CURLOPT_SSLKEY || (_curl_opt) == CURLOPT_SSLKEYTYPE || (_curl_opt) == CURLOPT_KEYPASSWD || (_curl_opt) == CURLOPT_SSLENGINE || (_curl_opt) == CURLOPT_CAINFO || (_curl_opt) == CURLOPT_CAPATH || (_curl_opt) == CURLOPT_RANDOM_FILE || (_curl_opt) == CURLOPT_EGDSOCKET || (_curl_opt) == CURLOPT_SSL_CIPHER_LIST || (_curl_opt) == CURLOPT_KRBLEVEL || (_curl_opt) == CURLOPT_SSH_HOST_PUBLIC_KEY_MD5 || (_curl_opt) == CURLOPT_SSH_PUBLIC_KEYFILE || (_curl_opt) == CURLOPT_SSH_PRIVATE_KEYFILE || (_curl_opt) == CURLOPT_CRLFILE || (_curl_opt) == CURLOPT_ISSUERCERT || (_curl_opt) == CURLOPT_SOCKS5_GSSAPI_SERVICE || (_curl_opt) == CURLOPT_SSH_KNOWNHOSTS || (_curl_opt) == CURLOPT_MAIL_FROM || (_curl_opt) == CURLOPT_RTSP_SESSION_ID || (_curl_opt) == CURLOPT_RTSP_STREAM_URI || (_curl_opt) == CURLOPT_RTSP_TRANSPORT || 0)) if(!((((__builtin_types_compatible_p(__typeof__(((header_handler))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((header_handler))), char *) || __builtin_types_compatible_p(__typeof__(((header_handler))), const char *)) || __builtin_types_compatible_p(__typeof__((header_handler)), char [])) || (((__builtin_types_compatible_p(__typeof__(((header_handler))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((header_handler))), signed char *) || __builtin_types_compatible_p(__typeof__(((header_handler))), const signed char *)) || __builtin_types_compatible_p(__typeof__((header_handler)), signed char [])) || (((__builtin_types_compatible_p(__typeof__(((header_handler))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((header_handler))), unsigned char *) || __builtin_types_compatible_p(__typeof__(((header_handler))), const unsigned char *)) || __builtin_types_compatible_p(__typeof__((header_handler)), unsigned char [])))) _curl_easy_setopt_err_string(); if(((_curl_opt) == CURLOPT_HEADERFUNCTION || (_curl_opt) == CURLOPT_WRITEFUNCTION)) if(!(((__builtin_types_compatible_p(__typeof__(header_handler), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(header_handler), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(header_handler), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_read_callback6*))) || __builtin_types_compatible_p(__typeof__(header_handler), __typeof__(fwrite)) || __builtin_types_compatible_p(__typeof__(header_handler), curl_write_callback) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_write_callback1) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_write_callback1*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_write_callback2) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_write_callback2*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_write_callback3) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_write_callback3*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_write_callback4) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_write_callback4*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_write_callback5) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_write_callback5*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_write_callback6) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_write_callback6*)))) _curl_easy_setopt_err_write_callback(); if((_curl_opt) == CURLOPT_READFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(header_handler), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(header_handler), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(header_handler), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_read_callback6*)))) _curl_easy_setopt_err_read_cb(); if((_curl_opt) == CURLOPT_IOCTLFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(header_handler), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(header_handler), curl_ioctl_callback) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_ioctl_callback1) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_ioctl_callback1*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_ioctl_callback2) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_ioctl_callback2*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_ioctl_callback3) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_ioctl_callback3*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_ioctl_callback4) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_ioctl_callback4*)))) _curl_easy_setopt_err_ioctl_cb(); if((_curl_opt) == CURLOPT_SOCKOPTFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(header_handler), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(header_handler), curl_sockopt_callback) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_sockopt_callback1) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_sockopt_callback1*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_sockopt_callback2) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_sockopt_callback2*)))) _curl_easy_setopt_err_sockopt_cb(); if((_curl_opt) == CURLOPT_OPENSOCKETFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(header_handler), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(header_handler), curl_opensocket_callback) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_opensocket_callback1) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_opensocket_callback1*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_opensocket_callback2) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_opensocket_callback2*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_opensocket_callback3) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_opensocket_callback3*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_opensocket_callback4) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_opensocket_callback4*)))) _curl_easy_setopt_err_opensocket_cb(); if((_curl_opt) == CURLOPT_PROGRESSFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(header_handler), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(header_handler), curl_progress_callback) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_progress_callback1) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_progress_callback1*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_progress_callback2) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_progress_callback2*)))) _curl_easy_setopt_err_progress_cb(); if((_curl_opt) == CURLOPT_DEBUGFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(header_handler), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(header_handler), curl_debug_callback) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_debug_callback1) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_debug_callback1*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_debug_callback2) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_debug_callback2*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_debug_callback3) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_debug_callback3*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_debug_callback4) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_debug_callback4*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_debug_callback5) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_debug_callback5*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_debug_callback6) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_debug_callback6*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_debug_callback7) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_debug_callback7*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_debug_callback8) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_debug_callback8*)))) _curl_easy_setopt_err_debug_cb(); if((_curl_opt) == CURLOPT_SSL_CTX_FUNCTION) if(!((__builtin_types_compatible_p(__typeof__(header_handler), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(header_handler), curl_ssl_ctx_callback) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_ssl_ctx_callback1) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_ssl_ctx_callback1*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_ssl_ctx_callback2) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_ssl_ctx_callback2*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_ssl_ctx_callback3) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_ssl_ctx_callback3*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_ssl_ctx_callback4) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_ssl_ctx_callback4*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_ssl_ctx_callback5) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_ssl_ctx_callback5*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_ssl_ctx_callback6) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_ssl_ctx_callback6*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_ssl_ctx_callback7) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_ssl_ctx_callback7*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_ssl_ctx_callback8) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_ssl_ctx_callback8*)))) _curl_easy_setopt_err_ssl_ctx_cb(); if(((_curl_opt) == CURLOPT_CONV_TO_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_UTF8_FUNCTION)) if(!((__builtin_types_compatible_p(__typeof__(header_handler), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(header_handler), curl_conv_callback) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_conv_callback1) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_conv_callback1*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_conv_callback2) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_conv_callback2*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_conv_callback3) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_conv_callback3*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_conv_callback4) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_conv_callback4*)))) _curl_easy_setopt_err_conv_cb(); if((_curl_opt) == CURLOPT_SEEKFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(header_handler), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(header_handler), curl_seek_callback) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_seek_callback1) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_seek_callback1*)) || (__builtin_types_compatible_p(__typeof__((header_handler)), _curl_seek_callback2) || __builtin_types_compatible_p(__typeof__((header_handler)), _curl_seek_callback2*)))) _curl_easy_setopt_err_seek_cb(); if(((_curl_opt) == CURLOPT_FILE || (_curl_opt) == CURLOPT_INFILE || (_curl_opt) == CURLOPT_IOCTLDATA || (_curl_opt) == CURLOPT_SOCKOPTDATA || (_curl_opt) == CURLOPT_OPENSOCKETDATA || (_curl_opt) == CURLOPT_PROGRESSDATA || (_curl_opt) == CURLOPT_WRITEHEADER || (_curl_opt) == CURLOPT_DEBUGDATA || (_curl_opt) == CURLOPT_SSL_CTX_DATA || (_curl_opt) == CURLOPT_SEEKDATA || (_curl_opt) == CURLOPT_PRIVATE || (_curl_opt) == CURLOPT_SSH_KEYDATA || (_curl_opt) == CURLOPT_INTERLEAVEDATA || (_curl_opt) == CURLOPT_CHUNK_DATA || (_curl_opt) == CURLOPT_FNMATCH_DATA || 0)) if(!(sizeof(header_handler) == sizeof(void*))) _curl_easy_setopt_err_cb_data(); if((_curl_opt) == CURLOPT_ERRORBUFFER) if(!((__builtin_types_compatible_p(__typeof__(header_handler), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(header_handler), char *) || __builtin_types_compatible_p(__typeof__(header_handler), char[]))) _curl_easy_setopt_err_error_buffer(); if((_curl_opt) == CURLOPT_STDERR) if(!(__builtin_types_compatible_p(__typeof__(header_handler), FILE *))) _curl_easy_setopt_err_FILE(); if(((_curl_opt) == CURLOPT_POSTFIELDS || (_curl_opt) == CURLOPT_COPYPOSTFIELDS || 0)) if(!(((__builtin_types_compatible_p(__typeof__((header_handler)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((header_handler)), void *) || __builtin_types_compatible_p(__typeof__((header_handler)), const void *)) || (((__builtin_types_compatible_p(__typeof__(((header_handler))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((header_handler))), char *) || __builtin_types_compatible_p(__typeof__(((header_handler))), const char *)) || __builtin_types_compatible_p(__typeof__((header_handler)), char [])))) _curl_easy_setopt_err_postfields(); if((_curl_opt) == CURLOPT_HTTPPOST) if(!(((__builtin_types_compatible_p(__typeof__(((header_handler))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((header_handler))), struct curl_httppost *) || __builtin_types_compatible_p(__typeof__(((header_handler))), const struct curl_httppost *)) || __builtin_types_compatible_p(__typeof__((header_handler)), struct curl_httppost []))) _curl_easy_setopt_err_curl_httpost(); if(((_curl_opt) == CURLOPT_HTTPHEADER || (_curl_opt) == CURLOPT_HTTP200ALIASES || (_curl_opt) == CURLOPT_QUOTE || (_curl_opt) == CURLOPT_POSTQUOTE || (_curl_opt) == CURLOPT_PREQUOTE || (_curl_opt) == CURLOPT_TELNETOPTIONS || (_curl_opt) == CURLOPT_MAIL_RCPT || 0)) if(!(((__builtin_types_compatible_p(__typeof__(((header_handler))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((header_handler))), struct curl_slist *) || __builtin_types_compatible_p(__typeof__(((header_handler))), const struct curl_slist *)) || __builtin_types_compatible_p(__typeof__((header_handler)), struct curl_slist []))) _curl_easy_setopt_err_curl_slist(); if((_curl_opt) == CURLOPT_SHARE) if(!((__builtin_types_compatible_p(__typeof__((header_handler)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((header_handler)), CURLSH *) || __builtin_types_compatible_p(__typeof__((header_handler)), const CURLSH *))) _curl_easy_setopt_err_CURLSH(); } curl_easy_setopt(request->curl, _curl_opt, header_handler); });
 int t = 10;
 __extension__ ({ __typeof__ (CURLOPT_DEBUGDATA) _curl_opt = CURLOPT_DEBUGDATA; if(__builtin_constant_p(_curl_opt)) { if((0 < (_curl_opt) && (_curl_opt) < 10000)) if(!(__builtin_types_compatible_p(__typeof__(&t), long) || __builtin_types_compatible_p(__typeof__(&t), signed long) || __builtin_types_compatible_p(__typeof__(&t), unsigned long) || __builtin_types_compatible_p(__typeof__(&t), int) || __builtin_types_compatible_p(__typeof__(&t), signed int) || __builtin_types_compatible_p(__typeof__(&t), unsigned int) || __builtin_types_compatible_p(__typeof__(&t), short) || __builtin_types_compatible_p(__typeof__(&t), signed short) || __builtin_types_compatible_p(__typeof__(&t), unsigned short) || __builtin_types_compatible_p(__typeof__(&t), char) || __builtin_types_compatible_p(__typeof__(&t), signed char) || __builtin_types_compatible_p(__typeof__(&t), unsigned char))) _curl_easy_setopt_err_long(); if(((_curl_opt) > 30000)) if(!(__builtin_types_compatible_p(__typeof__(&t), curl_off_t))) _curl_easy_setopt_err_curl_off_t(); if(((_curl_opt) == CURLOPT_URL || (_curl_opt) == CURLOPT_PROXY || (_curl_opt) == CURLOPT_INTERFACE || (_curl_opt) == CURLOPT_NETRC_FILE || (_curl_opt) == CURLOPT_USERPWD || (_curl_opt) == CURLOPT_USERNAME || (_curl_opt) == CURLOPT_PASSWORD || (_curl_opt) == CURLOPT_PROXYUSERPWD || (_curl_opt) == CURLOPT_PROXYUSERNAME || (_curl_opt) == CURLOPT_PROXYPASSWORD || (_curl_opt) == CURLOPT_NOPROXY || (_curl_opt) == CURLOPT_ACCEPT_ENCODING || (_curl_opt) == CURLOPT_REFERER || (_curl_opt) == CURLOPT_USERAGENT || (_curl_opt) == CURLOPT_COOKIE || (_curl_opt) == CURLOPT_COOKIEFILE || (_curl_opt) == CURLOPT_COOKIEJAR || (_curl_opt) == CURLOPT_COOKIELIST || (_curl_opt) == CURLOPT_FTPPORT || (_curl_opt) == CURLOPT_FTP_ALTERNATIVE_TO_USER || (_curl_opt) == CURLOPT_FTP_ACCOUNT || (_curl_opt) == CURLOPT_RANGE || (_curl_opt) == CURLOPT_CUSTOMREQUEST || (_curl_opt) == CURLOPT_SSLCERT || (_curl_opt) == CURLOPT_SSLCERTTYPE || (_curl_opt) == CURLOPT_SSLKEY || (_curl_opt) == CURLOPT_SSLKEYTYPE || (_curl_opt) == CURLOPT_KEYPASSWD || (_curl_opt) == CURLOPT_SSLENGINE || (_curl_opt) == CURLOPT_CAINFO || (_curl_opt) == CURLOPT_CAPATH || (_curl_opt) == CURLOPT_RANDOM_FILE || (_curl_opt) == CURLOPT_EGDSOCKET || (_curl_opt) == CURLOPT_SSL_CIPHER_LIST || (_curl_opt) == CURLOPT_KRBLEVEL || (_curl_opt) == CURLOPT_SSH_HOST_PUBLIC_KEY_MD5 || (_curl_opt) == CURLOPT_SSH_PUBLIC_KEYFILE || (_curl_opt) == CURLOPT_SSH_PRIVATE_KEYFILE || (_curl_opt) == CURLOPT_CRLFILE || (_curl_opt) == CURLOPT_ISSUERCERT || (_curl_opt) == CURLOPT_SOCKS5_GSSAPI_SERVICE || (_curl_opt) == CURLOPT_SSH_KNOWNHOSTS || (_curl_opt) == CURLOPT_MAIL_FROM || (_curl_opt) == CURLOPT_RTSP_SESSION_ID || (_curl_opt) == CURLOPT_RTSP_STREAM_URI || (_curl_opt) == CURLOPT_RTSP_TRANSPORT || 0)) if(!((((__builtin_types_compatible_p(__typeof__(((&t))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&t))), char *) || __builtin_types_compatible_p(__typeof__(((&t))), const char *)) || __builtin_types_compatible_p(__typeof__((&t)), char [])) || (((__builtin_types_compatible_p(__typeof__(((&t))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&t))), signed char *) || __builtin_types_compatible_p(__typeof__(((&t))), const signed char *)) || __builtin_types_compatible_p(__typeof__((&t)), signed char [])) || (((__builtin_types_compatible_p(__typeof__(((&t))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&t))), unsigned char *) || __builtin_types_compatible_p(__typeof__(((&t))), const unsigned char *)) || __builtin_types_compatible_p(__typeof__((&t)), unsigned char [])))) _curl_easy_setopt_err_string(); if(((_curl_opt) == CURLOPT_HEADERFUNCTION || (_curl_opt) == CURLOPT_WRITEFUNCTION)) if(!(((__builtin_types_compatible_p(__typeof__(&t), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&t), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(&t), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((&t)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((&t)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((&t)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((&t)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((&t)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((&t)), _curl_read_callback6*))) || __builtin_types_compatible_p(__typeof__(&t), __typeof__(fwrite)) || __builtin_types_compatible_p(__typeof__(&t), curl_write_callback) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_write_callback1) || __builtin_types_compatible_p(__typeof__((&t)), _curl_write_callback1*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_write_callback2) || __builtin_types_compatible_p(__typeof__((&t)), _curl_write_callback2*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_write_callback3) || __builtin_types_compatible_p(__typeof__((&t)), _curl_write_callback3*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_write_callback4) || __builtin_types_compatible_p(__typeof__((&t)), _curl_write_callback4*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_write_callback5) || __builtin_types_compatible_p(__typeof__((&t)), _curl_write_callback5*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_write_callback6) || __builtin_types_compatible_p(__typeof__((&t)), _curl_write_callback6*)))) _curl_easy_setopt_err_write_callback(); if((_curl_opt) == CURLOPT_READFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(&t), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&t), __typeof__(fread)) || __builtin_types_compatible_p(__typeof__(&t), curl_read_callback) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_read_callback1) || __builtin_types_compatible_p(__typeof__((&t)), _curl_read_callback1*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_read_callback2) || __builtin_types_compatible_p(__typeof__((&t)), _curl_read_callback2*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_read_callback3) || __builtin_types_compatible_p(__typeof__((&t)), _curl_read_callback3*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_read_callback4) || __builtin_types_compatible_p(__typeof__((&t)), _curl_read_callback4*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_read_callback5) || __builtin_types_compatible_p(__typeof__((&t)), _curl_read_callback5*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_read_callback6) || __builtin_types_compatible_p(__typeof__((&t)), _curl_read_callback6*)))) _curl_easy_setopt_err_read_cb(); if((_curl_opt) == CURLOPT_IOCTLFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(&t), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&t), curl_ioctl_callback) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_ioctl_callback1) || __builtin_types_compatible_p(__typeof__((&t)), _curl_ioctl_callback1*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_ioctl_callback2) || __builtin_types_compatible_p(__typeof__((&t)), _curl_ioctl_callback2*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_ioctl_callback3) || __builtin_types_compatible_p(__typeof__((&t)), _curl_ioctl_callback3*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_ioctl_callback4) || __builtin_types_compatible_p(__typeof__((&t)), _curl_ioctl_callback4*)))) _curl_easy_setopt_err_ioctl_cb(); if((_curl_opt) == CURLOPT_SOCKOPTFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(&t), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&t), curl_sockopt_callback) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_sockopt_callback1) || __builtin_types_compatible_p(__typeof__((&t)), _curl_sockopt_callback1*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_sockopt_callback2) || __builtin_types_compatible_p(__typeof__((&t)), _curl_sockopt_callback2*)))) _curl_easy_setopt_err_sockopt_cb(); if((_curl_opt) == CURLOPT_OPENSOCKETFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(&t), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&t), curl_opensocket_callback) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_opensocket_callback1) || __builtin_types_compatible_p(__typeof__((&t)), _curl_opensocket_callback1*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_opensocket_callback2) || __builtin_types_compatible_p(__typeof__((&t)), _curl_opensocket_callback2*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_opensocket_callback3) || __builtin_types_compatible_p(__typeof__((&t)), _curl_opensocket_callback3*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_opensocket_callback4) || __builtin_types_compatible_p(__typeof__((&t)), _curl_opensocket_callback4*)))) _curl_easy_setopt_err_opensocket_cb(); if((_curl_opt) == CURLOPT_PROGRESSFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(&t), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&t), curl_progress_callback) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_progress_callback1) || __builtin_types_compatible_p(__typeof__((&t)), _curl_progress_callback1*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_progress_callback2) || __builtin_types_compatible_p(__typeof__((&t)), _curl_progress_callback2*)))) _curl_easy_setopt_err_progress_cb(); if((_curl_opt) == CURLOPT_DEBUGFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(&t), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&t), curl_debug_callback) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_debug_callback1) || __builtin_types_compatible_p(__typeof__((&t)), _curl_debug_callback1*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_debug_callback2) || __builtin_types_compatible_p(__typeof__((&t)), _curl_debug_callback2*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_debug_callback3) || __builtin_types_compatible_p(__typeof__((&t)), _curl_debug_callback3*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_debug_callback4) || __builtin_types_compatible_p(__typeof__((&t)), _curl_debug_callback4*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_debug_callback5) || __builtin_types_compatible_p(__typeof__((&t)), _curl_debug_callback5*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_debug_callback6) || __builtin_types_compatible_p(__typeof__((&t)), _curl_debug_callback6*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_debug_callback7) || __builtin_types_compatible_p(__typeof__((&t)), _curl_debug_callback7*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_debug_callback8) || __builtin_types_compatible_p(__typeof__((&t)), _curl_debug_callback8*)))) _curl_easy_setopt_err_debug_cb(); if((_curl_opt) == CURLOPT_SSL_CTX_FUNCTION) if(!((__builtin_types_compatible_p(__typeof__(&t), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&t), curl_ssl_ctx_callback) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_ssl_ctx_callback1) || __builtin_types_compatible_p(__typeof__((&t)), _curl_ssl_ctx_callback1*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_ssl_ctx_callback2) || __builtin_types_compatible_p(__typeof__((&t)), _curl_ssl_ctx_callback2*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_ssl_ctx_callback3) || __builtin_types_compatible_p(__typeof__((&t)), _curl_ssl_ctx_callback3*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_ssl_ctx_callback4) || __builtin_types_compatible_p(__typeof__((&t)), _curl_ssl_ctx_callback4*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_ssl_ctx_callback5) || __builtin_types_compatible_p(__typeof__((&t)), _curl_ssl_ctx_callback5*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_ssl_ctx_callback6) || __builtin_types_compatible_p(__typeof__((&t)), _curl_ssl_ctx_callback6*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_ssl_ctx_callback7) || __builtin_types_compatible_p(__typeof__((&t)), _curl_ssl_ctx_callback7*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_ssl_ctx_callback8) || __builtin_types_compatible_p(__typeof__((&t)), _curl_ssl_ctx_callback8*)))) _curl_easy_setopt_err_ssl_ctx_cb(); if(((_curl_opt) == CURLOPT_CONV_TO_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_NETWORK_FUNCTION || (_curl_opt) == CURLOPT_CONV_FROM_UTF8_FUNCTION)) if(!((__builtin_types_compatible_p(__typeof__(&t), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&t), curl_conv_callback) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_conv_callback1) || __builtin_types_compatible_p(__typeof__((&t)), _curl_conv_callback1*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_conv_callback2) || __builtin_types_compatible_p(__typeof__((&t)), _curl_conv_callback2*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_conv_callback3) || __builtin_types_compatible_p(__typeof__((&t)), _curl_conv_callback3*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_conv_callback4) || __builtin_types_compatible_p(__typeof__((&t)), _curl_conv_callback4*)))) _curl_easy_setopt_err_conv_cb(); if((_curl_opt) == CURLOPT_SEEKFUNCTION) if(!((__builtin_types_compatible_p(__typeof__(&t), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&t), curl_seek_callback) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_seek_callback1) || __builtin_types_compatible_p(__typeof__((&t)), _curl_seek_callback1*)) || (__builtin_types_compatible_p(__typeof__((&t)), _curl_seek_callback2) || __builtin_types_compatible_p(__typeof__((&t)), _curl_seek_callback2*)))) _curl_easy_setopt_err_seek_cb(); if(((_curl_opt) == CURLOPT_FILE || (_curl_opt) == CURLOPT_INFILE || (_curl_opt) == CURLOPT_IOCTLDATA || (_curl_opt) == CURLOPT_SOCKOPTDATA || (_curl_opt) == CURLOPT_OPENSOCKETDATA || (_curl_opt) == CURLOPT_PROGRESSDATA || (_curl_opt) == CURLOPT_WRITEHEADER || (_curl_opt) == CURLOPT_DEBUGDATA || (_curl_opt) == CURLOPT_SSL_CTX_DATA || (_curl_opt) == CURLOPT_SEEKDATA || (_curl_opt) == CURLOPT_PRIVATE || (_curl_opt) == CURLOPT_SSH_KEYDATA || (_curl_opt) == CURLOPT_INTERLEAVEDATA || (_curl_opt) == CURLOPT_CHUNK_DATA || (_curl_opt) == CURLOPT_FNMATCH_DATA || 0)) if(!(sizeof(&t) == sizeof(void*))) _curl_easy_setopt_err_cb_data(); if((_curl_opt) == CURLOPT_ERRORBUFFER) if(!((__builtin_types_compatible_p(__typeof__(&t), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(&t), char *) || __builtin_types_compatible_p(__typeof__(&t), char[]))) _curl_easy_setopt_err_error_buffer(); if((_curl_opt) == CURLOPT_STDERR) if(!(__builtin_types_compatible_p(__typeof__(&t), FILE *))) _curl_easy_setopt_err_FILE(); if(((_curl_opt) == CURLOPT_POSTFIELDS || (_curl_opt) == CURLOPT_COPYPOSTFIELDS || 0)) if(!(((__builtin_types_compatible_p(__typeof__((&t)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((&t)), void *) || __builtin_types_compatible_p(__typeof__((&t)), const void *)) || (((__builtin_types_compatible_p(__typeof__(((&t))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&t))), char *) || __builtin_types_compatible_p(__typeof__(((&t))), const char *)) || __builtin_types_compatible_p(__typeof__((&t)), char [])))) _curl_easy_setopt_err_postfields(); if((_curl_opt) == CURLOPT_HTTPPOST) if(!(((__builtin_types_compatible_p(__typeof__(((&t))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&t))), struct curl_httppost *) || __builtin_types_compatible_p(__typeof__(((&t))), const struct curl_httppost *)) || __builtin_types_compatible_p(__typeof__((&t)), struct curl_httppost []))) _curl_easy_setopt_err_curl_httpost(); if(((_curl_opt) == CURLOPT_HTTPHEADER || (_curl_opt) == CURLOPT_HTTP200ALIASES || (_curl_opt) == CURLOPT_QUOTE || (_curl_opt) == CURLOPT_POSTQUOTE || (_curl_opt) == CURLOPT_PREQUOTE || (_curl_opt) == CURLOPT_TELNETOPTIONS || (_curl_opt) == CURLOPT_MAIL_RCPT || 0)) if(!(((__builtin_types_compatible_p(__typeof__(((&t))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&t))), struct curl_slist *) || __builtin_types_compatible_p(__typeof__(((&t))), const struct curl_slist *)) || __builtin_types_compatible_p(__typeof__((&t)), struct curl_slist []))) _curl_easy_setopt_err_curl_slist(); if((_curl_opt) == CURLOPT_SHARE) if(!((__builtin_types_compatible_p(__typeof__((&t)), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__((&t)), CURLSH *) || __builtin_types_compatible_p(__typeof__((&t)), const CURLSH *))) _curl_easy_setopt_err_CURLSH(); } curl_easy_setopt(request->curl, _curl_opt, &t); });


    if (context) {
  printf("cURL multi start\n");
        CURLMcode code = curl_multi_add_handle(context->curlm, request->curl);
  printf("cURL multi end\n");
        if (code == CURLM_OK) {
            if (context->requests) {
                request->prev = context->requests->prev;
                request->next = context->requests;
                context->requests->prev->next = request;
                context->requests->prev = request;
            }
            else {
                context->requests = request->next = request->prev = request;
            }
        }
        else {
            if (request->status == S3StatusOK) {
                request->status = (code == CURLM_OUT_OF_MEMORY) ?
                    S3StatusOutOfMemory : S3StatusInternalError;
            }
            request_finish(request);
        }
    }

    else {



        CURLcode code = curl_easy_perform(request->curl);

        if ((code != CURLE_OK) && (request->status == S3StatusOK)) {
            request->status = request_curl_code_to_status(code);
        }

  double up_sz, down_sz, pre_time, st_time, tot_time, redir_time, appcon_time, con_time, lu_time;
  up_sz = down_sz = pre_time = st_time = tot_time = lu_time = appcon_time = con_time = redir_time = 0;
  long redir_count = 0;

  if ((code = __extension__ ({ __typeof__ (CURLINFO_SIZE_DOWNLOAD) _curl_info = CURLINFO_SIZE_DOWNLOAD; if(__builtin_constant_p(_curl_info)) { if((0x100000 < (_curl_info) && (_curl_info) < 0x200000)) if(!(((__builtin_types_compatible_p(__typeof__(((&down_sz))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&down_sz))), char * *) || __builtin_types_compatible_p(__typeof__(((&down_sz))), const char * *)) || __builtin_types_compatible_p(__typeof__((&down_sz)), char * []))) _curl_easy_getinfo_err_string(); if((0x200000 < (_curl_info) && (_curl_info) < 0x300000)) if(!(((__builtin_types_compatible_p(__typeof__(((&down_sz))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&down_sz))), long *) || __builtin_types_compatible_p(__typeof__(((&down_sz))), const long *)) || __builtin_types_compatible_p(__typeof__((&down_sz)), long []))) _curl_easy_getinfo_err_long(); if((0x300000 < (_curl_info) && (_curl_info) < 0x400000)) if(!(((__builtin_types_compatible_p(__typeof__(((&down_sz))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&down_sz))), double *) || __builtin_types_compatible_p(__typeof__(((&down_sz))), const double *)) || __builtin_types_compatible_p(__typeof__((&down_sz)), double []))) _curl_easy_getinfo_err_double(); if((0x400000 < (_curl_info))) if(!(((__builtin_types_compatible_p(__typeof__(((&down_sz))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&down_sz))), struct curl_slist * *) || __builtin_types_compatible_p(__typeof__(((&down_sz))), const struct curl_slist * *)) || __builtin_types_compatible_p(__typeof__((&down_sz)), struct curl_slist * []))) _curl_easy_getinfo_err_curl_slist(); } curl_easy_getinfo(request->curl, _curl_info, &down_sz); })) != CURLE_OK) {
            fprintf(stderr, "ERROR: curl_easy_getinfo :: %d", code);
        }

  if ((code = __extension__ ({ __typeof__ (CURLINFO_SIZE_UPLOAD) _curl_info = CURLINFO_SIZE_UPLOAD; if(__builtin_constant_p(_curl_info)) { if((0x100000 < (_curl_info) && (_curl_info) < 0x200000)) if(!(((__builtin_types_compatible_p(__typeof__(((&up_sz))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&up_sz))), char * *) || __builtin_types_compatible_p(__typeof__(((&up_sz))), const char * *)) || __builtin_types_compatible_p(__typeof__((&up_sz)), char * []))) _curl_easy_getinfo_err_string(); if((0x200000 < (_curl_info) && (_curl_info) < 0x300000)) if(!(((__builtin_types_compatible_p(__typeof__(((&up_sz))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&up_sz))), long *) || __builtin_types_compatible_p(__typeof__(((&up_sz))), const long *)) || __builtin_types_compatible_p(__typeof__((&up_sz)), long []))) _curl_easy_getinfo_err_long(); if((0x300000 < (_curl_info) && (_curl_info) < 0x400000)) if(!(((__builtin_types_compatible_p(__typeof__(((&up_sz))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&up_sz))), double *) || __builtin_types_compatible_p(__typeof__(((&up_sz))), const double *)) || __builtin_types_compatible_p(__typeof__((&up_sz)), double []))) _curl_easy_getinfo_err_double(); if((0x400000 < (_curl_info))) if(!(((__builtin_types_compatible_p(__typeof__(((&up_sz))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&up_sz))), struct curl_slist * *) || __builtin_types_compatible_p(__typeof__(((&up_sz))), const struct curl_slist * *)) || __builtin_types_compatible_p(__typeof__((&up_sz)), struct curl_slist * []))) _curl_easy_getinfo_err_curl_slist(); } curl_easy_getinfo(request->curl, _curl_info, &up_sz); })) != CURLE_OK) {
            fprintf(stderr, "ERROR: curl_easy_getinfo :: %d", code);
        }

  if ((code = __extension__ ({ __typeof__ (CURLINFO_NAMELOOKUP_TIME) _curl_info = CURLINFO_NAMELOOKUP_TIME; if(__builtin_constant_p(_curl_info)) { if((0x100000 < (_curl_info) && (_curl_info) < 0x200000)) if(!(((__builtin_types_compatible_p(__typeof__(((&lu_time))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&lu_time))), char * *) || __builtin_types_compatible_p(__typeof__(((&lu_time))), const char * *)) || __builtin_types_compatible_p(__typeof__((&lu_time)), char * []))) _curl_easy_getinfo_err_string(); if((0x200000 < (_curl_info) && (_curl_info) < 0x300000)) if(!(((__builtin_types_compatible_p(__typeof__(((&lu_time))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&lu_time))), long *) || __builtin_types_compatible_p(__typeof__(((&lu_time))), const long *)) || __builtin_types_compatible_p(__typeof__((&lu_time)), long []))) _curl_easy_getinfo_err_long(); if((0x300000 < (_curl_info) && (_curl_info) < 0x400000)) if(!(((__builtin_types_compatible_p(__typeof__(((&lu_time))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&lu_time))), double *) || __builtin_types_compatible_p(__typeof__(((&lu_time))), const double *)) || __builtin_types_compatible_p(__typeof__((&lu_time)), double []))) _curl_easy_getinfo_err_double(); if((0x400000 < (_curl_info))) if(!(((__builtin_types_compatible_p(__typeof__(((&lu_time))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&lu_time))), struct curl_slist * *) || __builtin_types_compatible_p(__typeof__(((&lu_time))), const struct curl_slist * *)) || __builtin_types_compatible_p(__typeof__((&lu_time)), struct curl_slist * []))) _curl_easy_getinfo_err_curl_slist(); } curl_easy_getinfo(request->curl, _curl_info, &lu_time); })) != CURLE_OK) {
   fprintf(stderr, "ERROR: curl_easy_getinfo :: %d", code);
  }

  if ((code = __extension__ ({ __typeof__ (CURLINFO_CONNECT_TIME) _curl_info = CURLINFO_CONNECT_TIME; if(__builtin_constant_p(_curl_info)) { if((0x100000 < (_curl_info) && (_curl_info) < 0x200000)) if(!(((__builtin_types_compatible_p(__typeof__(((&con_time))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&con_time))), char * *) || __builtin_types_compatible_p(__typeof__(((&con_time))), const char * *)) || __builtin_types_compatible_p(__typeof__((&con_time)), char * []))) _curl_easy_getinfo_err_string(); if((0x200000 < (_curl_info) && (_curl_info) < 0x300000)) if(!(((__builtin_types_compatible_p(__typeof__(((&con_time))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&con_time))), long *) || __builtin_types_compatible_p(__typeof__(((&con_time))), const long *)) || __builtin_types_compatible_p(__typeof__((&con_time)), long []))) _curl_easy_getinfo_err_long(); if((0x300000 < (_curl_info) && (_curl_info) < 0x400000)) if(!(((__builtin_types_compatible_p(__typeof__(((&con_time))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&con_time))), double *) || __builtin_types_compatible_p(__typeof__(((&con_time))), const double *)) || __builtin_types_compatible_p(__typeof__((&con_time)), double []))) _curl_easy_getinfo_err_double(); if((0x400000 < (_curl_info))) if(!(((__builtin_types_compatible_p(__typeof__(((&con_time))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&con_time))), struct curl_slist * *) || __builtin_types_compatible_p(__typeof__(((&con_time))), const struct curl_slist * *)) || __builtin_types_compatible_p(__typeof__((&con_time)), struct curl_slist * []))) _curl_easy_getinfo_err_curl_slist(); } curl_easy_getinfo(request->curl, _curl_info, &con_time); })) != CURLE_OK) {
   fprintf(stderr, "ERROR: curl_easy_getinfo :: %d", code);
  }

  if ((code = __extension__ ({ __typeof__ (CURLINFO_APPCONNECT_TIME) _curl_info = CURLINFO_APPCONNECT_TIME; if(__builtin_constant_p(_curl_info)) { if((0x100000 < (_curl_info) && (_curl_info) < 0x200000)) if(!(((__builtin_types_compatible_p(__typeof__(((&appcon_time))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&appcon_time))), char * *) || __builtin_types_compatible_p(__typeof__(((&appcon_time))), const char * *)) || __builtin_types_compatible_p(__typeof__((&appcon_time)), char * []))) _curl_easy_getinfo_err_string(); if((0x200000 < (_curl_info) && (_curl_info) < 0x300000)) if(!(((__builtin_types_compatible_p(__typeof__(((&appcon_time))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&appcon_time))), long *) || __builtin_types_compatible_p(__typeof__(((&appcon_time))), const long *)) || __builtin_types_compatible_p(__typeof__((&appcon_time)), long []))) _curl_easy_getinfo_err_long(); if((0x300000 < (_curl_info) && (_curl_info) < 0x400000)) if(!(((__builtin_types_compatible_p(__typeof__(((&appcon_time))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&appcon_time))), double *) || __builtin_types_compatible_p(__typeof__(((&appcon_time))), const double *)) || __builtin_types_compatible_p(__typeof__((&appcon_time)), double []))) _curl_easy_getinfo_err_double(); if((0x400000 < (_curl_info))) if(!(((__builtin_types_compatible_p(__typeof__(((&appcon_time))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&appcon_time))), struct curl_slist * *) || __builtin_types_compatible_p(__typeof__(((&appcon_time))), const struct curl_slist * *)) || __builtin_types_compatible_p(__typeof__((&appcon_time)), struct curl_slist * []))) _curl_easy_getinfo_err_curl_slist(); } curl_easy_getinfo(request->curl, _curl_info, &appcon_time); })) != CURLE_OK) {
   fprintf(stderr, "ERROR: curl_easy_getinfo :: %d", code);
  }

  if ((code = __extension__ ({ __typeof__ (CURLINFO_PRETRANSFER_TIME) _curl_info = CURLINFO_PRETRANSFER_TIME; if(__builtin_constant_p(_curl_info)) { if((0x100000 < (_curl_info) && (_curl_info) < 0x200000)) if(!(((__builtin_types_compatible_p(__typeof__(((&pre_time))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&pre_time))), char * *) || __builtin_types_compatible_p(__typeof__(((&pre_time))), const char * *)) || __builtin_types_compatible_p(__typeof__((&pre_time)), char * []))) _curl_easy_getinfo_err_string(); if((0x200000 < (_curl_info) && (_curl_info) < 0x300000)) if(!(((__builtin_types_compatible_p(__typeof__(((&pre_time))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&pre_time))), long *) || __builtin_types_compatible_p(__typeof__(((&pre_time))), const long *)) || __builtin_types_compatible_p(__typeof__((&pre_time)), long []))) _curl_easy_getinfo_err_long(); if((0x300000 < (_curl_info) && (_curl_info) < 0x400000)) if(!(((__builtin_types_compatible_p(__typeof__(((&pre_time))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&pre_time))), double *) || __builtin_types_compatible_p(__typeof__(((&pre_time))), const double *)) || __builtin_types_compatible_p(__typeof__((&pre_time)), double []))) _curl_easy_getinfo_err_double(); if((0x400000 < (_curl_info))) if(!(((__builtin_types_compatible_p(__typeof__(((&pre_time))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&pre_time))), struct curl_slist * *) || __builtin_types_compatible_p(__typeof__(((&pre_time))), const struct curl_slist * *)) || __builtin_types_compatible_p(__typeof__((&pre_time)), struct curl_slist * []))) _curl_easy_getinfo_err_curl_slist(); } curl_easy_getinfo(request->curl, _curl_info, &pre_time); })) != CURLE_OK) {
            fprintf(stderr, "ERROR: curl_easy_getinfo :: %d", code);
        }

  if ((code = __extension__ ({ __typeof__ (CURLINFO_STARTTRANSFER_TIME) _curl_info = CURLINFO_STARTTRANSFER_TIME; if(__builtin_constant_p(_curl_info)) { if((0x100000 < (_curl_info) && (_curl_info) < 0x200000)) if(!(((__builtin_types_compatible_p(__typeof__(((&st_time))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&st_time))), char * *) || __builtin_types_compatible_p(__typeof__(((&st_time))), const char * *)) || __builtin_types_compatible_p(__typeof__((&st_time)), char * []))) _curl_easy_getinfo_err_string(); if((0x200000 < (_curl_info) && (_curl_info) < 0x300000)) if(!(((__builtin_types_compatible_p(__typeof__(((&st_time))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&st_time))), long *) || __builtin_types_compatible_p(__typeof__(((&st_time))), const long *)) || __builtin_types_compatible_p(__typeof__((&st_time)), long []))) _curl_easy_getinfo_err_long(); if((0x300000 < (_curl_info) && (_curl_info) < 0x400000)) if(!(((__builtin_types_compatible_p(__typeof__(((&st_time))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&st_time))), double *) || __builtin_types_compatible_p(__typeof__(((&st_time))), const double *)) || __builtin_types_compatible_p(__typeof__((&st_time)), double []))) _curl_easy_getinfo_err_double(); if((0x400000 < (_curl_info))) if(!(((__builtin_types_compatible_p(__typeof__(((&st_time))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&st_time))), struct curl_slist * *) || __builtin_types_compatible_p(__typeof__(((&st_time))), const struct curl_slist * *)) || __builtin_types_compatible_p(__typeof__((&st_time)), struct curl_slist * []))) _curl_easy_getinfo_err_curl_slist(); } curl_easy_getinfo(request->curl, _curl_info, &st_time); })) != CURLE_OK) {
            fprintf(stderr, "ERROR: curl_easy_getinfo :: %d", code);
        }

  if ((code = __extension__ ({ __typeof__ (CURLINFO_TOTAL_TIME) _curl_info = CURLINFO_TOTAL_TIME; if(__builtin_constant_p(_curl_info)) { if((0x100000 < (_curl_info) && (_curl_info) < 0x200000)) if(!(((__builtin_types_compatible_p(__typeof__(((&tot_time))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&tot_time))), char * *) || __builtin_types_compatible_p(__typeof__(((&tot_time))), const char * *)) || __builtin_types_compatible_p(__typeof__((&tot_time)), char * []))) _curl_easy_getinfo_err_string(); if((0x200000 < (_curl_info) && (_curl_info) < 0x300000)) if(!(((__builtin_types_compatible_p(__typeof__(((&tot_time))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&tot_time))), long *) || __builtin_types_compatible_p(__typeof__(((&tot_time))), const long *)) || __builtin_types_compatible_p(__typeof__((&tot_time)), long []))) _curl_easy_getinfo_err_long(); if((0x300000 < (_curl_info) && (_curl_info) < 0x400000)) if(!(((__builtin_types_compatible_p(__typeof__(((&tot_time))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&tot_time))), double *) || __builtin_types_compatible_p(__typeof__(((&tot_time))), const double *)) || __builtin_types_compatible_p(__typeof__((&tot_time)), double []))) _curl_easy_getinfo_err_double(); if((0x400000 < (_curl_info))) if(!(((__builtin_types_compatible_p(__typeof__(((&tot_time))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&tot_time))), struct curl_slist * *) || __builtin_types_compatible_p(__typeof__(((&tot_time))), const struct curl_slist * *)) || __builtin_types_compatible_p(__typeof__((&tot_time)), struct curl_slist * []))) _curl_easy_getinfo_err_curl_slist(); } curl_easy_getinfo(request->curl, _curl_info, &tot_time); })) != CURLE_OK) {
            fprintf(stderr, "ERROR: curl_easy_getinfo :: %d", code);
        }

  if ((code = __extension__ ({ __typeof__ (CURLINFO_REDIRECT_TIME) _curl_info = CURLINFO_REDIRECT_TIME; if(__builtin_constant_p(_curl_info)) { if((0x100000 < (_curl_info) && (_curl_info) < 0x200000)) if(!(((__builtin_types_compatible_p(__typeof__(((&redir_time))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&redir_time))), char * *) || __builtin_types_compatible_p(__typeof__(((&redir_time))), const char * *)) || __builtin_types_compatible_p(__typeof__((&redir_time)), char * []))) _curl_easy_getinfo_err_string(); if((0x200000 < (_curl_info) && (_curl_info) < 0x300000)) if(!(((__builtin_types_compatible_p(__typeof__(((&redir_time))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&redir_time))), long *) || __builtin_types_compatible_p(__typeof__(((&redir_time))), const long *)) || __builtin_types_compatible_p(__typeof__((&redir_time)), long []))) _curl_easy_getinfo_err_long(); if((0x300000 < (_curl_info) && (_curl_info) < 0x400000)) if(!(((__builtin_types_compatible_p(__typeof__(((&redir_time))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&redir_time))), double *) || __builtin_types_compatible_p(__typeof__(((&redir_time))), const double *)) || __builtin_types_compatible_p(__typeof__((&redir_time)), double []))) _curl_easy_getinfo_err_double(); if((0x400000 < (_curl_info))) if(!(((__builtin_types_compatible_p(__typeof__(((&redir_time))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&redir_time))), struct curl_slist * *) || __builtin_types_compatible_p(__typeof__(((&redir_time))), const struct curl_slist * *)) || __builtin_types_compatible_p(__typeof__((&redir_time)), struct curl_slist * []))) _curl_easy_getinfo_err_curl_slist(); } curl_easy_getinfo(request->curl, _curl_info, &redir_time); })) != CURLE_OK) {
   fprintf(stderr, "ERROR: curl_easy_getinfo :: %d", code);
  }

  if ((code = __extension__ ({ __typeof__ (CURLINFO_REDIRECT_COUNT) _curl_info = CURLINFO_REDIRECT_COUNT; if(__builtin_constant_p(_curl_info)) { if((0x100000 < (_curl_info) && (_curl_info) < 0x200000)) if(!(((__builtin_types_compatible_p(__typeof__(((&redir_count))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&redir_count))), char * *) || __builtin_types_compatible_p(__typeof__(((&redir_count))), const char * *)) || __builtin_types_compatible_p(__typeof__((&redir_count)), char * []))) _curl_easy_getinfo_err_string(); if((0x200000 < (_curl_info) && (_curl_info) < 0x300000)) if(!(((__builtin_types_compatible_p(__typeof__(((&redir_count))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&redir_count))), long *) || __builtin_types_compatible_p(__typeof__(((&redir_count))), const long *)) || __builtin_types_compatible_p(__typeof__((&redir_count)), long []))) _curl_easy_getinfo_err_long(); if((0x300000 < (_curl_info) && (_curl_info) < 0x400000)) if(!(((__builtin_types_compatible_p(__typeof__(((&redir_count))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&redir_count))), double *) || __builtin_types_compatible_p(__typeof__(((&redir_count))), const double *)) || __builtin_types_compatible_p(__typeof__((&redir_count)), double []))) _curl_easy_getinfo_err_double(); if((0x400000 < (_curl_info))) if(!(((__builtin_types_compatible_p(__typeof__(((&redir_count))), __typeof__(((void *)0)))) || __builtin_types_compatible_p(__typeof__(((&redir_count))), struct curl_slist * *) || __builtin_types_compatible_p(__typeof__(((&redir_count))), const struct curl_slist * *)) || __builtin_types_compatible_p(__typeof__((&redir_count)), struct curl_slist * []))) _curl_easy_getinfo_err_curl_slist(); } curl_easy_getinfo(request->curl, _curl_info, &redir_count); })) != CURLE_OK) {
   fprintf(stderr, "ERROR: curl_easy_getinfo :: %d", code);
  }

  { time_it_insert_time(&time_it, down_sz, 1291, 1291, __func__, "./src/request.c", "Download size"); };
  { time_it_insert_time(&time_it, up_sz, 1292, 1292, __func__, "./src/request.c", "Upload size"); };
  { time_it_insert_time(&time_it, lu_time, 1293, 1293, __func__, "./src/request.c", "Lookup time"); };
  { time_it_insert_time(&time_it, con_time, 1294, 1294, __func__, "./src/request.c", "Connect time"); };
  { time_it_insert_time(&time_it, appcon_time, 1295, 1295, __func__, "./src/request.c", "App connect time (SSL)"); };
  { time_it_insert_time(&time_it, pre_time, 1296, 1296, __func__, "./src/request.c", "Pretransfer time"); };
  { time_it_insert_time(&time_it, st_time, 1297, 1297, __func__, "./src/request.c", "Start time"); };
  { time_it_insert_time(&time_it, tot_time, 1298, 1298, __func__, "./src/request.c", "Total time"); };
  { time_it_insert_time(&time_it, redir_time, 1299, 1299, __func__, "./src/request.c", "Redirect time"); };


  { int __i; struct time_it_timer_data cur = {0}; printf("\n\n====== TIMES ======\n"); for(__i = 0; __i < time_it.idx; __i++){ cur = time_it.data[__i]; printf("%s:%d-%d in %s :: %lf msec :: %s\n", cur.file, cur.st_line, cur.en_line, cur.func, cur.time*1000, cur.comment); } printf("===================\n"); };


        request_finish(request);
    }
}


void request_finish(Request *request)
{


    request_headers_done(request);



    if (request->status == S3StatusOK) {
        error_parser_convert_status(&(request->errorParser),
                                    &(request->status));



        if ((request->status == S3StatusOK) &&
            ((request->httpResponseCode < 200) ||
             (request->httpResponseCode > 299))) {
            switch (request->httpResponseCode) {
            case 0:


                request->status = S3StatusConnectionFailed;
                break;
            case 100:

                break;
            case 301:
                request->status = S3StatusErrorPermanentRedirect;
                break;
            case 307:
                request->status = S3StatusHttpErrorMovedTemporarily;
                break;
            case 400:
                request->status = S3StatusHttpErrorBadRequest;
                break;
            case 403:
                request->status = S3StatusHttpErrorForbidden;
                break;
            case 404:
                request->status = S3StatusHttpErrorNotFound;
                break;
            case 405:
                request->status = S3StatusErrorMethodNotAllowed;
                break;
            case 409:
                request->status = S3StatusHttpErrorConflict;
                break;
            case 411:
                request->status = S3StatusErrorMissingContentLength;
                break;
            case 412:
                request->status = S3StatusErrorPreconditionFailed;
                break;
            case 416:
                request->status = S3StatusErrorInvalidRange;
                break;
            case 500:
                request->status = S3StatusErrorInternalError;
                break;
            case 501:
                request->status = S3StatusErrorNotImplemented;
                break;
            case 503:
                request->status = S3StatusErrorSlowDown;
                break;
            default:
                request->status = S3StatusHttpErrorUnknown;
                break;
            }
        }
    }

    (*(request->completeCallback))
        (request->status, &(request->errorParser.s3ErrorDetails),
         request->callbackData);

    request_release(request);
}


S3Status request_curl_code_to_status(CURLcode code)
{
    switch (code) {
    case CURLE_OUT_OF_MEMORY:
        return S3StatusOutOfMemory;
    case CURLE_COULDNT_RESOLVE_PROXY:
    case CURLE_COULDNT_RESOLVE_HOST:
        return S3StatusNameLookupError;
    case CURLE_COULDNT_CONNECT:
        return S3StatusFailedToConnect;
    case CURLE_WRITE_ERROR:
    case CURLE_OPERATION_TIMEDOUT:
        return S3StatusConnectionFailed;
    case CURLE_PARTIAL_FILE:
        return S3StatusOK;
    case CURLE_SSL_CACERT:
        return S3StatusServerFailedVerification;
    default:
        return S3StatusInternalError;
    }
}


S3Status S3_generate_authenticated_query_string
    (char *buffer, const S3BucketContext *bucketContext,
     const char *key, int64_t expires, const char *resource)
{



    if (expires < 0) {
        expires = (((int64_t) 1 << 31) - 1);
    }
    else if (expires > (((int64_t) 1 << 31) - 1)) {
        expires = (((int64_t) 1 << 31) - 1);
    }






    char urlEncodedKey[1024 * 3];
    if (key) {
        urlEncode(urlEncodedKey, key, strlen(key));
    }
    else {
        urlEncodedKey[0] = 0;
    }


    char canonicalizedResource[(1 + 255 + 1 + (3 * 1024) + (sizeof("?torrent") - 1) + 1)];
    canonicalize_resource(bucketContext->bucketName, resource, urlEncodedKey,
                          canonicalizedResource);
# 1452 "./src/request.c"
    char signbuf[17 + 1 + 1 + 1 + 20 + sizeof(canonicalizedResource) + 1];
    int len = 0;





    len += snprintf(&(signbuf[len]), sizeof(signbuf) - len, "%s\n", "GET");
    len += snprintf(&(signbuf[len]), sizeof(signbuf) - len, "%s\n", "");
    len += snprintf(&(signbuf[len]), sizeof(signbuf) - len, "%s\n", "");
    len += snprintf(&(signbuf[len]), sizeof(signbuf) - len, "%llu\n", (unsigned long long) expires);
    len += snprintf(&(signbuf[len]), sizeof(signbuf) - len, "%s", canonicalizedResource);


    unsigned char hmac[20];

    HMAC_SHA1(hmac, (unsigned char *) bucketContext->secretAccessKey,
              strlen(bucketContext->secretAccessKey),
              (unsigned char *) signbuf, len);


    char b64[((20 + 1) * 4) / 3];
    int b64Len = base64Encode(hmac, 20, b64);


    char signature[sizeof(b64) * 3];
    urlEncode(signature, b64, b64Len);



    char queryParams[sizeof("AWSAccessKeyId=") + 20 +
                     sizeof("&Expires=") + 20 +
                     sizeof("&Signature=") + sizeof(signature) + 1];

    sprintf(queryParams, "AWSAccessKeyId=%s&Expires=%ld&Signature=%s",
            bucketContext->accessKeyId, (long) expires, signature);

    return compose_uri(buffer, (sizeof("https:///") + 255 + (1024 * 3) + sizeof("?AWSAccessKeyId=") + 32 + sizeof("&Expires=") + 32 + sizeof("&Signature=") + 28 + 1),
                       bucketContext, urlEncodedKey, resource, queryParams);
}
