from functools import partial
import AccountCommands
from shared_utils.account_helpers.diff_utils import synchronizeDicts

class SessionStatistics(object):

    def __init__(self, syncData):
        super(SessionStatistics, self).__init__()
        self.__account = None
        self.__syncData = syncData
        self.__cache = {}
        self.__ignore = True
        return

    def onAccountBecomePlayer(self):
        self.__ignore = False

    def onAccountBecomeNonPlayer(self):
        self.__ignore = True

    def setAccount(self, account):
        self.__account = account

    def synchronize(self, isFullSync, diff):
        if isFullSync:
            self.__cache.clear()
        sessionStatsFull = diff.get(('sessionStats', '_r'), {})
        if sessionStatsFull:
            self.__cache['sessionStats'] = dict(sessionStatsFull)
        for item in ('sessionStats', 'wtr'):
            itemDiff = diff.get(item, None)
            if itemDiff is not None:
                synchronizeDicts(itemDiff, self.__cache.setdefault(item, {}))

        return

    def getCache(self, callback=None):
        if self.__ignore:
            if callback is not None:
                callback(AccountCommands.RES_NON_PLAYER, None)
            return
        self.__syncData.waitForSync(partial(self.__onGetCacheResponse, callback))
        return

    def resetStats(self, callback=None):
        if callback is not None:
            proxy = lambda requestID, resultID, errorStr, ext={}: callback(resultID, errorStr, ext)
        else:
            proxy = None
        self.__account._doCmdStr(AccountCommands.CMD_RESET_SESSION_STAT, '', proxy)
        return

    def __onGetCacheResponse(self, callback, resultID):
        if resultID < 0:
            if callback is not None:
                callback(resultID, None)
            return
        if callback is not None:
            callback(resultID, self.__cache)
        return