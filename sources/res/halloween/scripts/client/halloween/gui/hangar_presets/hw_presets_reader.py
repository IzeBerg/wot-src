from gui.hangar_presets.hangar_presets_reader import DefaultPresetReader

class HalloweenPresetsReader(DefaultPresetReader):
    _CONFIG_PATH = 'halloween/gui/configs/hw_hangar_gui_presets.xml'

    @staticmethod
    def isDefault():
        return False