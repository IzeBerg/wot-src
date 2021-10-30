from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class EventBossHPBarMeta(BaseDAAPIComponent):

    def as_setPhaseS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setPhase(value)

    def as_setBossHPS(self, label, progress):
        if self._isDAAPIInited():
            return self.flashObject.as_setBossHP(label, progress)

    def as_setVisibleS(self, vis):
        if self._isDAAPIInited():
            return self.flashObject.as_setVisible(vis)