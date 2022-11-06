from adisp import adisp_process, adisp_async
from gui.Scaleform.daapi.view.lobby.shared.cm_handlers import option, CMLabel
from gui.Scaleform.daapi.view.lobby.tank_setup.context_menu.base import TankSetupCMLabel
from gui.Scaleform.daapi.view.lobby.tank_setup.context_menu.base_equipment import BaseEquipmentItemContextMenu, BaseEquipmentSlotContextMenu, BaseHangarEquipmentSlotContextMenu
from gui.impl.gen.view_models.views.lobby.tank_setup.tank_setup_constants import TankSetupConstants
from gui.shared.gui_items.items_actions import factory as ActionsFactory
from gui.impl.gen.view_models.views.lobby.tank_setup.sub_views.base_setup_model import BaseSetupModel
from ids_generators import SequenceIDGenerator

class BattleAbilityItemContextMenu(BaseEquipmentItemContextMenu):
    _sqGen = SequenceIDGenerator(BaseEquipmentItemContextMenu._sqGen.currSequenceID)

    def _initFlashValues(self, ctx):
        super(BattleAbilityItemContextMenu, self)._initFlashValues(ctx)
        self._slotsCount = self._getVehicleItems().installed.getCapacity()

    def _isVisible(self, label):
        if label == CMLabel.INFORMATION:
            return False
        if label == TankSetupCMLabel.TAKE_OFF:
            return False
        return super(BattleAbilityItemContextMenu, self)._isVisible(label)

    def _getVehicleItems(self):
        return self._getVehicle().battleAbilities


class BattleAbilitySlotContextMenu(BaseEquipmentSlotContextMenu):
    _sqGen = SequenceIDGenerator(BaseEquipmentSlotContextMenu._sqGen.currSequenceID)

    @option(_sqGen.next(), TankSetupCMLabel.TAKE_OFF)
    def takeOff(self):
        if self._isMounted:
            self._sendSlotAction(BaseSetupModel.SELECT_SLOT_ACTION, intCD=None, currentSlotId=self._installedSlotId)
        else:
            self._sendSlotAction(BaseSetupModel.REVERT_SLOT_ACTION)
        return

    def _initFlashValues(self, ctx):
        super(BattleAbilitySlotContextMenu, self)._initFlashValues(ctx)
        self._slotsCount = self._getVehicleItems().installed.getCapacity()

    def _isVisible(self, label):
        if label == CMLabel.INFORMATION:
            return False
        if label == TankSetupCMLabel.TAKE_OFF:
            return False
        return super(BattleAbilitySlotContextMenu, self)._isVisible(label)

    def _getVehicleItems(self):
        return self._getVehicle().battleAbilities


class HangarBattleAbilitySlotContextMenu(BaseHangarEquipmentSlotContextMenu):
    _sqGen = SequenceIDGenerator(BaseHangarEquipmentSlotContextMenu._sqGen.currSequenceID)

    @option(_sqGen.next(), TankSetupCMLabel.TAKE_OFF)
    @adisp_process
    def takeOff(self):
        copyVehicle = self._getCopyVehicle()
        copyVehicle.battleAbilities.layout[self._installedSlotId] = None
        result = yield self._doPutOnAction(copyVehicle)
        if result:
            self._sendLastSlotAction(TankSetupConstants.BATTLE_ABILITIES, BaseSetupModel.REVERT_SLOT_ACTION, {'slotID': self._installedSlotId})
        return

    def _initFlashValues(self, ctx):
        super(HangarBattleAbilitySlotContextMenu, self)._initFlashValues(ctx)
        self._slotsCount = self._getVehicleItems().installed.getCapacity()

    def _putOnAction(self, onId):
        copyVehicle = self._getCopyVehicle()
        layout = copyVehicle.battleAbilities.layout
        self._makePutOnAction(TankSetupConstants.BATTLE_ABILITIES, onId, copyVehicle, layout)

    def _getCopyVehicle(self):
        copyVehicle = super(HangarBattleAbilitySlotContextMenu, self)._getCopyVehicle()
        copyVehicle.battleAbilities.setByOther(self._getVehicleItems())
        return copyVehicle

    def _isVisible(self, label):
        if label == CMLabel.INFORMATION:
            return False
        if label == TankSetupCMLabel.TAKE_OFF:
            return False
        return super(HangarBattleAbilitySlotContextMenu, self)._isVisible(label)

    @adisp_async
    @adisp_process
    def _doPutOnAction(self, vehicle, callback):
        action = ActionsFactory.getAction(ActionsFactory.INSTALL_BATTLE_ABILITIES, vehicle)
        result = yield ActionsFactory.asyncDoAction(action)
        callback(result)

    def _getVehicleItems(self):
        return self._getVehicle().battleAbilities