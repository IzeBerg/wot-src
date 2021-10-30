from bootcamp.Bootcamp import g_bootcamp
from gui import DialogsInterface
from gui.Scaleform.daapi.view import dialogs
from gui.Scaleform.daapi.view.lobby.techtree.unlock import UnlockItemConfirmator
from gui.impl import backport
from gui.impl.gen import R

class BCUnlockItemConfirmator(UnlockItemConfirmator):
    _dialogsInterfaceMethod = staticmethod(DialogsInterface.showBCConfirmationDialog)
    _BOOTCAM_LABELS_PATH = '../maps/icons/bootcamp/lines'
    _VEHICLE_COMPONENTS_LABLES = {'vehicleChassis': 'bcChassis.png', 
       'vehicleTurret': 'bcTurret.png', 'vehicleGun': 'bcGun.png', 
       'vehicleRadio': 'bcRadio.png', 'vehicleWheels': 'bcWheels.png', 
       'vehicleEngine': 'bcEngine.png'}

    @staticmethod
    def getPath(itemTypeName):
        dataStr = ''
        if itemTypeName in BCUnlockItemConfirmator._VEHICLE_COMPONENTS_LABLES:
            dataStr = ('/').join((BCUnlockItemConfirmator._BOOTCAM_LABELS_PATH,
             BCUnlockItemConfirmator._VEHICLE_COMPONENTS_LABLES[itemTypeName]))
        return dataStr

    def __getVehicleData(self, bcNationData, item):
        if item.intCD == bcNationData['vehicle_second']:
            return {'label': backport.text(R.strings.bootcamp.message.unlock.vehicle.title()).format(item.userName), 
               'labelExecute': backport.text(R.strings.bootcamp.message.unlock.vehicle.buttonLabel()), 
               'icon': bcNationData['vehicle_second_icon'], 
               'costValue': self._costCtx['xpCost'], 
               'isBuy': False}

    def __getVehicleComponentData(self, item):
        return {'label': backport.text(R.strings.bootcamp.message.unlock.module.title()).format(item.longUserName), 
           'labelExecute': backport.text(R.strings.bootcamp.message.unlock.module.buttonLabel()), 
           'icon': BCUnlockItemConfirmator.getPath(item.itemTypeName), 
           'costValue': self._costCtx['xpCost'], 
           'isBuy': False}

    def _makeMeta(self):
        item = self.itemsCache.items.getItemByCD(self._unlockCtx.itemCD)
        bcNationData = g_bootcamp.getNationData()
        if item.intCD == bcNationData['vehicle_second']:
            dialogData = self.__getVehicleData(bcNationData, item)
        else:
            dialogData = self.__getVehicleComponentData(item)
        return dialogs.BCConfirmDialogMeta(dialogData)