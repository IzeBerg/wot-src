import Event
from script_component.DynamicScriptComponent import DynamicScriptComponent

class HWVehicleSoulsContainerComponent(DynamicScriptComponent):

    def __init__(self):
        super(HWVehicleSoulsContainerComponent, self).__init__()
        self.onChangeSoulsCount = Event.Event()

    def set_lastCollected(self, _):
        _, reason = self.lastCollected
        self.onChangeSoulsCount(self.souls, reason)

    def onDestroy(self):
        self.onChangeSoulsCount.clear()
        super(HWVehicleSoulsContainerComponent, self).onDestroy()