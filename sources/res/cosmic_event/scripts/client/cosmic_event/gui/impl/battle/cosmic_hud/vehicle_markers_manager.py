import logging, typing
from cosmic_event.gui.impl.battle.cosmic_hud import getArenaScoreComponent, getVictimToKillerInfo, isMyKiller
from cosmic_event import getFragmentManager, getVehicleFragments
from cosmic_event.gui.impl.gen.view_models.views.battle.cosmic_hud.vehicle_marker_model import VehicleMarkerModel
from gui.Scaleform.daapi.view.battle.shared.markers2d import plugins, vehicle_plugins
from gui.Scaleform.daapi.view.battle.shared.markers2d.settings import CommonMarkerType
from gui.battle_control import avatar_getter
from wg_async import wg_await, wg_async, delay
if typing.TYPE_CHECKING:
    from frameworks.wulf import Array
_logger = logging.getLogger(__name__)
RESPAWN_TIME_OFFSET = 0.7

class VehicleMarkersManager(plugins.IMarkersManager):
    _pluginClass = vehicle_plugins.VehicleMarkerPlugin

    def __init__(self, markersArray, markersCtrl):
        self._plugins = []
        self._vehicleMarkerMgrIdx = -1
        self._markers = markersArray
        self._markersCtrl = markersCtrl

    def start(self):
        plugin = vehicle_plugins.VehicleMarkerPlugin(self)
        self._vehicleMarkerMgrIdx = len(self._plugins)
        self._plugins.append(plugin)
        for p in self._plugins:
            p.init()
            p.start()

        _logger.debug('VehicleMarkersManager: start')
        arenScoreComp = getArenaScoreComponent()
        if arenScoreComp:
            arenScoreComp.onVictimToKillerInfoUpdated += self.__onVictimToKillerInfoUpdated
            arenScoreComp.onArenaScoreUpdated += self.__onArenaScoreUpdated
        else:
            _logger.warning("Couldn't get ArenaInfoScoreSystemComponent!")
        fragmentManagerComp = getFragmentManager()
        if fragmentManagerComp:
            fragmentManagerComp.onFragmentsUpdate += self.__onFragmentsUpdate
            self.__onFragmentsUpdate(fragmentManagerComp.getVehiclesWithFragments())
        else:
            _logger.warning("Couldn't get FragmentManager")

    def stop(self):
        arenScoreComp = getArenaScoreComponent()
        if arenScoreComp:
            arenScoreComp.onVictimToKillerInfoUpdated -= self.__onVictimToKillerInfoUpdated
            arenScoreComp.onArenaScoreUpdated -= self.__onArenaScoreUpdated
        else:
            _logger.info("Couldn't unsubscribe because couldn't find ArenaInfoScoreSystemComponent!")
        fragmentManagerComp = getFragmentManager()
        if fragmentManagerComp:
            fragmentManagerComp.onFragmentsUpdate -= self.__onFragmentsUpdate
        else:
            _logger.info("Couldn't unsubscribe because couldn't find FragmentManager")
        for p in self._plugins:
            p.stop()
            p.fini()

        self._plugins = []
        for markerModel in self._markers:
            self._markersCtrl.remove(markerModel.proxy)

        _logger.debug('VehicleMarkersManager: stop')

    def createMarker(self, symbol, matrixProvider=None, active=True, markerType=CommonMarkerType.VEHICLE):
        _logger.debug('VehicleMarkersManager invoked: createMarker %s', symbol)
        markerModel = VehicleMarkerModel()
        self._markers.addViewModel(markerModel)
        return len(self._markers) - 1

    @wg_async
    def invokeMarker(self, markerID, *signature):
        _logger.debug('VehicleMarkersManager invoked: invokeMarker (%s)', str(signature))
        mModel = self._markers[markerID]
        if signature[0] == 'setVehicleInfo':
            mModel.setPlayerName(signature[6])
            self.__updateOffenderState(mModel, markerID, getVictimToKillerInfo())
        elif signature[0] == 'updateHealth':
            if signature[1] <= 0:
                mModel.setIsDisabled(True)
            else:
                yield wg_await(delay(RESPAWN_TIME_OFFSET))
                mModel.setIsDisabled(False)

    def setMarkerMatrix(self, markerID, matrix):
        _logger.debug('VehicleMarkersManager invoked: setMarkerMatrix')
        self._markersCtrl.add(self._markers[markerID].proxy, matrix)

    def setMarkerActive(self, markerID, active):
        mModel = self._markers[markerID]
        mModel.setIsVisible(active)

    def setVehicleMarkerDisabled(self, vehicleID, disabled):
        plugin = self._plugins[self._vehicleMarkerMgrIdx]
        markerID = plugin.getVehicleMarker(vehicleID).getMarkerID()
        mModel = self._markers[markerID]
        mModel.setIsDisabled(disabled)

    def setMarkerLocationOffset(self, markerID, minY, maxY, distForMinY, maxBoost, boostStart):
        pass

    def setMarkerRenderInfo(self, markerID, minScale, offset, innerOffset, cullDistance, boundsMinScale):
        pass

    def setMarkerBoundCheckEnabled(self, markerID, enable):
        pass

    def setMarkerObjectInFocus(self, markerID, isInFocus):
        pass

    def destroyMarker(self, markerID):
        pass

    def setMarkerSticky(self, markerID, isSticky):
        pass

    def _createCanvas(self, arenaVisitor):
        pass

    def _setupPlugins(self, arenaVisitor):
        pass

    def __onVictimToKillerInfoUpdated(self, victimToKiller):
        for i, m in enumerate(self._markers):
            if m:
                self.__updateOffenderState(m, i, victimToKiller)

    def __onArenaScoreUpdated(self, totalScore):
        maxScoreVehicleID = max(totalScore, key=totalScore.get)
        for i, model in enumerate(self._markers):
            if model:
                vehicleID = self._plugins[self._vehicleMarkerMgrIdx].getTargetIDFromMarkerID(i)
                model.setIsLeader(maxScoreVehicleID == vehicleID)

    def __onFragmentsUpdate(self, vehicleIDs):
        for i, model in enumerate(self._markers):
            if model:
                self.__updateFragmentsMarker(model, i)

    def __updateOffenderState(self, mModel, markerID, victimToKiller):
        mModel.setIsLastOffender(isMyKiller(myVehicleID=avatar_getter.getPlayerVehicleID(), otherVehicleID=self._plugins[self._vehicleMarkerMgrIdx].getTargetIDFromMarkerID(markerID), victimToKiller=victimToKiller))

    def __updateFragmentsMarker(self, markerModel, markerID):
        vehicleId = self._plugins[self._vehicleMarkerMgrIdx].getTargetIDFromMarkerID(markerID)
        markerModel.setFragmentsCollected(getVehicleFragments(vehicleId))