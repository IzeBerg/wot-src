import typing
from skeletons.gui.game_control import IGameController
if typing.TYPE_CHECKING:
    from Event import Event

class IVoiceoverManager(IGameController):
    if typing.TYPE_CHECKING:
        onSubtitleShow = None
        onSubtitleHide = None
        onStarted = None
        onStopped = None

    @property
    def currentSubtitle(self):
        raise NotImplementedError

    @property
    def currentCtx(self):
        raise NotImplementedError

    @property
    def isPlaying(self):
        raise NotImplementedError

    def stopVoiceover(self):
        raise NotImplementedError

    def playVoiceover(self, voiceoverId, ctx=None):
        raise NotImplementedError