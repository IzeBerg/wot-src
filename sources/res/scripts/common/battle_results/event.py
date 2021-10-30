from battle_results_constants import BATTLE_RESULT_ENTRY_TYPE as ENTRY_TYPE
from DictPackers import ValueReplayPacker
BATTLE_RESULTS = [
 (
  'eventPoints', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_ALL),
 (
  'eventPointsLeft', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_ALL),
 (
  'eventPointsTotal', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_ALL),
 (
  'environmentID', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_ALL),
 (
  'difficultyLevel', int, 0, None, 'any', ENTRY_TYPE.VEHICLE_ALL),
 (
  'eventAFKViolator', bool, False, None, 'skip', ENTRY_TYPE.VEHICLE_ALL),
 (
  'eventAFKBanned', bool, False, None, 'skip', ENTRY_TYPE.VEHICLE_ALL),
 (
  'hwRewardBoxKeys', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_ALL),
 (
  'hwRewardBoxBossKeys', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_ALL),
 (
  'hwTeamFightPlace', int, -1, None, 'any', ENTRY_TYPE.VEHICLE_ALL),
 (
  'hwBossFightPlace', int, -1, None, 'any', ENTRY_TYPE.VEHICLE_ALL)]