import typing
from visual_script.type import VScriptEnum
from constants import EQUIPMENT_STAGES, EQUIPMENT_ERROR_STATES

class Stage(VScriptEnum):

    @classmethod
    def vs_name(cls):
        return 'EquipmentStagesT'

    @classmethod
    def vs_enum(cls):
        return EQUIPMENT_STAGES


class EquipmentErrorState(VScriptEnum):

    @classmethod
    def vs_name(cls):
        return 'EquipmentErrorStatesT'

    @classmethod
    def vs_enum(cls):
        return EQUIPMENT_ERROR_STATES