from typing import Sequence
from soft_exception import SoftException

def bisectLE(a, v, lo=0, hi=None):
    if lo < 0:
        raise SoftException('lo must be non-negative')
    if hi is None:
        hi = len(a) - 1
    while lo < hi:
        mid = (lo + hi >> 1) + 1
        if a[mid] <= v:
            lo = mid
        else:
            hi = mid - 1

    return lo