from math import ceil
_CEIL_EPS = 6

def ceilTo(num, decimals=0):
    multiplier = 10 ** decimals
    return ceil(round(num / multiplier, _CEIL_EPS)) * multiplier


def round_int(number):
    return int(round(number))