from frameworks.wulf import ViewModel

class BadgeAwardViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(BadgeAwardViewModel, self).__init__(properties=properties, commands=commands)

    def getBadgeId(self):
        return self._getNumber(0)

    def setBadgeId(self, value):
        self._setNumber(0, value)

    def _initialize(self):
        super(BadgeAwardViewModel, self)._initialize()
        self._addNumberProperty('badgeId', 0)