import functools, logging, AccountCommands
_logger = logging.getLogger(__name__)

class ShopSalesEvent(object):

    def __init__(self):
        self.__account = None
        self.__ignore = False
        return

    def setAccount(self, account):
        self.__account = account

    def onAccountBecomePlayer(self):
        self.__ignore = False

    def onAccountBecomeNonPlayer(self):
        self.__ignore = True

    def getCurrentBundle(self, callback=None):
        self.__doCommand(AccountCommands.CMD_BUNDLE_GET, 'CMD_BUNDLE_GET', callback)

    def reRollBundle(self, callback=None):
        self.__doCommand(AccountCommands.CMD_BUNDLE_REROLL, 'CMD_BUNDLE_REROLL', callback)

    def __doCommand(self, command, commandName, callback):
        if self.__ignore:
            if callback is not None:
                callback(AccountCommands.RES_NON_PLAYER, {})
            return
        self.__account._doCmdInt(command, 0, functools.partial(self.__onResponse, commandName, callback))
        return

    @staticmethod
    def __onResponse(commandName, callback, requestID, resultID, errorCode, *args, **kwargs):
        ((errorCode or _logger).debug if 1 else _logger.error)('%s: (Req: %s, Res: %s) | Err: %s | Data: %s, %s', commandName, requestID, resultID, errorCode, args, kwargs)
        if callback is not None:
            callback(resultID, errorCode, (errorCode or args)[0] if 1 else (True, '', 0, None))
        return