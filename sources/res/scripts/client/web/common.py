import typing
from gui.game_control.wallet import WalletController
from gui.shared.money import Currency
from skeletons.gui.shared.utils.requesters import IStatsRequester

def getBalance(stats):
    actualMoney = stats.actualMoney.toDict()
    balanceData = {Currency.currencyExternalName(currency):actualMoney.get(currency, 0) for currency in Currency.ALL}
    balanceData.update(stats.dynamicCurrencies)
    return balanceData


def getWalletCurrencyStatuses(stats):
    statuses = {Currency.currencyExternalName(currencyCode):WalletController.STATUS.getKeyByValue(statusCode).lower() for currencyCode, statusCode in stats.currencyStatuses.iteritems() if currencyCode in Currency.ALL if currencyCode in Currency.ALL}
    statuses.update({currencyCode:WalletController.STATUS.getKeyByValue(statusCode).lower() for currencyCode, statusCode in stats.dynamicCurrencyStatuses.iteritems()})
    return statuses