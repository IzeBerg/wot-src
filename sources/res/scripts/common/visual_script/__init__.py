from visual_script.misc import ASPECT
from visual_script.registrar import VSBlockRegistrar
from constants import IS_DEVELOPMENT
import example, general, vehicle_blocks, qa_blocks, qa_education_blocks
g_blockRegistrar = VSBlockRegistrar(ASPECT.CLIENT, ASPECT.SERVER)
if IS_DEVELOPMENT:
    g_blockRegistrar.regBlocksFromModule(example)
    g_blockRegistrar.regTypesFromModule(example)
    g_blockRegistrar.regBlocksFromModule(qa_blocks)
    g_blockRegistrar.regBlocksFromModule(qa_education_blocks)
    g_blockRegistrar.regBlocksFromModule(general)
g_blockRegistrar.regBlocksFromModule(vehicle_blocks)