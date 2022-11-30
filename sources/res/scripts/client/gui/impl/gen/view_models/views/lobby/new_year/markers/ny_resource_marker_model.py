from enum import Enum
from frameworks.wulf import ViewModel

class AnimationState(Enum):
    DISABLED = 'disabled'
    AVAILABLE = 'available'
    COLLECTING = 'collecting'


class MarkerType(Enum):
    FRIEND = 'friend'
    DEFAULT = 'default'


class NyResourceMarkerModel(ViewModel):
    __slots__ = ('onAnimationEnd', )

    def __init__(self, properties=7, commands=1):
        super(NyResourceMarkerModel, self).__init__(properties=properties, commands=commands)

    def getResourceType(self):
        return self._getString(0)

    def setResourceType(self, value):
        self._setString(0, value)

    def getCollectAmount(self):
        return self._getNumber(1)

    def setCollectAmount(self, value):
        self._setNumber(1, value)

    def getAnimationState(self):
        return AnimationState(self._getString(2))

    def setAnimationState(self, value):
        self._setString(2, value.value)

    def getMarkerType(self):
        return MarkerType(self._getString(3))

    def setMarkerType(self, value):
        self._setString(3, value.value)

    def getIsAutoCollectActive(self):
        return self._getBool(4)

    def setIsAutoCollectActive(self, value):
        self._setBool(4, value)

    def getIsVisible(self):
        return self._getBool(5)

    def setIsVisible(self, value):
        self._setBool(5, value)

    def getIsCameraOnResources(self):
        return self._getBool(6)

    def setIsCameraOnResources(self, value):
        self._setBool(6, value)

    def _initialize(self):
        super(NyResourceMarkerModel, self)._initialize()
        self._addStringProperty('resourceType', '')
        self._addNumberProperty('collectAmount', 0)
        self._addStringProperty('animationState')
        self._addStringProperty('markerType')
        self._addBoolProperty('isAutoCollectActive', False)
        self._addBoolProperty('isVisible', True)
        self._addBoolProperty('isCameraOnResources', False)
        self.onAnimationEnd = self._addCommand('onAnimationEnd')