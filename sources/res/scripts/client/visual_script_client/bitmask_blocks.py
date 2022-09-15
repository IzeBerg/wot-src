from visual_script.bitmask_blocks_common import BitMaskBase
from visual_script.misc import ASPECT
from constants import EQUIPMENT_ERROR_STATES

class BitMask(BitMaskBase):
    _MASK_TYPES = {'Equipment ErrorStates': EQUIPMENT_ERROR_STATES}

    @classmethod
    def blockAspects(cls):
        return [ASPECT.CLIENT]