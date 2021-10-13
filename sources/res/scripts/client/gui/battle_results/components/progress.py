import logging, math, operator, typing
from collections import namedtuple
import BigWorld, personal_missions
from dog_tags_common.components_config import componentConfigAdapter as cca
from gui.dog_tag_composer import dogTagComposer
from gui.Scaleform.daapi.view.lobby.server_events.events_helpers import getEventPostBattleInfo, getBattlePassQuestInfo
from gui.Scaleform.daapi.view.lobby.customization.progression_helpers import getProgressionPostBattleInfo, parseEventID, getC11nProgressionLinkBtnParams
from gui.Scaleform.daapi.view.lobby.techtree.techtree_dp import g_techTreeDP
from gui.Scaleform.genConsts.PROGRESSIVEREWARD_CONSTANTS import PROGRESSIVEREWARD_CONSTANTS as prConst
from gui.Scaleform.locale.BATTLE_RESULTS import BATTLE_RESULTS
from gui.Scaleform.daapi.view.common.battle_royale.br_helpers import currentHangarIsSteelHunter
from gui.battle_results.components import base
from gui.battle_results.settings import PROGRESS_ACTION
from gui.impl import backport
from gui.impl.auxiliary.rewards_helper import getProgressiveRewardVO
from gui.impl.gen import R
from gui.shared.formatters import text_styles, getItemUnlockPricesVO, getItemPricesVO
from gui.shared.gui_items import GUI_ITEM_TYPE, Tankman, getVehicleComponentsByType
from gui.shared.gui_items.crew_skin import localizedFullName
from gui.shared.gui_items.Vehicle import getLevelIconPath
from gui.shared.gui_items.Tankman import getCrewSkinIconSmall
from gui.shared.gui_items.gui_item_economics import ItemPrice
from gui.shared.money import Currency
from helpers import dependency
from helpers.i18n import makeString as _ms
from skeletons.gui.lobby_context import ILobbyContext
from skeletons.gui.server_events import IEventsCache
from skeletons.gui.shared import IItemsCache
from items.components.crew_skins_constants import NO_CREW_SKIN_ID
from battle_pass_common import BattlePassConsts
MIN_BATTLES_TO_SHOW_PROGRESS = 5
_logger = logging.getLogger(__name__)

def isQuestCompleted(_, pPrev, pCur):
    return pCur.get('bonusCount', 0) - pPrev.get('bonusCount', 0) > 0


class VehicleProgressHelper(object):
    itemsCache = dependency.descriptor(IItemsCache)
    lobbyContext = dependency.descriptor(ILobbyContext)

    def __init__(self, vehTypeCompDescr):
        items = self.itemsCache.items
        stats = items.stats
        self.__unlocks = stats.unlocks
        self.__vehTypeCompDescr = vehTypeCompDescr
        self.__vehicle = items.getItemByCD(vehTypeCompDescr)
        self.__vehicleXp = stats.vehiclesXPs.get(self.__vehTypeCompDescr, 0)
        self.__avgVehicleXp = self.__getAvgVehicleXp(self.__vehTypeCompDescr)

    def clear(self):
        self.__unlocks = None
        self.__vehicle = None
        self.__vehicleXp = None
        self.__avgVehicleXp = None
        self.__vehTypeCompDescr = None
        return

    def getProgressList(self, vehicleBattleXp, pureCreditsReceived, tankmenXps):
        result = []
        ready2UnlockVehicles, ready2UnlockModules = self.getReady2UnlockItems(vehicleBattleXp)
        ready2BuyVehicles, ready2BuyModules = self.getReady2BuyItems(pureCreditsReceived)
        result.extend(ready2UnlockModules)
        result.extend(ready2BuyModules)
        result.extend(self.getNewSkilledTankmen(tankmenXps))
        result.extend(ready2UnlockVehicles)
        result.extend(ready2BuyVehicles)
        return result

    def __getAvgVehicleXp(self, vehTypeCompDescr):
        vehiclesStats = self.itemsCache.items.getAccountDossier().getRandomStats().getVehicles()
        vehicleStats = vehiclesStats.get(vehTypeCompDescr, None)
        if vehicleStats is not None:
            battlesCount, _, xp = vehicleStats
            if battlesCount:
                return xp / battlesCount
            return 0
        return 0

    def getReady2UnlockItems(self, vehicleBattleXp):
        ready2UnlockModules = []
        ready2UnlockVehicles = []
        possible2UnlockItems = g_techTreeDP.getAllPossibleItems2Unlock(self.__vehicle, self.__unlocks)
        getter = self.itemsCache.items.getItemByCD
        for itemTypeCD, unlockProps in possible2UnlockItems.iteritems():
            item = getter(itemTypeCD)
            if self.__vehicleXp - unlockProps.xpCost <= vehicleBattleXp:
                if item.itemTypeID == GUI_ITEM_TYPE.VEHICLE:
                    avgBattles2Unlock = self.__getAvgBattles2Unlock(unlockProps)
                    if self.__vehicleXp > unlockProps.xpCost or 0 < avgBattles2Unlock <= MIN_BATTLES_TO_SHOW_PROGRESS:
                        ready2UnlockVehicles.append(self.__makeUnlockVehicleVO(item, unlockProps, avgBattles2Unlock))
                elif self.__vehicleXp > unlockProps.xpCost:
                    ready2UnlockModules.append(self.__makeUnlockModuleVO(item, unlockProps))

        return (
         ready2UnlockVehicles, ready2UnlockModules)

    def getReady2BuyItems(self, pureCreditsReceived):
        ready2BuyModules = []
        ready2BuyVehicles = []
        creditsValue = self.itemsCache.items.stats.credits
        unlockedVehicleItems = g_techTreeDP.getUnlockedVehicleItems(self.__vehicle, self.__unlocks)
        getter = self.itemsCache.items.getItemByCD
        for itemTypeCD, unlockProps in unlockedVehicleItems.iteritems():
            item = getter(itemTypeCD)
            price = item.getBuyPrice(preferred=False).price
            if price.isCurrencyDefined(Currency.CREDITS) and not item.isInInventory:
                priceCredits = price.credits
                if creditsValue - priceCredits <= pureCreditsReceived and creditsValue > priceCredits:
                    if item.itemTypeID == GUI_ITEM_TYPE.VEHICLE:
                        ready2BuyVehicles.append(self.__makeVehiclePurchaseVO(item, unlockProps, price))
                    elif not item.isInstalled(self.__vehicle):
                        items = getVehicleComponentsByType(self.__vehicle, item.itemTypeID).values()
                        if items:
                            installedModule = max(items, key=lambda module: module.level)
                            if item.level > installedModule.level:
                                ready2BuyModules.append(self.__makeModulePurchaseVO(item, unlockProps, price))

        return (
         ready2BuyVehicles, ready2BuyModules)

    def getNewSkilledTankmen(self, tankmenXps):
        skilledTankmans = []
        for _, tman in self.__vehicle.crew:
            if tman is not None and tman.hasSkillToLearn():
                if not tman.isMaxRoleLevel:
                    continue
                tmanBattleXp = tankmenXps.get(tman.invID, 0)
                avgBattles2NewSkill = 0
                if tman.hasNewSkill(useCombinedRoles=True):
                    if tmanBattleXp - tman.descriptor.freeXP > 0:
                        skilledTankmans.append(self.__makeTankmanVO(tman, avgBattles2NewSkill))
                else:
                    tmanDossier = self.itemsCache.items.getTankmanDossier(tman.invID)
                    avgBattles2NewSkill = self.__getAvgBattles2NewSkill(tmanDossier.getAvgXP(), tman)
                    if 0 < avgBattles2NewSkill <= MIN_BATTLES_TO_SHOW_PROGRESS:
                        skilledTankmans.append(self.__makeTankmanVO(tman, avgBattles2NewSkill))

        return skilledTankmans

    def __getAvgBattles2Unlock(self, unlockProps):
        if self.__avgVehicleXp > 0:
            return int(math.ceil((unlockProps.xpCost - self.__vehicleXp) / float(self.__avgVehicleXp)))
        return 0

    def __getAvgBattles2NewSkill(self, avgTmanXp, tman):
        if avgTmanXp > 0:
            return max(1, math.ceil(tman.getNextSkillXpCost() / avgTmanXp))
        return 0

    def __makeTankmanDescription(self, roleName, fullName):
        role = text_styles.main(roleName)
        name = text_styles.standard(fullName)
        return _ms(BATTLE_RESULTS.COMMON_CREWMEMBER_DESCRIPTION, name=name, role=role)

    def __makeVehicleDescription(self, vehicle):
        vehicleType = text_styles.standard(vehicle.typeUserName)
        vehicleName = text_styles.main(vehicle.userName)
        return _ms(BATTLE_RESULTS.COMMON_VEHICLE_DETAILS, vehicle=vehicleName, type=vehicleType)

    def __makeTankmanVO(self, tman, avgBattles2NewSkill):
        prediction = ''
        if avgBattles2NewSkill > 0:
            prediction = _ms(BATTLE_RESULTS.COMMON_NEWSKILLPREDICTION, battles=backport.getIntegralFormat(avgBattles2NewSkill))
        data = {'title': _ms(BATTLE_RESULTS.COMMON_CREWMEMBER_NEWSKILL), 
           'prediction': prediction, 
           'linkEvent': PROGRESS_ACTION.NEW_SKILL_UNLOCK_TYPE, 
           'linkId': tman.invID}
        if tman.skinID != NO_CREW_SKIN_ID and self.lobbyContext.getServerSettings().isCrewSkinsEnabled():
            skinItem = self.itemsCache.items.getCrewSkin(tman.skinID)
            data['tankmenIcon'] = getCrewSkinIconSmall(skinItem.getIconID())
            fullTankmanName = localizedFullName(skinItem)
        else:
            data['tankmenIcon'] = Tankman.getSmallIconPath(tman.nationID, tman.descriptor.iconID)
            fullTankmanName = tman.fullUserName
        data['description'] = self.__makeTankmanDescription(tman.roleUserName, fullTankmanName)
        return data

    def __makeUnlockModuleVO(self, item, unlockProps):
        return {'title': _ms(BATTLE_RESULTS.COMMON_FITTING_RESEARCH), 
           'description': text_styles.main(item.userName), 
           'fittingType': item.getGUIEmblemID(), 
           'lvlIcon': getLevelIconPath(item.level), 
           'price': getItemUnlockPricesVO(unlockProps), 
           'linkEvent': PROGRESS_ACTION.RESEARCH_UNLOCK_TYPE, 
           'linkId': unlockProps.parentID}

    def __makeUnlockVehicleVO(self, item, unlockProps, avgBattlesTillUnlock):
        prediction = ''
        if avgBattlesTillUnlock > 0:
            prediction = _ms(BATTLE_RESULTS.COMMON_RESEARCHPREDICTION, battles=avgBattlesTillUnlock)
        return {'title': _ms(BATTLE_RESULTS.COMMON_VEHICLE_RESEARCH), 
           'description': self.__makeVehicleDescription(item), 
           'vehicleIcon': item.iconSmall, 
           'lvlIcon': getLevelIconPath(item.level), 
           'prediction': prediction, 
           'price': getItemUnlockPricesVO(unlockProps), 
           'linkEvent': PROGRESS_ACTION.RESEARCH_UNLOCK_TYPE, 
           'linkId': unlockProps.parentID}

    def __makeVehiclePurchaseVO(self, item, unlockProps, price):
        return {'title': _ms(BATTLE_RESULTS.COMMON_VEHICLE_PURCHASE), 
           'description': self.__makeVehicleDescription(item), 
           'vehicleIcon': item.iconSmall, 
           'lvlIcon': getLevelIconPath(item.level), 
           'price': getItemPricesVO(ItemPrice(price=price, defPrice=price)), 
           'linkEvent': PROGRESS_ACTION.PURCHASE_UNLOCK_TYPE, 
           'linkId': unlockProps.parentID}

    def __makeModulePurchaseVO(self, item, unlockProps, price):
        return {'title': _ms(BATTLE_RESULTS.COMMON_FITTING_PURCHASE), 
           'description': text_styles.main(item.userName), 
           'fittingType': item.itemTypeName, 
           'lvlIcon': getLevelIconPath(item.level), 
           'price': getItemPricesVO(ItemPrice(price=price, defPrice=price)), 
           'linkEvent': PROGRESS_ACTION.PURCHASE_UNLOCK_TYPE, 
           'linkId': unlockProps.parentID}


class VehicleProgressBlock(base.StatsBlock):
    __slots__ = ()

    def setRecord(self, result, reusable):
        for intCD, data in reusable.personal.getVehicleCDsIterator(result):
            vehicleBattleXp = data.get('xp', 0)
            pureCreditsReceived = data.get('pureCreditsReceived', 0)
            tmenXps = dict(data.get('xpByTmen', []))
            helper = VehicleProgressHelper(intCD)
            progress = helper.getProgressList(vehicleBattleXp, pureCreditsReceived, tmenXps)
            for item in progress:
                self.addComponent(self.getNextComponentIndex(), base.DirectStatsItem('', item))

            helper.clear()


PMComplete = namedtuple('PMComplete', [
 'isMainComplete',
 'isAddComplete'])

class BattlePassProgressBlock(base.StatsBlock):

    def setRecord(self, result, reusable):
        if reusable.battlePassProgress is not None:
            if BattlePassConsts.PROGRESSION_INFO_PREV in reusable.battlePassProgress:
                info = reusable.battlePassProgress[BattlePassConsts.PROGRESSION_INFO_PREV]
                self.addComponent(self.getNextComponentIndex(), base.DirectStatsItem('', getBattlePassQuestInfo(info)))
            if BattlePassConsts.PROGRESSION_INFO in reusable.battlePassProgress:
                info = reusable.battlePassProgress[BattlePassConsts.PROGRESSION_INFO]
                self.addComponent(self.getNextComponentIndex(), base.DirectStatsItem('', getBattlePassQuestInfo(info)))
        return


class QuestsProgressBlock(base.StatsBlock):
    eventsCache = dependency.descriptor(IEventsCache)
    __slots__ = ()

    def getVO(self):
        vo = super(QuestsProgressBlock, self).getVO()
        return vo

    def setRecord(self, result, reusable):
        questsProgress = reusable.personal.getQuestsProgress()
        personalMissions = {}
        commonQuests = []
        allCommonQuests = self.eventsCache.getQuests()
        allCommonQuests.update(self.eventsCache.getHiddenQuests(lambda q: q.isShowedPostBattle()))
        if questsProgress:
            for qID, qProgress in questsProgress.iteritems():
                pGroupBy, pPrev, pCur = qProgress
                isCompleted = isQuestCompleted(pGroupBy, pPrev, pCur)
                if qID in allCommonQuests:
                    quest = allCommonQuests[qID]
                    isProgressReset = not isCompleted and quest.bonusCond.isInRow() and pCur.get('battlesCount', 0) == 0
                    if pPrev or max(pCur.itervalues()) != 0:
                        commonQuests.append((
                         quest, {pGroupBy: pCur}, {pGroupBy: pPrev}, isProgressReset, isCompleted))
                elif personal_missions.g_cache.isPersonalMission(qID):
                    pqID = personal_missions.g_cache.getPersonalMissionIDByUniqueID(qID)
                    questsCache = self.eventsCache.getPersonalMissions()
                    quest = questsCache.getAllQuests()[pqID]
                    progress = personalMissions.setdefault(quest, {})
                    progress.update({qID: isCompleted})

        pm2Progress = reusable.personal.getPM2Progress()
        if pm2Progress:
            quests = self.eventsCache.getPersonalMissions().getAllQuests()
            for qID, data in pm2Progress.iteritems():
                quest = quests[qID]
                if quest in personalMissions:
                    personalMissions[quest].update(data)
                else:
                    progress = personalMissions.setdefault(quest, {})
                    progress.update(data)

        for quest, data in sorted(personalMissions.items(), key=operator.itemgetter(0), cmp=self.__sortPersonalMissions):
            if data.get(quest.getAddQuestID(), False):
                complete = PMComplete(True, True)
            elif data.get(quest.getMainQuestID(), False):
                complete = PMComplete(True, False)
            else:
                complete = PMComplete(False, False)
            info = getEventPostBattleInfo(quest, None, None, None, False, complete, progressData=data)
            if info is not None:
                self.addComponent(self.getNextComponentIndex(), base.DirectStatsItem('', info))

        for vehicleIntCD, c11nProgression in reusable.personal.getC11nProgress().iteritems():
            for intCD, progressionData in sorted(c11nProgression.iteritems(), key=lambda (_, d): -d.get('level', 0)):
                info = getProgressionPostBattleInfo(intCD, vehicleIntCD, progressionData)
                if info is not None:
                    self.addComponent(self.getNextComponentIndex(), ProgressiveCustomizationVO('', info))

        for e, pCur, pPrev, reset, complete in sorted(commonQuests, cmp=self.__sortCommonQuestsFunc):
            info = getEventPostBattleInfo(e, allCommonQuests, pCur, pPrev, reset, complete)
            if info is not None:
                self.addComponent(self.getNextComponentIndex(), base.DirectStatsItem('', info))

        return

    @staticmethod
    def __sortPersonalMissions(a, b):
        aFullCompleted, bFullCompleted = a.isFullCompleted(), b.isFullCompleted()
        if aFullCompleted != bFullCompleted:
            return bFullCompleted - aFullCompleted
        aCompleted, bCompleted = a.isCompleted(), b.isCompleted()
        if aCompleted != bCompleted:
            return bCompleted - aCompleted
        return b.getCampaignID() - a.getCampaignID()

    @staticmethod
    def __sortCommonQuestsFunc(aData, bData):
        aQuest, aCurProg, aPrevProg, _, _ = aData
        bQuest, bCurProg, bPrevProg, _, _ = bData
        res = cmp(aQuest.isCompleted(aCurProg), bQuest.isCompleted(bCurProg))
        if res:
            return -res
        if aQuest.isCompleted() and bQuest.isCompleted(bCurProg):
            res = aQuest.getBonusCount(aCurProg) - aPrevProg.get('bonusCount', 0) - (bQuest.getBonusCount(bCurProg) - bPrevProg.get('bonusCount', 0))
            if not res:
                return res
        return cmp(aQuest.getID(), bQuest.getID())


class DogTagsProgressBlock(base.StatsBlock):
    eventsCache = dependency.descriptor(IEventsCache)
    lobbyContext = dependency.descriptor(ILobbyContext)
    __slots__ = ()

    def getVO(self):
        vo = super(DogTagsProgressBlock, self).getVO()
        return vo

    @staticmethod
    def createDogTagInfo(componentId, dogTagType):
        compGrade = BigWorld.player().dogTags.getComponentProgress(componentId).grade
        return {'title': DogTagsProgressBlock.__getInfoTitle(componentId, compGrade, dogTagType), 
           'description': DogTagsProgressBlock.__getInfoDescription(componentId, dogTagType), 
           'dogTagType': dogTagType, 
           'componentId': componentId, 
           'imageSrc': dogTagComposer.getComponentImage(componentId, compGrade), 
           'unlockType': cca.getComponentById(componentId).viewType.value.lower()}

    @staticmethod
    def __getInfoTitle(componentId, grade, dogTagType):
        compTitle = dogTagComposer.getComponentTitle(componentId)
        viewType = cca.getComponentById(componentId).viewType.value.lower()
        strSource = R.strings.dogtags.postbattle.dyn(dogTagType).dyn(viewType).title()
        return backport.text(strSource).format(title=compTitle, level=grade + 1)

    @staticmethod
    def __getInfoDescription(componentId, dogTagType):
        viewType = cca.getComponentById(componentId).viewType.value.lower()
        strSource = R.strings.dogtags.postbattle.dyn(dogTagType).dyn(viewType).description()
        return backport.text(strSource)

    def setRecord(self, result, reusable):
        if not self.lobbyContext.getServerSettings().isDogTagInPostBattleEnabled():
            return
        dogTags = reusable.personal.getDogTagsProgress()
        for compId in dogTags.get('unlockedComps', []):
            info = self.createDogTagInfo(compId, 'unlock')
            self.addComponent(self.getNextComponentIndex(), base.DirectStatsItem('', info))

        for compId in dogTags.get('upgradedComps', []):
            info = self.createDogTagInfo(compId, 'upgrade')
            self.addComponent(self.getNextComponentIndex(), base.DirectStatsItem('', info))


class ProgressiveRewardVO(base.StatsItem):
    eventsCache = dependency.descriptor(IEventsCache)
    lobbyContext = dependency.descriptor(ILobbyContext)
    __slots__ = ()

    def _convert(self, record, reusable):
        progressiveReward = reusable.personal.getProgressiveReward()
        if progressiveReward is None:
            return
        else:
            progressiveConfig = self.lobbyContext.getServerSettings().getProgressiveRewardConfig()
            maxSteps = progressiveConfig.maxLevel
            hasCompleted, currentStep, probability = progressiveReward
            if currentStep >= maxSteps:
                _logger.warning('Current step more than max step in progressive reward')
                return
            if hasCompleted:
                currentStep = currentStep - 1 if currentStep else maxSteps - 1
            descText = text_styles.standard(backport.text(R.strings.battle_results.progressiveReward.descr()))
            return getProgressiveRewardVO(currentStep=currentStep, probability=probability, maxSteps=maxSteps, showBg=True, align=prConst.WIDGET_LAYOUT_H, isHighTitle=True, hasCompleted=hasCompleted, descText=descText)


class ProgressiveCustomizationVO(base.DirectStatsItem):
    _itemsCache = dependency.descriptor(IItemsCache)
    __slots__ = ()

    def getVO(self):
        questInfo = self._value.get('questInfo', {})
        questID = questInfo.get('questID', None)
        if questInfo and questID is not None:
            _, vehicleIntCD = parseEventID(questID)
            vehicle = self._itemsCache.items.getItemByCD(vehicleIntCD)
            linkBtnEnabled, linkBtnTooltip = getC11nProgressionLinkBtnParams(vehicle)
            if currentHangarIsSteelHunter():
                linkBtnEnabled = False
            self._value['linkBtnEnabled'] = linkBtnEnabled
            self._value['linkBtnTooltip'] = backport.text(linkBtnTooltip)
        return self._value