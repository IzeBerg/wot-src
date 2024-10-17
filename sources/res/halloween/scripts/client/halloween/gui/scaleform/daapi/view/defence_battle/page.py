from halloween.gui.scaleform.daapi.view.battle.indicators import hwCreateDamageIndicator
from halloween.gui.scaleform.daapi.view.battle.page import HalloweenBattlePage
from gui.Scaleform.daapi.view.battle.classic.page import DynamicAliases
from gui.Scaleform.daapi.view.battle.shared import drone_music_player, finish_sound_player
from gui.Scaleform.daapi.view.battle.shared.indicators import createPredictionIndicator
from gui.Scaleform.daapi.view.battle.shared.page import ComponentsConfig
from gui.Scaleform.daapi.view.battle.shared.start_countdown_sound_player import StartCountdownSoundPlayer
from gui.Scaleform.genConsts.BATTLE_VIEW_ALIASES import BATTLE_VIEW_ALIASES
from gui.battle_control.battle_constants import BATTLE_CTRL_ID
from halloween.gui.scaleform.daapi.view.battle.players_panel import HWPlayersPanel
from halloween.gui.scaleform.genConsts.HALLOWEEN_BATTLE_VIEW_ALIASES import HALLOWEEN_BATTLE_VIEW_ALIASES as HW_ALIASES

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
          BATTLE_CTRL_ID.PERKS, (BATTLE_VIEW_ALIASES.SITUATION_INDICATORS,)),
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
          BATTLE_CTRL_ID.AMMO,
          (
           BATTLE_VIEW_ALIASES.CONSUMABLES_PANEL,)),
         (
          BATTLE_CTRL_ID.HIT_DIRECTION,
          (
           BATTLE_VIEW_ALIASES.PREDICTION_INDICATOR, BATTLE_VIEW_ALIASES.HIT_DIRECTION)),
         (
          BATTLE_CTRL_ID.BATTLE_HINTS,
          (
           BATTLE_VIEW_ALIASES.BATTLE_HINT,
           HW_ALIASES.PINNABLE_BATTLE_HINT,
           HW_ALIASES.PROGRESS_BAR_BATTLE_HINT))), viewsConfig=(
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
_POSTMORTEM_HIDE_VIEW = {
 HW_ALIASES.POINT_COUNTER, BATTLE_VIEW_ALIASES.BATTLE_DAMAGE_LOG_PANEL, BATTLE_VIEW_ALIASES.CONSUMABLES_PANEL}

class HalloweenDefenceBattlePage(HalloweenBattlePage):
    CONFIG = _CONFIG
    EXTENDED_CONFIG = _EXTENDED_CONFIG
    POSTMORTEM_HIDE_VIEW = _POSTMORTEM_HIDE_VIEW