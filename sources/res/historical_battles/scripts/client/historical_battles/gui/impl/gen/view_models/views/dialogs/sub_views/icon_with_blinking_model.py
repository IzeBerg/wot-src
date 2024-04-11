from frameworks.wulf import Array
from gui.impl.gen.view_models.views.dialogs.sub_views.icon_set_view_model import IconSetViewModel
from gui.impl.gen.view_models.views.dialogs.sub_views.icon_view_model import IconViewModel

class IconWithBlinkingModel(IconSetViewModel):
    __slots__ = ()

    def __init__(self, properties=7, commands=0):
        super(IconWithBlinkingModel, self).__init__(properties=properties, commands=commands)

    def getBlinkingIcons(self):
        return self._getArray(6)

    def setBlinkingIcons(self, value):
        self._setArray(6, value)

    @staticmethod
    def getBlinkingIconsType():
        return IconViewModel

    def _initialize(self):
        super(IconWithBlinkingModel, self)._initialize()
        self._addArrayProperty('blinkingIcons', Array())