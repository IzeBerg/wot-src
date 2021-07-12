from typing import Optional, Generator, Iterator

class DynAccessor(object):
    __slots__ = ('__resId', )

    def __init__(self, value=0):
        self.__resId = value

    def __call__(self):
        return self.__resId

    def __nonzero__(self):
        return self.__resId >= 0

    def dyn(self, attr, default=None):
        return getattr(self, attr, default or _g_invalid)

    def num(self, attr, default=None):
        return getattr(self, ('c_{}').format(attr), default or _g_invalid)

    def keys(self):
        return (attr for attr in dir(self) if attr not in dir(DynAccessor) and not attr.startswith('_'))

    def values(self):
        return (getattr(self, attr) for attr in self.keys())

    def items(self):
        return ((attr, getattr(self, attr)) for attr in self.keys())

    def length(self):
        return len(tuple(self.keys()))

    def exists(self):
        return self.__resId > 0

    def isValid(self):
        return True


class _InvalidDynAccessor(DynAccessor):

    def keys(self):
        return iter(())

    def isValid(self):
        return False


_g_invalid = _InvalidDynAccessor(-1)