from enum import Enum
from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from cosmic_event.gui.impl.gen.view_models.views.battle.cosmic_hud.ability_model import AbilityModel
from cosmic_event.gui.impl.gen.view_models.views.battle.cosmic_hud.artefact_scanning import ArtefactScanning
from cosmic_event.gui.impl.gen.view_models.views.battle.cosmic_hud.direction_marker_model import DirectionMarkerModel
from cosmic_event.gui.impl.gen.view_models.views.battle.cosmic_hud.marker_model import MarkerModel
from cosmic_event.gui.impl.gen.view_models.views.battle.cosmic_hud.player_record_model import PlayerRecordModel
from cosmic_event.gui.impl.gen.view_models.views.battle.cosmic_hud.vehicle_marker_model import VehicleMarkerModel
from cosmic_event.gui.impl.gen.view_models.views.lobby.cosmic_lobby_view.scoring_model import ScoringModel

class PhaseTypesEnum(Enum):
    PREBATTLE = 'prebattle'
    IDLE = 'idle'
    DELIVERY = 'delivery'
    EVACUATION = 'evacuation'


class CosmicHudViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=30, commands=0):
        super(CosmicHudViewModel, self).__init__(properties=properties, commands=commands)

    @property
    def crosshair(self):
        return self._getViewModel(0)

    @staticmethod
    def getCrosshairType():
        return MarkerModel

    @property
    def aim(self):
        return self._getViewModel(1)

    @staticmethod
    def getAimType():
        return MarkerModel

    @property
    def poiMarker(self):
        return self._getViewModel(2)

    @staticmethod
    def getPoiMarkerType():
        return DirectionMarkerModel

    @property
    def artefactScanning(self):
        return self._getViewModel(3)

    @staticmethod
    def getArtefactScanningType():
        return ArtefactScanning

    def getVehicleMarkers(self):
        return self._getArray(4)

    def setVehicleMarkers(self, value):
        self._setArray(4, value)

    @staticmethod
    def getVehicleMarkersType():
        return VehicleMarkerModel

    def getArenaTimeLeft(self):
        return self._getReal(5)

    def setArenaTimeLeft(self, value):
        self._setReal(5, value)

    def getPhaseTypes(self):
        return PhaseTypesEnum(self._getString(6))

    def setPhaseTypes(self, value):
        self._setString(6, value.value)

    def getReloadTimeLeft(self):
        return self._getReal(7)

    def setReloadTimeLeft(self, value):
        self._setReal(7, value)

    def getReloadTime(self):
        return self._getReal(8)

    def setReloadTime(self, value):
        self._setReal(8, value)

    def getAnnouncementSecondsToEvent(self):
        return self._getNumber(9)

    def setAnnouncementSecondsToEvent(self, value):
        self._setNumber(9, value)

    def getAnnouncementCustomTitle(self):
        return self._getString(10)

    def setAnnouncementCustomTitle(self, value):
        self._setString(10, value)

    def getAnnouncementCustomSubtitle(self):
        return self._getString(11)

    def setAnnouncementCustomSubtitle(self, value):
        self._setString(11, value)

    def getPlayerName(self):
        return self._getString(12)

    def setPlayerName(self, value):
        self._setString(12, value)

    def getPlayerList(self):
        return self._getArray(13)

    def setPlayerList(self, value):
        self._setArray(13, value)

    @staticmethod
    def getPlayerListType():
        return PlayerRecordModel

    def getMessages(self):
        return self._getArray(14)

    def setMessages(self, value):
        self._setArray(14, value)

    @staticmethod
    def getMessagesType():
        return ScoringModel

    def getAbilities(self):
        return self._getArray(15)

    def setAbilities(self, value):
        self._setArray(15, value)

    @staticmethod
    def getAbilitiesType():
        return AbilityModel

    def getIsRespawning(self):
        return self._getBool(16)

    def setIsRespawning(self, value):
        self._setBool(16, value)

    def getShowPoiMarker(self):
        return self._getBool(17)

    def setShowPoiMarker(self, value):
        self._setBool(17, value)

    def getFragmentsCollected(self):
        return self._getNumber(18)

    def setFragmentsCollected(self, value):
        self._setNumber(18, value)

    def getIsTargeting(self):
        return self._getBool(19)

    def setIsTargeting(self, value):
        self._setBool(19, value)

    def getIsHideOnEvacuation(self):
        return self._getBool(20)

    def setIsHideOnEvacuation(self, value):
        self._setBool(20, value)

    def getOverchargeDuration(self):
        return self._getNumber(21)

    def setOverchargeDuration(self, value):
        self._setNumber(21, value)

    def getVehicleOverturned(self):
        return self._getBool(22)

    def setVehicleOverturned(self, value):
        self._setBool(22, value)

    def getIsShotHit(self):
        return self._getBool(23)

    def setIsShotHit(self, value):
        self._setBool(23, value)

    def getCurrentPhaseIdx(self):
        return self._getNumber(24)

    def setCurrentPhaseIdx(self, value):
        self._setNumber(24, value)

    def getCurrentPhaseDuration(self):
        return self._getNumber(25)

    def setCurrentPhaseDuration(self, value):
        self._setNumber(25, value)

    def getCurrentPhaseTimeLeft(self):
        return self._getNumber(26)

    def setCurrentPhaseTimeLeft(self, value):
        self._setNumber(26, value)

    def getCurrentPhaseType(self):
        return PhaseTypesEnum(self._getString(27))

    def setCurrentPhaseType(self, value):
        self._setString(27, value.value)

    def getPhaseCount(self):
        return self._getNumber(28)

    def setPhaseCount(self, value):
        self._setNumber(28, value)

    def getIsAnnouncerVisible(self):
        return self._getBool(29)

    def setIsAnnouncerVisible(self, value):
        self._setBool(29, value)

    def _initialize(self):
        super(CosmicHudViewModel, self)._initialize()
        self._addViewModelProperty('crosshair', MarkerModel())
        self._addViewModelProperty('aim', MarkerModel())
        self._addViewModelProperty('poiMarker', DirectionMarkerModel())
        self._addViewModelProperty('artefactScanning', ArtefactScanning())
        self._addArrayProperty('vehicleMarkers', Array())
        self._addRealProperty('arenaTimeLeft', 0.0)
        self._addStringProperty('phaseTypes')
        self._addRealProperty('reloadTimeLeft', 0.0)
        self._addRealProperty('reloadTime', 0.0)
        self._addNumberProperty('announcementSecondsToEvent', -1)
        self._addStringProperty('announcementCustomTitle', '')
        self._addStringProperty('announcementCustomSubtitle', '')
        self._addStringProperty('playerName', '')
        self._addArrayProperty('playerList', Array())
        self._addArrayProperty('messages', Array())
        self._addArrayProperty('abilities', Array())
        self._addBoolProperty('isRespawning', False)
        self._addBoolProperty('showPoiMarker', False)
        self._addNumberProperty('fragmentsCollected', 0)
        self._addBoolProperty('isTargeting', False)
        self._addBoolProperty('isHideOnEvacuation', False)
        self._addNumberProperty('overchargeDuration', 0)
        self._addBoolProperty('vehicleOverturned', False)
        self._addBoolProperty('isShotHit', False)
        self._addNumberProperty('currentPhaseIdx', 0)
        self._addNumberProperty('currentPhaseDuration', 0)
        self._addNumberProperty('currentPhaseTimeLeft', 0)
        self._addStringProperty('currentPhaseType')
        self._addNumberProperty('phaseCount', 0)
        self._addBoolProperty('isAnnouncerVisible', False)