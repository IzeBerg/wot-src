from account_helpers.AccountSyncData import BaseSyncDataCache
from shared_utils.account_helpers.diff_utils import synchronizeDicts

class OffersSyncData(BaseSyncDataCache):

    def _synchronize(self, diff):
        itemDiff = diff.get('offersData')
        if itemDiff is not None:
            synchronizeDicts(itemDiff, self._cache.setdefault('offersData', {}))
        return