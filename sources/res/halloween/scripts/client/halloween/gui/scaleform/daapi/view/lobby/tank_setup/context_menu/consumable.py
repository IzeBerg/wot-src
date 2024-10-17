from gui.Scaleform.daapi.view.lobby.tank_setup.context_menu.consumable import consumableDecorator, HangarConsumableSlotContextMenu
from halloween.gui.shared.event_dispatcher import showModuleInfo
from ids_generators import SequenceIDGenerator
from halloween.gui.shared import isHalloweenDefenceSelected
from HWAccountEquipmentController import getHWConsumables
from halloween.gui.impl.lobby.tank_setup import HWTankSetupConstants
from gui.shared.gui_items.items_actions import factory as ActionsFactory
from gui.impl.gen.view_models.views.lobby.tank_setup.sub_views.base_setup_model import BaseSetupModel
from halloween.gui.impl.lobby.tank_setup.interactor import ActionTypes
from adisp import adisp_process, adisp_async

@consumableDecorator
class HWHangarConsumableSlotContextMenu(HangarConsumableSlotContextMenu):
    _sqGen = SequenceIDGenerator(HangarConsumableSlotContextMenu._sqGen.currSequenceID)

    def _putOnAction(self, onId):
        if not isHalloweenDefenceSelected():
            super(HWHangarConsumableSlotContextMenu, self)._putOnAction(onId)
            return
        copyVehicle = self._getCopyVehicle()
        defConsumables = getHWConsumables(copyVehicle)
        defConsumables.layout = defConsumables.installed.copy()
        layout = defConsumables.layout
        self._makePutOnAction(HWTankSetupConstants.HW_CONSUMABLES, onId, copyVehicle, layout)

    @adisp_async
    @adisp_process
    def _doPutOnAction(self, vehicle, callback):
        actionName = ActionTypes.BUY_AND_INSTALL_HW_DEF_CONSUMABLES_ACTION if isHalloweenDefenceSelected() else ActionsFactory.BUY_AND_INSTALL_CONSUMABLES
        action = ActionsFactory.getAction(actionName, vehicle, confirmOnlyExchange=True)
        result = yield ActionsFactory.asyncDoAction(action)
        callback(result)

    def _getVehicleItems(self):
        if not isHalloweenDefenceSelected():
            return getHWConsumables(self._getVehicle())
        return self._getVehicle().consumables

    @adisp_process
    def _unloadAction(self):
        if not isHalloweenDefenceSelected():
            super(HWHangarConsumableSlotContextMenu, self)._unloadAction()
            return
        else:
            copyVehicle = self._getCopyVehicle()
            defConsumables = getHWConsumables(copyVehicle)
            defConsumables.layout = defConsumables.installed.copy()
            defConsumables.layout[self._installedSlotId] = None
            result = yield self._doPutOnAction(copyVehicle)
            if result:
                self._sendLastSlotAction(HWTankSetupConstants.HW_CONSUMABLES, BaseSetupModel.REVERT_SLOT_ACTION, {'slotID': self._installedSlotId})
            return

    def _showInfo(self):
        showModuleInfo(self._intCD, self._getVehicle().descriptor)