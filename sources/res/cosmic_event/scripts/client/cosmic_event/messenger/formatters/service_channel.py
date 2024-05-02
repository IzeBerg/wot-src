import logging
from typing import TYPE_CHECKING
from cosmic_constants import EVENT_STATES, PROGRESSION_STAGES_IN_PHASE
from cosmic_event.cosmic_constants import PROGRESSION_TOKEN
from cosmic_event.skeletons.battle_controller import ICosmicEventBattleController
from cosmic_event.skeletons.progression_controller import ICosmicEventProgressionController
from cosmic_event_common.cosmic_event_common import checkIfViolator
from gui.impl import backport
from helpers import int2roman, dependency
from messenger import g_settings
from messenger.formatters.service_channel import BattleResultsFormatter, ServiceChannelFormatter, QuestAchievesFormatter
from messenger.formatters.service_channel_helpers import MessageData, getRewardsForQuests
from messenger.formatters.token_quest_subformatters import SyncTokenQuestsSubFormatter
from cosmic_event.gui.game_control.progression_controller import QUEST_STEP_REGEX
_logger = logging.getLogger(__name__)
if TYPE_CHECKING:
    from typing import Dict, Any, List

class CosmicBattleResultsFormatter(BattleResultsFormatter):

    def _prepareFormatData(self, message):
        _, ctx = super(CosmicBattleResultsFormatter, self)._prepareFormatData(message)
        ctx['totalScore'] = self.__makeTotalScoreString(message)
        return ('cosmicBattleResult', ctx)

    @staticmethod
    def __makeTotalScoreString(message):
        value = (checkIfViolator(message.data) or message.data.get)('cosmicTotalScore', 0) if 1 else 0
        return backport.getIntegralFormat(value)


def formatCosmicQuestBonuses(rewards):
    results = []
    progressionTokens = rewards.get('tokens', {}).get(PROGRESSION_TOKEN, {}).get('count', 0)
    if progressionTokens:
        results.append(g_settings.htmlTemplates.format('cosmicEventProgressionToken', ctx={'progressionTokens': backport.getIntegralFormat(progressionTokens)}))
    formattedResults = QuestAchievesFormatter.formatQuestAchieves(rewards, asBattleFormatter=False)
    if formattedResults:
        results.append(formattedResults)
    return ('<br/>').join(results)


class CosmicDailyMessageFormatter(ServiceChannelFormatter):
    __TEMPLATE = 'CosmicDailyMessage'
    _cosmicProgression = dependency.descriptor(ICosmicEventProgressionController)

    def format(self, message, *args):
        rewards = message.get('rewards', {})
        formatted = g_settings.msgTemplates.format(self.__TEMPLATE, ctx={'rewards': formatCosmicQuestBonuses(rewards)})
        return [
         MessageData(formatted, self._getGuiSettings(message, self.__TEMPLATE))]


class CosmicCompletionMessageFormatter(ServiceChannelFormatter):
    __TEMPLATES = [
     'ArtifactResearchedMessage', 'CosmicCompletionMessage']

    def format(self, message, *args):
        messages = []
        for template in self.__TEMPLATES:
            formatted = g_settings.msgTemplates.format(template)
            messages.append(MessageData(formatted, self._getGuiSettings(message, template)))

        return messages


class CosmicProgressionMessageFormatter(SyncTokenQuestsSubFormatter):
    __STAGE_TEMPLATE = 'CosmicProgressionStageMessage'
    __PHASE_TEMPLATE = 'CosmicProgressionPhaseMessage'
    __FINISHED_TEMPLATE = 'ArtifactReadyForResearchMessage'
    _cosmicProgression = dependency.descriptor(ICosmicEventProgressionController)

    def format(self, message, *args):
        messages = []
        rewards = getRewardsForQuests(message, self._cosmicProgression.getQuests().keys())
        step = max(int(qId.split('step_')[1]) for qId in self.getQuestOfThisGroup(message.data['completedQuestIDs']))
        isStage = bool(step % PROGRESSION_STAGES_IN_PHASE)
        if step == self._cosmicProgression.getMaxStage():
            formatted = g_settings.msgTemplates.format(self.__FINISHED_TEMPLATE)
            messages.append(MessageData(formatted, self._getGuiSettings(message.data, self.__FINISHED_TEMPLATE)))
        template, step = (self.__STAGE_TEMPLATE, step) if isStage else (
         self.__PHASE_TEMPLATE, step // PROGRESSION_STAGES_IN_PHASE)
        formatted = g_settings.msgTemplates.format(template, ctx={'step': int2roman(step), 
           'rewards': self._achievesFormatter.formatQuestAchieves(rewards, asBattleFormatter=False, processCustomizations=True)})
        messages.append(MessageData(formatted, self._getGuiSettings(message.data, template)))
        return messages

    @classmethod
    def _isQuestOfThisGroup(cls, questID):
        return cls._cosmicProgression.isCosmicProgressionQuest(questID) and bool(QUEST_STEP_REGEX.match(questID))


class CosmicVehicleRentMessageFormatter(SyncTokenQuestsSubFormatter):

    def format(self, message, *args):
        return

    @classmethod
    def _isQuestOfThisGroup(cls, questID):
        return dependency.instance(ICosmicEventBattleController).isVehicleRentQuest(questID)


class CosmicEventStateMessageFormatter(ServiceChannelFormatter):
    __TEMPLATES = {EVENT_STATES.START: 'CosmicEventStartedMessage', 
       EVENT_STATES.FINISH: 'CosmicEventEndedMessage', 
       EVENT_STATES.SUSPEND: 'CosmicEventSuspendedMessage', 
       EVENT_STATES.RESUME: 'CosmicEventResumedMessage'}

    def format(self, message, *args):
        state = message.get('state', None)
        if state is None:
            _logger.error('[CosmicEventStateMessageFormatter] message.state is missing')
            return []
        else:
            template = self.__TEMPLATES.get(state, None)
            if template is None:
                _logger.error('[CosmicEventStateMessageFormatter] Missing template for state %s', state)
                return []
            formatted = g_settings.msgTemplates.format(template)
            return [MessageData(formatted, self._getGuiSettings(message, template))]