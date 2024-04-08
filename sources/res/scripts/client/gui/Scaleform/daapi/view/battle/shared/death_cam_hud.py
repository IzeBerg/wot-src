from gui.Scaleform.daapi.view.meta.DeathCamHudMeta import DeathCamHudMeta
from gui.shared import EVENT_BUS_SCOPE
from gui.shared.events import GameEvent, DeathCamEvent

class DeathCamHud(DeathCamHudMeta):

    def onAnimationFinished(self):
        self.fireEvent(GameEvent(DeathCamEvent.DEATH_CAM_HIDDEN), scope=EVENT_BUS_SCOPE.BATTLE)