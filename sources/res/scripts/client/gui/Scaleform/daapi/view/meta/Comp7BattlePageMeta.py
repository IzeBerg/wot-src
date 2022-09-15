from gui.Scaleform.daapi.view.battle.classic.page import ClassicPage

class Comp7BattlePageMeta(ClassicPage):

    def showHelp(self):
        self._printOverrideError('showHelp')

    def moveSpace(self, x, y, delta):
        self._printOverrideError('moveSpace')

    def notifyCursorOver3dScene(self, isOver3dScene):
        self._printOverrideError('notifyCursorOver3dScene')

    def notifyCursorDragging(self, isDragging):
        self._printOverrideError('notifyCursorDragging')

    def as_updateVehicleStatusS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_updateVehicleStatus(data)

    def as_onVehicleSelectionConfirmedS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_onVehicleSelectionConfirmed()

    def as_onPrebattleInputStateLockedS(self, isStateLocked):
        if self._isDAAPIInited():
            return self.flashObject.as_onPrebattleInputStateLocked(isStateLocked)