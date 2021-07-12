from collections import namedtuple
from gui import SystemMessages
from gui.shared.gui_items.processors.module import ModuleBuyer
from gui.shared.gui_items.processors.goodies import BoosterBuyer
from gui.shared.gui_items.processors.vehicle import VehicleBuyer
from gui.shared.gui_items.processors.common import PremiumAccountBuyer
from helpers import dependency
from helpers.time_utils import timestampToISO
from skeletons.gui.game_control import ITradeInController
from skeletons.gui.shared import IItemsCache
from soft_exception import SoftException
from skeletons.gui.goodies import IGoodiesCache
from web.web_client_api import W2CSchema, w2c, Field
from web.web_client_api.common import ShopItemType
_ItemBuySpec = namedtuple('ItemBuySpec', ('type', 'id', 'count'))

def parseItemsSpec(specList):
    specList = specList or tuple()
    fields = {'type', 'id', 'count'}
    if not all(set(spec).issubset(fields) for spec in specList):
        raise SoftException('invalid item buy spec')
    for spec in specList:
        if not ShopItemType.hasValue(spec['type']):
            raise SoftException(('unsupported item type "{}"').format(spec['type']))

    return [ _ItemBuySpec(spec['type'], spec['id'], spec['count']) for spec in specList ]


def itemsSpecValidator(specList):
    try:
        parseItemsSpec(specList)
    except SoftException:
        raise

    return True


class _SetTradeOffSelectedSchema(W2CSchema):
    id = Field(required=False, type=int)


class _BuyItemsSchema(W2CSchema):
    items = Field(required=True, type=list, validator=lambda value, _: itemsSpecValidator(value))


class TradeWebApiMixin(object):
    _goodiesCache = dependency.descriptor(IGoodiesCache)
    _itemsCache = dependency.descriptor(IItemsCache)
    _tradeIn = dependency.descriptor(ITradeInController)

    @w2c(W2CSchema, 'get_trade_in_info')
    def getTradeInInfo(self, _):
        start, end = self._tradeIn.getStartEndTimestamps()
        if self._tradeIn.isEnabled():
            return {'allowedVehicleLevels': self._tradeIn.getAllowedVehicleLevels(), 'startDate': timestampToISO(start), 'endDate': timestampToISO(end)}
        else:
            return

    @w2c(W2CSchema, 'get_trade_off_selected')
    def getTradeOffVehicleCD(self, _):
        tradeOffVehicleCD = self._tradeIn.getActiveTradeOffVehicleCD()
        vehicleState, vehicleStateLevel = self._tradeIn.getActiveTradeOffVehicleState()
        return {'id': tradeOffVehicleCD, 
           'state': vehicleState, 
           'level': vehicleStateLevel}

    @w2c(_SetTradeOffSelectedSchema, 'set_trade_off_selected')
    def setTradeOffVehicleCD(self, cmd):
        self._tradeIn.setActiveTradeOffVehicleCD(cmd.id)

    @w2c(_BuyItemsSchema, 'buy_items')
    def buyItems(self, cmd):
        responses = []
        items = self._itemsCache.items
        for spec in parseItemsSpec(cmd.items):
            if spec.type in (ShopItemType.DEVICE, ShopItemType.EQUIPMENT, ShopItemType.BATTLE_BOOSTER):
                item = items.getItemByCD(spec.id)
                currency = item.buyPrices.itemPrice.price.getCurrency()
                buyer = ModuleBuyer(item, spec.count, currency)
            elif spec.type == ShopItemType.BOOSTER:
                item = self._goodiesCache.getBooster(spec.id)
                currency = item.buyPrices.itemPrice.price.getCurrency()
                buyer = BoosterBuyer(item, spec.count, currency)
            elif spec.type == ShopItemType.VEHICLE:
                item = items.getItemByCD(spec.id)
                buyer = VehicleBuyer(item, buySlot=False, showNotEnoughSlotMsg=False)
            elif spec.type == ShopItemType.PREMIUM:
                daysCount = spec.count
                buyer = PremiumAccountBuyer(daysCount, price=items.shop.getPremiumCostWithDiscount()[daysCount], requireConfirm=False)
            else:
                raise SoftException(('Invalid item type: "{}".').format(spec.type))
            if buyer:
                response = yield buyer.request()
                responses.append(self.__makeResult(spec.type, spec.id, response))
            else:
                responses.append(None)

        results = []
        for response in responses:
            status = response['success']
            if status and status.userMsg:
                SystemMessages.pushI18nMessage(status.userMsg, type=status.sysMsgType)
                statusData = status.auxData
                if statusData is None or 'errStr' not in statusData or not statusData['errStr']:
                    result = 'success'
                else:
                    result = statusData['errStr']
                results.append(self.__makeResult(response['type'], response['id'], status.success, result))
            else:
                results.append(self.__makeResult(response['type'], response['id'], False))

        yield results
        return

    @staticmethod
    def __makeResult(itemType, itemId, success, result='error'):
        return {'type': itemType, 'id': itemId, 'success': success, 'result': result}