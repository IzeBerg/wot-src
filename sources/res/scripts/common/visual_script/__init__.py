from visual_script.misc import ASPECT
from visual_script.registrar import VSBlockRegistrar
import example, general, vehicle_blocks, qa_blocks, entity_blocks, ability_common, all_vstypes
g_blockRegistrar = VSBlockRegistrar(ASPECT.CLIENT, ASPECT.SERVER)
g_blockRegistrar.regBlocksFromModule(general)
g_blockRegistrar.regBlocksFromModule(vehicle_blocks)
g_blockRegistrar.regBlocksFromModule(qa_blocks)
g_blockRegistrar.regBlocksFromModule(entity_blocks)
g_blockRegistrar.regTypesFromModule(all_vstypes)
g_blockRegistrar.regType(ability_common.Stage)