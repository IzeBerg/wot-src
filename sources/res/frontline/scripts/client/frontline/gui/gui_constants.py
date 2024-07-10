from constants_utils import ConstInjector
from gui.Scaleform.daapi.view.lobby.hangar.header_helpers import flag_constants

class QuestFlagTypes(flag_constants.QuestFlagTypes, ConstInjector):
    _const_type = str
    EPIC = 'epicQuests'