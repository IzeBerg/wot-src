import typing, itertools
from gui.game_loading.resources.base import BaseResources
if typing.TYPE_CHECKING:
    from gui.game_loading.resources.models import BaseResourceModel

class LocalResources(BaseResources):
    __slots__ = ('_source', '_iterator', '_cycle')

    def __init__(self, source, cycle=False):
        super(LocalResources, self).__init__()
        self._source = list(source)
        self._cycle = cycle
        self._iterator = None
        return

    def get(self):
        if self._iterator is None:
            self._iterator = self._createIterator()
        try:
            return self._iterator.next()
        except StopIteration:
            return

        return

    def reset(self):
        if self._iterator is not None:
            self._iterator = None
        super(LocalResources, self).reset()
        return

    def destroy(self):
        super(LocalResources, self).destroy()
        self._iterator = None
        return

    def _createIterator(self):
        if self._cycle:
            return itertools.cycle(self._source)
        return iter(self._source)