from gui.impl.lobby.tank_setup.dialogs.confirm_dialog import TankSetupConfirmDialog

class HWTankSetupConfirmDialog(TankSetupConfirmDialog):

    def __init__(self, *args, **kwargs):
        super(HWTankSetupConfirmDialog, self).__init__(*args, **kwargs)
        self._itemsType = 'hw_equipment'