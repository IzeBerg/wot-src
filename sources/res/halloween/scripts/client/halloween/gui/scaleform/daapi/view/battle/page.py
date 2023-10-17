import BigWorld
from debug_utils import LOG_DEBUG
from constants import ARENA_PERIOD
from gui.Scaleform.daapi.view.battle.classic.page import DynamicAliases
from gui.Scaleform.daapi.view.battle.shared import drone_music_player, finish_sound_player
from gui.Scaleform.daapi.view.battle.shared.indicators import createPredictionIndicator, _DamageIndicator
from gui.Scaleform.daapi.view.battle.shared.page import ComponentsConfig
from gui.Scaleform.daapi.view.battle.shared.start_countdown_sound_player import StartCountdownSoundPlayer
from gui.Scaleform.genConsts.BATTLE_VIEW_ALIASES import BATTLE_VIEW_ALIASES
from gui.Scaleform.framework.entities.View import ViewKey
from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
from gui.battle_control import avatar_getter
from gui.battle_control.battle_constants import BATTLE_CTRL_ID, FEEDBACK_EVENT_ID, HIT_INDICATOR_MAX_ON_SCREEN
from gui.impl.gen import R
from halloween.gui.impl.battle.full_stats import FullEventStatsWindow
from halloween.gui.impl.battle.halloween_battle_loading import HalloweenBattleLoadingWindow
from halloween.gui.scaleform.daapi.view.battle.markers2d.manager import HalloweenMarkersManager
from halloween.gui.scaleform.daapi.view.battle.players_panel import HWPlayersPanel
from halloween.gui.scaleform.daapi.view.battle.shared.crosshair import HalloweenCrosshairPanelContainer
from halloween.gui.scaleform.daapi.view.meta.HalloweenBattlePageMeta import HalloweenBattlePageMeta
from halloween.gui.scaleform.genConsts.HALLOWEEN_BATTLE_VIEW_ALIASES import HALLOWEEN_BATTLE_VIEW_ALIASES as HW_ALIASES
from helpers import dependency
from skeletons.gui.impl import IGuiLoader
from PlayerEvents import g_playerEvents

def hwCreateDamageIndicator():

    class HWDamageIndicator(_DamageIndicator):
        _DAMAGE_INDICATOR_SWF = 'halloween|halloweenBattleDamageIndicatorApp.swf'

    return HWDamageIndicator(HIT_INDICATOR_MAX_ON_SCREEN)


class _ComponentsConfig(ComponentsConfig):

    def __init__(self):
        super(_ComponentsConfig, self).__init__((
         (
          BATTLE_CTRL_ID.ARENA_PERIOD,
          (
           BATTLE_VIEW_ALIASES.PREBATTLE_TIMER,
           DynamicAliases.PREBATTLE_TIMER_SOUND_PLAYER,
           BATTLE_VIEW_ALIASES.BATTLE_END_WARNING_PANEL,
           BATTLE_VIEW_ALIASES.HINT_PANEL,
           DynamicAliases.DRONE_MUSIC_PLAYER,
           HW_ALIASES.HW_PLAYERS_PANEL)),
         (
          BATTLE_CTRL_ID.TEAM_BASES,
          (
           BATTLE_VIEW_ALIASES.TEAM_BASES_PANEL,
           DynamicAliases.DRONE_MUSIC_PLAYER)),
         (
          BATTLE_CTRL_ID.CALLOUT, (BATTLE_VIEW_ALIASES.CALLOUT_PANEL,)),
         (
          BATTLE_CTRL_ID.MAPS, (BATTLE_VIEW_ALIASES.MINIMAP,)),
         (
          BATTLE_CTRL_ID.DEBUG, (BATTLE_VIEW_ALIASES.DEBUG_PANEL,)),
         (
          BATTLE_CTRL_ID.BATTLE_FIELD_CTRL,
          (
           DynamicAliases.DRONE_MUSIC_PLAYER,
           BATTLE_VIEW_ALIASES.FRAG_CORRELATION_BAR,
           HW_ALIASES.HW_PLAYERS_PANEL)),
         (
          BATTLE_CTRL_ID.ARENA_LOAD_PROGRESS, (DynamicAliases.DRONE_MUSIC_PLAYER,)),
         (
          BATTLE_CTRL_ID.GAME_MESSAGES_PANEL, (BATTLE_VIEW_ALIASES.GAME_MESSAGES_PANEL,)),
         (
          BATTLE_CTRL_ID.PREBATTLE_SETUPS_CTRL,
          (
           BATTLE_VIEW_ALIASES.PREBATTLE_AMMUNITION_PANEL, BATTLE_VIEW_ALIASES.DAMAGE_PANEL)),
         (
          BATTLE_CTRL_ID.AMMO,
          (
           BATTLE_VIEW_ALIASES.PREBATTLE_AMMUNITION_PANEL, BATTLE_VIEW_ALIASES.CONSUMABLES_PANEL)),
         (
          BATTLE_CTRL_ID.HIT_DIRECTION,
          (
           BATTLE_VIEW_ALIASES.PREDICTION_INDICATOR, BATTLE_VIEW_ALIASES.HIT_DIRECTION)),
         (
          BATTLE_CTRL_ID.BATTLE_HINTS,
          (
           HW_ALIASES.BUFF_NOTIFICATION_SYSTEM,
           BATTLE_VIEW_ALIASES.BATTLE_HINT,
           HW_ALIASES.PINNABLE_BATTLE_HINT))), viewsConfig=(
         (
          DynamicAliases.DRONE_MUSIC_PLAYER, drone_music_player.DroneMusicPlayer),
         (
          DynamicAliases.PREBATTLE_TIMER_SOUND_PLAYER, StartCountdownSoundPlayer),
         (
          BATTLE_VIEW_ALIASES.PREDICTION_INDICATOR, createPredictionIndicator),
         (
          BATTLE_VIEW_ALIASES.HIT_DIRECTION, hwCreateDamageIndicator),
         (
          HW_ALIASES.HW_PLAYERS_PANEL, HWPlayersPanel)))


_CONFIG = _ComponentsConfig()
_EXTENDED_CONFIG = _CONFIG + ComponentsConfig(config=(
 (
  BATTLE_CTRL_ID.ARENA_PERIOD, (DynamicAliases.FINISH_SOUND_PLAYER,)),
 (
  BATTLE_CTRL_ID.TEAM_BASES, (DynamicAliases.FINISH_SOUND_PLAYER,)),
 (
  BATTLE_CTRL_ID.BATTLE_FIELD_CTRL, (DynamicAliases.FINISH_SOUND_PLAYER,))), viewsConfig=(
 (
  DynamicAliases.FINISH_SOUND_PLAYER, finish_sound_player.FinishSoundPlayer),))
_EXTERNAL_COMPONENTS = (
 HalloweenCrosshairPanelContainer, HalloweenMarkersManager)
_POSTMORTEM_HIDE_VIEW = {
 BATTLE_VIEW_ALIASES.EVENT_BUFFS_PANEL, HW_ALIASES.POINT_COUNTER, HW_ALIASES.BUFF_NOTIFICATION_SYSTEM,
 BATTLE_VIEW_ALIASES.BATTLE_DAMAGE_LOG_PANEL}

class HalloweenBattlePage(HalloweenBattlePageMeta):

    def __init__(self, components=None, external=_EXTERNAL_COMPONENTS, fullStatsAlias=None):
        if components is None:
            components = _CONFIG if self.sessionProvider.isReplayPlaying else _EXTENDED_CONFIG
        super(HalloweenBattlePage, self).__init__(components=components, external=external, fullStatsAlias=None)
        return

    @property
    def hasTabScreen(self):
        guiLoader = dependency.instance(IGuiLoader)
        view = guiLoader.windowsManager.getViewByLayoutID(R.views.halloween.battle.FullStats())
        return view is not None and not view.getParentWindow().isHidden()

    def _populate(self):
        super(HalloweenBattlePage, self)._populate()
        LOG_DEBUG('-=>> Halloween battle page is created.')

    def _dispose(self):
        super(HalloweenBattlePage, self)._dispose()
        LOG_DEBUG('-=>> Halloween battle page is destroyed.')

    def _switchToPostmortem(self):
        super(HalloweenBattlePage, self)._switchToPostmortem()
        self._setComponentsVisibility(hidden=_POSTMORTEM_HIDE_VIEW)
        if self.hasTabScreen:
            self._setComponentsVisibility(hidden={BATTLE_VIEW_ALIASES.POSTMORTEM_PANEL})
            self._fsToggling.add(BATTLE_VIEW_ALIASES.POSTMORTEM_PANEL)
            self._fsToggling.difference_update(_POSTMORTEM_HIDE_VIEW)

    def _reloadPostmortem(self):
        super(HalloweenBattlePage, self)._reloadPostmortem()
        self._setComponentsVisibility(visible=_POSTMORTEM_HIDE_VIEW)
        if self.hasTabScreen:
            self._fsToggling.discard(BATTLE_VIEW_ALIASES.POSTMORTEM_PANEL)
            self._fsToggling.update(_POSTMORTEM_HIDE_VIEW)

    def _handleGUIToggled(self, event):
        if not self.hasTabScreen:
            self._toggleGuiVisible()

    def _toggleRadialMenu(self, isShown, allowAction=True):
        if self.hasTabScreen:
            return
        super(HalloweenBattlePage, self)._toggleRadialMenu(isShown, allowAction)

    def _toggleFullStats(self, isShown, permanent=None, tabAlias=None):
        manager = self.app.containerManager
        if manager.isModalViewsIsExists():
            return
        else:
            ctrl = self.sessionProvider.shared.calloutCtrl
            if ctrl is not None and ctrl.isRadialMenuOpened():
                return
            if self.hasTabScreen == isShown:
                return
            if isShown:
                if manager.getViewByKey(ViewKey(VIEW_ALIAS.INGAME_MENU)):
                    return
                guiLoader = dependency.instance(IGuiLoader)
                if guiLoader.windowsManager.findWindows(lambda w: w.isModal()):
                    return False
                self.__showBattlePageGFComponent(R.views.halloween.battle.FullStats(), FullEventStatsWindow)
                if not self._fsToggling:
                    self._fsToggling.update(self.as_getComponentsVisibilityS())
                if permanent is not None:
                    self._fsToggling.difference_update(permanent)
                self._setComponentsVisibility(hidden=self._fsToggling)
            else:
                self.__destroyBattlePageGFComponent(R.views.halloween.battle.FullStats())
                self._setComponentsVisibility(visible=self._fsToggling)
                self._fsToggling.clear()
            if self._isInPostmortem:
                self.as_setPostmortemTipsVisibleS(not isShown)
            if isShown:
                self.app.enterGuiControlMode(R.views.halloween.battle.FullStats(), cursorVisible=True, enableAiming=False)
            else:
                self.app.leaveGuiControlMode(R.views.halloween.battle.FullStats())
            return

    def _onBattleLoadingStart(self):
        self._toggleFullStats(isShown=False)
        self._isBattleLoading = True
        if not self._blToggling:
            self._blToggling = set(self.as_getComponentsVisibilityS())
        if not avatar_getter.isObserverSeesAll():
            self._blToggling.add(BATTLE_VIEW_ALIASES.BATTLE_MESSENGER)
        hintPanel = self.getComponent(BATTLE_VIEW_ALIASES.HINT_PANEL)
        if hintPanel and hintPanel.getActiveHint():
            self._blToggling.add(BATTLE_VIEW_ALIASES.HINT_PANEL)
        visible, additionalToggling = set(), set()
        if self.getComponent(BATTLE_VIEW_ALIASES.PREBATTLE_AMMUNITION_PANEL) is not None:
            visible.add(BATTLE_VIEW_ALIASES.PREBATTLE_AMMUNITION_PANEL)
            additionalToggling.add(BATTLE_VIEW_ALIASES.PREBATTLE_AMMUNITION_PANEL)
        self.__showBattlePageGFComponent(R.views.halloween.battle.EventBattleLoading(), HalloweenBattleLoadingWindow)
        self.app.enterGuiControlMode(R.views.halloween.battle.EventBattleLoading(), cursorVisible=True, enableAiming=False)
        self._blToggling.difference_update(additionalToggling)
        self._setComponentsVisibility(visible=visible, hidden=self._blToggling)
        self._blToggling.update(additionalToggling)
        return

    def _onBattleLoadingFinish(self):
        self._toggleFullStats(isShown=False)
        self._handleBattleNotifierVisibility()
        self._isBattleLoading = False
        self.app.leaveGuiControlMode(R.views.halloween.battle.EventBattleLoading())
        self.__destroyBattlePageGFComponent(R.views.halloween.battle.EventBattleLoading())
        self._setComponentsVisibility(visible=self._blToggling)
        self._blToggling.clear()
        for component in self._external:
            component.active(True)

        self.sessionProvider.shared.hitDirection.setVisible(True)
        battleCtx = self.sessionProvider.getCtx()
        periodCtrl = self.sessionProvider.shared.arenaPeriod
        if battleCtx.isPlayerObserver() and periodCtrl.getPeriod() in (ARENA_PERIOD.WAITING, ARENA_PERIOD.PREBATTLE):
            self._setComponentsVisibility(hidden={
             BATTLE_VIEW_ALIASES.DAMAGE_PANEL, BATTLE_VIEW_ALIASES.BATTLE_DAMAGE_LOG_PANEL})
        self._setComponentsVisibility(hidden={BATTLE_VIEW_ALIASES.FRAG_CORRELATION_BAR})
        if BigWorld.player().arena.period != ARENA_PERIOD.BATTLE:
            self._setComponentsVisibility(hidden={HW_ALIASES.HW_PLAYERS_PANEL, HW_ALIASES.PHASE_INDICATOR})

    def _startBattleSession(self):
        super(HalloweenBattlePage, self)._startBattleSession()
        ctrl = self.sessionProvider.shared.feedback
        if ctrl is not None:
            ctrl.onPlayerFeedbackReceived += self.__onPlayerFeedbackReceived
        g_playerEvents.onRoundFinished += self.__onRoundFinished
        g_playerEvents.onArenaPeriodChange += self.__onArenaPeriodChange
        return

    def _stopBattleSession(self):
        ctrl = self.sessionProvider.shared.feedback
        if ctrl is not None:
            ctrl.onPlayerFeedbackReceived -= self.__onPlayerFeedbackReceived
        g_playerEvents.onRoundFinished -= self.__onRoundFinished
        g_playerEvents.onArenaPeriodChange -= self.__onArenaPeriodChange
        super(HalloweenBattlePage, self)._stopBattleSession()
        return

    def __onArenaPeriodChange(self, period, periodEndTime, periodLength, periodAdditionalInfo):
        if period == ARENA_PERIOD.BATTLE:
            self._setComponentsVisibility(visible={HW_ALIASES.HW_PLAYERS_PANEL, HW_ALIASES.PHASE_INDICATOR})

    def __showBattlePageGFComponent(self, layoutID, windowClass):
        guiLoader = dependency.instance(IGuiLoader)
        view = guiLoader.windowsManager.getViewByLayoutID(layoutID)
        if view is not None:
            view.getParentWindow().show()
        else:
            window = windowClass()
            window.load()
        return

    def __destroyBattlePageGFComponent(self, layoutID):
        guiLoader = dependency.instance(IGuiLoader)
        view = guiLoader.windowsManager.getViewByLayoutID(layoutID)
        if view is not None:
            view.destroyWindow()
        return

    def __onPlayerFeedbackReceived(self, feedback):
        for event in feedback:
            eventType = event.getType()
            if eventType == FEEDBACK_EVENT_ID.ENEMY_DAMAGED_HP_PLAYER:
                damageExtra = event.getExtra()
                if damageExtra.isDeathZone():
                    self.as_updateDamageScreenS(True)

    def __onRoundFinished(self, winningTeam, reason, extraData):
        aliases = {
         BATTLE_VIEW_ALIASES.HINT_PANEL, HW_ALIASES.PINNABLE_BATTLE_HINT, BATTLE_VIEW_ALIASES.EVENT_TIMER}
        self._setComponentsVisibility(hidden=aliases)