from gui.platform.products_fetcher.fetch_result import FetchResult, ResponseStatus

class UserSubscriptionFetchResult(FetchResult):
    _CACHE_TTL = 600

    def stop(self):
        self._clearTimeoutBwCbId()
        self.status = ResponseStatus.UNDEFINED
        self.products = []