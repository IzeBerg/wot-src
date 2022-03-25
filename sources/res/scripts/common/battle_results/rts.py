from battle_results_constants import BATTLE_RESULT_ENTRY_TYPE as ENTRY_TYPE
BATTLE_RESULTS = [
 (
  'teamXP', int, 0, None, 'skip', ENTRY_TYPE.ACCOUNT_SELF),
 (
  'isCommander', bool, False, None, 'skip', ENTRY_TYPE.ACCOUNT_SELF),
 (
  'rtsVehicles', list, [], None, 'skip', ENTRY_TYPE.ACCOUNT_SELF),
 (
  'rts1x7TokensGain', int, 0, None, 'skip', ENTRY_TYPE.ACCOUNT_SELF),
 (
  'rts1x1TokensGain', int, 0, None, 'skip', ENTRY_TYPE.ACCOUNT_SELF),
 (
  'rts1x7TokensWithdraw', int, 0, None, 'skip', ENTRY_TYPE.ACCOUNT_SELF),
 (
  'rts1x1TokensWithdraw', int, 0, None, 'skip', ENTRY_TYPE.ACCOUNT_SELF),
 (
  'supplyDamageDealt', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_ALL),
 (
  'damageReceivedFromSupply', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_ALL),
 (
  'rtsEventPoints', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_ALL),
 (
  'rtsLeaderPoints', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_ALL),
 (
  'spottedSupplies', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_ALL),
 (
  'damagedSupplies', set, set(), None, 'joinSets', ENTRY_TYPE.VEHICLE_ALL),
 (
  'killedSupplies', int, 0, None, 'sum', ENTRY_TYPE.VEHICLE_ALL),
 (
  'damagedTanks', set, set(), None, 'joinSets', ENTRY_TYPE.VEHICLE_ALL),
 (
  'rtsOrdersCount', int, 0, None, 'skip', ENTRY_TYPE.SERVER)]