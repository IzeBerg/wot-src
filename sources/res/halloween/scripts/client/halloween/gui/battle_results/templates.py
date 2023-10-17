from gui.battle_results.components import base
from gui.battle_results.components.details import GainCreditsValueInBattleItem
from gui.battle_results.components.progress import QuestsProgressBlock
from gui.battle_results.templates import regular
from halloween.gui.battle_results import components as ex
from gui.battle_results.settings import BATTLE_RESULTS_RECORD as _RECORD
HW_TOTAL_VO_META = base.DictMeta({'common': {}, 'hwPhase': 0, 
   'hwPhasesCount': 0, 
   'players': [], 'quests': None, 
   'rewards': {}})
HW_TEAM_ITEM_VO_META = base.PropertyMeta((
 ('playerDBID', 0, 'playerDBID'),
 ('playerName', '', 'playerName'),
 ('vehicleName', '', 'vehicleName'),
 ('vehicleType', '', 'vehicleType'),
 ('vehicleCD', 0, 'vehicleCD'),
 ('vehicleLvl', -1, 'vehicleLvl'),
 ('clanAbbrev', '', 'clanAbbrev'),
 ('artefactKeys', 0, 'artefactKeys'),
 (
  'isPlayer', False, 'isPlayer'),
 ('squadID', 0, 'squadID'),
 (
  'isOwnSquad', False, 'isOwnSquad'),
 ('killerName', '', 'killerName'),
 ('deathReason', -1, 'deathReason'),
 ('kills', 0, 'kills'),
 ('damageDealt', 0, 'damageDealt'),
 ('soulsDelivered', 0, 'soulsDelivered'),
 ('badgeID', 0, 'badgeID'),
 ('badgeSuffixID', 0, 'badgeSuffixID'),
 (
  'isAfk', False, 'isAfk')))
HW_TEAM_ITEM_VO_META.bind(ex.HWVehicleStatsBlock)
HW_TOTAL_RESULTS_BLOCK = base.StatsBlock(HW_TOTAL_VO_META, 'hwVictoryData')
HW_PERSONAL_REWARDS_VO_META = base.DictMeta({'credits': 0, 
   'effectivenessKeys': 0, 
   'bossKeys': 0})
HW_PERSONAL_REWARDS_BLOCK = base.StatsBlock(HW_PERSONAL_REWARDS_VO_META, 'rewards')
HW_PERSONAL_REWARDS_BLOCK.addNextComponent(GainCreditsValueInBattleItem('credits', _RECORD.PERSONAL))
HW_PERSONAL_REWARDS_BLOCK.addNextComponent(ex.HwEffectivenessArtefactKeysItem('effectivenessKeys', _RECORD.PERSONAL))
HW_PERSONAL_REWARDS_BLOCK.addNextComponent(ex.HwBossArtefactKeysItem('bossKeys', _RECORD.PERSONAL))
HW_BATTLE_COMMON_STATS_BLOCK = regular.REGULAR_COMMON_STATS_BLOCK.clone(7)
regular.FINISH_RESULT_VO_META.bind(ex.HWBattleFinishResultBlock)
HW_TOTAL_RESULTS_BLOCK.addNextComponent(HW_BATTLE_COMMON_STATS_BLOCK)
HW_BATTLE_COMMON_STATS_BLOCK.addComponent(7, ex.HWBattleFinishResultBlock())
HW_TOTAL_RESULTS_BLOCK.addNextComponent(ex.HwPhaseItem('hwPhase', _RECORD.PERSONAL))
HW_TOTAL_RESULTS_BLOCK.addNextComponent(ex.HwPhasesCountItem('hwPhasesCount', _RECORD.PERSONAL))
HW_TOTAL_RESULTS_BLOCK.addNextComponent(ex.HWBattlesTeamStatsBlock(base.ListMeta(), 'players', _RECORD.VEHICLES))
HW_TOTAL_RESULTS_BLOCK.addNextComponent(QuestsProgressBlock(base.ListMeta(), 'quests', _RECORD.PERSONAL))
HW_TOTAL_RESULTS_BLOCK.addNextComponent(HW_PERSONAL_REWARDS_BLOCK)