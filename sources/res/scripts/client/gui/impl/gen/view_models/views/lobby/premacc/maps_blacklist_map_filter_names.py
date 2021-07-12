from frameworks.wulf import ViewModel

class MapsBlacklistMapFilterNames(ViewModel):
    __slots__ = ()
    MAPS_BLACKLIST_FILTER_NAME_SUMMER = 'summer'
    MAPS_BLACKLIST_FILTER_NAME_WINTER = 'winter'
    MAPS_BLACKLIST_FILTER_NAME_DESERT = 'desert'

    def __init__(self, properties=0, commands=0):
        super(MapsBlacklistMapFilterNames, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(MapsBlacklistMapFilterNames, self)._initialize()