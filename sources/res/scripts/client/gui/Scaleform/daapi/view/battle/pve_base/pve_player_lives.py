from gui.Scaleform.daapi.view.meta.PvePlayerLivesMeta import PvePlayerLivesMeta
from gui.battle_control import avatar_getter
from TeamInfoLivesComponent import TeamInfoLivesComponent

class PvePlayerLives(PvePlayerLivesMeta):

    def _populate(self):
        super(PvePlayerLives, self)._populate()
        TeamInfoLivesComponent.onTeamLivesUpdated += self._onTeamLivesUpdated
        self._updateRespawnInfo()

    def _dispose(self):
        TeamInfoLivesComponent.onTeamLivesUpdated -= self._onTeamLivesUpdated
        super(PvePlayerLives, self)._dispose()

    def _updateRespawnInfo(self):
        teamLives = TeamInfoLivesComponent.getInstance()
        if not teamLives:
            return
        playerVehicleID = avatar_getter.getPlayerVehicleID()
        lives = teamLives.getLives(playerVehicleID)
        usedLives = teamLives.getUsedLives(playerVehicleID)
        lockedLives = teamLives.getLockedLives(playerVehicleID)
        self.as_setCountLivesS(lives, usedLives, lockedLives)

    def _onTeamLivesUpdated(self):
        self._updateRespawnInfo()