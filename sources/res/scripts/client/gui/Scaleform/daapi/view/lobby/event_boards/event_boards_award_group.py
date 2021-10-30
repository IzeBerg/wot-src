from gui.Scaleform.daapi.view.meta.AwardGroupsMeta import AwardGroupsMeta
import Event

class EventBoardsAwardGroup(AwardGroupsMeta):

    def __init__(self):
        super(EventBoardsAwardGroup, self).__init__()
        self.onShowRewardCategory = Event.Event()

    def showGroup(self, groupId):
        self.onShowRewardCategory(groupId)

    def setActiveRewardGroup(self, groupID):
        self.as_setSelectedS(groupID - 1, True)