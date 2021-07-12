import struct, zlib

def getUsersListCheckSum(usersList):
    if len(usersList) == 0:
        return 0
    sortedList = sorted(list(usersList))
    return zlib.crc32((' ').join(sortedList))