import typing
if typing.TYPE_CHECKING:
    from typing import Optional

def parseHangarNameMask(mask):
    if mask is None:
        return (0, 0)
    else:
        titleIdx = mask & 65535
        descriptionIdx = mask >> 16 & 65535
        return (titleIdx, descriptionIdx)


def makeHangarNameMask(titleIdx, descriptionIdx):
    return (descriptionIdx << 16) + titleIdx