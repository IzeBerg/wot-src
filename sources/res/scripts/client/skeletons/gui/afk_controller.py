

class IAFKController(object):
    onBanUpdated = None

    def init(self):
        raise NotImplementedError

    def fini(self):
        raise NotImplementedError

    @property
    def isBanned(self):
        return False

    @property
    def banExpiryTime(self):
        return 0

    def showBanWindow(self):
        raise NotImplementedError

    def showWarningWindow(self):
        raise NotImplementedError

    def showQuest(self):
        raise NotImplementedError

    def questFilter(self, quest):
        raise NotImplementedError

    def showAFKWindows(self):
        raise NotImplementedError