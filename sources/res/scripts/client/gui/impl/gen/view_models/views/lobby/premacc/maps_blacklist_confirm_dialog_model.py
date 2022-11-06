from frameworks.wulf import ViewModel
from gui.impl.gen.view_models.ui_kit.list_model import ListModel

class MapsBlacklistConfirmDialogModel(ViewModel):
    __slots__ = ('onMapSelected', )

    def __init__(self, properties=4, commands=1):
        super(MapsBlacklistConfirmDialogModel, self).__init__(properties=properties, commands=commands)

    @property
    def selectedMaps(self):
        return self._getViewModel(0)

    @staticmethod
    def getSelectedMapsType():
        return ListModel

    def getMapId(self):
        return self._getString(1)

    def setMapId(self, value):
        self._setString(1, value)

    def getCooldownTime(self):
        return self._getNumber(2)

    def setCooldownTime(self, value):
        self._setNumber(2, value)

    def getShowSelectedMaps(self):
        return self._getBool(3)

    def setShowSelectedMaps(self, value):
        self._setBool(3, value)

    def _initialize(self):
        super(MapsBlacklistConfirmDialogModel, self)._initialize()
        self._addViewModelProperty('selectedMaps', ListModel())
        self._addStringProperty('mapId', '')
        self._addNumberProperty('cooldownTime', 0)
        self._addBoolProperty('showSelectedMaps', False)
        self.onMapSelected = self._addCommand('onMapSelected')