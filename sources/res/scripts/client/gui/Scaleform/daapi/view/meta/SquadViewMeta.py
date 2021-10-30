from gui.Scaleform.daapi.view.lobby.rally.BaseRallyRoomView import BaseRallyRoomView

class SquadViewMeta(BaseRallyRoomView):

    def leaveSquad(self):
        self._printOverrideError('leaveSquad')

    def as_updateBattleTypeS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_updateBattleType(data)

    def as_updateInviteBtnStateS(self, isEnabled):
        if self._isDAAPIInited():
            return self.flashObject.as_updateInviteBtnState(isEnabled)

    def as_setCoolDownForReadyButtonS(self, timer):
        if self._isDAAPIInited():
            return self.flashObject.as_setCoolDownForReadyButton(timer)

    def as_setSimpleTeamSectionDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setSimpleTeamSectionData(data)