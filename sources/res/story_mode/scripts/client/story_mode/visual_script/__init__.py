from story_mode.visual_script import voiceover_blocks, ui_blocks
from visual_script.misc import ASPECT
from visual_script.registrar import VSBlockRegistrar
g_blockRegistrar = VSBlockRegistrar(ASPECT.CLIENT, ASPECT.HANGAR)
g_blockRegistrar.regBlocksFromModule(voiceover_blocks)
g_blockRegistrar.regBlocksFromModule(ui_blocks)