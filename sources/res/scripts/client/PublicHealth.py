from debug_utils import LOG_DEBUG_DEV
from script_component.DynamicScriptComponent import DynamicScriptComponent

class PublicHealth(DynamicScriptComponent):

    def _onAvatarReady(self):
        for healthInfo in self.healthInfoList:
            self.__notifyHealthChange(healthInfo)

    def setNested_healthInfoList(self, path, prev):
        self.__notifyHealthChange(self.healthInfoList[path[0]])

    def setSlice_healthInfoList(self, path, prev):
        self.__notifyHealthChange(self.healthInfoList[path[0][0]])

    def __notifyHealthChange(self, healthInfo):
        LOG_DEBUG_DEV('[PublicHealth] __notifyHealthChange', healthInfo)
        feedback = self.entity.sessionProvider.shared.feedback
        feedback.onPublicHealthChange(healthInfo.vehicleID, healthInfo.health)