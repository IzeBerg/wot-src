from typing import List, Dict, Optional, Callable, Union
from ny_common.settings import MarketplaceConsts
from items.new_year import g_cache
from items.components.ny_constants import YEARS_INFO
from math import ceil

class MarketplaceConfig(object):
    __slots__ = ('_config', )

    def __init__(self, config):
        self._config = config

    def getCategoryByID(self, categoryID):
        if 0 <= categoryID < len(self._config):
            return self._config[categoryID]
        else:
            return

    def getCategoryByName(self, categoryName):
        for categoryData in self._config:
            if categoryData.get(MarketplaceConsts.CATEGORY_NAME, None) == categoryName:
                return categoryData

        return

    def getCategory(self, categoryID):
        if isinstance(categoryID, int):
            return self.getCategoryByID(categoryID)
        else:
            if isinstance(categoryID, str):
                return self.getCategoryByName(categoryID)
            return

    def getCategoryItems(self, categoryID):
        categoryData = self.getCategory(categoryID)
        if categoryData is None:
            return
        else:
            return map(CategoryItem, categoryData[MarketplaceConsts.CATEGORY_ITEMS])

    def getCategoryItem(self, categoryID, index):
        categoryData = self.getCategory(categoryID)
        if categoryData is None:
            return
        else:
            itemsData = categoryData[MarketplaceConsts.CATEGORY_ITEMS]
            if 0 <= index < len(itemsData):
                return CategoryItem(itemsData[index])
            return


class CategoryItem(object):
    __slots__ = ('_itemData', )

    def __init__(self, itemData):
        self._itemData = itemData

    def getID(self):
        return self._itemData.get(MarketplaceConsts.ITEM_ID, None)

    def getPrice(self):
        return self._itemData.get(MarketplaceConsts.ITEM_PRICE, 0)

    def getActions(self):
        return self._itemData.get(MarketplaceConsts.ITEM_ACTIONS, None)

    @staticmethod
    def calculateDiscountForFillCollection(actionData, collectionDistributions):
        collectionStrID = YEARS_INFO.getCollectionSettingID(actionData[MarketplaceConsts.FILL_COLLECTION_SETTING], actionData[MarketplaceConsts.FILL_COLLECTION_YEAR])
        collectionIntID = g_cache.collections[collectionStrID]
        return sum(collectionDistributions[collectionIntID]) * 100 / g_cache.toyCountByCollectionID[collectionIntID]

    @staticmethod
    def calculateDiscountForBuyReward(actionData, inventoryChecker):
        discount = 0
        for discountValue, rewardsData in actionData:
            if inventoryChecker(rewardsData):
                discount += discountValue

        return discount

    def calculateDiscount(self, collectionDistributions, inventoryChecker):
        discount = 0
        actionsData = self.getActions()
        if actionsData is None:
            return discount
        else:
            for actionName, actionData in actionsData.iteritems():
                if actionName == MarketplaceConsts.FILL_COLLECTION:
                    discount += self.calculateDiscountForFillCollection(actionData, collectionDistributions)
                elif actionName == MarketplaceConsts.BUY_REWARDS:
                    discount += self.calculateDiscountForBuyReward(actionData, inventoryChecker)

            return discount

    def getTotalPrice(self, collectionDistributions, inventoryChecker, discount=None):
        if discount is None:
            discount = self.calculateDiscount(collectionDistributions, inventoryChecker)
        defaultPrice = self.getPrice()
        return max(0, defaultPrice - int(ceil(defaultPrice * discount / 100.0)))