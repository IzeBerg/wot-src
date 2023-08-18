from gui.battle_control.arena_info import settings
from gui.battle_control.arena_info.arena_descrs import ArenaWithLabelDescription

class ArenaDescription(ArenaWithLabelDescription):

    def getScreenIcon(self):
        return settings.DEFAULT_SCREEN_MAP_IMAGE_RES_PATH