from gui.Scaleform.daapi.view.battle.classic.team_bases_panel import TeamBasesPanel

class EventTeamBasesPanelMeta(TeamBasesPanel):

    def as_updateCaptureS(self, id, points, rate, captureTime, vehiclesCount, captureString, colorType, locked):
        if self._isDAAPIInited():
            return self.flashObject.as_updateCapture(id, points, rate, captureTime, vehiclesCount, captureString, colorType, locked)