from battle_results.battle_results_constants import BATTLE_RESULT_ENTRY_TYPE as ENTRY_TYPE
from story_mode_common.story_mode_constants import UNDEFINED_MISSION_ID
BATTLE_RESULTS = [
 (
  'missionId', int, UNDEFINED_MISSION_ID, None, 'skip', ENTRY_TYPE.ACCOUNT_SELF),
 (
  'isForceOnboarding', bool, False, None, 'skip', ENTRY_TYPE.ACCOUNT_SELF)]