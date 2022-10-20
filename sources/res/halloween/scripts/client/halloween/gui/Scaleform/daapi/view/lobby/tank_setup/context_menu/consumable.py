import BigWorld
from adisp import adisp_process, adisp_async
from halloween.gui.shared import event_dispatcher
from gui.Scaleform.daapi.view.lobby.shared.cm_handlers import CMLabel, option
from gui.Scaleform.daapi.view.lobby.tank_setup.context_menu.base import TankSetupCMLabel
from gui.Scaleform.daapi.view.lobby.tank_setup.context_menu.consumable import consumableDecorator, ConsumableItemContextMenu, ConsumableSlotContextMenu, HangarConsumableSlotContextMenu
from gui.impl.gen.view_models.views.lobby.tank_setup.sub_views.base_setup_model import BaseSetupModel
from gui.impl.gen.view_models.views.lobby.tank_setup.tank_setup_constants import TankSetupConstants
from gui.impl.lobby.tank_setup.interactors.halloween import HWBuyAndInstallConsumables
from ids_generators import SequenceIDGenerator

@consumableDecorator
class HWConsumableItemContextMenu(ConsumableItemContextMenu):
    _sqGen = SequenceIDGenerator(ConsumableItemContextMenu._sqGen.currSequenceID)

    def showInfo(self):
        pass

    @option(_sqGen.next(), CMLabel.BUY_MORE)
    def buyMore(self):
        event_dispatcher.showHalloweenShop()

    @property
    def hwEqCtrl(self):
        return BigWorld.player().HWAccountEquipmentController

    def _getVehicleItems(self):
        hwVehicle = self.hwEqCtrl.makeVehicleHWAdapter(self._getVehicle())
        return hwVehicle.hwConsumables

    def _initFlashValues(self, ctx):
        super(HWConsumableItemContextMenu, self)._initFlashValues(ctx)
        self._slotsCount = self._getVehicleItems().installed.getCapacity()


@consumableDecorator
class HWConsumableSlotContextMenu(ConsumableSlotContextMenu):
    _sqGen = SequenceIDGenerator(ConsumableSlotContextMenu._sqGen.currSequenceID)

    @property
    def hwEqCtrl(self):
        return BigWorld.player().HWAccountEquipmentController

    def showInfo(self):
        pass

    @option(_sqGen.next(), CMLabel.BUY_MORE)
    def buyMore(self):
        event_dispatcher.showHalloweenShop()

    @option(_sqGen.next(), TankSetupCMLabel.UNLOAD)
    def unload(self):
        super(HWConsumableSlotContextMenu, self).unload()

    @option(_sqGen.next(), TankSetupCMLabel.TAKE_OFF)
    def takeOff(self):
        super(HWConsumableSlotContextMenu, self).takeOff()

    def _getVehicleItems(self):
        hwVehicle = self.hwEqCtrl.makeVehicleHWAdapter(self._getVehicle())
        return hwVehicle.hwConsumables

    def _initFlashValues(self, ctx):
        super(HWConsumableSlotContextMenu, self)._initFlashValues(ctx)
        self._slotsCount = self._getVehicleItems().installed.getCapacity()


@consumableDecorator
class HangarHWConsumableSlotContextMenu(HangarConsumableSlotContextMenu):
    _sqGen = SequenceIDGenerator(HangarConsumableSlotContextMenu._sqGen.currSequenceID)

    @property
    def hwEqCtrl(self):
        return BigWorld.player().HWAccountEquipmentController

    def showInfo(self):
        pass

    @option(_sqGen.next(), CMLabel.BUY_MORE)
    def buyMore(self):
        event_dispatcher.showHalloweenShop()

    @option(_sqGen.next(), TankSetupCMLabel.UNLOAD)
    def unload(self):
        self.__unloadAction()

    @option(_sqGen.next(), TankSetupCMLabel.TAKE_OFF)
    def takeOffFromSlot(self):
        self.__unloadAction()

    def _getVehicleItems(self):
        hwVehicle = self.hwEqCtrl.makeVehicleHWAdapter(self._getVehicle())
        return hwVehicle.hwConsumables

    def _initFlashValues(self, ctx):
        super(HangarHWConsumableSlotContextMenu, self)._initFlashValues(ctx)
        self._slotsCount = self._getVehicleItems().installed.getCapacity()

    def _putOnAction(self, onId):
        hwVehicle = self.hwEqCtrl.makeVehicleHWAdapter(self._getCopyVehicle())
        hwVehicle.hwConsumables.layout = hwVehicle.hwConsumables.installed
        layout = hwVehicle.hwConsumables.layout
        self._makePutOnAction(TankSetupConstants.HWCONSUMABLES, onId, hwVehicle, layout)

    @adisp_async
    @adisp_process
    def _doPutOnAction(self, vehicle, callback, skipDialog=False):
        action = HWBuyAndInstallConsumables(vehicle, confirmOnlyExchange=True, skipConfirm=skipDialog)
        if action is not None:
            result = yield action.doAction()
            callback(result)
        else:
            callback(None)
        return

    @adisp_process
    def __unloadAction(self):
        hwVehicle = self.hwEqCtrl.makeVehicleHWAdapter(self._getCopyVehicle())
        hwVehicle.hwConsumables.layout = hwVehicle.hwConsumables.installed
        hwVehicle.hwConsumables.layout[self._installedSlotId] = None
        result = yield self._doPutOnAction(hwVehicle)
        if result:
            self._sendLastSlotAction(TankSetupConstants.HWCONSUMABLES, BaseSetupModel.REVERT_SLOT_ACTION, {'slotID': self._installedSlotId})
        return