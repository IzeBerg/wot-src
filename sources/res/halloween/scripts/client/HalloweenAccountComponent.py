import AccountCommands
from BaseAccountExtensionComponent import BaseAccountExtensionComponent
from PlayerEvents import g_playerEvents as events
from halloween.skeletons.halloween_controller import IHalloweenController
from halloween_common.halloween_account_commands import CMD_UNLOCK_TOKEN, CMD_LOCK_TOKEN, CMD_HW_ARTEFACT_OPEN, CMD_HW_BUY_BUNDLE
from helpers import dependency

class HalloweenAccountComponent(BaseAccountExtensionComponent):
    _hwController = dependency.descriptor(IHalloweenController)

    def enqueueBattle(self, queueType, vehInvID):
        if not events.isPlayerEntityChanging:
            self.base.doCmdIntArr(AccountCommands.REQUEST_ID_NO_RESPONSE, AccountCommands.CMD_ENQUEUE_IN_BATTLE_QUEUE, (
             queueType, vehInvID))

    def dequeueBattle(self, queueType):
        if not events.isPlayerEntityChanging:
            self.base.doCmdInt(AccountCommands.REQUEST_ID_NO_RESPONSE, AccountCommands.CMD_DEQUEUE_FROM_BATTLE_QUEUE, queueType)

    def unlockToken(self, token, tokenCount=1, callback=None):
        if callback is not None:
            proxy = lambda requestID, resultID, errorStr, ext={}: callback(resultID)
        else:
            proxy = None
        self.account._doCmdIntStr(CMD_UNLOCK_TOKEN, tokenCount, token, proxy)
        return

    def lockToken(self, token, callback=None):
        if callback is not None:
            proxy = lambda requestID, resultID, errorStr, ext={}: callback(resultID)
        else:
            proxy = None
        self.account._doCmdStr(CMD_LOCK_TOKEN, token, proxy)
        return

    def openArtefact(self, artefactID, isSkipQuest, callback=None):
        if callback is not None:
            proxy = lambda requestID, resultID, errorStr, ext={}: callback(requestID, resultID, errorStr)
        else:
            proxy = None
        self.account._doCmdInt2Str(CMD_HW_ARTEFACT_OPEN, self.account.shop.getCacheRevision(), int(isSkipQuest), artefactID, proxy)
        return

    def buyBundle(self, bundleID, count=1, callback=None):
        if callback is not None:
            proxy = lambda requestID, resultID, errorStr, ext={}: callback(requestID, resultID, errorStr)
        else:
            proxy = None
        self.account._doCmdInt2Str(CMD_HW_BUY_BUNDLE, self.account.shop.getCacheRevision(), int(count), bundleID, proxy)
        return

    def getHalloweenController(self):
        return self._hwController