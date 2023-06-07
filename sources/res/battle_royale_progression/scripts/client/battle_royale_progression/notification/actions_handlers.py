from battle_royale_progression.gui.shared.event_dispatcher import showProgressionView
from notification.actions_handlers import NavigationDisabledActionHandler
from notification.settings import NOTIFICATION_TYPE

class ShowBRProgressionActionHandler(NavigationDisabledActionHandler):

    def doAction(self, model, entityID, action):
        showProgressionView()

    @classmethod
    def getNotType(cls):
        return NOTIFICATION_TYPE.MESSAGE

    @classmethod
    def getActions(cls):
        return ('showBattleRoyaleProgression', )