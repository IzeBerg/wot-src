from adisp import adisp_async, adisp_process
from helpers import time_utils
from messenger import g_settings
from messenger.formatters import TimeFormatter
from messenger.formatters.service_channel_helpers import MessageData
from messenger.formatters.token_quest_subformatters import AsyncTokenQuestsSubFormatter

class HalloweenStarterBundleFormatter(AsyncTokenQuestsSubFormatter):
    __QUEST_PREFIX = 'hw23_rent_vehicles'

    @adisp_async
    @adisp_process
    def format(self, message, callback):
        yield self._waitForSyncItems()
        callback([MessageData(None, None)])
        return

    @classmethod
    def _isQuestOfThisGroup(cls, questID):
        return questID.startswith(cls.__QUEST_PREFIX)


class HalloweenBattlePassPointsFormatter(AsyncTokenQuestsSubFormatter):
    __MESSAGE_TEMPLATE = 'hwBattlePassPointsMessage'
    __BATTLE_PASS_TOKEN_QUEST_PATTERN = 'battlepass_points'

    @classmethod
    def _isQuestOfThisGroup(cls, questID):
        return cls.__BATTLE_PASS_TOKEN_QUEST_PATTERN in questID

    @adisp_async
    @adisp_process
    def format(self, message, callback):
        isSynced = yield self._waitForSyncItems()
        messageDataList = []
        if isSynced:
            data = message.data or {}
            completedQuestIDs = self.getQuestOfThisGroup(data.get('completedQuestIDs', set()))
            for qID in completedQuestIDs:
                messageData = self.__buildMessage(qID, message)
                if messageData:
                    messageDataList.extend(messageData)

        if messageDataList:
            callback(messageDataList)
        callback([MessageData(None, None)])
        return

    def __buildMessage(self, questID, message):
        result = []
        data = message.data or {}
        battlePassPoints = sum(data.get('battlePassPoints', {}).get('vehicles', {}).itervalues())
        if not battlePassPoints:
            return
        operationTime = message.sentTime
        if operationTime:
            fDatetime = TimeFormatter.getLongDatetimeFormat(time_utils.makeLocalServerTime(operationTime))
        else:
            fDatetime = 'N/A'
        formatted = g_settings.msgTemplates.format(self.__MESSAGE_TEMPLATE, ctx={'at': fDatetime, 'bpPoints': battlePassPoints})
        settings = self._getGuiSettings(message, self.__MESSAGE_TEMPLATE)
        result.append(MessageData(formatted, settings))
        return result