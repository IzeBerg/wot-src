import os, random
from uuid import uuid1
_node = None

def _getNode():
    global _node
    if _node is not None:
        return _node
    else:
        _node = random.randrange(0, 4294967296) << 16
        _node = _node | os.getpid() & 65535
        _node = _node | 1099511627776
        return _node


def genUUID():
    return uuid1(_getNode())