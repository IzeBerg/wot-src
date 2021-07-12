

class IDownloader(object):

    def close(self):
        raise NotImplementedError

    def download(self, url, callback):
        raise NotImplementedError