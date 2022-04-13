from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class MannerReminderMeta(BaseDAAPIComponent):

    def as_setMannersS(self, manners):
        if self._isDAAPIInited():
            return self.flashObject.as_setManners(manners)

    def as_setEnabledS(self, enabled):
        if self._isDAAPIInited():
            return self.flashObject.as_setEnabled(enabled)