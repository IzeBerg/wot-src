from notification.actions_handlers import NavigationDisabledActionHandler
from notification.settings import NOTIFICATION_TYPE
from winback.gui.shared.event_dispatcher import showProgressionView, showWinbackSelectRewardView

class ShowWinbackProgressionActionHandler(NavigationDisabledActionHandler):

    def doAction(self, model, entityID, action):
        showProgressionView()

    @classmethod
    def getNotType(cls):
        return NOTIFICATION_TYPE.MESSAGE

    @classmethod
    def getActions(cls):
        return ('showWinbackProgression', )


class OpenWinbackSelectableRewardView(NavigationDisabledActionHandler):

    @classmethod
    def getNotType(cls):
        return NOTIFICATION_TYPE.WINBACK_SELECTABLE_REWARD_AVAILABLE

    @classmethod
    def getActions(cls):
        return ('openWinbackSelectableRewardView', )

    def doAction(self, model, entityID, action):
        showWinbackSelectRewardView()


class OpenWinbackSelectableRewardViewFromQuest(OpenWinbackSelectableRewardView):

    @classmethod
    def getNotType(cls):
        return NOTIFICATION_TYPE.MESSAGE