import BigWorld
from functools import partial
from PlayerEvents import g_playerEvents
from helpers.CallbackDelayer import CallbackDelayer
from gui.Scaleform.settings import ICONS_SIZES
from gui.shared.badges import buildBadge
from gui.battle_control import avatar_getter
from halloween.gui.halloween_gui_constants import BATTLE_CTRL_ID
from halloween.gui.battle_control.controllers.battle_gui_controller import EventBattleGoal
from halloween.gui.scaleform.daapi.view.meta.HWPlayersPanelMeta import HWPlayersPanelMeta
from HWTeamInfoStatsComponent import HWTeamInfoStatsComponent
from HWArenaPhasesComponent import HWArenaPhasesComponent
BattleGoalMapping = {EventBattleGoal.UNKNOWN: 0, 
   EventBattleGoal.COLLECT_SOULS: 1, 
   EventBattleGoal.DELIVER_SOULS: 2, 
   EventBattleGoal.GET_TO_COLLECTOR: 3}

class HWPlayersPanel(HWPlayersPanelMeta):
    _UPDATE_PERIOD = 0.2

    def __init__(self):
        super(HWPlayersPanel, self).__init__()
        self._callbackDelayer = CallbackDelayer()
        self.__isPostmortem = False
        self.__vehsCache = {}
        self.__prevTotalSouls = 0

    @property
    def arenaPhases(self):
        return HWArenaPhasesComponent.getInstance()

    @property
    def battleGUICtrl(self):
        return self.guiSessionProvider.dynamic.getControllerByID(BATTLE_CTRL_ID.HW_BATTLE_GUI_CTRL)

    @property
    def teamInfoStats(self):
        return HWTeamInfoStatsComponent.getInstance()

    def acceptSquad(self, sessionID):
        self.guiSessionProvider.invitations.accept(sessionID)

    def addToSquad(self, sessionID):
        self.guiSessionProvider.invitations.send(sessionID)

    def _populate(self):
        super(HWPlayersPanel, self)._populate()
        if self.teamInfoStats:
            self.teamInfoStats.onTeamHealthUpdated += self.__updateTeamPanel
            self.teamInfoStats.onTeamBuffsUpdated += self.__teamBuffsUpdated
            self.teamInfoStats.onTeamSoulsUpdated += self.__onTeamSoulsUpdated
        hwBattleGuiCtrl = self.battleGUICtrl
        if hwBattleGuiCtrl:
            hwBattleGuiCtrl.onPhaseChanged += self.__onPhaseChanged
            hwBattleGuiCtrl.onBattleGoalChanged += self.__onBattleGoalChanged
            hwBattleGuiCtrl.onSoulCollectorProgress += self.__onCollectorSoulsChanged
            self.__onBattleGoalChanged(hwBattleGuiCtrl.currentGoal)
            self.__onCollectorSoulsChanged()
        ctrl = self.sessionProvider.shared.vehicleState
        if ctrl is not None:
            ctrl.onPostMortemSwitched += self.__onPostMortemSwitched
            ctrl.onRespawnBaseMoving += self.__onRespawnBaseMoving
        g_playerEvents.onAvatarReady += self.__onAvatarReady
        return

    def _dispose(self):
        if self.teamInfoStats:
            self.teamInfoStats.onTeamHealthUpdated -= self.__updateTeamPanel
            self.teamInfoStats.onTeamBuffsUpdated -= self.__teamBuffsUpdated
            self.teamInfoStats.onTeamSoulsUpdated -= self.__onTeamSoulsUpdated
        hwBattleGuiCtrl = self.battleGUICtrl
        if hwBattleGuiCtrl:
            hwBattleGuiCtrl.onPhaseChanged -= self.__onPhaseChanged
            hwBattleGuiCtrl.onBattleGoalChanged -= self.__onBattleGoalChanged
            hwBattleGuiCtrl.onSoulCollectorProgress -= self.__onCollectorSoulsChanged
        ctrl = self.sessionProvider.shared.vehicleState
        if ctrl is not None:
            ctrl.onPostMortemSwitched -= self.__onPostMortemSwitched
            ctrl.onRespawnBaseMoving -= self.__onRespawnBaseMoving
        g_playerEvents.onAvatarReady -= self.__onAvatarReady
        self._callbackDelayer.destroy()
        self.__vehsCache.clear()
        self.__prevTotalSouls = 0
        super(HWPlayersPanel, self)._dispose()
        return

    def __onAvatarReady(self):
        self.__updateAllTeamates()
        self.__onTeamSoulsUpdated(needAnimateIncome=False)

    def __updateAllTeamates(self):
        arenaDP = self.guiSessionProvider.getArenaDP()
        vInfos = arenaDP.getVehiclesInfoIterator()
        teammateInfos = (v for v in vInfos if v.player.accountDBID > 0 and arenaDP.isAlly(v.vehicleID))
        teamhealth = self.teamInfoStats.getTeamHealth()
        for vInfo in teammateInfos:
            health = next((info['value'] for info in teamhealth if info['id'] == vInfo.vehicleID), vInfo.vehicleType.maxHealth)
            self.__updateTeammate(vInfo, health)
            self.__vehsCache.update({vInfo.vehicleID: health})

    def __onPhaseChanged(self):
        arenaPhases = self.arenaPhases
        lastPhase = arenaPhases.activePhase == arenaPhases.phasesCount
        if lastPhase:
            self.as_hideCollectorInfoS()

    def __updateTeamPanel(self, withTeamSouls=False):
        self._callbackDelayer.delayCallback(self._UPDATE_PERIOD, partial(self.__updateTeamPanelImpl, withTeamSouls))

    def __teamBuffsUpdated(self):
        self._callbackDelayer.delayCallback(self._UPDATE_PERIOD, partial(self.__updateTeamPanelImpl, False, True))

    def __updateTeamPanelImpl(self, withTeamSouls, forceUpdate=False):
        arenaDP = self.guiSessionProvider.getArenaDP()
        teamhealth = self.teamInfoStats.getTeamHealth()
        for info in teamhealth:
            vInfo = arenaDP.getVehicleInfo(info['id'])
            self.__setVehicleHealth(vInfo, info['value'], forceUpdate)

        if withTeamSouls:
            self.__onTeamSoulsUpdated()

    def __setVehicleHealth(self, vInfo, health, forceUpdate):
        prevHealth = self.__vehsCache.get(vInfo.vehicleID)
        if not forceUpdate and prevHealth is not None and prevHealth == health:
            return
        else:
            self.__vehsCache.update({vInfo.vehicleID: health})
            if not vInfo.isObserver():
                self.as_setPlayerPanelHpS(vInfo.vehicleID, self.__getVehicleMaxHealth(vInfo), health)
            if health <= 0:
                self.as_setPlayerDeadS(vInfo.vehicleID)
                self.as_setPlayerPanelCountSoulsS(vInfo.vehicleID, 0)
            return

    def __getVehicleMaxHealth(self, vInfo):
        vehicle = BigWorld.entities.get(vInfo.vehicleID)
        if vehicle is not None:
            return vehicle.maxHealth
        else:
            return vInfo.vehicleType.maxHealth

    def __updateTeammate(self, vInfo, hpCurrent):
        arenaDP = self.guiSessionProvider.getArenaDP()
        playerVehicleID = avatar_getter.getPlayerVehicleID()
        isSelf = vInfo.vehicleID == playerVehicleID
        playerSquad = arenaDP.getVehicleInfo(playerVehicleID).squadIndex
        isSquad = False
        if playerSquad > 0 and playerSquad == vInfo.squadIndex or playerSquad == 0 and vInfo.vehicleID == playerVehicleID:
            isSquad = True
        badgeID = vInfo.selectedBadge
        badge = buildBadge(badgeID, vInfo.getBadgeExtraInfo())
        badgeVO = badge.getBadgeVO(ICONS_SIZES.X24, {'isAtlasSource': True}, shortIconName=True) if badge else None
        suffixBadgeId = vInfo.selectedSuffixBadge
        playerName = vInfo.player.name
        if vInfo.player.clanAbbrev:
            playerName = ('{}[{}]').format(vInfo.player.name, vInfo.player.clanAbbrev)
        self.as_setPlayerPanelInfoS({'vehID': vInfo.vehicleID, 'name': playerName, 
           'badgeVO': badgeVO, 
           'suffixBadgeIcon': ('badge_{}').format(suffixBadgeId) if suffixBadgeId else '', 
           'suffixBadgeStripIcon': ('strip_{}').format(suffixBadgeId) if suffixBadgeId else '', 
           'nameVehicle': vInfo.vehicleType.shortName, 
           'typeVehicle': vInfo.vehicleType.classTag, 
           'hpMax': vInfo.vehicleType.maxHealth, 
           'hpCurrent': hpCurrent, 
           'isSelf': isSelf, 
           'isSquad': isSquad, 
           'squadIndex': vInfo.squadIndex, 
           'countSouls': self.teamInfoStats.getSouls(vInfo.vehicleID), 
           'isPostMortem': self.__isPostmortem})
        return

    def __onTeamSoulsUpdated(self, needAnimateIncome=True):
        totalSouls = 0
        for data in self.teamInfoStats.souls:
            self.as_setPlayerPanelCountSoulsS(data.id, data.value)
            totalSouls += data.value

        delta = max(totalSouls - self.__prevTotalSouls, 0) if needAnimateIncome else 0
        self.as_setCollectorTeamValueS(totalSouls, delta)
        self.__prevTotalSouls = totalSouls

    def __onCollectorSoulsChanged(self, *args):
        if self.battleGUICtrl:
            souls, capacity = self.battleGUICtrl.getCurrentCollectorSoulsInfo()
            if souls is not None and capacity is not None:
                self.as_setCollectorNeedValueS(max(0, capacity - souls))
        return

    def __onBattleGoalChanged(self, relevantGoal):
        if relevantGoal == EventBattleGoal.UNKNOWN:
            self.as_setCollectorGoalS(BattleGoalMapping[EventBattleGoal.COLLECT_SOULS])
        else:
            self.as_setCollectorGoalS(BattleGoalMapping[relevantGoal])
        self.__onCollectorSoulsChanged()

    def __onPostMortemSwitched(self, noRespawnPossible, respawnAvailable):
        self.__isPostmortem = True
        self.__updateTeamPanel()
        self.as_setPostmortemS(True)

    def __onRespawnBaseMoving(self):
        self.__isPostmortem = False
        self.__updateTeamPanel()
        self.as_setPostmortemS(False)