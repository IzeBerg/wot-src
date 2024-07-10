import logging, CGF, Math
from Triggers import CylinderAreaComponent, AreaTriggerComponent
from races_prefabs import LINK_DETECTOR
from races_common.races_constants import PATH_DETECTOR_RADIUS, PATH_DETECTOR_HEIGHT, PATH_DETECTOR_DEEP
from script_component.DynamicScriptComponent import DynamicScriptComponent
from gui.shared import g_eventBus, EVENT_BUS_SCOPE
from races.gui.shared.event import RacesEvent
_logger = logging.getLogger(__name__)

class RaceVehicleComponent(DynamicScriptComponent):

    def __init__(self, *_, **__):
        super(RaceVehicleComponent, self).__init__(*_, **__)
        self.pathProjectData = None
        self.currentDistanceToFinish = float('inf')
        self.__areaTriggerGO = None
        self.__links = []
        CGF.loadGameObjectIntoHierarchy(LINK_DETECTOR, self.vehicle.entityGameObject, Math.Vector3(0, -PATH_DETECTOR_DEEP, 0), self._linkDetectorLoaded)
        return

    @property
    def vehicle(self):
        return self.entity

    @property
    def linksInZone(self):
        area = self.__areaTriggerGO() if self.__areaTriggerGO is not None else None
        if area:
            return area.objectsInProximity
        else:
            return []

    def setPathProject(self, projectData):
        self.projectData = projectData
        self.currentDistanceToFinish = projectData.getDistanceToLastNode()

    def set_raceFinishTime(self, _=None):
        if self.vehicle.isPlayerVehicle and self.raceFinishTime:
            g_eventBus.handleEvent(RacesEvent(RacesEvent.ON_RACE_FINISHED), scope=EVENT_BUS_SCOPE.BATTLE)
        _logger.debug('RaceVehicleComponent endTime=%s', self.raceFinishTime)

    def needPathProjectUpdate(self):
        return self.racePosition == 0 and self.__areaTriggerGO is not None and self.__areaTriggerGO() is not None

    def _linkDetectorLoaded(self, go):
        if self.vehicle.isDestroyed:
            return
        else:
            if go.findComponentByType(CylinderAreaComponent) is None:
                go.createComponent(CylinderAreaComponent, PATH_DETECTOR_RADIUS, PATH_DETECTOR_HEIGHT)
            self.__areaTriggerGO = CGF.ComponentLink(go, AreaTriggerComponent)
            return