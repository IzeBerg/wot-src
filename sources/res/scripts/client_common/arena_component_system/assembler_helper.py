from battleground.airdrops import AirdropsComponent
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
from arena_components.battle_royale_component import BattleRoyaleComponent
from arena_components.comp7_equipment_component import Comp7EquipmentComponent
COMPONENT_ASSEMBLER = {ARENA_BONUS_TYPE.EPIC_RANDOM: EpicRandomBattleComponentAssembler, 
   ARENA_BONUS_TYPE.EPIC_RANDOM_TRAINING: EpicRandomBattleComponentAssembler, 
   ARENA_BONUS_TYPE.EPIC_BATTLE: EpicBattleComponentAssembler, 
   ARENA_BONUS_TYPE.EPIC_BATTLE_TRAINING: EpicBattleComponentAssembler}
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
   'airDropComponent': (
                      ARENA_BONUS_TYPE_CAPS.LOOT_DROP, AirdropsComponent), 
   'battleRoyaleComponent': (
                           ARENA_BONUS_TYPE_CAPS.BATTLEROYALE, BattleRoyaleComponent), 
   'berserkerEffectComponent': (
                              ARENA_BONUS_TYPE_CAPS.BATTLEROYALE, BerserkerEffectComponent), 
   'comp7EquipmentComponent': (
                             ARENA_BONUS_TYPE_CAPS.COMP7, Comp7EquipmentComponent)}