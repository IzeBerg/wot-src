import logging

def getLogger(loggerName):
    return logging.getLogger(('Collections:{}').format(loggerName))


def getCdnCacheLogger():
    return getLogger('CdnCache')


def getLocalCacheLogger():
    return getLogger('LocalCache')