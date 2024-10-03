

def getTankPortalActualPrice(tankPortalPrice, discountPerToken, discountTokenCount):
    totalDiscount = discountTokenCount * discountPerToken
    return tankPortalPrice - totalDiscount


def getTankPortalDiscount(tankPortalPrice, discountPerToken, discountTokenCount):
    discount = discountPerToken * discountTokenCount
    return 100.0 * discount / tankPortalPrice