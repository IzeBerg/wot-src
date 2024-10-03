from gui.hangar_presets.hangar_presets_reader import DefaultPresetReader

class WhiteTigerPresetsReader(DefaultPresetReader):
    _CONFIG_PATH = 'white_tiger/gui/configs/white_tiger_hangar_gui_presets.xml'

    @staticmethod
    def isDefault():
        return False