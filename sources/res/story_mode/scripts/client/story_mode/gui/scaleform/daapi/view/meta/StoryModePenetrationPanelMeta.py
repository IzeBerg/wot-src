from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class StoryModePenetrationPanelMeta(BaseDAAPIComponent):

    def as_setPenetrationS(self, penetrationType, isPurple):
        if self._isDAAPIInited():
            return self.flashObject.as_setPenetration(penetrationType, isPurple)