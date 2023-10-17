import itertools, operator
from collections import namedtuple
from adisp import adisp_async
import Event
from gui.ClientUpdateManager import g_clientUpdateManager
from gui import SystemMessages
from gui.shared.utils import decorators
from constants import EVENT_CLIENT_DATA
from gui.server_events.bonuses import getNonQuestBonuses, VehiclesBonus, TokensBonus, mergeBonuses, CustomizationsBonus
from gui.shared.gui_items.Vehicle import Vehicle
from gui.shared.gui_items import GUI_ITEM_TYPE
from halloween.gui.shared.gui_items.processors.processors import OpenArtefactProcessor
from halloween.skeletons.halloween_controller import IHalloweenController
from halloween.skeletons.halloween_artefacts_controller import IHalloweenArtefactsController
from halloween_common.halloween_constants import ArtefactsSettings, ArtefactType, RENT_VEHICLE_PREFIX
from helpers import dependency
from skeletons.account_helpers.settings_core import ISettingsCore
from skeletons.gui.customization import ICustomizationService
from skeletons.gui.server_events import IEventsCache
from skeletons.gui.shared import IItemsCache
QuestConditions = namedtuple('QuestConditions', ('name', 'description', 'totalValue',
                                                 'progress'))
QuestConditions.__new__.__defaults__ = ('', '', 0, 0)
ArtefactPrice = namedtuple('ArtefactPrice', ('currency', 'amount'))
ArtefactPrice.__new__.__defaults__ = (None, 0)
QUEST_BONUS_CONDITIONS = ('cumulative', 'cumulativeExt', 'cumulativeSum', 'vehicleKillsCumulative',
                          'vehicleDamageCumulative', 'vehicleStunCumulative', 'battles')
PHASE_COMPLETION_QUEST_BR_CONDITION = ('halloween_phase', 'greater')
TOTAL_PHASE_COUNT = 4
QUEST_BONUS_ORDERS = [
 'battleToken', 'dossier_achievement', 'dossier_badge', 'vehicles', 'slots',
 'hw23_bonus_crew_100', 'customizations', 'crewBooks', 'battlePassPoints', 'premium_plus',
 'hw23_artefact_key', 'crystal', 'gold', 'credits', 'goodies', 'dossier']
HIDDEN_STYLES = [807]

class Artefact(namedtuple('Artefact', ('artefactID', 'decodePrice', 'skipPrice', 'bonusRewards', 'questConditions',
                        'artefactTypes', 'difficulty'))):

    def getCtx(self):
        return dict(self._asdict())


def compareBonuses(bonusName1, bonusName2):
    if bonusName1 in QUEST_BONUS_ORDERS and bonusName2 in QUEST_BONUS_ORDERS:
        return cmp(QUEST_BONUS_ORDERS.index(bonusName1), QUEST_BONUS_ORDERS.index(bonusName2))
    return 0


def isArtefactQuest(qID):
    return qID.startswith(ArtefactsSettings.QUEST_PREFIX)


class HalloweenArtefactsController(IHalloweenArtefactsController):
    itemsCache = dependency.descriptor(IItemsCache)
    eventsCache = dependency.descriptor(IEventsCache)
    settingsCore = dependency.descriptor(ISettingsCore)
    halloweenCtrl = dependency.descriptor(IHalloweenController)
    c11n = dependency.descriptor(ICustomizationService)

    def __init__(self):
        super(HalloweenArtefactsController, self).__init__()
        self.onArtefactStatusUpdated = Event.Event()
        self.onArtefactKeyUpdated = Event.Event()
        self.onArtefactSettingsUpdated = Event.Event()
        self._artefacts = {}
        self._artefactPhaseCompletionBind = {}

    def fini(self):
        g_clientUpdateManager.removeObjectCallbacks(self)
        self.halloweenCtrl.onSettingsUpdate -= self.__updateSettings
        self.onArtefactStatusUpdated.clear()
        self.onArtefactKeyUpdated.clear()
        self.onArtefactSettingsUpdated.clear()
        self._artefacts = {}

    def isEnabled(self):
        return self._getConfig().get('enabled', False)

    def onLobbyInited(self, event):
        g_clientUpdateManager.addCallbacks({'tokens': self.__handleTokensUpdate, 
           'eventsData.' + str(EVENT_CLIENT_DATA.QUEST): self.__onQuestsUpdated})
        self.halloweenCtrl.onSettingsUpdate += self.__updateSettings
        self._initArtefacts()

    def artefactsSorted(self):
        return sorted(self._artefacts.itervalues(), key=lambda artefact: self.getIndex(artefact.artefactID))

    def regularArtefacts(self):
        return self.artefactsSorted()[:-1]

    def getFinalArtefact(self):
        return next((x for x in self._artefacts.itervalues() if ArtefactType.FINAL in x.artefactTypes), None)

    def geArtefactIDFromOpenToken(self, token):
        return token.replace(self._getConfig().get('openedSuffix', ''), '')

    def isFinalArtefact(self, artefect):
        return ArtefactType.FINAL in artefect.artefactTypes

    def getArtefact(self, artefactID):
        return self._artefacts.get(artefactID)

    def isArtefactOpened(self, artefactID):
        openedTokenID = artefactID + self._getConfig().get('openedSuffix', '')
        return self.eventsCache.questsProgress.getTokenCount(openedTokenID) > 0

    def isArtefactReceived(self, artefactID):
        return self.eventsCache.questsProgress.getTokenCount(artefactID) > 0

    def getArtefactKeyQuantity(self):
        return self.eventsCache.questsProgress.getTokenCount(ArtefactsSettings.KEY_TOKEN)

    def getCurrentArtefactProgress(self):
        return sum(list(int(self.isArtefactOpened(artefactID)) for artefactID in self._artefacts))

    def getAvailableArtefactProgress(self):
        return sum(list(int(self.isArtefactReceived(artefactID)) for artefactID in self._artefacts))

    def getMaxArtefactsProgress(self):
        return len(self._artefacts) - 1

    def getMainGiftVehicle(self):
        finalArtefact = self.getFinalArtefact()
        if not finalArtefact:
            return
        else:
            for bonus in finalArtefact.bonusRewards:
                if not isinstance(bonus, VehiclesBonus):
                    continue
                vehiclesBonuses = bonus.getVehicles()
                mainVehicleBonus = vehiclesBonuses[0] if vehiclesBonuses else []
                return next((b for b in mainVehicleBonus if isinstance(b, Vehicle)), None)

            return

    def getIsHiddenBonusStyle(self, bonus):
        if bonus.bonusName == 'customizations':
            args = bonus.specialArgs
            if args:
                style = self.c11n.getItemByCD(args.itemCD)
                if style.id in HIDDEN_STYLES:
                    return True
        return False

    def getMainGiftStyle(self):
        finalArtefact = self.getFinalArtefact()
        if not finalArtefact:
            return
        else:
            for bonus in finalArtefact.bonusRewards:
                if not isinstance(bonus, CustomizationsBonus):
                    continue
                bonuses = bonus.getList()
                for item in bonuses:
                    customization = self.itemsCache.items.getItemByCD(item.get('intCD', 0))
                    if customization and customization.itemTypeID == GUI_ITEM_TYPE.STYLE:
                        return customization

            return

    def getArtefactIDForAccessToVehicle(self, vehTypeCD):
        for artefactID, artefact in self._getArtefacts().iteritems():
            accessToVehicle = artefact.get('accessToVehicle')
            if accessToVehicle == vehTypeCD:
                return artefactID

        return

    def getPhaseCompletionArtefact(self, phase, difficulty):
        return self._artefactPhaseCompletionBind.get((phase, difficulty))

    @adisp_async
    @decorators.adisp_process('updating')
    def openArtefact(self, artefactID, isSkipQuest, callback):
        result = yield OpenArtefactProcessor(self, artefactID, isSkipQuest).request()
        if result.userMsg:
            SystemMessages.pushMessage(result.userMsg, type=result.sysMsgType)
        callback(result.success)

    def _initArtefacts(self):
        quests = self.eventsCache.getAllQuests(lambda q: isArtefactQuest(q.getID()))
        self._artefacts = dict((artefactID, Artefact(artefactID, ArtefactPrice(*self._getArtefactPrice(artefactID)), ArtefactPrice(*self._getArtefactQuestSkipPrice(artefactID)), self._getArtefactBonuses(artefactID, quests), self._getArtefactQuestConditions(artefactID, quests), self._getArtefactTypes(artefactID), self._getArtefactDifficulty(artefactID))) for artefactID in self._getArtefacts().iterkeys())
        for artefactID in self._getArtefacts().iterkeys():
            completionInfo = self._getArtefactPhaseCompletionBind(artefactID, quests)
            if completionInfo:
                self._artefactPhaseCompletionBind[completionInfo] = artefactID

    def getIndex(self, artefactID):
        _, index, __ = artefactID.split(':')
        return int(index)

    def _getArtefactPhaseCompletionBind(self, artefactID, quests):
        quest = quests.get(artefactID)
        if quest is None:
            return
        else:
            conditions = quest.postBattleCond.getConditions()
            phase = self._getCorrespondingPhaseFromConditions(conditions)
            if phase is None:
                return
            artefact = self._artefacts[artefactID]
            return (phase, artefact.difficulty)

    def _getCorrespondingPhaseFromConditions(self, conditions):
        winCondition = conditions.find('win')
        if winCondition:
            if winCondition.getValue():
                return TOTAL_PHASE_COUNT
            return None
        resultCondtition = conditions.find('results')
        if not resultCondtition:
            return None
        else:
            if (
             resultCondtition.keyName, resultCondtition.relation) != PHASE_COMPLETION_QUEST_BR_CONDITION:
                return None
            return int(resultCondtition.relationValue)

    def _getArtefactTypes(self, artefactID):
        return self._getArtefacts().get(artefactID, {}).get('type', [])

    def _getArtefactDifficulty(self, artefactID):
        return self._getArtefacts().get(artefactID, {}).get('difficulty', 0)

    def _getArtefactQuestSkipPrice(self, artefactID):
        return self._getArtefacts().get(artefactID, {}).get('questSkipCost', (None,
                                                                              0))

    def _getArtefactPrice(self, artefactID):
        return self._getArtefacts().get(artefactID, {}).get('cost', (None, 0))

    def _getArtefactQuestConditions(self, artefactID, quests):
        quest = quests.get(artefactID)
        if quest is not None:
            curProggres, totalValue = self.__getFirstQuestProgress(quest)
            return QuestConditions(quest.getUserName(), quest.getDescription(), totalValue, curProggres)
        else:
            return QuestConditions()

    def _getArtefactBonuses(self, artefactID, quests):
        if ArtefactType.FINAL in self._getArtefactTypes(artefactID):
            quest = quests.get(artefactID)
            if quest:
                return sorted(quest.getBonuses(), cmp=compareBonuses, key=operator.methodcaller('getName'))
            return []
        rewards = []
        rewards.extend(getNonQuestBonuses(TokensBonus.TOKENS, {ArtefactsSettings.MEMORY: {}}))
        artefactConfig = self._getArtefacts().get(artefactID, {})
        bonusesConfig = artefactConfig.get('bonus', {})
        accessToVehicle = artefactConfig.get('accessToVehicle')
        if accessToVehicle:
            rentTime = self._getRentConfig().get('time', 0)
            opendSuffix = self._getRentConfig().get('openedSuffix')
            shopSuffix = self._getRentConfig().get('shopSuffix')
            vehiclesConfig = self._getRentConfig().get('vehicles', {})
            accessShopToken = vehiclesConfig.get(accessToVehicle, {}).get(shopSuffix, 'hw23_unknown')
            accessOpenToken = vehiclesConfig.get(accessToVehicle, {}).get(opendSuffix)
            if not self.eventsCache.questsProgress.getTokenCount(accessShopToken) > 0 or self.eventsCache.questsProgress.getTokenCount(accessOpenToken) > 0:
                rewards.extend(getNonQuestBonuses(VehiclesBonus.VEHICLES_BONUS, {accessToVehicle: {'rent': {'time': rentTime}}}))
        for bonusType, bonusValue in bonusesConfig.iteritems():
            rewards.extend(getNonQuestBonuses(bonusType, bonusValue))

        questsToRun = artefactConfig.get('questsToRun')
        if questsToRun:
            quests = self.eventsCache.getHiddenQuests(lambda q: q.getID() in questsToRun)
            if quests:
                rewards.extend(itertools.chain.from_iterable(q.getBonuses() for q in quests.itervalues()))
        return mergeBonuses(sorted(rewards, cmp=compareBonuses, key=operator.methodcaller('getName')))

    def _getConfig(self):
        return self.halloweenCtrl.getModeSettings().artefactsSettings

    def _getRentConfig(self):
        return self.halloweenCtrl.getModeSettings().rent

    def _getArtefacts(self):
        return self._getConfig().get('artefacts', {})

    def __getFirstQuestProgress(self, quest):
        for condName in QUEST_BONUS_CONDITIONS:
            cond = quest.bonusCond.getConditions().find(condName)
            if not cond:
                continue
            curProgressData = quest.bonusCond.getProgress().get(None, {})
            totalValue = cond.getTotalValue()
            curProggres = (quest.isCompleted() or curProgressData.get)(cond.getKey(), 0) if 1 else totalValue
            return (curProggres, totalValue)

        return (0, 1)

    def __handleTokensUpdate(self, diff):
        for token in diff:
            if token.startswith(ArtefactsSettings.KEY_TOKEN):
                self.onArtefactKeyUpdated()
                continue
            if token.startswith(ArtefactsSettings.TOKEN_PREFIX):
                self.onArtefactStatusUpdated(token)
            if token.startswith(RENT_VEHICLE_PREFIX):
                self._initArtefacts()
                self.onArtefactSettingsUpdated()

    def __onQuestsUpdated(self, _):
        self._initArtefacts()
        self.onArtefactSettingsUpdated()

    def __updateSettings(self):
        self._initArtefacts()
        self.onArtefactSettingsUpdated()