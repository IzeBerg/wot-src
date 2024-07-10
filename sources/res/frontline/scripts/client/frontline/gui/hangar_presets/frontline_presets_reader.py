from gui.hangar_presets.hangar_presets_reader import DefaultPresetReader

class FrontlinePresetsReader(DefaultPresetReader):
    _CONFIG_PATH = 'frontline/gui/configs/frontline_hangar_gui_presets.xml'

    @staticmethod
    def isDefault():
        return False