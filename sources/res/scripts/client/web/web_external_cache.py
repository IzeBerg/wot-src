

class IWebExternalCache(object):

    class IStorage(object):

        def get(self, url):
            raise NotImplementedError