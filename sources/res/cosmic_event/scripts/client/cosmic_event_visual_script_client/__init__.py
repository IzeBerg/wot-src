import player_blocks
from visual_script.misc import ASPECT
from visual_script.registrar import VSBlockRegistrar
g_blockRegistrar = VSBlockRegistrar(ASPECT.CLIENT)
g_blockRegistrar.regBlocksFromModule(player_blocks)