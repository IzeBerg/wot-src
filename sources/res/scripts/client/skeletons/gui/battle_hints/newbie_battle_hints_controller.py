import typing

class INewbieBattleHintsController(object):

    def fini(self):
        raise NotImplementedError

    def isEnabled(self):
        raise NotImplementedError

    def isUserSettingEnabled(self):
        raise NotImplementedError

    def getDisplayCount(self, uniqueName):
        raise NotImplementedError

    def resetHistory(self):
        raise NotImplementedError