import logging, typing, BigWorld, CGF, Event, GenericComponents
from gui.battle_control.arena_info.interfaces import IPointsOfInterestController
from gui.battle_control.battle_constants import BATTLE_CTRL_ID
from points_of_interest.components import PoiStateComponent
from shared_utils import findFirst
if typing.TYPE_CHECKING:
    from EmptyEntity import EmptyEntity
    from gui.battle_control.controllers.repositories import BattleSessionSetup
_logger = logging.getLogger(__name__)

class PointsOfInterestController(IPointsOfInterestController):

    def __init__(self, setup):
        super(PointsOfInterestController, self).__init__()
        self.__eManager = Event.EventManager()
        self.onPoiEquipmentUsed = Event.Event(self.__eManager)
        self.onPoiCaptured = Event.Event(self.__eManager)
        self._vehPoiRegistry = {}

    def startControl(self):
        _logger.debug('[POI] PointsOfInterestController started.')

    def stopControl(self):
        _logger.debug('[POI] PointsOfInterestController stopped.')
        self._vehPoiRegistry.clear()
        self.__eManager.clear()

    def getControllerID(self):
        return BATTLE_CTRL_ID.POINTS_OF_INTEREST_CTRL

    @staticmethod
    def getPoiState(poiID):
        query = CGF.Query(BigWorld.player().spaceID, PoiStateComponent)
        return findFirst(lambda s: s.id == poiID, query)

    @staticmethod
    def getPoiEntity(poiID):
        return BigWorld.entities.get(poiID)

    def getVehicleCapturingPoiGO(self, poiName, entityGameObject, spaceID):
        if poiName in self._vehPoiRegistry:
            return self._vehPoiRegistry[poiName]
        self._vehPoiRegistry[poiName] = poiGameObject = CGF.GameObject(spaceID, poiName)
        poiGameObject.createComponent(GenericComponents.HierarchyComponent, entityGameObject)
        poiGameObject.activate()
        return poiGameObject