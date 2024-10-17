import WWISE
from gui.impl.backport import BackportTooltipWindow, createTooltipData
from gui.impl.lobby.common.tooltips.extended_text_tooltip import ExtendedTextTooltip
from gui.server_events.bonuses import getNonQuestBonuses, mergeBonuses, TokensBonus
from gui.server_events.awards_formatters import AWARDS_SIZES
from gui.battle_results.settings import PLAYER_TEAM_RESULT
from gui.impl.gen import R
from frameworks.wulf import ViewFlags, ViewSettings
from gui.shared.gui_items.Vehicle import VEHICLE_TAGS
from gui.shared.money import Currency
from halloween.gui.game_control.halloween_artefacts_controller import compareBonusesByPriority
from halloween.gui.impl.gen.view_models.views.common.base_team_member_model import TeamMemberBanType
from halloween.gui.impl.gen.view_models.views.lobby.battle_result_view_model import BattleResultViewModel
from halloween.gui.impl.gen.view_models.views.common.bonus_item_view_model import BonusItemViewModel
from halloween.gui.impl.lobby.hw_helpers.bonuses_formatters import HalloweenBonusesAwardsComposer, getHWBattleResultAwardFormatter, getImgName
from halloween.gui.impl.lobby.tooltips.key_tooltip import KeyTooltipView
from halloween.gui.impl.lobby.widgets.battle_result_stats import BattleResultStats
from halloween.gui.sounds import playSound
from halloween.gui.sounds.sound_constants import PBS_ENTER, PBS_EXIT, VO, DefVO, DifficultyState
from halloween.skeletons.halloween_artefacts_controller import IHalloweenArtefactsController
from halloween_common.halloween_constants import ArtefactsSettings, ARENA_BONUS_TYPE_TO_LEVEL, ARENA_BONUS_TYPE
from ids_generators import SequenceIDGenerator
from skeletons.gui.battle_results import IBattleResultsService
from helpers import dependency
from skeletons.gui.game_control import IEventBattlesController
from skeletons.gui.lobby_context import ILobbyContext
from halloween.gui.impl.lobby.base_view import BaseView
from skeletons.account_helpers.settings_core import ISettingsCore
from gui.sounds.ambients import BattleResultsEnv
from skeletons.gui.server_events import IEventsCache
from skeletons.gui.shared import IItemsCache
_R_BACKPORT_TOOLTIP = R.views.common.tooltip_window.backport_tooltip_content.BackportTooltipContent()
_R_KEY_TOOLTIP = R.views.halloween.lobby.tooltips.KeyTooltip()

class BattleResultView(BaseView):
    __slots__ = ('__arenaUniqueID', '__bonusCache', '__idGen', '__tooltipCtx')
    battleResults = dependency.descriptor(IBattleResultsService)
    lobbyContext = dependency.descriptor(ILobbyContext)
    eventBattlesController = dependency.descriptor(IEventBattlesController)
    settingsCore = dependency.descriptor(ISettingsCore)
    hwArtefactCtrl = dependency.descriptor(IHalloweenArtefactsController)
    eventsCache = dependency.descriptor(IEventsCache)
    itemsCache = dependency.descriptor(IItemsCache)
    _MAX_BONUSES_IN_VIEW = 5
    __sound_env__ = BattleResultsEnv

    def __init__(self, layoutID, ctx):
        settings = ViewSettings(layoutID or R.views.halloween.lobby.BattleResultView())
        settings.flags = ViewFlags.VIEW
        settings.model = BattleResultViewModel()
        super(BattleResultView, self).__init__(settings)
        self.__idGen = SequenceIDGenerator()
        self.__bonusCache = {}
        self.__tooltipCtx = {}
        self.__arenaUniqueID = ctx['arenaUniqueID']

    @property
    def viewModel(self):
        return super(BattleResultView, self).getViewModel()

    def createContextMenu(self, event):
        statsView = self.getChildView(R.views.halloween.lobby.widgets.EventStats())
        return statsView.createContextMenu(event)

    def createToolTip(self, event):
        if event.contentID == _R_BACKPORT_TOOLTIP:
            tooltipId = event.getArgument('tooltipId')
            bonus = self.__bonusCache.get(tooltipId)
            if bonus:
                window = BackportTooltipWindow(createTooltipData(tooltip=bonus.tooltip, isSpecial=bonus.isSpecial, specialAlias=bonus.specialAlias, specialArgs=bonus.specialArgs, isWulfTooltip=bonus.isWulfTooltip), self.getParentWindow(), event=event)
                window.load()
                return window
        return super(BattleResultView, self).createToolTip(event)

    def createToolTipContent(self, event, contentID):
        if contentID == _R_KEY_TOOLTIP:
            return KeyTooltipView(isPostBattle=True, ctx=self.__tooltipCtx.get(contentID, {}))
        if contentID == R.views.lobby.common.tooltips.ExtendedTextTooltip():
            text = event.getArgument('text', '')
            stringifyKwargs = event.getArgument('stringifyKwargs', '')
            return ExtendedTextTooltip(text, stringifyKwargs)
        return super(BattleResultView, self).createToolTipContent(event, contentID)

    def _onLoading(self, *args, **kwargs):
        super(BattleResultView, self)._onLoading(*args, **kwargs)
        if self.battleResults.areResultsPosted(self.__arenaUniqueID):
            self.__fillViewModel()
        self.setChildView(resourceID=R.views.halloween.lobby.widgets.EventStats(), view=BattleResultStats(arenaUniqueID=self.__arenaUniqueID))

    def _initialize(self, *args, **kwargs):
        super(BattleResultView, self)._initialize()
        playSound(PBS_ENTER)

    def _finalize(self):
        playSound(PBS_EXIT)
        super(BattleResultView, self)._finalize()

    def _subscribe(self):
        super(BattleResultView, self)._subscribe()
        self.viewModel.onClose += self._onClose

    def _unsubscribe(self):
        self.viewModel.onClose -= self._onClose
        super(BattleResultView, self)._unsubscribe()

    def __fillViewModel(self):
        totalVO = self.battleResults.getResultsVO(self.__arenaUniqueID)
        with self.viewModel.transaction() as (model):
            self.__fillCommonInfo(model, totalVO)
            self.__fillPlayerInfo(model.playerInfo, totalVO)
            self.__fillRewardsInfo(model.getRewards(), totalVO)
            self.__playVoiceover(totalVO)

    def __fillCommonInfo(self, model, totalVO):
        commonVO = totalVO['common']
        model.setIsBossDefeated(commonVO['resultShortStr'] == PLAYER_TEAM_RESULT.WIN)
        model.battleInfo.setStartDate(commonVO['arenaCreateTimeStr'])
        model.battleInfo.setDuration(commonVO['duration'])
        difficulty = ARENA_BONUS_TYPE_TO_LEVEL[commonVO['bonusType']]
        model.setDifficultyLevel(difficulty)
        model.setCurrentPhase(totalVO['hwPhase'])
        model.setTime(totalVO['hwDefTime'])
        model.setBestTime(totalVO['hwDefBestTime'])

    def __fillPlayerInfo(self, playerInfo, totalVO):
        playersVO = totalVO['players']
        personalVO = next((player for player in playersVO if player['isPlayer']), None)
        playerInfo.user.setUserName(personalVO['playerName'])
        playerInfo.user.setClanAbbrev(personalVO['clanAbbrev'])
        playerInfo.vehicle.setVehicleName(personalVO['vehicleName'])
        playerInfo.vehicle.setVehicleShortName(personalVO['vehicleShortName'])
        if personalVO.get('vehicleIsIGR', False):
            playerInfo.vehicle.setTags(VEHICLE_TAGS.PREMIUM_IGR)
        playerInfo.vehicle.setVehicleType(personalVO['vehicleType'])
        vehicleItem = self.itemsCache.items.getItemByCD(personalVO['vehicleCD'])
        playerInfo.vehicle.setVehicleIconName(vehicleItem.name.replace(':', '_'))
        playerInfo.setRespCount(personalVO['hwVehiclesRespawnCount'])
        banType = (personalVO['hasPenalties'] or TeamMemberBanType).NOTBANNED if 1 else TeamMemberBanType.BANNED
        playerInfo.setBanType(banType)
        return

    def __fillRewardsInfo(self, model, totalVO):
        rewardsVO = totalVO['rewards']
        effectivenessKeys = rewardsVO['effectivenessKeys']
        bossKeys = rewardsVO['bossKeys']
        keysBonus = self.__getKeysBonus(effectivenessKeys + bossKeys)
        questBonuses = self.__getQuestBonuses(totalVO['quests'])
        creditsBonus = self.__getCreditsBonus(rewardsVO['credits'])
        totalBonuses = creditsBonus + keysBonus + questBonuses
        dailyKeys = sum(self.__getKeyCountFromTokens(bonus.getTokens()) for bonus in questBonuses if bonus.getName() == 'battleToken')
        self.__tooltipCtx[_R_KEY_TOOLTIP] = {'effective': effectivenessKeys, 
           'boss': bossKeys, 
           'daily': dailyKeys, 
           'isDefenseMode': totalVO['common']['bonusType'] == ARENA_BONUS_TYPE.HALLOWEEN_DEFENCE}
        model.clear()
        sortedBonuses = sorted(mergeBonuses(totalBonuses), cmp=compareBonusesByPriority)
        formatter = HalloweenBonusesAwardsComposer(self._MAX_BONUSES_IN_VIEW, getHWBattleResultAwardFormatter())
        bonusRewards = formatter.getFormattedBonuses(sortedBonuses, AWARDS_SIZES.BIG)
        for bonus in bonusRewards:
            rewardItem = BonusItemViewModel()
            tooltipId = ('{}').format(self.__idGen.next())
            self.__bonusCache[tooltipId] = bonus
            rewardItem.setName(bonus.bonusName)
            rewardItem.setValue(str(bonus.label))
            rewardItem.setIcon(getImgName(bonus.getImage(AWARDS_SIZES.BIG)))
            rewardItem.setTooltipId(tooltipId)
            if isinstance(bonus.tooltip, int):
                rewardItem.setTooltipContentId(str(bonus.tooltip))
            model.addViewModel(rewardItem)

        model.invalidate()

    def __playVoiceover(self, totalVO):
        commonVO = totalVO['common']
        WWISE.WW_setState(DifficultyState.GROUP, DifficultyState.VALUE(commonVO['bonusType']))
        if commonVO['bonusType'] == ARENA_BONUS_TYPE.HALLOWEEN_DEFENCE:
            self.__playDefVO(commonVO)
        else:
            self.__playClassicVO(totalVO)

    def __playClassicVO(self, totalVO):
        commonVO = totalVO['common']
        if commonVO['resultShortStr'] == PLAYER_TEAM_RESULT.WIN:
            VO.WIN.play()
        elif totalVO['hwPhase'] == totalVO['hwPhasesCount']:
            playSound(VO.LOSE_BOSS_FIGHT)
        else:
            playSound(VO.LOSE_BEFORE_BOSS_BATTLE)

    def __playDefVO(self, commonVO):
        if commonVO['resultShortStr'] == PLAYER_TEAM_RESULT.WIN:
            playSound(DefVO.WIN)
        else:
            playSound(DefVO.LOSE)

    def __getLeaderboardPosition(self, players, personal, field):
        leaderboard = sorted(players, key=lambda block: block[field], reverse=True)
        return leaderboard.index(personal) + 1

    def __getCreditsBonus(self, credits):
        if credits > 0:
            return getNonQuestBonuses(Currency.CREDITS, credits)
        return []

    def __getKeysBonus(self, keys):
        if keys > 0:
            return getNonQuestBonuses(TokensBonus.TOKENS, {ArtefactsSettings.KEY_TOKEN: {'count': keys}})
        return []

    def __getQuestBonuses(self, quests):
        questBonuses = []
        for questProgress in quests:
            questID = questProgress['questInfo']['questID']
            quest = self.eventsCache.getAllQuests().get(questID)
            if not quest or not questProgress['awards']:
                continue
            bonuses = quest.getBonuses()
            questBonuses.extend(bonuses)

        return questBonuses

    def __getKeyCountFromTokens(self, tokens):
        artefactKeyToken = tokens.get(ArtefactsSettings.KEY_TOKEN)
        if artefactKeyToken:
            return artefactKeyToken.count
        return 0