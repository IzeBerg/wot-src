import BigWorld
from helpers import isPlayerAccount

class BaseAccountExtensionComponent(BigWorld.StaticScriptComponent):

    @property
    def account(self):
        return self.entity

    @property
    def base(self):
        return self.account.base

    @classmethod
    def instance(cls):
        playerAccount = BigWorld.player()
        if isPlayerAccount() and cls.__name__ in playerAccount.components:
            return getattr(playerAccount, cls.__name__, None)
        else:
            return