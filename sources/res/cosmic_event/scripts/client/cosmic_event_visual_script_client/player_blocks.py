from visual_script_client.player_blocks import PlayerEventMeta

class CosmicPlayerMeta(PlayerEventMeta):

    @classmethod
    def blockColor(cls):
        return 10512127

    @classmethod
    def blockCategory(cls):
        return 'Cosmic Player'

    @classmethod
    def blockIcon(cls):
        return ':vse/blocks/player'