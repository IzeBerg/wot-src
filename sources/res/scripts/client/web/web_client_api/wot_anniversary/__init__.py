import logging
from gui.server_events.events_helpers import EventInfoModel
from gui.wot_anniversary.wot_anniversary_helpers import WOT_ANNIVERSARY_QUEST_POINTS, WOT_ANNIVERSARY_FINAL_REWARD_QUEST_PREFIX, getQuestNeededTokensCount, WOT_ANNIVERSARY_BATTLE_QUEST_PREFIX, WOT_ANNIVERSARY_LOGIN_QUEST_PREFIX, getQuestDayNumber, showFactDialog
from helpers import dependency
from helpers import time_utils
from skeletons.gui.game_control import IWotAnniversaryController
from web.web_client_api import w2capi, w2c, W2CSchema, Field, WebCommandException
from web.web_client_api.quests import Quest, formatQuestConditions, formatQuestBonuses
from wot_anniversary_common import WotAnniversaryUrls
_logger = logging.getLogger(__name__)

def _arrayIndexValidator(index, _=None):
    if index < 0:
        raise WebCommandException(('Invalid array index "{}"').format(index))
    return True


class _OpenFactOverlaySchema(W2CSchema):
    factIndex = Field(required=True, type=int, validator=_arrayIndexValidator)


@w2capi(name='wot_anniversary', key='action')
class WotAnniversaryWebApi(object):
    __wotAnniversaryCtrl = dependency.descriptor(IWotAnniversaryController)

    @w2c(W2CSchema, 'get_settings')
    def getSettings(self, _):
        quests = self.__wotAnniversaryCtrl.getQuests()
        result = {'isSecretMessageActive': self.__wotAnniversaryCtrl.isSecretMessageActive(), 
           'infoPageUrl': self.__wotAnniversaryCtrl.getUrl(WotAnniversaryUrls.INFO_PAGE), 
           'shopEventPath': self.__wotAnniversaryCtrl.getUrl(WotAnniversaryUrls.SHOP_EVENT_PATH), 
           'facts': self.__wotAnniversaryCtrl.getInterestingFactsInDict(), 
           'eventStartTimestamp': self.__wotAnniversaryCtrl.getConfig().startTime, 
           'eventEndTimestamp': self.__wotAnniversaryCtrl.getConfig().activePhaseEndTime, 
           'eventCategoryEndTime': self.__wotAnniversaryCtrl.getConfig().eventCategoryEndTime, 
           'quests': {'login': {'questIdPrefix': WOT_ANNIVERSARY_LOGIN_QUEST_PREFIX}, 
                      'battle': {'questIdPrefix': WOT_ANNIVERSARY_BATTLE_QUEST_PREFIX}, 
                      'reward': {'questId': WOT_ANNIVERSARY_FINAL_REWARD_QUEST_PREFIX}}, 
           'rewards': {'token': WOT_ANNIVERSARY_QUEST_POINTS, 
                       'maxPoints': getQuestNeededTokensCount(quests.get(WOT_ANNIVERSARY_FINAL_REWARD_QUEST_PREFIX))}}
        return result

    @w2c(W2CSchema, 'get_time_data')
    def getTimeData(self, _):
        nextGameDay = time_utils.getCurrentLocalServerTimestamp() + EventInfoModel.getDailyProgressResetTimeDelta()
        return {'endTimeOfGameDay': int(nextGameDay)}

    @w2c(W2CSchema, 'get_quests')
    def getQuests(self, _):
        data = {}
        quests = self.__wotAnniversaryCtrl.getQuests()
        for qID, quest in quests.iteritems():
            data[qID] = self._questAsDict(quest)

        return data

    @w2c(_OpenFactOverlaySchema, 'open_fact_overlay')
    def openFactOverlay(self, cmd):
        facts = self.__wotAnniversaryCtrl.getInterestingFacts()
        if cmd.factIndex < len(facts):
            showFactDialog(facts[cmd.factIndex])
        else:
            _logger.warning('Unable to show fact with index %d', cmd.factIndex)

    @w2c(W2CSchema, 'claim_secret_message_reward')
    def claimSecretMessageReward(self, _):
        return {'isFirstWin': self.__wotAnniversaryCtrl.claimSecretReward()}

    def _questAsDict(self, quest):
        questAsDict = {'id': quest.getID(), 
           'description': quest.getDescription(), 
           'name': quest.getUserName(), 
           'conditions': formatQuestConditions(quest), 
           'bonuses': formatQuestBonuses(quest), 
           'is_completed': quest.isCompleted(), 
           'priority': quest.getPriority(), 
           'wasted': False, 
           'is_squad': quest.isSquad(), 
           'completed_at': self.__wotAnniversaryCtrl.getQuestCompletedAt(quest)}
        dayNumber = getQuestDayNumber(questAsDict['id'])
        questAsDict['starts_at_event_day'] = dayNumber or ''
        if questAsDict['id'].startswith(WOT_ANNIVERSARY_LOGIN_QUEST_PREFIX):
            if not questAsDict['is_completed'] and not self.__wotAnniversaryCtrl.getLoginDayUnlockToken(dayNumber):
                questAsDict['wasted'] = True
        return questAsDict