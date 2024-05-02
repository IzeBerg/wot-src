from cosmic_event.gui.impl.gen.view_models.views.battle.cosmic_hud.marker_model import MarkerModel

class VehicleMarkerModel(MarkerModel):
    __slots__ = ()

    def __init__(self, properties=9, commands=0):
        super(VehicleMarkerModel, self).__init__(properties=properties, commands=commands)

    def getPlayerName(self):
        return self._getString(4)

    def setPlayerName(self, value):
        self._setString(4, value)

    def getIsLastOffender(self):
        return self._getBool(5)

    def setIsLastOffender(self, value):
        self._setBool(5, value)

    def getIsLeader(self):
        return self._getBool(6)

    def setIsLeader(self, value):
        self._setBool(6, value)

    def getFragmentsCollected(self):
        return self._getNumber(7)

    def setFragmentsCollected(self, value):
        self._setNumber(7, value)

    def getIsDisabled(self):
        return self._getBool(8)

    def setIsDisabled(self, value):
        self._setBool(8, value)

    def _initialize(self):
        super(VehicleMarkerModel, self)._initialize()
        self._addStringProperty('playerName', '')
        self._addBoolProperty('isLastOffender', False)
        self._addBoolProperty('isLeader', False)
        self._addNumberProperty('fragmentsCollected', 0)
        self._addBoolProperty('isDisabled', False)