from battle_results.battle_results_constants import BATTLE_RESULT_ENTRY_TYPE as ENTRY_TYPE
from cosmic_event_common.cosmic_event_common import ScoreEvents
BATTLE_RESULTS = [
 (
  'cosmicTotalScore', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_ALL),
 (
  'cosmicScore/SHOT', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_ALL),
 (
  'cosmicScore/RAMMING', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_ALL),
 (
  'cosmicScore/KILL_ASSIST', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_ALL),
 (
  'cosmicScore/KILL', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_ALL),
 (
  'cosmicScore/ABILITY_PICKUP', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_ALL),
 (
  'cosmicScore/ABILITY_HIT', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_ALL),
 (
  'cosmicScore/FRAGMENT_PICKUP', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_ALL),
 (
  'cosmicScore/FRAGMENT_CARRYING', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_ALL),
 (
  'cosmicScore/FRAGMENT_DELIVERING', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_ALL),
 (
  'cosmicScore/FRAGMENT_HOLDER_KILL', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_ALL),
 (
  'cosmicScore/EVACUATION', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_ALL),
 (
  'cosmicBattleEvent/SHOT', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_ALL),
 (
  'cosmicBattleEvent/RAMMING', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_ALL),
 (
  'cosmicBattleEvent/KILL_ASSIST', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_ALL),
 (
  'cosmicBattleEvent/KILL', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_ALL),
 (
  'cosmicBattleEvent/ABILITY_PICKUP', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_ALL),
 (
  'cosmicBattleEvent/ABILITY_HIT', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_ALL),
 (
  'cosmicBattleEvent/FRAGMENT_PICKUP', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_ALL),
 (
  'cosmicBattleEvent/FRAGMENT_CARRYING', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_ALL),
 (
  'cosmicBattleEvent/FRAGMENT_DELIVERING', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_ALL),
 (
  'cosmicBattleEvent/FRAGMENT_HOLDER_KILL', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_ALL),
 (
  'cosmicBattleEvent/LAST_OWN_KILLER_ELIMINATIONS_COUNT', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_SELF),
 (
  'cosmicBattleEvent/SCORE_LEADER_HIT_COUNT', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_SELF),
 (
  'cosmicBattleEvent/EVACUATION', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_ALL),
 (
  'cosmicBattleEvent/EVACUATION_SUCCESS', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_SELF),
 (
  'cosmicEquipment/2458107', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_SELF),
 (
  'cosmicEquipment/2458619', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_SELF),
 (
  'cosmicEquipment/2459899', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_SELF),
 (
  'cosmicAbilitiesImpacts/VORTEX', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_SELF),
 (
  'cosmicAbilitiesImpacts/REPULSOR', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_SELF),
 (
  'cosmicAbilitiesImpacts/GRAVITY_FIELD', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_SELF),
 (
  'cosmicAbilitiesImpacts/SNIPER_SHOT', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_SELF),
 (
  'cosmicAbilitiesImpacts/JUMP', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_SELF),
 (
  'cosmicAbilitiesImpacts/MINES', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_SELF),
 (
  'cosmicAbilitiesUsage/TOTAL', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_SELF)]
BATTLE_RESULTS_NAMES = set([ i[0] for i in BATTLE_RESULTS ])
SCORE_EVENT_NAMES = set([ 'cosmicScore/' + i.name for i in ScoreEvents ])
BATTLE_EVENT_NAMES = set([ 'cosmicBattleEvent/' + i.name for i in ScoreEvents ])