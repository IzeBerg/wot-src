from visual_script.block import Meta

class PVEBattleHUDMeta(Meta):

    @classmethod
    def blockColor(cls):
        return 16742912

    @classmethod
    def blockCategory(cls):
        return 'Event HUD'

    @classmethod
    def blockIcon(cls):
        return ':vse/blocks/hint'