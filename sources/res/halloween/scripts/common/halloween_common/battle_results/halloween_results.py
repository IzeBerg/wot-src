from battle_results.battle_results_constants import BATTLE_RESULT_ENTRY_TYPE as ENTRY_TYPE
BATTLE_RESULTS = [
 (
  'halloween_phase', int, 0, None, 'skip', ENTRY_TYPE.VEHICLE_ALL),
 (
  'halloween_phases_count', int, 0, None, 'skip', ENTRY_TYPE.VEHICLE_ALL),
 (
  'artefactKeys', tuple, (0, 0), None, 'skip', ENTRY_TYPE.VEHICLE_ALL),
 (
  'hwTeamFightPlace', int, -1, None, 'skip', ENTRY_TYPE.VEHICLE_ALL),
 (
  'hwBossFightPlace', int, -1, None, 'skip', ENTRY_TYPE.VEHICLE_ALL),
 (
  'hwVehiclesRespawnCount', int, 0, None, 'skip', ENTRY_TYPE.VEHICLE_ALL),
 (
  'hwKafkaVehicleStats', dict, {}, None, 'skip', ENTRY_TYPE.SERVER),
 (
  'hwKafkaAvatarStats', dict, {}, None, 'skip', ENTRY_TYPE.SERVER),
 (
  'hwDefBestTime', int, 0, None, 'skip', ENTRY_TYPE.VEHICLE_SELF)]