from gui.Scaleform.daapi.view.lobby.storage.category_view import BaseCategoryView

class StorageCategoryOffersViewMeta(BaseCategoryView):

    def navigateToStore(self):
        self._printOverrideError('navigateToStore')

    def openOfferWindow(self, offerID):
        self._printOverrideError('openOfferWindow')