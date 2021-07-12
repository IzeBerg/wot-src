import sys, resource_helper
_PREBATTLE_TIPS_XML_PATH = 'gui/prebattle_tips.xml'
_PRECEDING_DEFAULT_SHOW_TIMES = 1
DEFAULT_STATUS = 'payAttention'
DEFAULT_GROUP = 'all'

def _readPreBattleTips():
    filters = dict()
    tips = dict()
    ctx, root = resource_helper.getRoot(_PREBATTLE_TIPS_XML_PATH)
    for _, filterSection in resource_helper.getIterator(ctx, root['filters']):
        filterId = filterSection.readString('id')
        filters[filterId] = {'minBattles': filterSection.readInt('minBattles', 0), 
           'maxBattles': filterSection.readInt('maxBattles', sys.maxint), 
           'arenaTypes': filterSection.readString('arenaTypes'), 
           'nations': filterSection.readString('nations'), 
           'levels': filterSection.readString('levels'), 
           'vehicleClass': filterSection.readString('vehicleClass'), 
           'tags': filterSection.readString('tags'), 
           'realms': filterSection.readString('realms'), 
           'preceding': _readPrecedingData(filterSection), 
           'battlePassActiveCheck': filterSection.readBool('battlePassActiveCheck', False), 
           'rankedYearRewardCheck': filterSection.readBool('rankedYearRewardCheck', False), 
           'rankedLBCheck': filterSection.readBool('rankedLBCheck', False), 
           'rankedShopCheck': filterSection.readBool('rankedShopCheck', False)}

    for _, tipsSection in resource_helper.getIterator(ctx, root['tips']):
        filterId = tipsSection.readString('filter')
        tipId = tipsSection.readString('id')
        status = tipsSection.readString('status', DEFAULT_STATUS)
        group = tipsSection.readString('group', DEFAULT_GROUP)
        tipConfig = filters.get(filterId)
        tips[tipId] = {'filter': tipConfig, 
           'status': status, 
           'group': group}

    resource_helper.purgeResource(_PREBATTLE_TIPS_XML_PATH)
    return tips


def _readPrecedingData(section):
    precedingData = None
    if section['preceding'] is not None:
        precedingData = {'showTimes': section['preceding'].readInt('showTimes', _PRECEDING_DEFAULT_SHOW_TIMES)}
    return precedingData


def getPreBattleTipsConfig():
    global _preBattleTipsConfig
    if _preBattleTipsConfig is None:
        _preBattleTipsConfig = _readPreBattleTips()
    return _preBattleTipsConfig


_preBattleTipsConfig = None