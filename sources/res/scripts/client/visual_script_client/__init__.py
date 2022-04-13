from constants import IS_EDITOR, IS_VS_EDITOR
from visual_script.misc import ASPECT
from visual_script.registrar import VSBlockRegistrar
from contexts.sound_notifications_context import SoundNotificationsContext
from contexts.cgf_context import CGFGameObjectContext
if not IS_EDITOR:
    import arena_blocks, vehicle_blocks, scene_blocks, event_platform_blocks, triggers_blocks, hint_blocks, marker_blocks, player_blocks, sound_blocks, game_settings_blocks, hangar_blocks, camera_blocks, rts_vehicle_blocks, rts_player_blocks, cgf_blocks
    from visual_script_client import battle_hud_block
g_blockRegistrar = VSBlockRegistrar(ASPECT.CLIENT)
if not IS_EDITOR:
    g_blockRegistrar.regBlocksFromModule(event_platform_blocks)
    g_blockRegistrar.regBlocksFromModule(arena_blocks)
    g_blockRegistrar.regBlocksFromModule(vehicle_blocks)
    g_blockRegistrar.regBlocksFromModule(scene_blocks)
    g_blockRegistrar.regBlocksFromModule(triggers_blocks)
    g_blockRegistrar.regBlocksFromModule(hint_blocks)
    g_blockRegistrar.regBlocksFromModule(marker_blocks)
    g_blockRegistrar.regBlocksFromModule(player_blocks)
    g_blockRegistrar.regBlocksFromModule(sound_blocks)
    g_blockRegistrar.regBlocksFromModule(game_settings_blocks)
    g_blockRegistrar.regBlocksFromModule(battle_hud_block)
    g_blockRegistrar.regBlocksFromModule(cgf_blocks)
    g_blockRegistrar.regBlocksFromModule(rts_vehicle_blocks)
    g_blockRegistrar.regBlocksFromModule(rts_player_blocks)
    g_blockRegistrar.regBlocksFromModule(camera_blocks)
g_blockRegistrar.regContext(SoundNotificationsContext)
g_blockRegistrar.regContext(CGFGameObjectContext)
if not IS_VS_EDITOR:
    from visual_script_client import client_perk_blocks
    g_blockRegistrar.regBlocksFromModule(client_perk_blocks)
g_hangarBlockRegistrar = VSBlockRegistrar(ASPECT.HANGAR)
if not IS_EDITOR:
    g_hangarBlockRegistrar.regBlocksFromModule(hangar_blocks)
    g_hangarBlockRegistrar.regBlocksFromModule(hint_blocks)