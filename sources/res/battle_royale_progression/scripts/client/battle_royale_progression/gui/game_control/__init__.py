from battle_royale_progression.gui.game_control.awards_controller import BRProgressionStageHandler
from battle_royale_progression.gui.game_control.progression_controller import BRProgressionController
from battle_royale_progression.gui.gui_constants import SM_TYPE_BR_PROGRESSION
from chat_shared import SYS_MESSAGE_TYPE
from gui.shared.system_factory import registerAwardControllerHandler, registerGameControllers
from soft_exception import SoftException

def registerBRGameControllers():
    from battle_royale_progression.skeletons.game_controller import IBRProgressionOnTokensController
    registerGameControllers([
     (
      IBRProgressionOnTokensController, BRProgressionController, False)])


def registerBRProgressionAwardControllers():
    try:
        SYS_MESSAGE_TYPE.__getattr__(SM_TYPE_BR_PROGRESSION).index()
    except AttributeError:
        raise SoftException('No index for {attr} found. Use registerSystemMessagesTypes before')

    registerAwardControllerHandler(BRProgressionStageHandler)