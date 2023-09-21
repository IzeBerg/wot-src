from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from gui.impl.gen.view_models.views.lobby.postbattle.widget_model import WidgetModel

class WidgetsModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(WidgetsModel, self).__init__(properties=properties, commands=commands)

    def getWidgets(self):
        return self._getArray(0)

    def setWidgets(self, value):
        self._setArray(0, value)

    @staticmethod
    def getWidgetsType():
        return WidgetModel

    def _initialize(self):
        super(WidgetsModel, self)._initialize()
        self._addArrayProperty('widgets', Array())