import types, BigWorld, ResMgr, i18n, constants
from aih_constants import CTRL_MODE_NAME
from debug_utils import LOG_CURRENT_EXCEPTION
from soft_exception import SoftException
from abc import abstractmethod
VERSION_FILE_PATH = '../version.xml'
_CLIENT_VERSION = None

def gEffectsDisabled():
    return False


def isPlayerAccount():
    return hasattr(BigWorld.player(), 'databaseID')


def isPlayerAvatar():
    return hasattr(BigWorld.player(), 'arena')


def getLanguageCode():
    if i18n.doesTextExist('#settings:LANGUAGE_CODE'):
        return i18n.makeString('#settings:LANGUAGE_CODE')
    else:
        return


def getClientLanguage():
    lng = constants.DEFAULT_LANGUAGE
    try:
        lng = getLanguageCode()
        if lng is None:
            lng = constants.DEFAULT_LANGUAGE
    except Exception:
        LOG_CURRENT_EXCEPTION()

    return lng


def getClientOverride():
    if constants.IS_CHINA:
        return 'CN'
    else:
        if getClientLanguage() == 'ko':
            return 'KR'
        return


def getLocalizedData(dataDict, key, defVal=''):
    resVal = defVal
    if dataDict:
        lng = getClientLanguage()
        localesDict = dataDict.get(key, {})
        if localesDict:
            if lng in localesDict:
                resVal = localesDict[lng]
            elif constants.DEFAULT_LANGUAGE in localesDict:
                resVal = localesDict[constants.DEFAULT_LANGUAGE]
            else:
                resVal = localesDict.items()[0][1]
    return resVal


def int2roman(number):
    numerals = {1: 'I', 4: 'IV', 5: 'V', 9: 'IX', 10: 'X', 40: 'XL', 50: 'L', 
       90: 'XC', 100: 'C', 400: 'CD', 500: 'D', 900: 'CM', 
       1000: 'M'}
    result = ''
    for value, numeral in sorted(numerals.items(), reverse=True):
        while number >= value:
            result += numeral
            number -= value

    return result


def getClientVersion(force=True):
    global _CLIENT_VERSION
    if _CLIENT_VERSION is None or force:
        sec = ResMgr.openSection(VERSION_FILE_PATH)
        if sec is None:
            _CLIENT_VERSION = ''
        else:
            _CLIENT_VERSION = sec.readString('version')
    return _CLIENT_VERSION


def getShortClientVersion():
    sec = ResMgr.openSection(VERSION_FILE_PATH)
    if sec is None:
        return ''
    else:
        return sec.readString('version').split('#')[0]


def getFullClientVersion():
    sec = ResMgr.openSection(VERSION_FILE_PATH)
    if sec is None:
        return ''
    else:
        version = i18n.makeString(sec.readString('appname')) + ' ' + sec.readString('version')
        return version


def newFakeModel():
    return BigWorld.Model('')


_g_alphabetOrderExcept = {1105: 1077.5, 
   1025: 1045.5, 
   197: 196, 
   196: 197, 
   229: 228, 
   228: 229, 
   1030: 1048, 
   1110: 1080, 
   1028: 1045.5, 
   1108: 1077.5}

def _getSymOrderIdx(symbol):
    if not isinstance(symbol, types.UnicodeType):
        raise SoftException('')
    symIdx = ord(symbol)
    return _g_alphabetOrderExcept.get(symIdx, symIdx)


def strcmp(word1, word2):
    if not isinstance(word1, types.UnicodeType):
        raise SoftException('First argument should be unicode')
    if not isinstance(word2, types.UnicodeType):
        raise SoftException('Second argument should be unicode')
    for sym1, sym2 in zip(word1, word2):
        if sym1 != sym2:
            return int(round(_getSymOrderIdx(sym1) - _getSymOrderIdx(sym2)))

    return len(word1) - len(word2)


def setHangarVisibility(isVisible):
    BigWorld.worldDrawEnabled(isVisible)


def getHelperServicesConfig(manager):
    from helpers.statistics import StatisticsCollector
    from helpers.platform import getPublishPlatform
    from skeletons.helpers.statistics import IStatisticsCollector
    from skeletons.helpers.platform import IPublishPlatform
    collector = StatisticsCollector()
    collector.init()
    manager.addInstance(IStatisticsCollector, collector, finalizer='fini')
    platform = getPublishPlatform()
    platform.init()
    manager.addInstance(IPublishPlatform, platform, finalizer='fini')


def isShowingKillCam--- This code section failed: ---

 L. 234         0  LOAD_CONST               -1
                3  LOAD_CONST               ('DeathCamEvent',)
                6  IMPORT_NAME           0  'gui.shared.events'
                9  IMPORT_FROM           1  'DeathCamEvent'
               12  STORE_FAST            0  'DeathCamEvent'
               15  POP_TOP          

 L. 235        16  LOAD_GLOBAL           2  'BigWorld'
               19  LOAD_ATTR             3  'player'
               22  CALL_FUNCTION_0       0  None
               25  LOAD_ATTR             4  'inputHandler'
               28  STORE_FAST            1  'inputHandler'

 L. 238        31  LOAD_FAST             1  'inputHandler'
               34  POP_JUMP_IF_FALSE    74  'to 74'
               37  LOAD_FAST             1  'inputHandler'
               40  LOAD_ATTR             5  'ctrlModeName'
               43  LOAD_GLOBAL           6  'CTRL_MODE_NAME'
               46  LOAD_ATTR             7  'KILL_CAM'
               49  COMPARE_OP            2  ==
               52  JUMP_IF_FALSE_OR_POP    77  'to 77'
               55  LOAD_FAST             1  'inputHandler'
               58  LOAD_ATTR             8  'ctrl'
               61  LOAD_ATTR             9  'killCamState'
               64  LOAD_FAST             0  'DeathCamEvent'
               67  LOAD_ATTR            10  'SIMULATION_INCL_FADES'
               70  COMPARE_OP            6  in
               73  RETURN_END_IF    
             74_0  COME_FROM            52  '52'
             74_1  COME_FROM            34  '34'
               74  LOAD_GLOBAL          11  'False'
               77  RETURN_VALUE     
               -1  RETURN_LAST      

Parse error at or near `RETURN_END_IF' instruction at offset 73


class ReferralButtonHandler(object):

    @classmethod
    def invoke(cls, **kwargs):
        from gui.shared.event_dispatcher import showReferralProgramWindow
        from gui.Scaleform.daapi.view.lobby.referral_program.referral_program_helpers import getReferralProgramURL
        value = kwargs.get('value', None)
        url = value.get('action_url', None) if isinstance(value, dict) else None
        url = getReferralProgramURL() + url
        showReferralProgramWindow(url)
        return


class ClanQuestButtonHandler(object):

    @classmethod
    def invoke(cls, **kwargs):
        from gui.impl.lobby.clan_supply.clan_supply_helpers import showClanSupplyView
        showClanSupplyView(tabId=1)


class ClanSupplyQuestButtonHandler(object):

    @classmethod
    def invoke(cls, **kwargs):
        from gui.impl.lobby.clan_supply.clan_supply_helpers import showClanSupplyView
        from uilogging.clan_supply.constants import ClanSupplyLogKeys
        showClanSupplyView(tabId=1, parentScreenLog=ClanSupplyLogKeys.NOTIFICATION)


def unicodeToStr(data):
    if isinstance(data, unicode):
        return data.encode('utf-8')
    if isinstance(data, list):
        return [ unicodeToStr(el) for el in data ]
    if isinstance(data, dict):
        res = {}
        for k, v in data.iteritems():
            res[unicodeToStr(k)] = unicodeToStr(v)

        return res
    return data# Decompile failed :(