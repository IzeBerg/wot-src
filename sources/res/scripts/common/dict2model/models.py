from __future__ import absolute_import
import typing
from itertools import chain

class Model(object):
    __slots__ = ()

    def __init__(self, *args, **kwargs):
        super(Model, self).__init__()

    def toDict(self):
        slots = set(chain.from_iterable(getattr(cls, '__slots__', tuple()) for cls in self.__class__.__mro__))
        return {attr:getattr(self, attr) for attr in slots if hasattr(self, attr)}

    def _reprArgs(self):
        return ''

    def __repr__(self):
        _reprArgs = self._reprArgs()
        if _reprArgs:
            return ('<{}({})>').format(self.__class__.__name__, _reprArgs)
        return super(Model, self).__repr__()