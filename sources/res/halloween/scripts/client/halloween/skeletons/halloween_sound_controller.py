from skeletons.gui.game_control import IGameController

class IHalloweenSoundController(IGameController):

    def playSoundEvent(self, audioEvent):
        raise NotImplementedError