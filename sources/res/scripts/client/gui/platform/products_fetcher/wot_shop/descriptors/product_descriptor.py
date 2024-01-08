from gui.platform.products_fetcher.product_descriptor import ProductDescriptor as BaseDescriptor

class ProductDescriptor(BaseDescriptor):

    @property
    def productID(self):
        return self._getFromParams('id', '')

    @property
    def productCode(self):
        return self._getFromParams('code', '')

    @property
    def categories(self):
        return self._getFromParams('categories', [])

    @property
    def category(self):
        return self.categories[0]

    @property
    def purchasable(self):
        return self._getFromParams('purchasable', False)

    @property
    def price(self):
        return self._getFromParams('price', {})

    @property
    def currencyName(self):
        return self.price.get('currency')

    @property
    def originalPrice(self):
        return self.price.get('value')

    @property
    def promotion(self):
        return self._getFromParams('promotion', {})

    @property
    def discountPrice(self):
        if self.promotion:
            return self.promotion.get('discounted_cost', 0)
        return 0

    @property
    def entitlements(self):
        return self._getFromParams('entitlements', [])

    @property
    def description(self):
        return self._getFromParams('description', '')