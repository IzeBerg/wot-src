from __future__ import absolute_import
from future.utils import PY3
if PY3:
    from collections.abc import *
else:
    from collections import Container, Hashable, Iterable, Iterator, Sized, Callable, Sequence, MutableSequence, Set, MutableSet
    from _abcoll import MutableMapping, MappingView, ItemsView, KeysView, Mapping