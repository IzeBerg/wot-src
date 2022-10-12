from functools import partial
import BigWorld, AccountCommands
from adisp import adisp_async, adisp_process
from gui.shared.utils.requesters.common import RequestProcessor
from gui.shared.money import Currency
from debug_utils import LOG_WARNING
from helpers import isPlayerAccount
_REQUEST_COOLDOWN = 5.0
_TOKEN_CURRENCY_CODE = 'currency_code'
_TOKEN_IS_PAID = 'is_paid'
_TOKEN_CLASS = 'class'
_TOKEN_AMOUNT = 'amount'
_TOKEN_GOLD = Currency.GOLD
_TOKEN_CREDITS = Currency.CREDITS
_ACTION_PURCHASED = '_purchased'
_ACTION_EARNED = '_earned'
GOLD_PURCHASED = _TOKEN_GOLD + _ACTION_PURCHASED
GOLD_EARNED = _TOKEN_GOLD + _ACTION_EARNED
CREDITS_PURCHASED = _TOKEN_CREDITS + _ACTION_PURCHASED
CREDITS_EARNED = _TOKEN_CREDITS + _ACTION_EARNED

class WGMBalanceInfoRequester(object):

    def __init__(self):
        self.__request = None
        self.__lastResponseTime = 0
        self.__receivedData = {}
        self.__callbacks = []
        return

    def isRequestInProgress(self):
        return self.__request is not None

    def getLastReceivedData(self):
        return self.__receivedData

    def clearCallbacks(self):
        if self.isRequestInProgress():
            self.__request.cancel()
        del self.__callbacks[:]

    @adisp_process
    def requestInfo(self, callback):
        if callback not in self.__callbacks:
            self.__callbacks.append(callback)
        if not self.isRequestInProgress():
            result = yield self.__requestWGMBalanceInfo()
            for c in self.__callbacks:
                c(result)

            self.__callbacks = []

    @adisp_async
    def __requestWGMBalanceInfo(self, callback):
        proxy = partial(self.__processResponse, callback)
        self.__request = RequestProcessor(self.__nextRequestTime(), lambda : self.__cooldownCallback(proxy))

    def __cooldownCallback(self, callback):
        if isPlayerAccount():
            BigWorld.player().requestWGMBalanceInfo(callback)
        else:
            self.__request = None
            LOG_WARNING('The player is no longer an Account, the request to WGM is skipped')
        return

    def __nextRequestTime(self):
        cooldown = _REQUEST_COOLDOWN - (BigWorld.timeExact() - self.__lastResponseTime)
        if cooldown > 0:
            return cooldown
        return 0

    def __processResponse(self, callback, resultID, errorStr, ext):
        self.__request = None
        self.__lastResponseTime = BigWorld.timeExact()
        self.__receivedData = {}
        if not AccountCommands.isCodeValid(resultID):
            LOG_WARNING(('WGM Balance info is not received, resultID: {}, errorStr: {}').format(resultID, errorStr))
            callback(self.__receivedData)
            return
        else:
            for item in ext:
                if self.__checkFields(item):
                    currencyCode = item[_TOKEN_CURRENCY_CODE]
                    if currencyCode == _TOKEN_GOLD or currencyCode == _TOKEN_CREDITS:
                        amount = item[_TOKEN_AMOUNT]
                        isPaid = item[_TOKEN_CLASS][_TOKEN_IS_PAID]
                        action = _ACTION_PURCHASED if isPaid else _ACTION_EARNED
                        key = currencyCode + action
                        self.__receivedData[key] = amount
                else:
                    LOG_WARNING('Error parsing wgm response, row is: ', item)

            callback(self.__receivedData)
            return

    @staticmethod
    def __checkFields(row):
        expected_keys = frozenset((_TOKEN_CURRENCY_CODE, _TOKEN_CLASS, _TOKEN_AMOUNT))
        view = row.viewkeys()
        diff = expected_keys - view
        return not diff and _TOKEN_IS_PAID in row[_TOKEN_CLASS]