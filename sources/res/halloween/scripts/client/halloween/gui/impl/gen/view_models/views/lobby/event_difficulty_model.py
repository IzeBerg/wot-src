from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from halloween.gui.impl.gen.view_models.views.lobby.difficulty_dropdown_item_model import DifficultyDropdownItemModel

class EventDifficultyModel(ViewModel):
    __slots__ = ('onChange', )

    def __init__(self, properties=3, commands=1):
        super(EventDifficultyModel, self).__init__(properties=properties, commands=commands)

    def getItems(self):
        return self._getArray(0)

    def setItems(self, value):
        self._setArray(0, value)

    @staticmethod
    def getItemsType():
        return DifficultyDropdownItemModel

    def getSelected(self):
        return self._getArray(1)

    def setSelected(self, value):
        self._setArray(1, value)

    @staticmethod
    def getSelectedType():
        return unicode

    def getLevel(self):
        return self._getNumber(2)

    def setLevel(self, value):
        self._setNumber(2, value)

    def _initialize(self):
        super(EventDifficultyModel, self)._initialize()
        self._addArrayProperty('items', Array())
        self._addArrayProperty('selected', Array())
        self._addNumberProperty('level', 0)
        self.onChange = self._addCommand('onChange')