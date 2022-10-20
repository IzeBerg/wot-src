import BigWorld
from helpers import dependency
from halloween.skeletons.gui.game_event_controller import IHalloweenProgressController

class HWArenaInfoComponent(BigWorld.DynamicScriptComponent):
    _hwController = dependency.descriptor(IHalloweenProgressController)

    def __init__(self):
        super(HWArenaInfoComponent, self).__init__()
        self._hwController.phasesHalloween.setArenaActivePhaseIndex(self.activePhaseIndex)

    def set_activePhaseIndex(self, _):
        self._hwController.phasesHalloween.setArenaActivePhaseIndex(self.activePhaseIndex)