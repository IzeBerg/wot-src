from gui.impl.gen.view_models.views.lobby.tank_setup.sub_views.base_setup_model import BaseSetupModel
from gui.impl.lobby.tank_setup.configurations.battle_booster import BattleBoostersTabsController, BattleBoosterTabs
from gui.impl.lobby.tank_setup.sub_views.base_equipment_setup import BaseEquipmentSetupSubView

class BattleBoosterSetupSubView(BaseEquipmentSetupSubView):
    __slots__ = ()

    def updateSlots(self, slotID, fullUpdate=True, updateData=True):
        item = self._interactor.getCurrentLayout()[slotID]
        if item is not None:
            self._setTab(BattleBoosterTabs.CREW if item.isCrewBooster() else BattleBoosterTabs.OPT_DEVICE)
        if item is not None and item.isHidden and not item.isInInventory:
            self._interactor.changeSlotItem(slotID, None)
            self._interactor.getAutoRenewal().setLocalValue(False)
        super(BattleBoosterSetupSubView, self).updateSlots(slotID, fullUpdate, updateData)
        return

    def revertItem(self, slotID):
        self._interactor.revertSlot(slotID)
        self.update()

    def _createTabsController(self):
        return BattleBoostersTabsController()

    def _addListeners(self):
        super(BattleBoosterSetupSubView, self)._addListeners()
        self._addSlotAction(BaseSetupModel.ADD_ONE_SLOT_ACTION, self.__onAdd)

    def __onAdd(self, args):
        itemIntCD = int(args.get('intCD'))
        self._interactor.buyMore(itemIntCD)