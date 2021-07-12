from visual_script.misc import ASPECT
from visual_script.registrar import VSBlockRegistrar
import example, general, vehicle_blocks, qa_blocks
g_blockRegistrar = VSBlockRegistrar(ASPECT.CLIENT, ASPECT.SERVER)
g_blockRegistrar.regBlocksFromModule(general)
g_blockRegistrar.regBlocksFromModule(vehicle_blocks)
g_blockRegistrar.regBlocksFromModule(qa_blocks)