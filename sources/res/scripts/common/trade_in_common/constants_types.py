from collections import namedtuple
CONFIG_NAME = 'trade_in_config'
ConversionRule = namedtuple('ConversionRule', [
 'freeExchange', 'sellPriceFactor', 'accessToken', 'checkVehicleAscendingLevels',
 'visibleToEveryone', 'allowToBuyNotInShopVehicles'])
TradeInInfo = namedtuple('TradeInInfo', ['sellGroupId', 'buyGroupId', 'conversionRule'])