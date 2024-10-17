import BigWorld
from gui.impl.lobby.tank_setup.interactors.consumable import ConsumableInteractor
from gui.shared.gui_items.items_actions import factory as ActionsFactory
from adisp import adisp_process
from halloween.gui.impl.lobby.tank_setup import HWTankSetupConstants
from gui.shared.gui_items.processors import Processor
from gui.shared.utils import decorators
from gui.impl.lobby.tank_setup.interactors.base import BaseAutoRenewal
from HWAccountEquipmentController import getHWConsumables

class ActionTypes(object):
    BUY_AND_INSTALL_HW_CONSUMABLES_ACTION = 'buyAndInstallHWConsumables'
    BUY_AND_INSTALL_HW_DEF_CONSUMABLES_ACTION = 'buyAndInstallHWDefConsumables'


class HalloweenInteractor(ConsumableInteractor):
    CONFIRM_ACTION = ActionTypes.BUY_AND_INSTALL_HW_CONSUMABLES_ACTION

    def getName(self):
        return HWTankSetupConstants.HW_CONSUMABLES

    @adisp_process
    def confirm(self, callback, skipDialog=False):
        action = ActionsFactory.getAction(self.CONFIRM_ACTION, self.getItem(), confirmOnlyExchange=True, skipConfirm=skipDialog)
        if action is not None:
            result = yield action.doAction()
            callback(result)
        else:
            callback(None)
        return


class HalloweenDefInteractor(HalloweenInteractor):
    CONFIRM_ACTION = ActionTypes.BUY_AND_INSTALL_HW_DEF_CONSUMABLES_ACTION

    def getInstalledLayout(self):
        return getHWConsumables(self.getItem()).installed

    def getCurrentLayout(self):
        return getHWConsumables(self.getItem()).layout

    def getVehicleAfterInstall(self):
        vehicle = super(HalloweenDefInteractor, self).getVehicleAfterInstall()
        getHWConsumables(vehicle).installed = getHWConsumables(self.getItem()).layout.copy()
        return vehicle

    def revert(self):
        getHWConsumables(self.getItem()).layout = self.getInstalledLayout().copy()
        super(HalloweenDefInteractor, self).revert()

    def updateFrom(self, vehicle, onlyInstalled=True):
        super(HalloweenDefInteractor, self).updateFrom(vehicle, onlyInstalled)
        getHWConsumables(self.getItem()).installed = getHWConsumables(vehicle).installed.copy()
        getHWConsumables(self.getItem()).isAutoEquip = getHWConsumables(vehicle).isAutoEquip
        self._playerLayout = getHWConsumables(vehicle).layout.copy()
        if not onlyInstalled:
            getHWConsumables(self.getItem()).layout = getHWConsumables(vehicle).layout.copy()

    def _createAutoRenewal(self):
        return HWDefConsumableAutoRenewal(self.getItem())


class HWVehicleAutoEquipProcessor(Processor):

    def __init__(self, vehicle, value):
        super(HWVehicleAutoEquipProcessor, self).__init__()
        self._value = value
        self._vehicle = vehicle

    def _request(self, callback):
        eqCtrl = BigWorld.player().HWAccountEquipmentController
        eqCtrl.setHwAutoMaintenanceEnabled(self._vehicle.invID, self._value, lambda requestID, code, errStr: self._response(code, callback, errStr=errStr))


class HWDefConsumableAutoRenewal(BaseAutoRenewal):

    def getValue(self):
        return getHWConsumables(self._vehicle).isAutoEquip

    @decorators.adisp_process('techMaintenance')
    def processVehicleAutoRenewal(self, callback):
        yield HWVehicleAutoEquipProcessor(self._vehicle, self.getLocalValue()).request()
        self.setLocalValue(None)
        callback(None)
        return