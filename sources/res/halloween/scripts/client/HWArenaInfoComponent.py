import BigWorld
from helpers import dependency
from skeletons.gui.game_control import IHalloweenController

class HWArenaInfoComponent(BigWorld.DynamicScriptComponent):
    _hwController = dependency.descriptor(IHalloweenController)

    def __init__(self):
        super(HWArenaInfoComponent, self).__init__()
        self._hwController.phases.setArenaActivePhaseIndex(self.activePhaseIndex)

    def set_activePhaseIndex(self, _):
        self._hwController.phases.setArenaActivePhaseIndex(self.activePhaseIndex)