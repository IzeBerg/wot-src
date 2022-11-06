from constants import QUEUE_TYPE
from gui.prb_control.dispatcher import g_prbLoader
from gui.prb_control.entities.base.ctx import PrbAction
from gui.prb_control.settings import PREBATTLE_ACTION_NAME
from gui.shared.event_dispatcher import showHangar
from helpers import dependency
from skeletons.gui.game_control import IEpicBattleMetaGameController
from web.web_client_api import w2c, W2CSchema

class OpenFrontLinePagesMixin(object):
    __epicController = dependency.descriptor(IEpicBattleMetaGameController)

    @w2c(W2CSchema, 'frontline_hangar')
    def selectMode(self, _):
        result = False
        dispatcher = g_prbLoader.getDispatcher()
        if dispatcher is not None and self.__epicController.isEnabled():
            isPrbActive = dispatcher.getFunctionalState().isInPreQueue(QUEUE_TYPE.EPIC)
            if not isPrbActive:
                actionName = PREBATTLE_ACTION_NAME.EPIC
                result = yield dispatcher.doSelectAction(PrbAction(actionName))
            else:
                result = isPrbActive
            if result:
                showHangar()
        yield {'success': result}
        return