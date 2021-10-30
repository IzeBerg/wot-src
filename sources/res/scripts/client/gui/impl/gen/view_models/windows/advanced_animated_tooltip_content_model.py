from frameworks.wulf import ViewModel

class AdvancedAnimatedTooltipContentModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=3, commands=0):
        super(AdvancedAnimatedTooltipContentModel, self).__init__(properties=properties, commands=commands)

    def getHeader(self):
        return self._getString(0)

    def setHeader(self, value):
        self._setString(0, value)

    def getBody(self):
        return self._getString(1)

    def setBody(self, value):
        self._setString(1, value)

    def getAnimation(self):
        return self._getString(2)

    def setAnimation(self, value):
        self._setString(2, value)

    def _initialize(self):
        super(AdvancedAnimatedTooltipContentModel, self)._initialize()
        self._addStringProperty('header', '')
        self._addStringProperty('body', '')
        self._addStringProperty('animation', '')