from constants import IS_UE_EDITOR, IS_VS_EDITOR
from visual_script.misc import ASPECT
from visual_script.registrar import VSBlockRegistrar
from contexts.sound_notifications_context import SoundNotificationsContext
from contexts.cgf_context import CGFGameObjectContext
from contexts.ability_context import AbilityContextClient
g_blockRegistrar = VSBlockRegistrar(ASPECT.CLIENT, ASPECT.HANGAR)

def registerContext():
    g_blockRegistrar.regContext(SoundNotificationsContext)
    g_blockRegistrar.regContext(CGFGameObjectContext)


def registerForGeneral():
    g_blockRegistrar.regContext(SoundNotificationsContext)
    g_blockRegistrar.regContext(CGFGameObjectContext)
    registerContext()
    import arena_blocks, vehicle_blocks, scene_blocks, event_platform_blocks, triggers_blocks, hint_blocks, marker_blocks, player_blocks, sound_blocks, game_settings_blocks, hangar_blocks, battle_hud_block, cgf_blocks, bitmask_blocks, new_year_blocks
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
    g_blockRegistrar.regBlocksFromModule(bitmask_blocks)
    g_blockRegistrar.regBlocksFromModule(hangar_blocks)
    g_blockRegistrar.regBlocksFromModule(hint_blocks)
    g_blockRegistrar.regBlocksFromModule(new_year_blocks)


g_blockRegistrar.regContext(AbilityContextClient)

def registerForUEEditor():
    registerContext()


def registerForVSEditor():
    registerForGeneral()


def registerForClient():
    registerForGeneral()
    from visual_script_client import client_perk_blocks
    g_blockRegistrar.regBlocksFromModule(client_perk_blocks)


if IS_UE_EDITOR:
    registerForUEEditor()
elif IS_VS_EDITOR:
    registerForVSEditor()
else:
    registerForClient()