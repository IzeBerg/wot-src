import SoundGroups
from frameworks.wulf import ViewSettings
from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.impl import backport
from gui.impl.backport import BackportTooltipWindow, createTooltipData
from gui.impl.backport.backport_tooltip import DecoratedTooltipWindow
from gui.impl.gen import R
from gui.impl.pub import ViewImpl, ToolTipWindow
from gui.impl.pub.lobby_window import LobbyNotificationWindow
from gui.impl.pub.tooltip_window import SimpleTooltipContent
from gui.shared.gui_items import GUI_ITEM_TYPE_INDICES, GUI_ITEM_TYPE
from gui.shared.gui_items.customization import CustomizationTooltipContext
from gui.shared.image_helper import getTextureLinkByID
from gui.server_events.events_dispatcher import showRecruitWindow
from halloween.gui.game_control.halloween_progress_controller import getProgressInfo
from halloween.gui.impl.gen.view_models.views.lobby.common.crew_item_model import CrewItemModel
from halloween.gui.impl.gen.view_models.views.lobby.common.reward_model import RewardModel
from halloween.gui.impl.gen.view_models.views.lobby.reward_screen_view_model import RewardScreenViewModel
from halloween.gui.impl.lobby.tooltips.crew_tooltip import CrewTooltip
from halloween.gui.impl.lobby.tooltips.simply_format_tooltip import SimplyFormatTooltipView
from halloween.hw_constants import HWBonusesType, GLOBAL_PROGRESS_HW_XP_QUEST, HWTooltips, PhaseType
from halloween.skeletons.gui.game_event_controller import IHalloweenProgressController
from halloween.gui.sounds.sound_constants import HANGAR_WITCHES_VO_PREVIEW, REWARDS_SOUND_SPACE, RewardsEvents
from helpers import dependency
from items import tankmen, vehicles
from shared_utils import findFirst
from skeletons.gui.customization import ICustomizationService
from skeletons.gui.server_events import IEventsCache

class RewardScreenView(ViewImpl):
    c11n = dependency.descriptor(ICustomizationService)
    eventsCache = dependency.descriptor(IEventsCache)
    hwController = dependency.descriptor(IHalloweenProgressController)
    _COMMON_SOUND_SPACE = REWARDS_SOUND_SPACE

    def __init__(self, data, bonuses):
        settings = ViewSettings(R.views.halloween.lobby.RewardScreenView())
        settings.model = RewardScreenViewModel()
        super(RewardScreenView, self).__init__(settings)
        self.__screenType = data.get('screenType')
        self.__phase = data.get('phase')
        self.__phasesCount = len(self.hwController.phasesHalloween.getPhasesByType(PhaseType.REGULAR))
        self.__bonuses = bonuses

    @property
    def viewModel(self):
        return super(RewardScreenView, self).getViewModel()

    def createToolTip(self, event):
        if event.contentID == R.views.common.tooltip_window.backport_tooltip_content.BackportTooltipContent():
            tooltipId = event.getArgument('tooltipId', None)
            bonusArg = event.getArgument('name', None)
            if tooltipId == HWBonusesType.TANKMAN:
                return self.__tankmanTooltip(event)
            if tooltipId in [HWBonusesType.STYLE, HWBonusesType.DECAL]:
                return self.__customizationTooltip(tooltipId)
            if tooltipId == HWBonusesType.BADGE:
                return self.__badgeTooltip(bonusArg)
            if tooltipId == HWBonusesType.MEDAL:
                return self.__achievementTooltip(tooltipId, bonusArg)
            if tooltipId.startswith(HWBonusesType.CRYSTAL):
                return self.__createSimpleTooltip(event, header=backport.text(R.strings.hw_lobby.meta.tooltip.crystal.header()), body=backport.text(R.strings.hw_lobby.meta.tooltip.crystal.body()))
            if tooltipId.startswith(HWBonusesType.EQUIPMENT):
                name = event.getArgument('name', '')
                return self.__equipmentTooltip(equipmentName=name)
        return super(RewardScreenView, self).createToolTip(event)

    def createToolTipContent(self, event, contentID):
        if contentID == R.views.halloween.lobby.tooltips.SimplyFormatTooltip():
            header = event.getArgument('header', '')
            body = event.getArgument('body', '')
            return SimplyFormatTooltipView(header, body)
        if contentID == R.views.halloween.lobby.tooltips.CrewTooltip():
            phaseIndex = event.getArgument('id')
            return CrewTooltip(phaseIndex=phaseIndex)
        return super(RewardScreenView, self).createToolTipContent(event, contentID)

    def _onLoading(self, *args, **kwargs):
        super(RewardScreenView, self)._onLoading(*args, **kwargs)
        self.viewModel.onRecruitBtnClick += self.__onRecruitBtnClick
        self.viewModel.onSoundBtnClick += self.__onSoundBtnClick
        self.viewModel.onClose += self.__onClose
        self.__fillViewModel()

    def _initialize(self):
        super(RewardScreenView, self)._initialize()
        if self.__screenType == RewardScreenViewModel.TYPE_SHOW_CREW:
            SoundGroups.g_instance.playSound2D(RewardsEvents.CREW_ENTER)
        else:
            SoundGroups.g_instance.playSound2D(RewardsEvents.REWARDS_ENTER)

    def _finalize(self):
        self.viewModel.onClose -= self.__onClose
        self.viewModel.onRecruitBtnClick -= self.__onRecruitBtnClick
        self.viewModel.onSoundBtnClick -= self.__onSoundBtnClick
        if self.__screenType == RewardScreenViewModel.TYPE_SHOW_CREW:
            SoundGroups.g_instance.playSound2D(RewardsEvents.CREW_EXIT)
        else:
            SoundGroups.g_instance.playSound2D(RewardsEvents.REWARDS_EXIT)
        super(RewardScreenView, self)._finalize()

    def __fillBonuses(self, model):
        rewardModels = model.getRewards()
        rewardModels.clear()
        for bonus in self.__bonuses:
            _, bType, bID, count = bonus
            rewardItem = RewardModel()
            bName = self.__getBonusName(bType, bID)
            rewardItem.setName(bName)
            if bType == HWBonusesType.DECAL:
                item = self.c11n.getItemByID(GUI_ITEM_TYPE.PROJECTION_DECAL, bID)
                rewardItem.setIconName(getTextureLinkByID(item.texture))
            elif bType == HWBonusesType.EQUIPMENT:
                rewardItem.setName(bID.descriptor.groupName)
                rewardItem.setLabelCount(('x{}').format(count))
                rewardItem.setDescription(bID.shortUserName)
            elif bType == HWBonusesType.CRYSTAL:
                rewardItem.setDescription(backport.text(R.strings.hw_lobby.rewardScreen.reward.crystal(), value=count))
            rewardItem.setTooltipId(bType)
            rewardModels.addViewModel(rewardItem)

        rewardModels.invalidate()

    def __getBonusName(self, bType, bID):
        name = bType
        if bType == HWBonusesType.BADGE:
            name = ('{}{}').format(HWBonusesType.BADGE, bID)
        elif bType == HWBonusesType.MEDAL:
            name = bID
        elif bType == HWBonusesType.TANKMAN:
            groupName = bID.split(':')[3]
            name = ('{}_{}').format(HWBonusesType.TANKMAN, groupName)
        return name

    def __getRandomBoosterType(self):
        boostersInfo = self.__phase.getBoosters()
        if not boostersInfo:
            return ''
        return boostersInfo[0].bonusName

    def __onClose(self):
        self.destroyWindow()

    def __onRecruitBtnClick(self):
        tokenID = self.__phase.getTmanTokenBonus()
        if tokenID:
            showRecruitWindow(tokenID)
        self.destroyWindow()

    def __onSoundBtnClick(self):
        SoundGroups.g_instance.playSound2D(HANGAR_WITCHES_VO_PREVIEW)

    def __fillViewModel(self):
        with self.viewModel.transaction() as (model):
            model.setScreenType(self.__screenType)
            if self.__screenType == RewardScreenViewModel.TYPE_SHOW_CREW:
                crew = self.__getCrewInfo()
                crewListModels = model.crewListBlock.getCrewList()
                crewListModels.clear()
                for num in sorted(crew):
                    itemModel = CrewItemModel()
                    itemModel.setId(num)
                    role, group = crew[num]
                    itemModel.setRole(role)
                    itemModel.setGroup(group)
                    itemModel.setIsAvailable(True)
                    crewListModels.addViewModel(itemModel)

            else:
                if self.__screenType == RewardScreenViewModel.TYPE_ONE_WITCH:
                    crew = self.__getCrewInfo()
                    role, group = crew[self.__phase.phaseIndex]
                    model.setCrewRole(role)
                    model.setCrewGroup(group)
                elif self.__screenType == RewardScreenViewModel.TYPE_XP_ACHIEVEMENT:
                    quest = self.eventsCache.getAllQuests().get(GLOBAL_PROGRESS_HW_XP_QUEST)
                    info = getProgressInfo(quest)
                    model.setCondition(info['totalProgress'])
                self.__fillBonuses(model)

    def __getCrewInfo(self):
        crew = {}
        phases = self.hwController.phasesHalloween.getPhasesByType(PhaseType.REGULAR)
        for phase in phases:
            tankmanTokenArgs = phase.getTmanTokenBonus().split(':')
            if not tankmanTokenArgs:
                continue
            groupName = tankmanTokenArgs[3]
            group = findFirst(lambda g, name=groupName: g.name == name, tankmen.getNationGroups(0, isPremium=True).itervalues())
            roles = group.rolesList
            if not roles:
                continue
            crew[phase.phaseIndex] = (
             roles[0], groupName)

        return crew

    def __createSimpleTooltip(self, event, header='', body=''):
        window = DecoratedTooltipWindow(content=SimpleTooltipContent(R.views.common.tooltip_window.simple_tooltip_content.SimpleTooltipContent(), body=body, header=header), parent=self.getParentWindow())
        window.load()
        window.move(event.mouse.positionX, event.mouse.positionY)
        return window

    def __tankmanTooltip(self, event):
        content = CrewTooltip(self.__phase.phaseIndex)
        window = ToolTipWindow(event, content, self.getParentWindow())
        window.load()
        window.move(event.mouse.positionX, event.mouse.positionY)
        return window

    def __customizationTooltip(self, customizationType):
        for bonus in self.__bonuses:
            _, bType, bID, _ = bonus
            if bType != customizationType:
                continue
            itemTypeID = GUI_ITEM_TYPE.PROJECTION_DECAL if bType == HWBonusesType.DECAL else GUI_ITEM_TYPE_INDICES.get(bType)
            item = self.c11n.getItemByID(itemTypeID, bID)
            window = BackportTooltipWindow(createTooltipData(isSpecial=True, specialAlias=TOOLTIPS_CONSTANTS.TECH_CUSTOMIZATION_ITEM_AWARD, specialArgs=CustomizationTooltipContext(itemCD=item.intCD, showInventoryBlock=True)), self.getParentWindow())
            window.load()
            return window

    def __badgeTooltip(self, badgeID):
        bID = badgeID.replace(HWBonusesType.BADGE, '')
        window = backport.BackportTooltipWindow(backport.createTooltipData(isSpecial=True, specialAlias=HWTooltips.HW_BADGE, specialArgs=[
         int(bID)]), self.getParentWindow())
        window.load()
        return window

    def __achievementTooltip(self, block, name):
        window = backport.BackportTooltipWindow(backport.createTooltipData(isSpecial=True, specialAlias=TOOLTIPS_CONSTANTS.BATTLE_STATS_ACHIEVS, specialArgs=[
         block, name]), self.getParentWindow())
        window.load()
        return window

    def __equipmentTooltip(self, equipmentName=None):
        eq = self.__getEquipmentByName(equipmentName)
        if eq is not None:
            window = BackportTooltipWindow(createTooltipData(isSpecial=True, specialAlias=TOOLTIPS_CONSTANTS.AWARD_MODULE, specialArgs=[
             eq.compactDescr]), self.getParentWindow())
            window.load()
            return window
        else:
            return

    def __getEquipmentByName(self, name):
        cache = vehicles.g_cache
        equipmentID = cache.equipmentIDs().get(name)
        if equipmentID is None:
            return
        else:
            return cache.equipments()[equipmentID]


class RewardScreenWindow(LobbyNotificationWindow):
    __slots__ = ('__params', )

    def __init__(self, data, bonuses):
        self.__params = dict(data=data, bonuses=bonuses)
        super(RewardScreenWindow, self).__init__(content=RewardScreenView(**self.__params))

    def isParamsEqual(self, *args, **kwargs):
        return all(pValue in args or kwargs.get(pName) == pValue for pName, pValue in self.__params.iteritems())