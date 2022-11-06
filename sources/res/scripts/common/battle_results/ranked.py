from battle_results_constants import BATTLE_RESULT_ENTRY_TYPE as ENTRY_TYPE
BATTLE_RESULTS = [
 (
  'updatedRankChange', int, 0, None, 'skip', ENTRY_TYPE.ACCOUNT_SELF),
 (
  'accRank', tuple, (0, 0), None, 'skip', ENTRY_TYPE.ACCOUNT_SELF),
 (
  'vehRank', tuple, (0, 0), None, 'skip', ENTRY_TYPE.ACCOUNT_SELF),
 (
  'prevMaxRank', tuple, (0, 0), None, 'skip', ENTRY_TYPE.ACCOUNT_SELF),
 (
  'prevVehRank', tuple, (0, 0), None, 'skip', ENTRY_TYPE.ACCOUNT_SELF),
 (
  'shields', dict, {}, None, 'skip', ENTRY_TYPE.ACCOUNT_SELF),
 (
  'prevShields', dict, {}, None, 'skip', ENTRY_TYPE.ACCOUNT_SELF),
 (
  'rankedSeason', tuple, (0, 0), None, 'skip', ENTRY_TYPE.ACCOUNT_SELF),
 (
  'rankedSeasonNum', int, 0, None, 'skip', ENTRY_TYPE.ACCOUNT_SELF),
 (
  'bonusBattleUsed', int, 0, None, 'skip', ENTRY_TYPE.ACCOUNT_SELF),
 (
  'efficiencyBonusBattles', int, 0, None, 'skip', ENTRY_TYPE.ACCOUNT_SELF),
 (
  'stepsBonusBattles', int, 0, None, 'skip', ENTRY_TYPE.ACCOUNT_SELF),
 (
  'prevAccRank', tuple, (0, 0), None, 'skip', ENTRY_TYPE.ACCOUNT_ALL),
 (
  'bpChapter', int, 0, None, 'skip', ENTRY_TYPE.ACCOUNT_ALL),
 (
  'basePointsDiff', int, 0, None, 'skip', ENTRY_TYPE.ACCOUNT_ALL),
 (
  'bpNonChapterPointsDiff', int, 0, None, 'skip', ENTRY_TYPE.ACCOUNT_ALL),
 (
  'sumPoints', int, 0, None, 'skip', ENTRY_TYPE.ACCOUNT_ALL),
 (
  'hasBattlePass', bool, False, None, 'skip', ENTRY_TYPE.ACCOUNT_ALL)]