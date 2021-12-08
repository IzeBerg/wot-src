from gui.Scaleform.framework.entities.View import View

class LobbyPageMeta(View):

    def moveSpace(self, x, y, delta):
        self._printOverrideError('moveSpace')

    def getSubContainerTypes(self):
        self._printOverrideError('getSubContainerTypes')

    def notifyCursorOver3dScene(self, isOver3dScene):
        self._printOverrideError('notifyCursorOver3dScene')

    def notifyCursorDragging(self, isDragging):
        self._printOverrideError('notifyCursorDragging')

    def as_showHelpLayoutS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_showHelpLayout()

    def as_closeHelpLayoutS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_closeHelpLayout()

    def as_switchLobbyDraggingS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_switchLobbyDragging(value)

    def as_showWaitingS(self, message):
        if self._isDAAPIInited():
            return self.flashObject.as_showWaiting(message)

    def as_hideWaitingS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideWaiting()

    def as_setSubContainerItemsVisibilityS(self, isVisible):
        if self._isDAAPIInited():
            return self.flashObject.as_setSubContainerItemsVisibility(isVisible)