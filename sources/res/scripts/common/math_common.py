from math import ceil
_CEIL_EPS = 1

def ceilTo(num, decimals=0, epsilon=0.0004):
    multiplier = 10 ** decimals
    return ceil(round((num + epsilon) / multiplier, _CEIL_EPS)) * multiplier


def round_int(number):
    return int(round(number))


def isAlmostEqual(first, second, epsilon=0.0004):
    return second - epsilon <= first <= second + epsilon


def trim(v, min, max):
    if v < min:
        v = min
    elif v > max:
        v = max
    return v