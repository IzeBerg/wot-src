from gui.Scaleform.daapi.view.lobby.battle_queue.base_queue import BattleQueueBase

class RTSBattleQueueMeta(BattleQueueBase):

    def onSwitchVehicleClick(self):
        self._printOverrideError('onSwitchVehicleClick')

    def as_showSwitchVehicleS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_showSwitchVehicle(data)

    def as_hideSwitchVehicleS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideSwitchVehicle()

    def as_setRTSDPS(self, dataProvider):
        if self._isDAAPIInited():
            return self.flashObject.as_setRTSDP(dataProvider)