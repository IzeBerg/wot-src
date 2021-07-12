import BigWorld

class OfflineEntity(BigWorld.Entity):

    def __init__(self):
        pass

    def prerequisites(self):
        return []

    def onEnterWorld(self, prereqs):
        pass

    def onLeaveWorld(self):
        pass


class PlayerOfflineEntity(BigWorld.Entity):
    inputHandler = None

    def __init__(self):
        pass

    def prerequisites(self):
        return []

    def onEnterWorld(self, prereqs):
        pass

    def onLeaveWorld(self):
        pass

    def handleKeyEvent(self, event):
        return False