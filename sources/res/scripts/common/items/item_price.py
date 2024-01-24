from goodies.GoodieResources import Gold, Credits
DEFAULT_ZERO_BERTH = 0

class PRICE_TYPE:
    DEFAULT = (0, )
    PROMO = (1, )
    PERSONAL = (2, )


def getItemPrice(item, gameParams, goodies=None, goodieTarget=None):
    priceType = PRICE_TYPE.DEFAULT
    actualPrice = gameParams['items']['itemPrices'][item]
    defaultPrice = gameParams['defaults'].get('items', {}).get('itemPrices', {}).get(item, None)
    if not defaultPrice:
        defaultPrice = actualPrice
    else:
        priceType = PRICE_TYPE.PROMO
    if (actualPrice[0] == 0 or actualPrice[1] == 0) and goodies and goodieTarget:
        personalDiscounts = goodies.test(goodieTarget, {Credits(defaultPrice[0]), Gold(defaultPrice[1])})
        for _, discount in personalDiscounts.iteritems():
            if isinstance(discount, Gold) and discount.value <= actualPrice[1]:
                actualPrice = (
                 0, discount.value)
                priceType = PRICE_TYPE.PERSONAL
            elif isinstance(discount, Credits) and discount.value <= actualPrice[0]:
                actualPrice = (
                 discount.value, 0)
                priceType = PRICE_TYPE.PERSONAL

    return (
     defaultPrice, actualPrice, priceType)


def getNextSlotPrice(slots, slotsPrices):
    addSlotNumber = slots - slotsPrices[0]
    if addSlotNumber < 0:
        if len(slotsPrices[1]):
            return (slotsPrices[1][0][0], 0)
        return ('credits', 0)
    if addSlotNumber < len(slotsPrices[1]):
        return slotsPrices[1][addSlotNumber]
    return slotsPrices[1][(-1)]


def getBerthPackCount(berthsInPack, selectedCount):
    return selectedCount / berthsInPack


def getNextBerthPackPrice(currentBerthsCount, berthsPrices, selectedCount=None):
    initialBerths, berthsInPack, packsCost = berthsPrices
    packCost = packsCost[(-1)]
    selectedCount = selectedCount if selectedCount is not None else berthsInPack
    countPacks = getBerthPackCount(berthsInPack, selectedCount)
    countFreePacks = max((initialBerths - currentBerthsCount) / berthsInPack, DEFAULT_ZERO_BERTH)
    return max((countPacks - countFreePacks) * packCost, DEFAULT_ZERO_BERTH)