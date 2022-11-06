from battle_results_constants import BATTLE_RESULT_ENTRY_TYPE as ENTRY_TYPE
BATTLE_RESULTS = [
 (
  'hwXP', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_ALL),
 (
  'hwXP', int, 0, None, 'sum', ENTRY_TYPE.ACCOUNT_SELF),
 (
  'hwConsumedAmmo', list, [], None, 'skip', ENTRY_TYPE.SERVER),
 (
  'hwBaseCaptured', list, [], None, 'any', ENTRY_TYPE.VEHICLE_ALL),
 (
  'hw_phase', int, 0, None, 'any', ENTRY_TYPE.ACCOUNT_SELF),
 (
  'hw_quest_progress', dict, {}, None, 'joinDicts', ENTRY_TYPE.ACCOUNT_SELF)]