import BigWorld, BattleReplay, GUI, Math
from chat_commands_consts import INVALID_TARGET_ID, MarkerType, ReplyState, BATTLE_CHAT_COMMAND_NAMES
from gui.battle_control import avatar_getter
from gui.Scaleform.daapi.view.battle.epic.minimap import CenteredPersonalEntriesPlugin, MINIMAP_SCALE_TYPES, makeMousePositionToEpicWorldPosition
from gui.Scaleform.daapi.view.battle.shared.minimap.common import BaseAreaMarkerEntriesPlugin, SimplePlugin
from gui.Scaleform.daapi.view.battle.shared.minimap import settings
from gui.Scaleform.daapi.view.battle.shared.minimap.entries import MinimapEntry
from gui.Scaleform.daapi.view.battle.shared.minimap.plugins import ArenaVehiclesPlugin, AreaStaticMarkerPlugin, MinimapPingPlugin, EquipmentsPlugin, _BASE_PING_RANGE, _LOCATION_PING_RANGE
from halloween.gui.hw_vehicle_role_helper import getVehicleRole
from halloween.gui.scaleform.daapi.view.meta.HWMinimapMeta import HWMinimapMeta
from halloween.gui.shared.utils import findMarkerEntity
from shared_utils import findFirst, nextTick
from HWArenaPhasesComponent import HWArenaPhasesComponent
from StaticDeathZoneVisual import StaticDeathZoneVisual
from vehicle_systems.stricted_loading import makeCallbackWeak
_C_NAME = settings.CONTAINER_NAME

class AreaMarkerEntry(MinimapEntry):

    def __init__(self, markerID, active, matrix, targetID=INVALID_TARGET_ID, bcMarkerType=MarkerType.INVALID_MARKER_TYPE):
        super(AreaMarkerEntry, self).__init__(markerID, active, matrix)
        self._targetID = targetID
        self._bcMarkerType = bcMarkerType
        self._isReplied = False
        self._hasAnimation = False

    def getTargetID(self):
        return self._targetID

    def getBCMarkerType(self):
        return self._bcMarkerType

    def getIsReplied(self):
        return self._isReplied

    def setIsReplied(self, value):
        self._isReplied = value

    def hasAnimation(self):
        return self._hasAnimation

    def setHasAnimation(self, value):
        self._hasAnimation = value


class HalloweenMinimapScaleMixin(SimplePlugin):

    def _addEntry(self, symbol, container, matrix=None, active=False, transformProps=settings.TRANSFORM_FLAG.DEFAULT):
        entryID = super(HalloweenMinimapScaleMixin, self)._addEntry(symbol, container, matrix, active, transformProps)
        self._parentObj.setEntryParameters(entryID, scaleType=MINIMAP_SCALE_TYPES.NATIVE)
        return entryID


class HalloweenAreaMarkerEntriesPlugin(HalloweenMinimapScaleMixin, BaseAreaMarkerEntriesPlugin):

    def __init__(self, parent, clazz=AreaMarkerEntry):
        super(HalloweenAreaMarkerEntriesPlugin, self).__init__(parent)
        self._clazz = clazz
        self.__replayMarkersFeedbackStorage = {}

    def start(self):
        super(HalloweenAreaMarkerEntriesPlugin, self).start()
        self.__replayMarkersFeedbackStorage = {}
        ctrl = self.sessionProvider.shared.feedback
        if ctrl is not None:
            ctrl.onReplyFeedbackReceived += self.__onReplyFeedbackReceived
        return

    def stop(self):
        self.__replayMarkersFeedbackStorage = {}
        ctrl = self.sessionProvider.shared.feedback
        if ctrl is not None:
            ctrl.onReplyFeedbackReceived -= self.__onReplyFeedbackReceived
        super(HalloweenAreaMarkerEntriesPlugin, self).stop()
        return

    def createMarker(self, uniqueID, symbol, container, matrix, active, targetID=INVALID_TARGET_ID, bcMarkerType=MarkerType.INVALID_MARKER_TYPE):
        model = self._addEntryEx(uniqueID, symbol, container, matrix=matrix, active=active, targetID=targetID, bcMarkerType=bcMarkerType)
        if model is not None:
            self.__checkReplayFeedback(targetID, bcMarkerType)
            return True
        else:
            return False

    def setHasAnimation(self, componentID, value):
        entry = self._entries.get(componentID)
        if not entry:
            return
        entry.setHasAnimation(value)

    def _addEntryEx(self, uniqueID, symbol, container, matrix=None, active=False, targetID=INVALID_TARGET_ID, bcMarkerType=MarkerType.INVALID_MARKER_TYPE, transformProps=settings.TRANSFORM_FLAG.DEFAULT):
        if uniqueID in self._entries:
            return self._entries[uniqueID]
        else:
            entryID = self._addEntry(symbol, container, matrix=matrix, active=active, transformProps=transformProps)
            if entryID:
                model = self._clazz(entryID, active, matrix, targetID=targetID, bcMarkerType=bcMarkerType)
                self._entries[uniqueID] = model
            else:
                model = None
            return model

    def _getMarkerFromTargetID(self, targetID, markerType):
        return findFirst(lambda item: item.getTargetID() == targetID and item.getBCMarkerType() == markerType, self._entries.itervalues())

    def __onReplyFeedbackReceived(self, targetID, replierID, markerType, oldReplyCount, newReplyCount):
        entry = self._getMarkerFromTargetID(targetID, markerType)
        if not entry:
            if BattleReplay.g_replayCtrl.isPlaying:
                self.__replayMarkersFeedbackStorage.setdefault((
                 targetID, markerType), []).append((targetID, replierID, markerType, oldReplyCount, newReplyCount))
            return
        if entry.hasAnimation() and oldReplyCount == 0 and newReplyCount == 0:
            self._parentObj.invoke(entry.getID(), 'triggerClickAnimation')
        isReply = newReplyCount > 0
        if entry.getIsReplied() != isReply:
            self._parentObj.invoke(entry.getID(), 'setMarkerReplied', isReply)
            entry.setIsReplied(isReply)

    def __checkReplayFeedback(self, targetID, markerType):
        argsStorage = self.__replayMarkersFeedbackStorage.pop((targetID, markerType), [])
        for args in argsStorage:
            nextTick(makeCallbackWeak(self.__onReplyFeedbackReceived))(*args)

    def setEntryParameters(self, uniqueID, doClip=True, scaleType=MINIMAP_SCALE_TYPES.ADAPTED_SCALE):
        model = self._entries.get(uniqueID)
        if model:
            self._parentObj.setEntryParameters(model.getID(), doClip, scaleType)


class HalloweenMinimapVehiclesPlugin(HalloweenMinimapScaleMixin, ArenaVehiclesPlugin):

    def start(self):
        super(HalloweenMinimapVehiclesPlugin, self).start()
        HWArenaPhasesComponent.onHideVehicleOnMinimap += self._onHideVehicleOnMinimap

    def stop(self):
        super(HalloweenMinimapVehiclesPlugin, self).stop()
        HWArenaPhasesComponent.onHideVehicleOnMinimap -= self._onHideVehicleOnMinimap

    def _getVehicleClassTag(self, vInfo):
        vehicleType = vInfo.vehicleType
        role = getVehicleRole(vehicleType)
        if role is not None:
            return role
        else:
            return super(HalloweenMinimapVehiclesPlugin, self)._getVehicleClassTag(vInfo)

    def _onHideVehicleOnMinimap(self, vehicleID):
        entry = self._entries.get(vehicleID)
        if entry:
            entry.setActive(False)
            entry.setInAoI(False)
            self._setActive(entry.getID(), False)


class HalloweenAreaStaticMarkerPlugin(AreaStaticMarkerPlugin):

    def _addEntry(self, symbol, container, matrix=None, active=False, transformProps=settings.TRANSFORM_FLAG.DEFAULT):
        entryID = super(HalloweenAreaStaticMarkerPlugin, self)._addEntry(symbol, container, matrix, active, transformProps)
        self._parentObj.setEntryParameters(entryID, doClip=False, scaleType=MINIMAP_SCALE_TYPES.PROPORTIONAL)
        return entryID


class HalloweenEquipmentsPlugin(HalloweenMinimapScaleMixin, EquipmentsPlugin):
    pass


class HalloweenMinimapPingPlugin(HalloweenMinimapScaleMixin, MinimapPingPlugin):

    def _getClickPosition(self, x, y):
        return makeMousePositionToEpicWorldPosition(x, y, self._parentObj.getVisualBounds())

    def _getIdByBaseNumber(self, team, number):
        pass

    def _processCommandByPosition(self, commands, locationCommand, position, minimapScaleIndex):
        if avatar_getter.isVehicleAlive():
            entity = self._getNearestMarkerEntity(position, _BASE_PING_RANGE)
            if entity is not None:
                self._make3DPingEntity(commands, entity)
                return
            locationID = self._getNearestLocationIDForPosition(position, _LOCATION_PING_RANGE)
            if locationID is not None:
                self._replyPing3DMarker(commands, locationID)
                return
        commands.sendAttentionToPosition3D(position, locationCommand)
        return

    def _getNearestMarkerEntity(self, inPosition, pingRange):
        entities = findMarkerEntity()
        if not entities:
            return
        else:
            nearestEntity = entities[0]
            for entity in entities:
                if Math.Vector3(entity.position).flatDistTo(inPosition) < Math.Vector3(nearestEntity.position).flatDistTo(inPosition):
                    nearestEntity = entity

            if Math.Vector3(nearestEntity.position).flatDistTo(inPosition) <= pingRange:
                return nearestEntity
            return

    def _make3DPingEntity(self, commands, entity):
        advChatCmp = getattr(self.sessionProvider.arenaVisitor.getComponentSystem(), 'advancedChatComponent', None)
        if advChatCmp is None:
            return
        else:
            targetID = entity.id
            replyState, commandKey = advChatCmp.getReplyStateForTargetIDAndMarkerType(targetID, MarkerType.TARGET_POINT_MARKER_TYPE)
            if replyState is ReplyState.NO_REPLY:
                commands.sendTargetedCommand(BATTLE_CHAT_COMMAND_NAMES.MOVING_TO_TARGET_POINT, targetID)
                return
            self._processReplyCommand(replyState, commands, targetID, commandKey)
            return


class HWPersonalEntriesPlugin(HalloweenMinimapScaleMixin, CenteredPersonalEntriesPlugin):
    _SYMBOL = 'HWEmptyEntryUI'

    def __init__(self, parentObj):
        super(HWPersonalEntriesPlugin, self).__init__(parentObj)
        self.__minimapCenterEntry = None
        self.__centerCoordinate = Math.Vector3(0, 0, 0)
        return

    def start(self):
        super(HWPersonalEntriesPlugin, self).start()
        StaticDeathZoneVisual.onShowDeathZone += self._onShowDeathZone
        self._setMinimapCenter()

    def stop(self):
        super(HWPersonalEntriesPlugin, self).stop()
        StaticDeathZoneVisual.onShowDeathZone -= self._onShowDeathZone

    def initControlMode(self, mode, available):
        super(HWPersonalEntriesPlugin, self).initControlMode(mode, available)
        self._setMinimapCenter()
        if self._getViewPointID() >= 0:
            self._parentObj.setEntryParameters(self._getViewPointID(), doClip=False, scaleType=MINIMAP_SCALE_TYPES.NATIVE)
        if self._getAnimationID() >= 0:
            self._parentObj.setEntryParameters(self._getAnimationID(), doClip=False, scaleType=MINIMAP_SCALE_TYPES.NATIVE)

    def updateControlMode(self, mode, vehicleID):
        super(HWPersonalEntriesPlugin, self).updateControlMode(mode, vehicleID)
        self._setMinimapCenter()

    def _setMinimapCenter(self):
        matrix = Math.Matrix()
        matrix.setTranslate(self.__centerCoordinate)
        if self.__minimapCenterEntry is None:
            self.__minimapCenterEntry = self._addEntry(self._SYMBOL, _C_NAME.ICONS, matrix=matrix, active=True)
        else:
            self._setMatrix(self.__minimapCenterEntry, matrix)
        self._parentObj.setMinimapCenterEntry(self.__minimapCenterEntry)
        return

    def _onShowDeathZone(self, zoneId, dzVisual):
        guid = dzVisual.entity.masks[0].udoGuid
        udo = BigWorld.userDataObjects.get(guid, None)
        self._calcDZCenter(udo)
        self._setMinimapCenter()
        return

    def _calcDZCenter(self, udo):
        cX, cZ = [], []
        for x, z in udo.minimapMarkerPolygon:
            cX.append(x + udo.position[0])
            cZ.append(udo.position[2] - z)

        resX = (min(cX) + max(cX)) / 2
        resZ = (min(cZ) + max(cZ)) / 2
        self.__centerCoordinate = Math.Vector3(resX, 0, resZ)


class HalloweenMinimapComponent(HWMinimapMeta):
    _MINIMAP_NO_ZOOM = 1.4
    _MINIMAP_ZOOM_DZ = 0.4
    _MINIMAP_1M_IN_PX = 0.21

    def getVisualBounds(self):
        return self.getComponent().getVisualBound()

    def _populate(self):
        super(HalloweenMinimapComponent, self)._populate()
        StaticDeathZoneVisual.onShowDeathZone += self._onShowDeathZone
        self.changeMinimapZoom(self._MINIMAP_NO_ZOOM)

    def _dispose(self):
        super(HalloweenMinimapComponent, self)._dispose()
        StaticDeathZoneVisual.onShowDeathZone -= self._onShowDeathZone

    def changeMinimapZoom(self, mode):
        self.getComponent().changeMinimapZoom(mode)

    def setEntryParameters(self, entryId, doClip=True, scaleType=MINIMAP_SCALE_TYPES.ADAPTED_SCALE):
        self.getComponent().setEntryParameters(entryId, doClip, scaleType)

    def setMinimapCenterEntry(self, entryID):
        self.getComponent().setMinimapCenterEntry(entryID)

    def _createFlashComponent(self):
        return GUI.WGScrollingMinimapGUIComponentAS3(self.app.movie, settings.MINIMAP_COMPONENT_PATH)

    def _processMinimapSize(self, minSize, maxSize):
        mapWidthPx = int(abs(maxSize[0] - minSize[0]) * self._MINIMAP_1M_IN_PX)
        mapHeightPx = int(abs(maxSize[1] - minSize[1]) * self._MINIMAP_1M_IN_PX)
        self.as_setMapDimensionsS(mapWidthPx, mapHeightPx)

    def _onShowDeathZone(self, zoneId, dzVisual):
        self.changeMinimapZoom(self._MINIMAP_ZOOM_DZ)
        self.as_setZoomModeS(True)

    def _setupPlugins(self, arenaVisitor):
        setup = super(HalloweenMinimapComponent, self)._setupPlugins(arenaVisitor)
        setup['area_markers'] = HalloweenAreaMarkerEntriesPlugin
        setup['personal'] = HWPersonalEntriesPlugin
        setup['vehicles'] = HalloweenMinimapVehiclesPlugin
        setup['area'] = HalloweenAreaStaticMarkerPlugin
        setup['equipments'] = HalloweenEquipmentsPlugin
        if not BattleReplay.g_replayCtrl.isPlaying:
            setup['pinging'] = HalloweenMinimapPingPlugin
        return setup