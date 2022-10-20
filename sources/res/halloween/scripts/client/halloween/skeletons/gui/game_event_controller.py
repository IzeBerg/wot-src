from skeletons.gui.game_control import IGameController

class IHalloweenProgressController(IGameController):
    onQuestsUpdated = None
    onChangeActivePhase = None
    onSyncCompleted = None
    phasesHalloween = None

    def isPostPhase(self):
        raise NotImplementedError