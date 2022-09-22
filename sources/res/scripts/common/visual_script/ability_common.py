from visual_script.type import VScriptEnum
from visual_script.misc import ASPECT
from constants import EQUIPMENT_STAGES as STAGES

class Stage(VScriptEnum):

    @classmethod
    def vs_enum(cls):
        return STAGES

    @classmethod
    def vs_aspects(cls):
        return ASPECT.ALL