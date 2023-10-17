from HWTeamInfoStatsComponent import HWTeamInfoStatsComponent
from HWArenaInfoBossHealthBarComponent import getArenaInfoBossHealthBarComponent
from HWBuffShowCannotBeDamagedMarker import isInvulnerableBoss
from gui.Scaleform.daapi.view.battle.shared.markers2d.vehicle_plugins import RespawnableVehicleMarkerPlugin
from halloween.gui.halloween_gui_constants import BATTLE_CTRL_ID
from gui.battle_control.battle_constants import FEEDBACK_EVENT_ID, MARKER_HIT_STATE
from halloween.gui.hw_vehicle_role_helper import getVehicleRole
from gui.impl.gen import R
from gui.impl import backport
_STUN_EFFECT_DURATION = 1000
_STUN_STATE = 0
_VEHICLE_INFO_MARKER_ARG_NAME_ID = 1
_HIT_STATE = MARKER_HIT_STATE[FEEDBACK_EVENT_ID.VEHICLE_HIT]
VEHICLE_MARKER = 'HWVehicleMarkerUI'

def getVehicleMarkerHealth(vehicleID, health):
    component = getArenaInfoBossHealthBarComponent()
    if not component:
        return health
    if vehicleID != component.bossVehicleId:
        return health
    currentHealth, _ = component.getVehicleMarkerHealthValues(health)
    return currentHealth


class HalloweenVehicleMarkerPlugin(RespawnableVehicleMarkerPlugin):
    ICON_HIT_BLOCKED = 'hit_blocked'

    def init(self, *args):
        super(HalloweenVehicleMarkerPlugin, self).init()
        hwBattleGuiCtrl = self.sessionProvider.dynamic.getControllerByID(BATTLE_CTRL_ID.HW_BATTLE_GUI_CTRL)
        if hwBattleGuiCtrl:
            hwBattleGuiCtrl.onBossAuraVictimMarkerIcon += self.__onAuraVictimMarkerIcon
            hwBattleGuiCtrl.onVehicleBuffIconAdded += self.__onVehicleBuffIconAdded
        if self.vehicleStats:
            self.vehicleStats.onTeamSoulsUpdated += self.__onTeamSoulsUpdated

    def fini(self):
        hwBattleGuiCtrl = self.sessionProvider.dynamic.getControllerByID(BATTLE_CTRL_ID.HW_BATTLE_GUI_CTRL)
        if hwBattleGuiCtrl:
            hwBattleGuiCtrl.onBossAuraVictimMarkerIcon -= self.__onAuraVictimMarkerIcon
            hwBattleGuiCtrl.onVehicleBuffIconAdded -= self.__onVehicleBuffIconAdded
        if self.vehicleStats:
            self.vehicleStats.onTeamSoulsUpdated -= self.__onTeamSoulsUpdated
        super(HalloweenVehicleMarkerPlugin, self).fini()

    @property
    def vehicleStats(self):
        return HWTeamInfoStatsComponent.getInstance()

    def _getMarkerSymbol(self, vehicleID):
        return VEHICLE_MARKER

    def _setMarkerInitialState(self, marker, vInfo):
        super(HalloweenVehicleMarkerPlugin, self)._setMarkerInitialState(marker, vInfo)
        if self.sessionProvider.getArenaDP().isAllyTeam(vInfo.team) and self.vehicleStats:
            self._invokeMarker(marker.getMarkerID(), 'showSoulMark', self.vehicleStats.getSouls(vInfo.vehicleID))

    def _setHealthMarker(self, vehicleID, handle, newHealth):
        super(HalloweenVehicleMarkerPlugin, self)._setHealthMarker(vehicleID, handle, newHealth)
        self.__updateBossMarkerHealth(vehicleID, handle, newHealth)

    def _updateHealthMarker(self, vehicleID, handle, newHealth, *args):
        newHealth = getVehicleMarkerHealth(vehicleID, newHealth)
        super(HalloweenVehicleMarkerPlugin, self)._updateHealthMarker(vehicleID, handle, newHealth, *args)

    def _getVehicleClassTag(self, vehicleType):
        role = getVehicleRole(vehicleType)
        if role is not None:
            return role
        else:
            return super(HalloweenVehicleMarkerPlugin, self)._getVehicleClassTag(vehicleType)

    def _setVehicleInfoMarker(self, vehicleID, handle, classTag, *args):
        arenaDataProvider = self.sessionProvider.getArenaDP()
        vInfo = arenaDataProvider.getVehicleInfo(vehicleID)
        args = list(args)
        args[_VEHICLE_INFO_MARKER_ARG_NAME_ID] = vInfo.vehicleType.name
        super(HalloweenVehicleMarkerPlugin, self)._setVehicleInfoMarker(vehicleID, handle, classTag, *args)
        if classTag == 'boss':
            isBossFight = self.__updateBossMarkerHealth(vehicleID, handle)
            self._invokeMarker(handle, 'setBossMode', isBossFight)

    def _onVehicleFeedbackReceived(self, eventID, vehicleID, value):
        super(HalloweenVehicleMarkerPlugin, self)._onVehicleFeedbackReceived(eventID, vehicleID, value)
        if eventID == FEEDBACK_EVENT_ID.HW_VEHICLE_MARKER_HEALTH and vehicleID in self._markers:
            self.__updateBossMarkerHealth(vehicleID, self._markers[vehicleID].getMarkerID(), value)
        elif eventID == FEEDBACK_EVENT_ID.VEHICLE_DEAD and isInvulnerableBoss(vehicleID):
            self._hideVehicleMarker(vehicleID)

    def _updateMarkerState(self, handle, newState, isImmediate, text='', iconAnimation=''):
        if self.__isBossInvulnerable(handle):
            if newState == MARKER_HIT_STATE[FEEDBACK_EVENT_ID.VEHICLE_ARMOR_PIERCED][0]:
                text = backport.text(R.strings.ingame_gui.hitMarker.useless())
                iconAnimation = self.ICON_HIT_BLOCKED
            elif newState == MARKER_HIT_STATE[FEEDBACK_EVENT_ID.VEHICLE_HIT][0]:
                text = backport.text(R.strings.ingame_gui.hitMarker.useless())
        super(HalloweenVehicleMarkerPlugin, self)._updateMarkerState(handle, newState, isImmediate, text, iconAnimation)

    def __isBossInvulnerable(self, markerID):
        for vehicleID, marker in self._markers.items():
            if marker.getMarkerID() == markerID:
                if isInvulnerableBoss(vehicleID):
                    return True
                break

        return False

    def __onAuraVictimMarkerIcon(self, vehicle, show):
        vehicleId = vehicle.id
        if vehicleId in self._markers:
            animated = True
            isSourceVehicle = True
            handle = self._markers[vehicleId].getMarkerID()
            self._updateStatusMarkerState(vehicleId, show, handle, _STUN_STATE, _STUN_EFFECT_DURATION, animated, isSourceVehicle)

    def __onVehicleBuffIconAdded(self, vehicleId, icon):
        marker = self._markers.get(vehicleId)
        if marker is not None:
            self._invokeMarker(marker.getMarkerID(), 'showEnemyBuff', icon)
        return

    def __onTeamSoulsUpdated(self):
        if not self.vehicleStats:
            return
        for vehicleId, marker in self._markers.iteritems():
            self._invokeMarker(marker.getMarkerID(), 'showSoulMark', self.vehicleStats.getSouls(vehicleId))

    def __updateBossMarkerHealth(self, vehicleID, handle, health=None):
        component = getArenaInfoBossHealthBarComponent()
        if not component or not component.isActive or vehicleID != component.bossVehicleId:
            return False
        currentHealth, maxHealth = component.getBossCurrentLifeHealthValues()
        self._invokeMarker(handle, 'setMaxHealth', maxHealth)
        self._invokeMarker(handle, 'setHealth', currentHealth)
        self._invokeMarker(handle, 'setBossMode', True)
        return True