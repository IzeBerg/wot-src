EARLY_ACCESS_PREFIX = 'early_access'
EARLY_ACCESS_PDATA_KEY = 'earlyAccess'
EARLY_ACCESS_POSTPR_KEY = 'postprogression'

def earlyAccessInitialData():
    return {'currentSeason': None}


def isEarlyAccessToken(tokenName):
    return tokenName.startswith(EARLY_ACCESS_PREFIX)


def makeEarlyAccessToken(seasonID):
    return (':').join((EARLY_ACCESS_PREFIX, ('season_{}').format(seasonID)))


def getGroupName(groupName):
    if groupName == EARLY_ACCESS_POSTPR_KEY:
        return ('_').join((EARLY_ACCESS_PREFIX, ('{}').format(groupName)))
    return ('_').join((EARLY_ACCESS_PREFIX, ('cycle_{}').format(groupName)))