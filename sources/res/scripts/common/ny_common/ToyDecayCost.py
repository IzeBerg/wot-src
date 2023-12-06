from typing import Optional, TYPE_CHECKING
from items import new_year
if TYPE_CHECKING:
    from items.collectibles import ToyDescriptor

class ToyDecayCostConfig(object):
    __slots__ = ('_config', )

    def __init__(self, config):
        self._config = config

    def getToyDecayCost(self, toyID=None, toyDescr=None):
        if toyDescr is None:
            toyDescr = new_year.g_cache.toys[toyID]
        return getattr(toyDescr, 'fragments', 0) or self._config.get((toyDescr.type, toyDescr.rank), 0)