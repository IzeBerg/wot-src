from battle_results_constants import BATTLE_RESULT_ENTRY_TYPE as ENTRY_TYPE
from DictPackers import ValueReplayPacker, MergeDictPacker, DictPacker
BATTLE_RESULTS = [
 (
  'maxAchievedBRTitle', tuple, (0, 0), None, 'skip', ENTRY_TYPE.ACCOUNT_SELF),
 (
  'brPosInBattle', int, 255, None, 'skip', ENTRY_TYPE.VEHICLE_SELF),
 (
  'battleXPTotal', int, 0, None, 'sum', ENTRY_TYPE.SERVER),
 (
  'modulesDescriptors', list, [], None, 'extend', ENTRY_TYPE.SERVER),
 (
  'achivedLevel', int, 1, None, 'skip', ENTRY_TYPE.VEHICLE_ALL),
 (
  'bpChapter', int, 0, None, 'skip', ENTRY_TYPE.ACCOUNT_ALL),
 (
  'basePointsDiff', int, 0, None, 'skip', ENTRY_TYPE.ACCOUNT_ALL),
 (
  'bpNonChapterPointsDiff', int, 0, None, 'skip', ENTRY_TYPE.ACCOUNT_ALL),
 (
  'sumPoints', int, 0, None, 'skip', ENTRY_TYPE.ACCOUNT_ALL),
 (
  'hasBattlePass', bool, False, None, 'skip', ENTRY_TYPE.ACCOUNT_ALL),
 (
  'battlePassComplete', bool, False, None, 'skip', ENTRY_TYPE.ACCOUNT_ALL),
 (
  'currencies', dict, {},
  MergeDictPacker((
   'brcoin', dict, {},
   MergeDictPacker((
    'count', int, 0, None, 'sum'), (
    'original', int, 0, None, 'sum'), (
    'replay', str, '', ValueReplayPacker(), 'skip'), (
    'premiumFactor100', int, 0, None, 'any'), (
    'premiumPlusFactor100', int, 0, None, 'any'), (
    'premiumVipFactor100', int, 0, None, 'any'), (
    'appliedPremiumFactor100', int, 0, None, 'any'), (
    'subtotal', int, 0, None, 'sum')),
   'joinByEachPacker')),
  'joinByEachPacker', ENTRY_TYPE.VEHICLE_SELF)]