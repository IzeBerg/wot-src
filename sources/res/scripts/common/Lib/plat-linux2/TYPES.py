_SYS_TYPES_H = 1
_FEATURES_H = 1
__USE_ANSI = 1
__FAVOR_BSD = 1
_ISOC99_SOURCE = 1
_POSIX_SOURCE = 1
_POSIX_C_SOURCE = 199506
_XOPEN_SOURCE = 600
_XOPEN_SOURCE_EXTENDED = 1
_LARGEFILE64_SOURCE = 1
_BSD_SOURCE = 1
_SVID_SOURCE = 1
_BSD_SOURCE = 1
_SVID_SOURCE = 1
__USE_ISOC99 = 1
_POSIX_SOURCE = 1
_POSIX_C_SOURCE = 2
_POSIX_C_SOURCE = 199506
__USE_POSIX = 1
__USE_POSIX2 = 1
__USE_POSIX199309 = 1
__USE_POSIX199506 = 1
__USE_XOPEN = 1
__USE_XOPEN_EXTENDED = 1
__USE_UNIX98 = 1
_LARGEFILE_SOURCE = 1
__USE_XOPEN2K = 1
__USE_ISOC99 = 1
__USE_XOPEN_EXTENDED = 1
__USE_LARGEFILE = 1
__USE_LARGEFILE64 = 1
__USE_FILE_OFFSET64 = 1
__USE_MISC = 1
__USE_BSD = 1
__USE_SVID = 1
__USE_GNU = 1
__USE_REENTRANT = 1
__STDC_IEC_559__ = 1
__STDC_IEC_559_COMPLEX__ = 1
__STDC_ISO_10646__ = 200009
__GNU_LIBRARY__ = 6
__GLIBC__ = 2
__GLIBC_MINOR__ = 2
_SYS_CDEFS_H = 1

def __PMT(args):
    return args


def __P(args):
    return args


def __PMT(args):
    return args


def __STRING(x):
    pass


__flexarr = []
__flexarr = [
 0]
__flexarr = []
__flexarr = [1]

def __ASMNAME(cname):
    return __ASMNAME2(__USER_LABEL_PREFIX__, cname)


def __attribute__(xyz):
    pass


def __attribute_format_arg__(x):
    return __attribute__(__format_arg__(x))


def __attribute_format_arg__(x):
    pass


__USE_LARGEFILE = 1
__USE_LARGEFILE64 = 1
__USE_EXTERN_INLINES = 1
_BITS_TYPES_H = 1
__FD_SETSIZE = 1024
_BITS_PTHREADTYPES_H = 1
SCHED_OTHER = 0
SCHED_FIFO = 1
SCHED_RR = 2
CSIGNAL = 255
CLONE_VM = 256
CLONE_FS = 512
CLONE_FILES = 1024
CLONE_SIGHAND = 2048
CLONE_PID = 4096
CLONE_PTRACE = 8192
CLONE_VFORK = 16384
__defined_schedparam = 1
_TIME_H = 1
_BITS_TIME_H = 1
CLOCKS_PER_SEC = 1000000
CLOCK_REALTIME = 0
CLOCK_PROCESS_CPUTIME_ID = 2
CLOCK_THREAD_CPUTIME_ID = 3
TIMER_ABSTIME = 1
_STRUCT_TIMEVAL = 1
CLK_TCK = CLOCKS_PER_SEC
__clock_t_defined = 1
__time_t_defined = 1
__clockid_t_defined = 1
__timer_t_defined = 1
__timespec_defined = 1

def __isleap(year):
    pass


__BIT_TYPES_DEFINED__ = 1
_ENDIAN_H = 1
__LITTLE_ENDIAN = 1234
__BIG_ENDIAN = 4321
__PDP_ENDIAN = 3412
__BYTE_ORDER = __LITTLE_ENDIAN
__FLOAT_WORD_ORDER = __BYTE_ORDER
LITTLE_ENDIAN = __LITTLE_ENDIAN
BIG_ENDIAN = __BIG_ENDIAN
PDP_ENDIAN = __PDP_ENDIAN
BYTE_ORDER = __BYTE_ORDER
_SYS_SELECT_H = 1

def __FD_ZERO(fdsp):
    pass


def __FD_ZERO(set):
    pass


_SIGSET_H_types = 1
_SIGSET_H_fns = 1

def __sigmask(sig):
    pass


def __sigemptyset(set):
    pass


def __sigfillset(set):
    pass


def __sigisemptyset(set):
    pass


def __FDELT(d):
    return d / __NFDBITS


FD_SETSIZE = __FD_SETSIZE

def FD_ZERO(fdsetp):
    return __FD_ZERO(fdsetp)


_SYS_SYSMACROS_H = 1

def major(dev):
    return int(dev >> 8 & 255)


def minor(dev):
    return int(dev & 255)


def major(dev):
    return dev.__val[1] >> 8 & 255


def minor(dev):
    return dev.__val[1] & 255


def major(dev):
    return dev.__val[0] >> 8 & 255


def minor(dev):
    return dev.__val[0] & 255