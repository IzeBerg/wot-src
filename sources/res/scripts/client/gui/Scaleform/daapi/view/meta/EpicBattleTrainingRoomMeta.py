from gui.Scaleform.daapi.view.lobby.trainings.TrainingRoomBase import TrainingRoomBase

class EpicBattleTrainingRoomMeta(TrainingRoomBase):

    def onChangeTeamLane(self, accID, team, lane):
        self._printOverrideError('onChangeTeamLane')

    def onSwapTeamLane(self, fromTeam, fromLane, toTeam, toLane):
        self._printOverrideError('onSwapTeamLane')