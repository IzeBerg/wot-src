from battleground.airdrops import AirdropsComponent
from battleground.kamikaze_effect import KamikazeActivationEffect
from battleground.berserker_effect import BerserkerEffectComponent
from constants import ARENA_BONUS_TYPE
from arena_component_system.destructible_entity_component import DestructibleEntitiesComponent
from arena_component_system.sector_base_arena_component import SectorBaseArenaComponent
from arena_component_system.sectors_arena_component import SectorsArenaComponent
from arena_component_system.step_repair_point_component import StepRepairPointComponent
from arena_component_system.epic_random_battle_component_assembler import EpicRandomBattleComponentAssembler
from arena_component_system.epic_battle_component_assembler import EpicBattleComponentAssembler
from arena_component_system.protection_zone_component import ProtectionZoneComponent
from arena_bonus_type_caps import ARENA_BONUS_TYPE_CAPS
from arena_components.death_zone_component import BRDeathZoneComponent
from arena_components.battle_royale_component import BattleRoyaleComponent
from arena_component_system.arena_game_event_component import GameEventComponent
from arena_component_system.event_battle_component_assembler import EventBattleComponentAssembler
from arena_components.loot import LootComponent
from arena_components.event_control_point import EventControlPointComponent
from arena_components.hw_personal_deathzones import PersonalDeathZonesComponent
COMPONENT_ASSEMBLER = {ARENA_BONUS_TYPE.EPIC_RANDOM: EpicRandomBattleComponentAssembler, 
   ARENA_BONUS_TYPE.EPIC_RANDOM_TRAINING: EpicRandomBattleComponentAssembler, 
   ARENA_BONUS_TYPE.EPIC_BATTLE: EpicBattleComponentAssembler, 
   ARENA_BONUS_TYPE.EPIC_BATTLE_TRAINING: EpicBattleComponentAssembler, 
   ARENA_BONUS_TYPE.EVENT_BATTLES: EventBattleComponentAssembler}
ARENA_BONUS_TYPE_CAP_COMPONENTS = {'sectorBaseComponent': (
                         ARENA_BONUS_TYPE_CAPS.SECTOR_MECHANICS, SectorBaseArenaComponent), 
   'sectorComponent': (
                     ARENA_BONUS_TYPE_CAPS.SECTOR_MECHANICS, SectorsArenaComponent), 
   'destructibleEntityComponent': (
                                 ARENA_BONUS_TYPE_CAPS.DESTRUCTIBLE_ENTITIES, DestructibleEntitiesComponent), 
   'stepRepairPointComponent': (
                              ARENA_BONUS_TYPE_CAPS.STEP_REPAIR_MECHANIC, StepRepairPointComponent), 
   'protectionZoneComponent': (
                             ARENA_BONUS_TYPE_CAPS.PROTECTION_ZONE, ProtectionZoneComponent), 
   'deathZoneComponent': (
                        ARENA_BONUS_TYPE_CAPS.DEATH_ZONES, BRDeathZoneComponent), 
   'airDropComponent': (
                      ARENA_BONUS_TYPE_CAPS.LOOT_DROP, AirdropsComponent), 
   'kamikazeActivatedComponent': (
                                ARENA_BONUS_TYPE_CAPS.BATTLEROYALE, KamikazeActivationEffect), 
   'battleRoyaleComponent': (
                           ARENA_BONUS_TYPE_CAPS.BATTLEROYALE, BattleRoyaleComponent), 
   'berserkerEffectComponent': (
                              ARENA_BONUS_TYPE_CAPS.BATTLEROYALE, BerserkerEffectComponent), 
   'gameEventComponent': (
                        ARENA_BONUS_TYPE_CAPS.SOULS_SYSTEM, GameEventComponent), 
   'loot': (
          ARENA_BONUS_TYPE_CAPS.DROP_SYSTEM, LootComponent), 
   'ecp': (
         ARENA_BONUS_TYPE_CAPS.EVENT_CONTROL_POINT, EventControlPointComponent), 
   'personalDeathZones': (
                        ARENA_BONUS_TYPE_CAPS.HW_PERSONAL_DEATH_ZONES, PersonalDeathZonesComponent)}