import logging
from collections import namedtuple, OrderedDict
from typing import Optional
from account_helpers.AccountSettings import AccountSettings, WOT_ANNIVERSARY_SECTION
from gui.impl import backport
from gui.impl.gen import R
from gui.shared import g_eventBus, events, EVENT_BUS_SCOPE
from helpers import dependency
from skeletons.account_helpers.settings_core import ISettingsCore
from skeletons.gui.shared import IItemsCache
_logger = logging.getLogger(__name__)
InterestingFacts = namedtuple('InterestingFacts', ('techName', 'smallSizeResourceId',
                                                   'mediumSizeResourceId', 'bigSizeResourceId',
                                                   'largeSizeResourceId', 'title',
                                                   'description'))
WOT_ANNIVERSARY_PREFIX = 'anniversary:'
WOT_ANNIVERSARY_LOGIN_QUEST_PREFIX = WOT_ANNIVERSARY_PREFIX + 'login:day:'
WOT_ANNIVERSARY_BATTLE_QUEST_PREFIX = WOT_ANNIVERSARY_PREFIX + 'battle:day:'
WOT_ANNIVERSARY_FINAL_REWARD_QUEST_PREFIX = WOT_ANNIVERSARY_PREFIX + 'final_reward'
WOT_ANNIVERSARY_SECRET_MESSAGE_TOKEN = WOT_ANNIVERSARY_PREFIX + 'secret_message_reward'
WOT_ANNIVERSARY_SECRET_MESSAGE_REWARD_QUEST_PREFIX = WOT_ANNIVERSARY_PREFIX + 'secretMessageReward'
WOT_ANNIVERSARY_QUEST_POINTS = WOT_ANNIVERSARY_PREFIX + 'points'
WOT_ANNIVERSARY_LOGIN_DAY_UNLOCK_TOKEN = WOT_ANNIVERSARY_LOGIN_QUEST_PREFIX + '{0}' + ':unlock'
WOT_ANNIVERSARY_ALL_DAYS_UNLOCK_TOKEN = WOT_ANNIVERSARY_LOGIN_QUEST_PREFIX + 'unlocks'
WOT_ANNIVERSARY_VEHICLE_PREVIEW = 'anniversary_vehicle_preview'
WOT_ANNIVERSARY_COMPLETED_PREFIX = ':completed'
LOCAL_TO_API_NAMES = {'smallSizeResourceId': 'smallSizeUrl', 
   'mediumSizeResourceId': 'mediumSizeUrl', 
   'bigSizeResourceId': 'bigSizeUrl', 
   'largeSizeResourceId': 'largeSizeUrl'}
FACTS_FILENAMES = OrderedDict([
 ('birthday_2022', 'd17abb9a'),
 ('white_tiger', 'c3d0eef5'),
 ('halloween', 'a6539c35'),
 ('comp7', 'edc48b51'),
 ('frontline', 'd27884d0'),
 ('fep', 'e719adc6'),
 ('ny_2023', 'ac78c417'),
 ('lunar_ny', 'b487594c'),
 ('steel_hunter', 'b259336b'),
 ('cosmic', 'a1c27892'),
 ('battle_pass', 'b9384736')])

class WotAnniversaryEventState(object):
    STARTED = 0
    PAUSE = 1
    ENABLED = 2
    FINISHED = 3


def showWotAnniversaryLoginAwardWindow(questID, rawAwards, useQueue=False):
    from gui.shared.event_dispatcher import findAndLoadWindow
    from gui.wot_anniversary.interesting_fact_and_bonus_view import InterestingFactAndBonusViewWindow
    findAndLoadWindow(useQueue, InterestingFactAndBonusViewWindow, questID, rawAwards)


def showWotAnniversaryAwardWindow(rawAwards, useQueue=False):
    from gui.shared.event_dispatcher import findAndLoadWindow
    from gui.wot_anniversary.wot_anniversary_award_view import WotAnniversaryAwardWindow
    findAndLoadWindow(useQueue, WotAnniversaryAwardWindow, rawAwards)


def showWotAnniversaryIntroWindow(closeCallback=None):
    from gui.wot_anniversary.wot_anniversary_intro_view import WotAnniversaryIntroWindow
    if not WotAnniversaryIntroWindow.getInstances():
        window = WotAnniversaryIntroWindow(closeCallback=closeCallback)
        window.load()


def showWotAnniversaryWelcomeWindow(useQueue=False):
    from gui.shared.event_dispatcher import findAndLoadWindow
    from gui.wot_anniversary.wot_anniversary_welcome_view import WotAnniversaryWelcomeWindow
    findAndLoadWindow(useQueue, WotAnniversaryWelcomeWindow)


def getWotAnniversarySectionSetting(settingName):
    settings = AccountSettings.getSettings(WOT_ANNIVERSARY_SECTION)
    return settings.get(settingName)


def setWotAnniversarySectionSetting(settingName, settingValue):
    settings = AccountSettings.getSettings(WOT_ANNIVERSARY_SECTION)
    settings.update({settingName: settingValue})
    AccountSettings.setSettings(WOT_ANNIVERSARY_SECTION, settings)


@dependency.replace_none_kwargs(settings=ISettingsCore)
def setAnniversaryServerSetting(settingsSection, settings=None):
    from account_helpers.settings_core.ServerSettingsManager import SETTINGS_SECTIONS
    settings.serverSettings.setSections([SETTINGS_SECTIONS.WOT_ANNIVERSARY_STORAGE], settingsSection)


@dependency.replace_none_kwargs(settings=ISettingsCore)
def isAnniversaryNotificationShowed(notification, settings=None):
    from account_helpers.settings_core.ServerSettingsManager import SETTINGS_SECTIONS
    return settings.serverSettings.getSection(SETTINGS_SECTIONS.WOT_ANNIVERSARY_STORAGE).get(notification)


@dependency.replace_none_kwargs(settings=ISettingsCore)
def isAnniversaryIntroShowed(settings=None):
    from account_helpers.settings_core.ServerSettingsManager import SETTINGS_SECTIONS
    from account_helpers.settings_core.settings_constants import WotAnniversaryStorageKeys
    return settings.serverSettings.getSection(SETTINGS_SECTIONS.WOT_ANNIVERSARY_STORAGE).get(WotAnniversaryStorageKeys.WOT_ANNIVERSARY_INTRO_SHOWED)


def showMainView():
    from gui.server_events.events_dispatcher import showWotAnniversaryMissions
    showWotAnniversaryMissions()


def fireMainViewOpened():
    g_eventBus.handleEvent(events.WotAnniversaryEvent(events.WotAnniversaryEvent.ON_MAIN_VIEW_OPENED), scope=EVENT_BUS_SCOPE.LOBBY)


def fireMainViewClosed():
    g_eventBus.handleEvent(events.WotAnniversaryEvent(events.WotAnniversaryEvent.ON_MAIN_VIEW_CLOSED), scope=EVENT_BUS_SCOPE.LOBBY)


def isWotAnniversaryQuest(questID):
    return questID.startswith(WOT_ANNIVERSARY_PREFIX)


def isWotAnniversaryBattleQuest(questID):
    return questID.startswith(WOT_ANNIVERSARY_BATTLE_QUEST_PREFIX)


def isWotAnniversaryLoginQuest(questID):
    return questID.startswith(WOT_ANNIVERSARY_LOGIN_QUEST_PREFIX) and questID != WOT_ANNIVERSARY_ALL_DAYS_UNLOCK_TOKEN


def isFinalTokenQuest(questID):
    return questID.startswith(WOT_ANNIVERSARY_FINAL_REWARD_QUEST_PREFIX)


def isSecretMessageReward(questID):
    return questID.startswith(WOT_ANNIVERSARY_SECRET_MESSAGE_REWARD_QUEST_PREFIX)


def getQuestDayNumber(questID):
    dayNumber = None
    if questID.startswith(WOT_ANNIVERSARY_LOGIN_QUEST_PREFIX):
        dayNumber = questID.split(':')[(-1)]
    elif questID.startswith(WOT_ANNIVERSARY_BATTLE_QUEST_PREFIX):
        dayNumber = questID.split(':')[(-2)]
    if dayNumber and dayNumber.isdigit():
        return int(dayNumber)
    else:
        return


def getQuestNeededTokensCount(quest):
    if quest is not None:
        tokens = quest.accountReqs.getTokens()
        if tokens:
            return tokens[(-1)].getNeededCount()
    return 0


def filterNotCompletedBattleQuests(quests):
    return [ quest for quest in quests.values() if quest.getID().startswith(WOT_ANNIVERSARY_BATTLE_QUEST_PREFIX) and not quest.isCompleted()
           ]


def findLatestQuest(quests):
    return max(quests, key=lambda quest: quest.getStartTimeRaw())


@dependency.replace_none_kwargs(itemsCache=IItemsCache)
def getQuestRewardVehicle(quest, itemsCache=None):
    if quest is not None:
        for vehBonus in quest.getBonuses('vehicles'):
            vehicles = vehBonus.getValue()
            for intCD in vehicles.iterkeys():
                return itemsCache.items.getItemByCD(intCD)

    return


def getFactTitleByTechName(techName):
    if not techName:
        return ''
    return backport.text(R.strings.wot_anniversary.interestingFact.title.dyn(techName)())


def getFactDescriptionByTechName(techName):
    if not techName:
        return ''
    return backport.text(R.strings.wot_anniversary.interestingFact.description.dyn(techName)())


def getFactGfImagePath(imagePath):
    return backport.image(imagePath)


def getFactIGBImagePath(imagePath):
    return backport.image(imagePath).replace('img://', 'wotdata://')


def showFactDialog(fact):
    from gui.impl.dialogs import dialogs
    from gui.impl.dialogs.wot_anniversary.gf_builders import WotAnniversaryDialogBuilder
    techName = fact.techName
    largeSizeResourceId = fact.largeSizeResourceId
    if largeSizeResourceId and techName:
        builder = WotAnniversaryDialogBuilder()
        builder.setTitle(getFactTitleByTechName(techName))
        builder.setDescription(getFactDescriptionByTechName(techName))
        builder.setImage(getFactGfImagePath(largeSizeResourceId))
        dialogs.show(builder.build())
    else:
        _logger.error('largeSizeResourceId or techName are missing for fact %s', fact)