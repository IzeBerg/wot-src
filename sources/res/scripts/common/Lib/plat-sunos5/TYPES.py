_CHAR_ALIGNMENT = 1
_SHORT_ALIGNMENT = 2
_INT_ALIGNMENT = 4
_LONG_ALIGNMENT = 8
_LONG_LONG_ALIGNMENT = 8
_DOUBLE_ALIGNMENT = 8
_LONG_DOUBLE_ALIGNMENT = 16
_POINTER_ALIGNMENT = 8
_MAX_ALIGNMENT = 16
_ALIGNMENT_REQUIRED = 1
_CHAR_ALIGNMENT = 1
_SHORT_ALIGNMENT = 2
_INT_ALIGNMENT = 4
_LONG_ALIGNMENT = 4
_LONG_LONG_ALIGNMENT = 4
_DOUBLE_ALIGNMENT = 4
_LONG_DOUBLE_ALIGNMENT = 4
_POINTER_ALIGNMENT = 4
_MAX_ALIGNMENT = 4
_ALIGNMENT_REQUIRED = 0
_CHAR_ALIGNMENT = 1
_SHORT_ALIGNMENT = 2
_INT_ALIGNMENT = 4
_LONG_LONG_ALIGNMENT = 8
_DOUBLE_ALIGNMENT = 8
_ALIGNMENT_REQUIRED = 1
_LONG_ALIGNMENT = 4
_LONG_DOUBLE_ALIGNMENT = 8
_POINTER_ALIGNMENT = 4
_MAX_ALIGNMENT = 8
_LONG_ALIGNMENT = 8
_LONG_DOUBLE_ALIGNMENT = 16
_POINTER_ALIGNMENT = 8
_MAX_ALIGNMENT = 16
_POSIX_C_SOURCE = 1
_LARGEFILE64_SOURCE = 1
_LARGEFILE_SOURCE = 1
_FILE_OFFSET_BITS = 64
_FILE_OFFSET_BITS = 32
_POSIX_C_SOURCE = 199506
_POSIX_PTHREAD_SEMANTICS = 1
_XOPEN_VERSION = 500
_XOPEN_VERSION = 4
_XOPEN_VERSION = 3
INT8_MAX = 127
INT16_MAX = 32767
INT32_MAX = 2147483647
INTMAX_MAX = INT32_MAX
INT_LEAST8_MAX = INT8_MAX
INT_LEAST16_MAX = INT16_MAX
INT_LEAST32_MAX = INT32_MAX
INT8_MIN = -128
INT16_MIN = -32768
INT32_MIN = -2147483648
INTMAX_MIN = INT32_MIN
INT_LEAST8_MIN = INT8_MIN
INT_LEAST16_MIN = INT16_MIN
INT_LEAST32_MIN = INT32_MIN

def INT8_C(c):
    return c


def INT16_C(c):
    return c


def INT32_C(c):
    return c


def INT64_C(c):
    return __CONCAT__(c, l)


def INT64_C(c):
    return __CONCAT__(c, ll)


def UINT8_C(c):
    return __CONCAT__(c, u)


def UINT16_C(c):
    return __CONCAT__(c, u)


def UINT32_C(c):
    return __CONCAT__(c, u)


def UINT64_C(c):
    return __CONCAT__(c, ul)


def UINT64_C(c):
    return __CONCAT__(c, ull)


def INTMAX_C(c):
    return __CONCAT__(c, l)


def UINTMAX_C(c):
    return __CONCAT__(c, ul)


def INTMAX_C(c):
    return __CONCAT__(c, ll)


def UINTMAX_C(c):
    return __CONCAT__(c, ull)


def INTMAX_C(c):
    return c


def UINTMAX_C(c):
    return c


PRId8 = 'd'
PRId16 = 'd'
PRId32 = 'd'
PRId64 = 'ld'
PRId64 = 'lld'
PRIdLEAST8 = 'd'
PRIdLEAST16 = 'd'
PRIdLEAST32 = 'd'
PRIdLEAST64 = 'ld'
PRIdLEAST64 = 'lld'
PRIi8 = 'i'
PRIi16 = 'i'
PRIi32 = 'i'
PRIi64 = 'li'
PRIi64 = 'lli'
PRIiLEAST8 = 'i'
PRIiLEAST16 = 'i'
PRIiLEAST32 = 'i'
PRIiLEAST64 = 'li'
PRIiLEAST64 = 'lli'
PRIo8 = 'o'
PRIo16 = 'o'
PRIo32 = 'o'
PRIo64 = 'lo'
PRIo64 = 'llo'
PRIoLEAST8 = 'o'
PRIoLEAST16 = 'o'
PRIoLEAST32 = 'o'
PRIoLEAST64 = 'lo'
PRIoLEAST64 = 'llo'
PRIx8 = 'x'
PRIx16 = 'x'
PRIx32 = 'x'
PRIx64 = 'lx'
PRIx64 = 'llx'
PRIxLEAST8 = 'x'
PRIxLEAST16 = 'x'
PRIxLEAST32 = 'x'
PRIxLEAST64 = 'lx'
PRIxLEAST64 = 'llx'
PRIX8 = 'X'
PRIX16 = 'X'
PRIX32 = 'X'
PRIX64 = 'lX'
PRIX64 = 'llX'
PRIXLEAST8 = 'X'
PRIXLEAST16 = 'X'
PRIXLEAST32 = 'X'
PRIXLEAST64 = 'lX'
PRIXLEAST64 = 'llX'
PRIu8 = 'u'
PRIu16 = 'u'
PRIu32 = 'u'
PRIu64 = 'lu'
PRIu64 = 'llu'
PRIuLEAST8 = 'u'
PRIuLEAST16 = 'u'
PRIuLEAST32 = 'u'
PRIuLEAST64 = 'lu'
PRIuLEAST64 = 'llu'
SCNd16 = 'hd'
SCNd32 = 'd'
SCNd64 = 'ld'
SCNd64 = 'lld'
SCNi16 = 'hi'
SCNi32 = 'i'
SCNi64 = 'li'
SCNi64 = 'lli'
SCNo16 = 'ho'
SCNo32 = 'o'
SCNo64 = 'lo'
SCNo64 = 'llo'
SCNu16 = 'hu'
SCNu32 = 'u'
SCNu64 = 'lu'
SCNu64 = 'llu'
SCNx16 = 'hx'
SCNx32 = 'x'
SCNx64 = 'lx'
SCNx64 = 'llx'
PRIdMAX = 'ld'
PRIoMAX = 'lo'
PRIxMAX = 'lx'
PRIuMAX = 'lu'
PRIdMAX = 'lld'
PRIoMAX = 'llo'
PRIxMAX = 'llx'
PRIuMAX = 'llu'
PRIdMAX = 'd'
PRIoMAX = 'o'
PRIxMAX = 'x'
PRIuMAX = 'u'
SCNiMAX = 'li'
SCNdMAX = 'ld'
SCNoMAX = 'lo'
SCNxMAX = 'lx'
SCNiMAX = 'lli'
SCNdMAX = 'lld'
SCNoMAX = 'llo'
SCNxMAX = 'llx'
SCNiMAX = 'i'
SCNdMAX = 'd'
SCNoMAX = 'o'
SCNxMAX = 'x'
SHRT_MIN = -32768
SHRT_MAX = 32767
USHRT_MAX = 65535
INT_MIN = -2147483648
INT_MAX = 2147483647
LONG_MIN = -9223372036854775808
LONG_MAX = 9223372036854775807
LONG_MIN = -2147483648
LONG_MAX = 2147483647
P_MYID = -1
TIME32_MAX = INT32_MAX
TIME32_MIN = INT32_MIN

def TIMEVAL_OVERFLOW(tv):
    pass


from TYPES import *
DST_NONE = 0
DST_USA = 1
DST_AUST = 2
DST_WET = 3
DST_MET = 4
DST_EET = 5
DST_CAN = 6
DST_GB = 7
DST_RUM = 8
DST_TUR = 9
DST_AUSTALT = 10
ITIMER_REAL = 0
ITIMER_VIRTUAL = 1
ITIMER_PROF = 2
ITIMER_REALPROF = 3

def ITIMERVAL_OVERFLOW(itv):
    pass


SEC = 1
MILLISEC = 1000
MICROSEC = 1000000
NANOSEC = 1000000000

def TIMESPEC_OVERFLOW(ts):
    pass


def ITIMERSPEC_OVERFLOW(it):
    pass


__CLOCK_REALTIME0 = 0
CLOCK_VIRTUAL = 1
CLOCK_PROF = 2
__CLOCK_REALTIME3 = 3
CLOCK_HIGHRES = 4
CLOCK_MAX = 5
CLOCK_REALTIME = __CLOCK_REALTIME3
CLOCK_REALTIME = __CLOCK_REALTIME0
TIMER_RELTIME = 0
TIMER_ABSTIME = 1
from TYPES import *

def MUTEX_HELD(x):
    return mutex_owned(x)


def TICK_TO_SEC(tick):
    return tick / hz


def SEC_TO_TICK(sec):
    return sec * hz


def TICK_TO_MSEC(tick):
    pass


def MSEC_TO_TICK(msec):
    pass


def MSEC_TO_TICK_ROUNDUP(msec):
    pass


def TICK_TO_USEC(tick):
    return tick * usec_per_tick


def USEC_TO_TICK(usec):
    return usec / usec_per_tick


def USEC_TO_TICK_ROUNDUP(usec):
    pass


def TICK_TO_NSEC(tick):
    return tick * nsec_per_tick


def NSEC_TO_TICK(nsec):
    return nsec / nsec_per_tick


def NSEC_TO_TICK_ROUNDUP(nsec):
    pass


def TIMEVAL_TO_TICK(tvp):
    pass


def TIMESTRUC_TO_TICK(tsp):
    pass


from TYPES import *
NULL = 0
NULL = 0
CLOCKS_PER_SEC = 1000000
FD_SETSIZE = 65536
FD_SETSIZE = 1024
_NBBY = 8
NBBY = _NBBY

def FD_ZERO(p):
    return bzero(p, sizeof(*p))