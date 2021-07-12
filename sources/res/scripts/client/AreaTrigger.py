import BigWorld, TriggersManager

class AreaTrigger(BigWorld.UserDataObject):

    def __init__(self):
        BigWorld.UserDataObject.__init__(self)
        self.__id = TriggersManager.g_manager.addTrigger(TriggersManager.TRIGGER_TYPE.AREA, name=self.name, position=self.position, radius=self.radius, scale=self.scale, exitInterval=self.exitInterval, direction=self.direction)

    def destroy(self):
        TriggersManager.g_manager.delTrigger(self.__id)