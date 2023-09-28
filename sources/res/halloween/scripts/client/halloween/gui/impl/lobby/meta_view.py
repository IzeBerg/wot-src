import adisp, WWISE
from gui.impl import backport
from items import vehicles
from wg_async import wg_await
from frameworks.wulf import ViewFlags, ViewSettings, WindowLayer
from gui import GUI_SETTINGS
from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.impl.pub.fade_manager import FadeManager
from gui.shared.event_dispatcher import showHangar, showBrowserOverlayView
from gui.shared.gui_items import GUI_ITEM_TYPE_INDICES, GUI_ITEM_TYPE
from gui.shared.gui_items.customization import CustomizationTooltipContext
from halloween.gui.impl.gen.view_models.views.lobby.common.base_quest_model import QuestStatusEnum, BaseQuestModel, QuestTypeEnum
from halloween.gui.impl.gen.view_models.views.lobby.common.reward_model import RewardModel
from halloween.gui.impl.gen.view_models.views.lobby.meta_view_model import MetaViewModel
from gui.impl.gen import R
from gui.impl.backport import BackportTooltipWindow, createTooltipData
from gui.impl.backport.backport_tooltip import DecoratedTooltipWindow
from gui.impl.pub import ToolTipWindow
from gui.impl.pub.tooltip_window import SimpleTooltipContent
from gui.shared.image_helper import getTextureLinkByID
from halloween.gui.impl.gen.view_models.views.lobby.witches_model import WidgetTypeEnum
from halloween.gui.impl.lobby.base_event_view import BaseEventView, isNewIntro, isNewOutro
from halloween.gui.impl.lobby.tooltips.crew_tooltip import CrewTooltip
from halloween.gui.impl.lobby.widgets.witches_widget import WitchesWidget
from halloween.gui.shared.event_dispatcher import showPreviewView, showMetaIntroView
from halloween.gui.sounds.sound_constants import WITCHES_SOUND_SPACE, WitchesMetaState
from halloween.hw_constants import QuestType, PhaseType, EVENT_ABILITY_QUEST_PREFIX, HWBonusesType, INVALID_PHASE_INDEX
from helpers import dependency
from skeletons.gui.customization import ICustomizationService
from skeletons.gui.server_events import IEventsCache
from skeletons.gui.shared import IItemsCache
from halloween.skeletons.gui.sound_controller import IHWSoundController
from gui_lootboxes.gui.impl.lobby.gui_lootboxes.tooltips.lootbox_tooltip import LootboxTooltip
ABOUT_EVENT_SETTING_KEY = 'aboutCoven'

class MetaView(BaseEventView):
    __slots__ = ('__witchesWidget', 'selectedPhase')
    layoutID = R.views.halloween.lobby.MetaView()
    eventsCache = dependency.descriptor(IEventsCache)
    c11n = dependency.descriptor(ICustomizationService)
    hwSoundController = dependency.descriptor(IHWSoundController)
    __itemsCache = dependency.descriptor(IItemsCache)
    _COMMON_SOUND_SPACE = WITCHES_SOUND_SPACE

    def __init__(self, layoutID=None, selectedPhase=INVALID_PHASE_INDEX):
        settings = ViewSettings(layoutID or self.layoutID, ViewFlags.LOBBY_SUB_VIEW, MetaViewModel())
        super(MetaView, self).__init__(settings)
        self.__witchesWidget = WitchesWidget(viewModel=self.viewModel.witchesWidget, parentView=WidgetTypeEnum.META)
        self.selectedPhase = selectedPhase
        self.__currentVOSwitchPhase = None
        return

    @property
    def viewModel(self):
        return super(MetaView, self).getViewModel()

    def createToolTipContent(self, event, contentID):
        if contentID == R.views.halloween.lobby.tooltips.CrewTooltip():
            phaseIndex = event.getArgument('id')
            return CrewTooltip(phaseIndex=phaseIndex)
        else:
            if contentID == R.views.common.tooltip_window.backport_tooltip_content.BackportTooltipContent():
                tooltipData = event.getArgument('tooltipId')
                tooltipType, lootBoxId = tooltipData.split(':') if tooltipData else (None,
                                                                                     None)
                if tooltipType == HWBonusesType.LOOT_BOXES and lootBoxId:
                    lootBox = self.__itemsCache.items.tokens.getLootBoxByID(int(lootBoxId))
                    return LootboxTooltip(lootBox)
            return

    def createToolTip(self, event):
        tooltipId = event.getArgument('tooltipId', None)
        if event.contentID == R.views.common.tooltip_window.backport_tooltip_content.BackportTooltipContent() and self.selectedPhase:
            if tooltipId.startswith(HWBonusesType.TANKMAN):
                return self.__tankmanTooltip(event)
            if tooltipId in [HWBonusesType.STYLE, HWBonusesType.DECAL]:
                return self.__customizationTooltip(tooltipId)
            if tooltipId.startswith(HWBonusesType.CRYSTAL):
                return self.__createSimpleTooltip(event, header=backport.text(R.strings.hw_lobby.meta.tooltip.crystal.header()), body=backport.text(R.strings.hw_lobby.meta.tooltip.crystal.body()))
            if tooltipId.startswith(HWBonusesType.CREDITS):
                return self.__createSimpleTooltip(event, header=backport.text(R.strings.hw_lobby.meta.tooltip.credits.header()), body=backport.text(R.strings.hw_lobby.meta.tooltip.credits.body()))
            if tooltipId.startswith(HWBonusesType.EQUIPMENT):
                name = event.getArgument('name', '')
                return self.__equipmentTooltip(equipmentName=name)
            if tooltipId.startswith(HWBonusesType.BATTLE_BOOSTER):
                name = event.getArgument('name', '')
                return self.__equipmentTooltip(equipmentName=name, isBattleBooster=True)
        return super(MetaView, self).createToolTip(event)

    def _onLoading(self, *args, **kwargs):
        super(MetaView, self)._onLoading(*args, **kwargs)
        self.__witchesWidget.onLoading()

    def _initialize(self):
        super(MetaView, self)._initialize()
        self.__setVOSwitch()
        showMetaIntroView(forceOpen=False, onViewLoaded=self.__introViewLoaded, onViewClosed=self.__introViewClosed, parent=self.getParentWindow())
        WWISE.WW_setState(WitchesMetaState.GROUP, WitchesMetaState.WINDOW_META)

    def _finalize(self):
        self.__witchesWidget.finalize()
        super(MetaView, self)._finalize()

    def _subscribe(self):
        super(MetaView, self)._subscribe()
        self.viewModel.onInfoClick += self.__onInfoClick
        self.viewModel.onAboutClick += self.__onAboutClick
        self.viewModel.onPreviewClick += self.__onPreviewClick
        self.viewModel.onPhaseChange += self.__onChangePhaseClick

    def _unsubscribe(self):
        super(MetaView, self)._unsubscribe()
        self.viewModel.onInfoClick -= self.__onInfoClick
        self.viewModel.onAboutClick -= self.__onAboutClick
        self.viewModel.onPreviewClick -= self.__onPreviewClick
        self.viewModel.onPhaseChange -= self.__onChangePhaseClick

    def _fillViewModel(self):
        super(MetaView, self)._fillViewModel()
        self.__update()
        self.__witchesWidget.updateAll()

    def _onClose(self):
        showHangar()

    def __onChangePhaseClick(self, args=None):
        self.selectedPhase = args.get('phase', INVALID_PHASE_INDEX) if args is not None else INVALID_PHASE_INDEX
        self.__setVOSwitch()
        self.__update()
        return

    def __onAboutClick(self):
        url = GUI_SETTINGS.lookup(ABOUT_EVENT_SETTING_KEY)
        showBrowserOverlayView(url, VIEW_ALIAS.WEB_VIEW_TRANSPARENT, hiddenLayers=(
         WindowLayer.MARKER, WindowLayer.VIEW, WindowLayer.WINDOW))

    def __introViewLoaded(self):
        self.viewModel.setIsViewHidden(True)

    def __introViewClosed(self):
        self.viewModel.setIsViewHidden(False)

    def __onInfoClick(self):
        showMetaIntroView(forceOpen=True, onViewLoaded=self.__introViewLoaded, onViewClosed=self.__introViewClosed, parent=self.getParentWindow())

    @adisp.adisp_process
    def __onPreviewClick(self, args=None):
        selectedPhase = args.get('phase', 0) if args is not None else 0
        with FadeManager(WindowLayer.SERVICE_LAYOUT) as (fadeManager):
            yield wg_await(fadeManager.show())
            yield wg_await(showPreviewView(selectedPhase=selectedPhase, onClose=self.__updateNewFlags, parent=self.getParentWindow()))
            yield wg_await(fadeManager.hide())
        return

    def __updateNewFlags(self):
        phase = self._hwController.phases.getPhaseByIndex(self.selectedPhase)
        if not phase:
            return
        self.viewModel.setIsNew(isNewIntro(phase) or isNewOutro(phase))
        self.__witchesWidget.updateNew()

    def __update(self):
        with self.viewModel.transaction() as (model):
            activePhase = self._hwController.phases.getActivePhase(PhaseType.REGULAR)
            if self.selectedPhase == INVALID_PHASE_INDEX:
                self.selectedPhase = activePhase.phaseIndex
            phase = self._hwController.phases.getPhaseByIndex(self.selectedPhase)
            model.setSelectedPhase(self.selectedPhase)
            self._fillPhase(model.phase, phase)
            model.setIsNew(isNewIntro(phase) or isNewOutro(phase))
            self.__fillQuests(model, phase)

    def __fillQuests(self, model, phase):
        quests = phase.getQuestsByType(QuestType.HALLOWEEN)
        questModels = model.getQuests()
        questModels.clear()
        for quest in quests:
            questModel = BaseQuestModel()
            questId = quest.getQuestId()
            questStatus = self.__getQuestStatus(quest)
            questModel.setName(questId)
            questModel.setStatus(questStatus)
            ability = phase.getQuestConditionAbilityInfo(quest.getQuest())
            if ability is not None:
                questModel.setAbilityIcon(ability.descriptor.iconName)
                questModel.setAbilityName(ability.shortUserName)
            questModel.setIsDisabled(not phase.isActive())
            info = quest.getProgressInfo()
            questModel.setAmount(info['totalProgress'])
            currentProgress = info['currentProgress']
            questModel.setProgress(currentProgress)
            questModel.setDeltaFrom(currentProgress)
            if EVENT_ABILITY_QUEST_PREFIX in questId:
                questModel.setType(QuestTypeEnum.EVENTABILITY)
            else:
                questModel.setType(QuestTypeEnum.SIMPLY)
            self.__fillBonuses(quest, questModel)
            questModels.addViewModel(questModel)

        questModels.invalidate()
        return

    def __fillBonuses(self, quest, questModel):
        rewards = questModel.getRewards()
        rewards.clear()
        for bonus in quest.getBonusesInfo():
            reward = RewardModel()
            bId, bType, bItem, count = bonus
            tooltipID = bType
            reward.setName(self.__getBonusName(bType, bItem))
            reward.setTooltipId(tooltipID)
            if bType == HWBonusesType.DECAL:
                item = self.c11n.getItemByID(GUI_ITEM_TYPE.PROJECTION_DECAL, bItem)
                reward.setIconName(getTextureLinkByID(item.texture))
            elif bType == HWBonusesType.EQUIPMENT:
                if bItem.itemTypeID == GUI_ITEM_TYPE.BATTLE_BOOSTER:
                    tooltipID = HWBonusesType.BATTLE_BOOSTER
                    reward.setTooltipId(tooltipID)
                reward.setName(bItem.descriptor.groupName)
                reward.setLabelCount(('x{}').format(count))
            elif bType == HWBonusesType.CRYSTAL:
                reward.setLabelCount(str(count))
            elif bType == HWBonusesType.CREDITS:
                reward.setLabelCount(str(count))
            elif bType == HWBonusesType.LOOT_BOXES:
                reward.setLabelCount(('x{}').format(count))
                reward.setName(HWBonusesType.LOOT_BOXES)
                reward.setTooltipId(('{}:{}').format(HWBonusesType.LOOT_BOXES, bId))
            rewards.addViewModel(reward)

        rewards.invalidate()

    def __getBonusName(self, bType, bID):
        if bType == HWBonusesType.TANKMAN:
            groupName = bID.split(':')[3]
            return ('{}_{}').format(HWBonusesType.TANKMAN, groupName)
        return bType

    def __getQuestStatus(self, quest):
        if quest.isLock():
            return QuestStatusEnum.WILLOPEN
        if quest.isCompleted():
            return QuestStatusEnum.COMPLETED
        if quest.isAvailable():
            return QuestStatusEnum.INPROGRESS
        return QuestStatusEnum.REWARDNOTTAKEN

    def __createSimpleTooltip(self, event, header='', body=''):
        window = DecoratedTooltipWindow(content=SimpleTooltipContent(R.views.common.tooltip_window.simple_tooltip_content.SimpleTooltipContent(), body=body, header=header), parent=self.getParentWindow())
        window.load()
        window.move(event.mouse.positionX, event.mouse.positionY)
        return window

    def __tankmanTooltip(self, event):
        content = CrewTooltip(self.selectedPhase)
        window = ToolTipWindow(event, content, self.getParentWindow())
        window.load()
        window.move(event.mouse.positionX, event.mouse.positionY)
        return window

    def __customizationTooltip(self, customizationType):
        phase = self._hwController.phases.getPhaseByIndex(self.selectedPhase)
        if not phase:
            return
        else:
            quests = phase.getQuestsByType(QuestType.HALLOWEEN)
            for quest in quests:
                bonuses = quest.getBonusesInfo()
                for bonus in bonuses:
                    _, bType, bID, _ = bonus
                    if bType != customizationType:
                        continue
                    itemTypeID = GUI_ITEM_TYPE.PROJECTION_DECAL if customizationType == HWBonusesType.DECAL else GUI_ITEM_TYPE_INDICES.get(customizationType)
                    item = self.c11n.getItemByID(itemTypeID, bID)
                    window = BackportTooltipWindow(createTooltipData(isSpecial=True, specialAlias=TOOLTIPS_CONSTANTS.TECH_CUSTOMIZATION_ITEM_AWARD, specialArgs=CustomizationTooltipContext(itemCD=item.intCD, showInventoryBlock=True)), self.getParentWindow())
                    window.load()
                    return window

            return

    def __equipmentTooltip(self, equipmentName=None, isBattleBooster=False):
        eq = self.__getEquipmentByName(equipmentName)
        if eq is not None:
            window = BackportTooltipWindow(createTooltipData(isSpecial=True, specialAlias=TOOLTIPS_CONSTANTS.AWARD_BATTLE_BOOSTER if isBattleBooster else TOOLTIPS_CONSTANTS.AWARD_MODULE, specialArgs=[
             eq.compactDescr]), self.getParentWindow())
            window.load()
            return window
        else:
            return

    def __setVOSwitch(self):
        if self.__currentVOSwitchPhase != int(self.selectedPhase):
            self.__currentVOSwitchPhase = int(self.selectedPhase)
            self.hwSoundController.switchSoundPhase(self.__currentVOSwitchPhase)

    def __getEquipmentByName(self, name):
        cache = vehicles.g_cache
        equipmentID = cache.equipmentIDs().get(name)
        if equipmentID is None:
            return
        else:
            return cache.equipments()[equipmentID]