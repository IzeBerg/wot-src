import BigWorld
from constants import FIRE_NOTIFICATION_CODES
from skeletons.gui.battle_session import IBattleSessionProvider
from helpers import dependency
import CGF, Math
from script_component.DynamicScriptComponent import DynamicScriptComponent

class CircuitOverload(DynamicScriptComponent):
    __guiSessionProvider = dependency.descriptor(IBattleSessionProvider)

    def __init__(self):
        super(CircuitOverload, self).__init__()
        self.__prefab = None
        return

    def set_circuitOverloadInfo(self, _=None):
        circuitOverloadInfo = self.circuitOverloadInfo
        if circuitOverloadInfo is None:
            return
        else:
            vehicle = self.entity
            avatar = BigWorld.player()
            self.__guiSessionProvider.shared.messages.showVehicleDamageInfo(avatar, FIRE_NOTIFICATION_CODES[circuitOverloadInfo['notificationIndex']], vehicle.id, 0, None, 0)
            CGF.loadGameObjectIntoHierarchy(circuitOverloadInfo['prefabPath'], vehicle.entityGameObject, Math.Vector3(0, 0, 0), self.__onGameObjectLoaded)
            return

    def __onGameObjectLoaded(self, prefab):
        self.__prefab = prefab

    def onDestroy(self):
        if self.__prefab is not None:
            CGF.removeGameObject(self.__prefab)
        self.__prefab = None
        super(CircuitOverload, self).onDestroy()
        return