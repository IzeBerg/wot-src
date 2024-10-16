import BigWorld
from adisp import adisp_async
import wg_async as future_async
from gui.shared.gui_items.items_actions.actions import BuyAndInstallConsumables
from gui.shared.gui_items.items_actions.actions import _needExchangeForBuy
from gui.shared.money import ZERO_MONEY
from gui.impl.lobby.dialogs.auxiliary.buy_and_exchange_state_machine import BuyAndExchangeStateEnum
from halloween.gui.shared.event_dispatcher import showHWTankSetupConfirmDialog
from gui.shared.utils import decorators
from gui.shared.gui_items.processors.vehicle import BuyAndInstallConsumablesProcessor
from gui.shared.money import Money
from gui.impl import backport
from gui.impl.gen import R
from gui.shared.gui_items.processors.messages.items_processor_messages import ItemBuyProcessorMessage
from gui.shared.gui_items.processors import plugins as proc_plugs, makeSuccess
from gui.shared.gui_items.gui_item_economics import ITEM_PRICE_ZERO
from HWAccountEquipmentController import getHWConsumables

class HWBuyAndInstallConsumables(BuyAndInstallConsumables):
    __slots__ = ('__confirmOnlyExchange', )

    def __init__(self, vehicle, confirmOnlyExchange=False):
        super(HWBuyAndInstallConsumables, self).__init__(vehicle, confirmOnlyExchange=confirmOnlyExchange)
        self.__confirmOnlyExchange = confirmOnlyExchange

    @adisp_async
    @future_async.wg_async
    def _confirm(self, callback):
        if self._changedItems and _needExchangeForBuy(sum([ item.getBuyPrice().price for item in self._changedItems if not item.isInInventory ], ZERO_MONEY)):
            startState = BuyAndExchangeStateEnum.EXCHANGE_CONTENT
        elif self._changedItems:
            startState = BuyAndExchangeStateEnum.BUY_CONTENT
        else:
            startState = BuyAndExchangeStateEnum.BUY_NOT_REQUIRED
        if self.__confirmOnlyExchange and startState != BuyAndExchangeStateEnum.EXCHANGE_CONTENT:
            callback(True)
        else:
            result = yield future_async.wg_await(showHWTankSetupConfirmDialog(items=self._changedItems, vehicle=self._vehicle, startState=startState))
            callback((result.busy or result.result)[0] if 1 else False)

    @adisp_async
    @decorators.adisp_process('techMaintenance')
    def _action(self, callback):
        result = yield HWBuyAndInstallConsumablesProcessor(self._vehicle).request()
        callback(result)


class HWBuyAndInstallConsumablesProcessor(BuyAndInstallConsumablesProcessor):

    def _successHandler(self, code, ctx=None):
        additionalMessages = []
        if ctx:
            additionalMessages = [ HWItemBuyProcessorMessage(self.itemsCache.items.getItemByCD(cd), count, Money.makeFromMoneyTuple(price)).makeSuccessMsg() for cd, price, count in ctx.get('eqs', [])
                                 ]
        return makeSuccess(auxData=additionalMessages)


class HWItemBuyProcessorMessage(ItemBuyProcessorMessage):

    def _getMsgCtx(self):
        res = super(HWItemBuyProcessorMessage, self)._getMsgCtx()
        res['kind'] = backport.text(R.strings.halloween_system_messages.hw_equipment.title())
        return res


def getVehicleHWConsumablesLayoutPrice(hwConsumables):
    result = sum([ item.getBuyPrice() for item in hwConsumables.layout.getItems() if not item.isInInventory and item not in hwConsumables.installed
                 ], ITEM_PRICE_ZERO)
    return result


class HWDefConsumablesInstallValidator(proc_plugs.ConsumablesInstallValidator):

    def _getLayout(self):
        return getHWConsumables(self._vehicle).layout

    def _getInstalled(self):
        return getHWConsumables(self._vehicle).installed


class HWDefBuyAndInstallConsumablesProcessor(HWBuyAndInstallConsumablesProcessor):

    def _setupPlugins(self):
        self.addPlugins((
         proc_plugs.VehicleValidator(self._vehicle),
         proc_plugs.MoneyValidator(getVehicleHWConsumablesLayoutPrice(getHWConsumables(self._vehicle)).price, byCurrencyError=False),
         HWDefConsumablesInstallValidator(self._vehicle)))

    def _request(self, callback):
        eqCtrl = BigWorld.player().HWAccountEquipmentController
        eqCtrl.updateSelectedEquipment(self._vehicle.invID, self.__getLayoutRaw(), lambda _, code, errStr, ext={}: self._response(code, callback, errStr=errStr, ctx=ext))

    def __getLayoutRaw(self):
        return [ item.intCD if item is not None else 0 for item in getHWConsumables(self._vehicle).layout
               ]


class HWDefBuyAndInstallConsumables(HWBuyAndInstallConsumables):
    __slots__ = ()

    def __init__(self, vehicle, confirmOnlyExchange=False):
        super(HWDefBuyAndInstallConsumables, self).__init__(vehicle, confirmOnlyExchange)
        hwConsumables = getHWConsumables(vehicle)
        self._changedItems = [ item for item in hwConsumables.layout.getItems() if item not in hwConsumables.installed
                             ]

    @adisp_async
    @decorators.adisp_process('techMaintenance')
    def _action(self, callback):
        result = yield HWDefBuyAndInstallConsumablesProcessor(self._vehicle).request()
        callback(result)