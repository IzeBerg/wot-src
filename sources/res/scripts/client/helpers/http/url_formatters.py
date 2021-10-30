import typing, urllib, urlparse

class URL_PARTS_IDS(object):
    SCHEME = 0
    NETLOC = 1
    PATH = 2
    PARAMS = 3
    QUERY = 4
    FRAGMENT = 5


def addParamsToUrlQuery(url, params, keepBlankValues=False):
    urlParts = list(urlparse.urlparse(url))
    query = urlparse.parse_qs(urlParts[URL_PARTS_IDS.QUERY], keep_blank_values=keepBlankValues)
    query.update(params)
    urlParts[URL_PARTS_IDS.QUERY] = urllib.urlencode(query, True)
    return urlparse.urlunparse(urlParts)


def separateQuery(url):
    urlParts = list(urlparse.urlparse(url))
    mainUrlParts = urlParts[:URL_PARTS_IDS.QUERY] + ['', '']
    queryParts = [''] * 4 + urlParts[URL_PARTS_IDS.QUERY:]
    return (urlparse.urlunparse(mainUrlParts), urlparse.urlunparse(queryParts))