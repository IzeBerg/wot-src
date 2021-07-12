

class ILinkedSetController(object):
    onStateChanged = None

    def init(self):
        raise NotImplementedError

    def fini(self):
        raise NotImplementedError

    def isLinkedSetEnabled(self):
        raise NotImplementedError

    def isLinkedSetFinished(self):
        raise NotImplementedError

    def hasLinkedSetFinishToken(self):
        raise NotImplementedError

    def isFinalQuest(self, quest):
        raise NotImplementedError

    def getFinalQuest(self):
        raise NotImplementedError

    def getMaxMissionID(self):
        raise NotImplementedError

    def getCompletedButNotShowedQuests(self):
        raise NotImplementedError

    def getMissions(self):
        raise NotImplementedError

    def getMissionByID(self, missionID):
        raise NotImplementedError

    def isBootcampQuest(self, quest):
        raise NotImplementedError

    def getInitialMissionID(self):
        raise NotImplementedError

    def getBonusForBootcampMission(self):
        raise NotImplementedError

    def getCompletedLinkedSetQuests(self, filterFunc=None):
        raise NotImplementedError

    def getLinkedSetQuests(self, filterFunc=None):
        raise NotImplementedError