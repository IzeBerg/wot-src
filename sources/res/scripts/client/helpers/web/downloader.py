

class IDownloader(object):

    @property
    def stopped(self):
        raise NotImplementedError

    def close(self):
        raise NotImplementedError

    def downloadLowPriority(self, url, callback):
        raise NotImplementedError

    def download(self, url, callback):
        raise NotImplementedError