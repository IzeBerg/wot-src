import importlib
from DictPackers import Meta
from battle_results_common import BATTLE_RESULTS
from battle_results_constants import BATTLE_RESULT_ENTRY_TYPE as ENTRY_TYPE, PATH_TO_CONFIG, POSSIBLE_TYPES
g_config = {'checksums': {}, 'bonusTypes': {}, 'allResults': Meta()}

def __processBonusTypeResults(config, allResults, bonusType, serverResults):
    modeConfig = {}
    for name, transportType, default, packer, aggFunc, entryType in allResults:
        if transportType is None:
            pass
        value = (
         name, transportType, default, packer, aggFunc)
        if name in serverResults:
            pass
        else:
            serverResults[name] = value
        if entryType == ENTRY_TYPE.SERVER:
            continue
        modeConfig.setdefault(entryType, []).append(value)
        if entryType == ENTRY_TYPE.ACCOUNT_ALL:
            modeConfig.setdefault(ENTRY_TYPE.ACCOUNT_SELF, []).append(value)
        if entryType == ENTRY_TYPE.VEHICLE_ALL:
            modeConfig.setdefault(ENTRY_TYPE.VEHICLE_SELF, []).append(value)

    config['bonusTypes'][bonusType] = bonusTypeConfig = {}
    for entryType, resultsList in modeConfig.iteritems():
        meta = Meta(*resultsList)
        config['checksums'][meta.getChecksum()] = meta
        bonusTypeConfig[entryType] = meta

    return


def setBattleResultsConfig(config):
    serverResults = {}
    for bonusType, path in PATH_TO_CONFIG.iteritems():
        module = importlib.import_module('battle_results.' + path)
        allResults = BATTLE_RESULTS + module.BATTLE_RESULTS
        __processBonusTypeResults(config, allResults, bonusType, serverResults)

    __processBonusTypeResults(config, BATTLE_RESULTS, 'default', serverResults)
    config['allResults'] = Meta(*sorted(serverResults.values(), key=lambda x: x[0]))


def packClientBattleResults(data, bonusType, packingType):
    if bonusType not in g_config['bonusTypes']:
        bonusType = 'default'
    return g_config['bonusTypes'][bonusType][packingType].pack(data)


def unpackClientBattleResults(data):
    checksum = data[0]
    if checksum not in g_config['checksums']:
        return None
    else:
        return g_config['checksums'][checksum].unpack(data)


def getBattleResultsNames():
    return g_config['allResults'].names()


def init():
    setBattleResultsConfig(g_config)