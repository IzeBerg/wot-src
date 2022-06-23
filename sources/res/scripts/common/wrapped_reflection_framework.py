from constants import IS_UE_EDITOR
from collections import namedtuple
from contextlib import contextmanager
if IS_UE_EDITOR:
    from reflection_framework import ReflectionMetaclass
    from reflection_framework import reflectedNamedTuple
    from reflection_framework import notifyPropertiesReset
else:
    ReflectionMetaclass = type
    reflectedNamedTuple = namedtuple

    @contextmanager
    def notifyPropertiesReset(obj):
        yield
        return