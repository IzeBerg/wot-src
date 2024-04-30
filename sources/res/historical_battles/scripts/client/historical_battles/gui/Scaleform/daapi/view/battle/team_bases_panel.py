from gui.Scaleform.daapi.view.battle.classic.team_bases_panel import TeamBasesPanel

class HBTeamBasesPanel(TeamBasesPanel):

    def setOffsetForEnemyPoints(self):
        pass

    def setTeamBaseCaptured(self, clientID, playerTeam):
        super(HBTeamBasesPanel, self).setTeamBaseCaptured(clientID, playerTeam)
        self.removeTeamBase(clientID)