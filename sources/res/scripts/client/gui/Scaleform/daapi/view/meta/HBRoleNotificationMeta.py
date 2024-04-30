from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class HBRoleNotificationMeta(BaseDAAPIComponent):

    def as_showS(self, roleImage, roleName, message):
        if self._isDAAPIInited():
            return self.flashObject.as_show(roleImage, roleName, message)