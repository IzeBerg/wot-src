from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class WTBossTeleportViewMeta(BaseDAAPIComponent):

    def onTeleportPointClick(self, id):
        self._printOverrideError('onTeleportPointClick')

    def onCancel(self):
        self._printOverrideError('onCancel')