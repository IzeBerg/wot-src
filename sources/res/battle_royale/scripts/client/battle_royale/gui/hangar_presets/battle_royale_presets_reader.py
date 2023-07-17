from gui.hangar_presets.hangar_presets_reader import DefaultPresetReader

class BattleRoyalePresetsReader(DefaultPresetReader):
    _CONFIG_PATH = 'battle_royale/gui/configs/battle_royale_hangar_gui_presets.xml'

    @staticmethod
    def isDefault():
        return False