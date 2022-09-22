from visual_script.misc import ASPECT
from visual_script.registrar import VSBlockRegistrar
import example, general, vehicle_blocks, qa_blocks, qa_education_blocks, balance, entity_blocks, ability_common
g_blockRegistrar = VSBlockRegistrar(ASPECT.CLIENT, ASPECT.SERVER)
g_blockRegistrar.regBlocksFromModule(example)
g_blockRegistrar.regTypesFromModule(example)
g_blockRegistrar.regBlocksFromModule(qa_blocks)
g_blockRegistrar.regBlocksFromModule(qa_education_blocks)
g_blockRegistrar.regBlocksFromModule(balance)
g_blockRegistrar.regTypesFromModule(balance)
g_blockRegistrar.regBlocksFromModule(general)
g_blockRegistrar.regBlocksFromModule(vehicle_blocks)
g_blockRegistrar.regBlocksFromModule(entity_blocks)
g_blockRegistrar.regType(ability_common.Stage)