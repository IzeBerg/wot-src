from gui.platform.products_fetcher.product_descriptor import ProductDescriptor

class CategoriesDescriptor(ProductDescriptor):

    @property
    def code(self):
        return self._getFromParams('code', '')

    @property
    def metadata(self):
        return self._getFromParams('metadata', {})