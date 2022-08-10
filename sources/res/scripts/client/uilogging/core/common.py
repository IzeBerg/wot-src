import typing
from enum import Enum
from itertools import izip_longest
from helpers import getClientVersion

def getClientBuildVersion():
    return getClientVersion(force=False)


def grouper(iterable, batch):
    args = [
     iter(iterable)] * batch
    for parts in izip_longest(fillvalue=None, *args):
        yield [ part for part in parts if part is not None ]

    return


def convertEnum(value):
    if isinstance(value, Enum):
        return value.value
    return value