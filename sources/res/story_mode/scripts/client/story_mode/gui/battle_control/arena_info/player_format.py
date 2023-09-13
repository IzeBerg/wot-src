from gui.battle_control.arena_info import player_format
from gui.battle_control.arena_info.player_format import PlayerFormatResult
from helpers import i18n

class StoryModeNameFormatter(player_format.PlayerFullNameFormatter):

    def format(self, vInfoVO, playerName=None):
        obj = super(StoryModeNameFormatter, self).format(vInfoVO, playerName)
        playerName = obj.playerName
        if playerName.startswith('#'):
            playerName = i18n.makeString(playerName)
        elif playerName.startswith(':'):
            playerName = obj.vehicleName
        return PlayerFormatResult(playerName, playerName, obj.playerFakeName, obj.clanAbbrev, obj.regionCode, obj.vehicleName)