import season_common

def getShieldsConfig(rankedConfig, now):
    result = {}
    res, seasonInfo = season_common.getSeason(rankedConfig, now)
    if not res:
        return result
    _, _, seasonID, cycleID = seasonInfo
    season = rankedConfig['seasons'].get(seasonID)
    if season:
        cycle = season['cycles'].get(cycleID, {})
        result.update(cycle.get('shields', rankedConfig['shields']))
    return result


class SwitchState(object):
    ENABLED = 'enabled'
    DISABLED = 'disabled'
    HIDDEN = 'hidden'
    ALL = ('enabled', 'disabled', 'hidden')