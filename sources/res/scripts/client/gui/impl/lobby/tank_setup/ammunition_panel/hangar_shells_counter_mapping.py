from account_helpers.settings_core.ServerSettingsManager import UI_STORAGE_KEYS

class ShellCounterMapping(dict):

    def __init__(self, vehicle):
        super(ShellCounterMapping, self).__init__({vehicle.gun.isDamageMutable: UI_STORAGE_KEYS.MUTABLE_DAMAGE_SHELL_MARK_IS_SHOWN})