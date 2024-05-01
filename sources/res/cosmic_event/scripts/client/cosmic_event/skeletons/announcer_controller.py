import typing
from skeletons.gui.game_control import IGameController
if typing.TYPE_CHECKING:
    from Event import Event
    from cosmic_event.gui.game_control.announcer_controller import AnnouncerEvents

class IAnnouncerController(IGameController):
    onAnnouncerPlay = None

    def startQueuePlay(self):
        raise NotImplementedError

    def stopQueuePlay(self):
        raise NotImplementedError

    def addToQueue(self, event):
        raise NotImplementedError

    def processProgressFinished(self):
        raise NotImplementedError