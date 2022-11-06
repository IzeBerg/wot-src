import logging, BattleReplay, BigWorld, CommandMapping, Keys, Math
from PlayerEvents import g_playerEvents
from account_helpers import AccountSettings
from account_helpers.settings_core import settings_constants
from chat_commands_consts import BATTLE_CHAT_COMMAND_NAMES, getBaseTeamAndIDFromUniqueID, MarkerType, getUniqueTeamOrControlPointID
from constants import IS_DEVELOPMENT
from debug_utils import LOG_DEBUG
from gui import GUI_SETTINGS, g_repeatKeyHandlers
from gui.Scaleform.daapi.view.battle.shared.minimap import common, plugins
from gui.Scaleform.daapi.view.battle.shared.minimap import component
from gui.Scaleform.daapi.view.battle.shared.minimap import settings
from gui.Scaleform.daapi.view.battle.shared.minimap.plugins import _LOCATION_PING_RANGE, _BASE_PING_RANGE, _EMinimapMouseKey
from gui.Scaleform.genConsts.BATTLE_MINIMAP_CONSTS import BATTLE_MINIMAP_CONSTS
from gui.battle_control import minimap_utils, avatar_getter
from gui.shared import g_eventBus, events, EVENT_BUS_SCOPE
from messenger import MessengerEntry
from messenger.proto.bw_chat2.battle_chat_cmd import BASE_CMD_NAMES
from messenger_common_chat2 import MESSENGER_ACTION_IDS as _ACTIONS
_C_NAME = settings.CONTAINER_NAME
_S_NAME = settings.ENTRY_SYMBOL_NAME
_MIN_BASE_SCALE = 1.0
_MAX_BASE_SCALE = 0.6
_logger = logging.getLogger(__name__)
_CLASSIC_MINIMAP_DIMENSIONS = 10

class ClassicMinimapComponent(component.MinimapComponent):

    def _setupPlugins(self, arenaVisitor):
        setup = super(ClassicMinimapComponent, self)._setupPlugins(arenaVisitor)
        setup['settings'] = GlobalSettingsPlugin
        setup['points'] = TeamsOrControlsPointsPlugin
        if not BattleReplay.g_replayCtrl.isPlaying:
            setup['pinging'] = ClassicMinimapPingPlugin
        if IS_DEVELOPMENT:
            setup['teleport'] = ClassicTeleportPlugin
        return setup

    def hasMinimapGrid(self):
        return True

    def getMinimapDimensions(self):
        return _CLASSIC_MINIMAP_DIMENSIONS


class GlobalSettingsPlugin(common.SimplePlugin):
    __slots__ = ('_currentSizeSettings', '__isVisible', '_sizeIndex', '__canChangeAlpha')
    _AccountSettingsClass = AccountSettings

    def __init__(self, parentObj):
        super(GlobalSettingsPlugin, self).__init__(parentObj)
        self._currentSizeSettings = 'minimapSize'
        self.__isVisible = True
        self._sizeIndex = 0
        self.__canChangeAlpha = parentObj.canChangeAlpha()

    def start(self):
        super(GlobalSettingsPlugin, self).start()
        if GUI_SETTINGS.minimapSize:
            g_eventBus.addListener(events.GameEvent.MINIMAP_CMD, self.__handleMinimapCmd, scope=EVENT_BUS_SCOPE.BATTLE)
            g_repeatKeyHandlers.add(self.__handleRepeatKeyEvent)

    def stop(self):
        if GUI_SETTINGS.minimapSize:
            g_eventBus.removeListener(events.GameEvent.MINIMAP_CMD, self.__handleMinimapCmd, scope=EVENT_BUS_SCOPE.BATTLE)
            g_repeatKeyHandlers.discard(self.__handleRepeatKeyEvent)
        super(GlobalSettingsPlugin, self).stop()

    def setSettings(self):
        newSize = settings.clampMinimapSizeIndex(self._AccountSettingsClass.getSettings(self._currentSizeSettings))
        if self._sizeIndex != newSize:
            self._sizeIndex = newSize
            self._parentObj.as_setSizeS(self._sizeIndex)
        self.__updateAlpha()

    def updateSettings(self, diff):
        if settings_constants.GAME.MINIMAP_ALPHA in diff or settings_constants.GAME.MINIMAP_ALPHA_ENABLED in diff:
            self.__updateAlpha()

    def applyNewSize(self, sizeIndex):
        LOG_DEBUG('Size index of minimap is changed', sizeIndex)
        self._sizeIndex = sizeIndex
        self._saveSettings()

    def _changeSizeSettings(self, newSizeSettings):
        if newSizeSettings == self._currentSizeSettings:
            return newSizeSettings
        previousSettings = self._currentSizeSettings
        self._currentSizeSettings = newSizeSettings
        self.setSettings()
        return previousSettings

    def _toogleVisible(self):
        self.__isVisible = not self.__isVisible
        self._parentObj.as_setVisibleS(self.__isVisible)

    def _saveSettings(self):
        self._AccountSettingsClass.setSettings(self._currentSizeSettings, self._sizeIndex)

    def __setSizeByStep(self, step):
        newIndex = settings.clampMinimapSizeIndex(self._sizeIndex + step)
        if self._sizeIndex != newIndex:
            LOG_DEBUG('Try to change size index of minimap by step', newIndex)
            self._parentObj.as_setSizeS(newIndex)

    def __handleKey(self, key):
        if self._parentObj.isModalViewShown():
            return
        cmdMap = CommandMapping.g_instance
        if cmdMap.isFired(CommandMapping.CMD_MINIMAP_SIZE_DOWN, key):
            self.__setSizeByStep(-1)
        elif cmdMap.isFired(CommandMapping.CMD_MINIMAP_SIZE_UP, key):
            self.__setSizeByStep(1)
        elif cmdMap.isFired(CommandMapping.CMD_MINIMAP_VISIBLE, key):
            self._toogleVisible()

    def __handleRepeatKeyEvent(self, event):
        if MessengerEntry.g_instance.gui.isFocused():
            return
        if event.isRepeatedEvent() and event.isKeyDown() and not BigWorld.isKeyDown(Keys.KEY_RSHIFT) and CommandMapping.g_instance.isFiredList((
         CommandMapping.CMD_MINIMAP_SIZE_DOWN,
         CommandMapping.CMD_MINIMAP_SIZE_UP), event.key):
            self.__handleKey(event.key)

    def __handleMinimapCmd(self, event):
        self.__handleKey(event.ctx['key'])

    def __updateAlpha(self):
        if not self.__canChangeAlpha:
            return
        if self.settingsCore.getSetting(settings_constants.GAME.MINIMAP_ALPHA_ENABLED):
            value = int(self.settingsCore.getSetting(settings_constants.GAME.MINIMAP_ALPHA))
        else:
            value = 0.0
        self._parentObj.as_setAlphaS(1 - value / 100.0)


class TeamsOrControlsPointsPlugin(common.EntriesPlugin):
    __slots__ = ('__personalTeam', '__entries', '__markerIDs', '__hasActiveCommit')

    def __init__(self, parentObj):
        super(TeamsOrControlsPointsPlugin, self).__init__(parentObj)
        self.__personalTeam = 0
        self.__entries = []
        self.__markerIDs = {}
        self.__hasActiveCommit = False

    def start(self):
        super(TeamsOrControlsPointsPlugin, self).start()
        g_playerEvents.onTeamChanged += self.__onTeamChanged
        ctrl = self.sessionProvider.shared.feedback
        if ctrl is not None:
            ctrl.onActionAddedToMarkerReceived += self.__onActionAddedToMarkerReceived
            ctrl.onReplyFeedbackReceived += self.__onReplyFeedbackReceived
            ctrl.onRemoveCommandReceived += self.__onRemoveCommandReceived
        self.restart()
        return

    def stop(self):
        g_playerEvents.onTeamChanged -= self.__onTeamChanged
        super(TeamsOrControlsPointsPlugin, self).stop()
        ctrl = self.sessionProvider.shared.feedback
        if ctrl is not None:
            ctrl.onActionAddedToMarkerReceived -= self.__onActionAddedToMarkerReceived
            ctrl.onReplyFeedbackReceived -= self.__onReplyFeedbackReceived
            ctrl.onRemoveCommandReceived -= self.__onRemoveCommandReceived
        return

    def restart(self):
        for x in self.__entries:
            self._delEntry(x)

        self.__entries = []
        self.__personalTeam = self._arenaDP.getNumberOfTeam()
        self.__addTeamSpawnPoints()
        self.__addTeamBasePositions()
        self.__addControlPoints()

    def __onActionAddedToMarkerReceived(self, senderID, commandID, markerType, objectID):
        if _ACTIONS.battleChatCommandFromActionID(commandID).name not in BASE_CMD_NAMES:
            return
        else:
            if objectID not in self.__markerIDs:
                return
            model = self.__markerIDs[objectID]
            if model is not None:
                if _ACTIONS.battleChatCommandFromActionID(commandID).name in [BATTLE_CHAT_COMMAND_NAMES.ATTACKING_BASE,
                 BATTLE_CHAT_COMMAND_NAMES.DEFENDING_BASE]:
                    self.__onReplyFeedbackReceived(objectID, senderID, MarkerType.BASE_MARKER_TYPE, 0, 1)
                else:
                    self._invoke(model.getID(), BATTLE_MINIMAP_CONSTS.SET_STATE, BATTLE_MINIMAP_CONSTS.STATE_ATTACK)
            return

    def __onReplyFeedbackReceived(self, ucmdID, replierID, markerType, oldReplyCount, newReplyCount):
        if markerType != MarkerType.BASE_MARKER_TYPE:
            return
        newReply = newReplyCount > oldReplyCount
        playerHasReply = replierID == avatar_getter.getPlayerVehicleID()
        if ucmdID in self.__markerIDs and newReply:
            if playerHasReply:
                self._invoke(self.__markerIDs[ucmdID].getID(), BATTLE_MINIMAP_CONSTS.SET_STATE, BATTLE_MINIMAP_CONSTS.STATE_REPLY)
                self.__hasActiveCommit = True
            elif not self.__hasActiveCommit:
                self._invoke(self.__markerIDs[ucmdID].getID(), BATTLE_MINIMAP_CONSTS.SET_STATE, BATTLE_MINIMAP_CONSTS.STATE_IDLE)
        if ucmdID in self.__markerIDs:
            if newReplyCount < oldReplyCount and playerHasReply or newReplyCount <= 0:
                self._invoke(self.__markerIDs[ucmdID].getID(), BATTLE_MINIMAP_CONSTS.SET_STATE, BATTLE_MINIMAP_CONSTS.STATE_IDLE)
                if playerHasReply:
                    self.__hasActiveCommit = False

    def __onRemoveCommandReceived(self, removeID, markerType):
        if not self.__markerIDs or markerType != MarkerType.BASE_MARKER_TYPE:
            return
        if removeID in self.__markerIDs:
            self._invoke(self.__markerIDs[removeID].getID(), BATTLE_MINIMAP_CONSTS.SET_STATE, BATTLE_MINIMAP_CONSTS.STATE_DEFAULT)
            return
        _logger.error(str(removeID) + ' not found in markerIDs')

    def __onTeamChanged(self, teamID):
        self.restart()

    def __addBaseEntry(self, symbol, position, uid):
        matrix = Math.Matrix()
        matrix.setTranslate(position)
        model = self._addEntryEx(uid, symbol, _C_NAME.TEAM_POINTS, matrix=matrix, active=True)
        if model is not None:
            self.__markerIDs[uid] = model
            _, number = getBaseTeamAndIDFromUniqueID(uid)
            self._invoke(model.getID(), BATTLE_MINIMAP_CONSTS.SET_POINT_NUMBER, number)
            self._invoke(model.getID(), BATTLE_MINIMAP_CONSTS.SET_STATE, BATTLE_MINIMAP_CONSTS.STATE_DEFAULT)
        return

    def __addPointEntry(self, symbol, position, number):
        matrix = Math.Matrix()
        matrix.setTranslate(position)
        entryID = self._addEntry(symbol, _C_NAME.TEAM_POINTS, matrix=matrix, active=True)
        if entryID:
            self._invoke(entryID, BATTLE_MINIMAP_CONSTS.SET_POINT_NUMBER, number)
            self.__entries.append(entryID)

    def __addTeamSpawnPoints(self):
        points = self._arenaVisitor.getTeamSpawnPointsIterator(self.__personalTeam)
        for team, position, number in points:
            if team == self.__personalTeam:
                symbol = _S_NAME.ALLY_TEAM_SPAWN
            else:
                symbol = _S_NAME.ENEMY_TEAM_SPAWN
            self.__addPointEntry(symbol, position, number)

    def __addTeamBasePositions(self):
        positions = self._arenaVisitor.type.getTeamBasePositionsIterator()
        for team, position, number in positions:
            if team == self.__personalTeam:
                symbol = _S_NAME.ALLY_TEAM_BASE
            else:
                symbol = _S_NAME.ENEMY_TEAM_BASE
            uid = getUniqueTeamOrControlPointID(team, number)
            self.__addBaseEntry(symbol, position, uid)

    def __addControlPoints(self):
        points = self._arenaVisitor.type.getControlPointsIterator()
        for position, number in points:
            uid = getUniqueTeamOrControlPointID(0, number)
            self.__addBaseEntry(_S_NAME.CONTROL_POINT, position, uid)


class ClassicMinimapPingPlugin(plugins.MinimapPingPlugin):

    def _getClickPosition(self, x, y):
        return minimap_utils.makePointMatrixByLocal(x, y, *self._boundingBox).translation

    def _getIdByBaseNumber(self, team, number):
        return getUniqueTeamOrControlPointID(team, number)

    def _processCommandByPosition(self, commands, locationCommand, position, minimapScaleIndex):
        minimapScale = minimap_utils.getMinimapBasePingScale(minimapScaleIndex, _MIN_BASE_SCALE, _MAX_BASE_SCALE)
        scaledBaseRange = _BASE_PING_RANGE * minimapScale
        bases = self.__getNearestBaseForPosition(position, scaledBaseRange)
        if bases is not None:
            self._make3DPingBases(commands, bases)
            return
        else:
            locationID = self._getNearestLocationIDForPosition(position, _LOCATION_PING_RANGE)
            if locationID is not None:
                self._replyPing3DMarker(commands, locationID)
                return
            commands.sendAttentionToPosition3D(position, locationCommand)
            return

    def __getNearestBaseForPosition(self, inPosition, range_):
        positions = self._arenaVisitor.type.getTeamBasePositionsIterator()
        minVal = None
        for team, position, number in positions:
            if minVal is None:
                minVal = (
                 team, position, number)
                continue
            if Math.Vector3(position).flatDistTo(inPosition) < Math.Vector3(minVal[1]).flatDistTo(inPosition):
                minVal = (
                 team, position, number)

        for posControl, number in self._arenaVisitor.type.getControlPointsIterator():
            if minVal is None:
                minVal = (
                 0, posControl, number)
                continue
            if Math.Vector3(posControl).flatDistTo(inPosition) < Math.Vector3(minVal[1]).flatDistTo(inPosition):
                minVal = (
                 0, posControl, number)

        if minVal is None:
            return
        else:
            if Math.Vector3(minVal[1]).flatDistTo(inPosition) <= range_:
                return minVal
            return


class ClassicTeleportPlugin(ClassicMinimapPingPlugin):

    def onMinimapClicked(self, x, y, buttonIdx, minimapScaleIndex):
        if buttonIdx != _EMinimapMouseKey.KEY_MBL.value:
            return
        else:
            player = BigWorld.player()
            if player is not None and player.isTeleport:
                position = self._getClickPosition(x, y)
                result = BigWorld.collide(player.spaceID, (position.x, 1000.0, position.z), (
                 position.x, -1000.0, position.z))
                player.base.vehicle_teleport((
                 position[0], result[0][1], position[2]), 0)
            return