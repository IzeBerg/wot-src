import BigWorld
from constants import QUEUE_TYPE

class BaseAccountExtensionComponent(BigWorld.StaticScriptComponent):
    _QUEUE_TYPE = QUEUE_TYPE.UNKNOWN

    @property
    def account(self):
        return self.entity

    @property
    def base(self):
        return self.account.base

    def getQueueType(self):
        return self._QUEUE_TYPE