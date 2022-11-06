from gui.Scaleform.daapi.view.lobby.popover.SmartPopOverView import SmartPopOverView

class SessionStatsPopoverMeta(SmartPopOverView):

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)