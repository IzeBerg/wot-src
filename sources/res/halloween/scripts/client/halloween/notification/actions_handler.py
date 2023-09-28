from halloween.gui.shared.event_dispatcher import showHalloweenShop
from gui.shared.system_factory import registerNotificationsActionsHandlers
from helpers import dependency
from notification.actions_handlers import ActionHandler
from notification.settings import NOTIFICATION_TYPE
from skeletons.gui.game_control import IHalloweenController

class _selectEventBattleHandler(ActionHandler):
    _eventController = dependency.descriptor(IHalloweenController)

    @classmethod
    def getNotType(cls):
        return NOTIFICATION_TYPE.MESSAGE

    @classmethod
    def getActions(cls):
        return ('selectEventBattle', )

    def handleAction(self, model, entityID, action):
        super(_selectEventBattleHandler, self).handleAction(model, entityID, action)
        self._eventController.selectEventBattle()


class _showHalloweenShop(ActionHandler):

    @classmethod
    def getNotType(cls):
        return NOTIFICATION_TYPE.MESSAGE

    @classmethod
    def getActions(cls):
        return ('showHalloweenShop', )

    def handleAction(self, model, entityID, action):
        super(_showHalloweenShop, self).handleAction(model, entityID, action)
        showHalloweenShop()


_EVENT_ACTION_HANDLERS = [
 _selectEventBattleHandler,
 _showHalloweenShop]

def addHW22ActionHandlers():
    registerNotificationsActionsHandlers(_EVENT_ACTION_HANDLERS)