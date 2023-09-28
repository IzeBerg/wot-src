from frameworks.wulf.view.array import fillViewModelsArray
from gui.impl.gen.view_models.views.lobby.tank_setup.dialogs.sub_views.current_balance_model import CurrentBalanceModel

def initBalance(balanceArray, currencies, itemsCache):
    money = itemsCache.items.stats.money
    currencyModelsList = []
    for currency in currencies:
        cur = CurrentBalanceModel()
        cur.setCurrencyType(currency)
        cur.setCurrencyValue(money.get(currency, 0))
        currencyModelsList.append(cur)

    fillViewModelsArray(currencyModelsList, balanceArray)