from halloween.gui.halloween_gui_constants import VIEW_ALIAS
from frameworks.wulf import WindowLayer
from gui.app_loader import settings as app_settings
from gui.Scaleform.framework import getSwfExtensionUrl, ViewSettings, ScopeTemplates, ComponentSettings
from gui.Scaleform.framework.package_layout import PackageBusinessHandler
from gui.Scaleform.genConsts.BATTLE_VIEW_ALIASES import BATTLE_VIEW_ALIASES
from gui.shared import EVENT_BUS_SCOPE
from gui.Scaleform.genConsts.BATTLE_CONTEXT_MENU_HANDLER_TYPE import BATTLE_CONTEXT_MENU_HANDLER_TYPE
from halloween.gui.scaleform.genConsts.HALLOWEEN_BATTLE_VIEW_ALIASES import HALLOWEEN_BATTLE_VIEW_ALIASES

def getContextMenuHandlers():
    from gui.Scaleform.daapi.view.battle.classic import player_menu_handler
    return (
     (
      BATTLE_CONTEXT_MENU_HANDLER_TYPE.PLAYERS_PANEL, player_menu_handler.PlayerMenuHandler),)


def getViewSettings():
    from halloween.gui.scaleform.daapi.view.defence_battle.page import HalloweenDefenceBattlePage
    from gui.Scaleform.daapi.view.battle.shared import frag_correlation_bar
    from gui.Scaleform.daapi.view.battle.classic import team_bases_panel
    from gui.Scaleform.daapi.view.battle.classic import battle_end_warning_panel
    from gui.Scaleform.daapi.view.battle.shared import quest_progress_top_view
    from gui.Scaleform.daapi.view.battle.shared import timers_panel
    from halloween.gui.scaleform.daapi.view.battle.phase_indicator import HWPhaseIndicator
    from halloween.gui.scaleform.daapi.view.battle.status_notifications.panel import HWStatusNotificationTimerPanel
    from halloween.gui.scaleform.daapi.view.battle import damage_log_panel
    from halloween.gui.scaleform.daapi.view.battle import ribbons_panel
    from halloween.gui.scaleform.daapi.view.battle.souls_counter_panel import HWSoulsCounter
    from halloween.gui.scaleform.daapi.view.battle import event_timer
    from halloween.gui.scaleform.daapi.view.defence_battle import postmortem_panel
    from halloween.gui.scaleform.daapi.view.battle.minimap.minimap import HalloweenMinimapComponent
    from halloween.gui.scaleform.daapi.view.battle import consumables_panel
    from halloween.gui.scaleform.daapi.view.battle import messages as hw_messages
    from halloween.gui.scaleform.daapi.view.battle import indicators as hw_indicators
    from halloween.gui.scaleform.daapi.view.battle import battle_hint
    from halloween.gui.scaleform.daapi.view.battle import damage_panel
    from halloween.gui.scaleform.daapi.view.battle.players_panel import HWPlayersPanel
    from halloween.gui.scaleform.daapi.view.battle import game_messages_panel
    from halloween.gui.scaleform.daapi.view.battle import battle_timers
    from halloween.gui.scaleform.daapi.view.battle import stats_exchange
    from halloween.gui.scaleform.daapi.view.battle.hint_panel.component import HWBattleHintPanel
    from gui.Scaleform.daapi.view.battle.shared import indicators
    from gui.Scaleform.daapi.view.battle.shared import situation_indicators
    return (
     ViewSettings(VIEW_ALIAS.HALLOWEEN_DEFENCE_BATTLE_PAGE, HalloweenDefenceBattlePage, getSwfExtensionUrl('halloween', 'HalloweenDefenceBattlePage.swf'), WindowLayer.VIEW, None, ScopeTemplates.DEFAULT_SCOPE),
     ViewSettings(BATTLE_VIEW_ALIASES.VEHICLE_MESSAGES, hw_messages.HalloweenVehicleMessages, None, WindowLayer.UNDEFINED, None, None, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(BATTLE_VIEW_ALIASES.BATTLE_DAMAGE_LOG_PANEL, damage_log_panel.HWDamageLogPanel, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(BATTLE_VIEW_ALIASES.BATTLE_STATISTIC_DATA_CONTROLLER, stats_exchange.HWStatisticsDataController, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(BATTLE_VIEW_ALIASES.TEAM_BASES_PANEL, team_bases_panel.TeamBasesPanel, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(BATTLE_VIEW_ALIASES.FRAG_CORRELATION_BAR, frag_correlation_bar.FragCorrelationBar, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(HALLOWEEN_BATTLE_VIEW_ALIASES.HW_PLAYERS_PANEL, HWPlayersPanel, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(BATTLE_VIEW_ALIASES.MINIMAP, HalloweenMinimapComponent, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(BATTLE_VIEW_ALIASES.DAMAGE_PANEL, damage_panel.HalloweenDamagePanel, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(BATTLE_VIEW_ALIASES.TIMERS_PANEL, timers_panel.TimersPanel, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(BATTLE_VIEW_ALIASES.BATTLE_END_WARNING_PANEL, battle_end_warning_panel.BattleEndWarningPanel, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(BATTLE_VIEW_ALIASES.CONSUMABLES_PANEL, consumables_panel.HWConsumablesPanel, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(BATTLE_VIEW_ALIASES.RIBBONS_PANEL, ribbons_panel.HWBattleRibbonsPanel, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(BATTLE_VIEW_ALIASES.GAME_MESSAGES_PANEL, game_messages_panel.HWGameMessagesPanel, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(BATTLE_VIEW_ALIASES.QUEST_PROGRESS_TOP_VIEW, quest_progress_top_view.QuestProgressTopView, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(BATTLE_VIEW_ALIASES.HINT_PANEL, HWBattleHintPanel, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(BATTLE_VIEW_ALIASES.VEHICLE_ERROR_MESSAGES, hw_messages.HalloweenVehicleErrorMessages, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(BATTLE_VIEW_ALIASES.PLAYER_MESSAGES, hw_messages.HalloweenPlayerMessages, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(BATTLE_VIEW_ALIASES.PREBATTLE_TIMER, battle_timers.PreBattleTimer, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(HALLOWEEN_BATTLE_VIEW_ALIASES.PHASE_INDICATOR, HWPhaseIndicator, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(BATTLE_VIEW_ALIASES.STATUS_NOTIFICATIONS_PANEL, HWStatusNotificationTimerPanel, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(HALLOWEEN_BATTLE_VIEW_ALIASES.POINT_COUNTER, HWSoulsCounter, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(BATTLE_VIEW_ALIASES.EVENT_TIMER, event_timer.EventTimer, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(BATTLE_VIEW_ALIASES.POSTMORTEM_PANEL, postmortem_panel.HWDefPostmortemPanel, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(BATTLE_VIEW_ALIASES.SIXTH_SENSE, hw_indicators.HalloweenSixthSenseIndicator, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(BATTLE_VIEW_ALIASES.BATTLE_HINT, battle_hint.BattleHint, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(HALLOWEEN_BATTLE_VIEW_ALIASES.PINNABLE_BATTLE_HINT, battle_hint.BattleHint, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(HALLOWEEN_BATTLE_VIEW_ALIASES.PROGRESS_BAR_BATTLE_HINT, battle_hint.DefenceProgressBarBattleHint, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(BATTLE_VIEW_ALIASES.ROCKET_ACCELERATOR_INDICATOR, indicators.RocketAcceleratorIndicator, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(BATTLE_VIEW_ALIASES.SITUATION_INDICATORS, situation_indicators.SituationIndicators, ScopeTemplates.DEFAULT_SCOPE))


def getBusinessHandlers():
    return (
     _HalloweenDefenceBattlePackageBusinessHandler(),)


class _HalloweenDefenceBattlePackageBusinessHandler(PackageBusinessHandler):
    __slots__ = ()

    def __init__(self):
        listeners = (
         (
          VIEW_ALIAS.HALLOWEEN_DEFENCE_BATTLE_PAGE, self._loadPage),)
        super(_HalloweenDefenceBattlePackageBusinessHandler, self).__init__(listeners, app_settings.APP_NAME_SPACE.SF_BATTLE, EVENT_BUS_SCOPE.BATTLE)

    def _loadPage(self, event):
        page = self.findViewByAlias(WindowLayer.VIEW, event.name)
        if page is not None:
            page.reload()
        else:
            self.loadViewBySharedEvent(event)
        return