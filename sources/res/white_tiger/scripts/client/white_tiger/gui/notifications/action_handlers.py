from helpers import dependency
from notification.actions_handlers import NavigationDisabledActionHandler
from skeletons.gui.game_control import IWhiteTigerController
from gui.shop import showBuyLootboxOverlay
from notification.settings import NOTIFICATION_TYPE
from white_tiger.gui.shared import event_dispatcher
from gui.shared import event_dispatcher as shared_events

class _WTEventHandler(NavigationDisabledActionHandler):
    _wtController = dependency.descriptor(IWhiteTigerController)

    @classmethod
    def getNotType(cls):
        return NOTIFICATION_TYPE.MESSAGE

    def _canNavigate(self):
        result = super(_WTEventHandler, self)._canNavigate()
        return self._wtController.isEnabled() and result


class WTOpenPortalsHandler(_WTEventHandler):

    @classmethod
    def getActions(cls):
        return ('wtOpenPortals', )

    def doAction(self, model, entityID, action):
        self._wtController.doSelectEventPrbAndCallback(shared_events.showEventStorageWindow)


class WTOpenCollectionHandler(_WTEventHandler):

    @classmethod
    def getActions(cls):
        return ('wtOpenCollection', )

    def doAction(self, model, entityID, action):
        self._wtController.doSelectEventPrbAndCallback(shared_events.showEventProgressionWindow)


class WTOpenHandler(_WTEventHandler):

    @classmethod
    def getActions(cls):
        return ('wtOpen', )

    def doAction(self, model, entityID, action):
        self._wtController.doSelectEventPrb()


class WTOpenQuestsHandler(_WTEventHandler):

    @classmethod
    def getActions(cls):
        return ('wtOpenQuests', )

    def doAction(self, model, entityID, action):
        self._wtController.doSelectEventPrbAndCallback(event_dispatcher.showEventProgressionWindow)


class WTOpenTicketPurchasingHandler(_WTEventHandler):

    @classmethod
    def getActions(cls):
        return ('wtOpenTicketPurchasing', )

    def doAction(self, model, entityID, action):
        self._wtController.doSelectEventPrbAndCallback(showBuyLootboxOverlay)