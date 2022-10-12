from helpers import dependency
from script_component.DynamicScriptComponent import DynamicScriptComponent
from skeletons.gui.battle_session import IBattleSessionProvider

class PoiBaseComponent(DynamicScriptComponent):
    _POI_GO_NAME = 'PointOfInterest{id}'
    __sessionProvider = dependency.descriptor(IBattleSessionProvider)

    def __init__(self):
        super(PoiBaseComponent, self).__init__()
        self._poiGameObject = self.__getPoiGameObject()

    def onLeaveWorld(self):
        self._poiGameObject = None
        return

    def __getPoiGameObject(self):
        name = self._POI_GO_NAME.format(id=self.pointID)
        poiCtrl = self.__sessionProvider.dynamic.pointsOfInterest
        return poiCtrl.getVehicleCapturingPoiGO(name, self.entity.entityGameObject, self.spaceID)