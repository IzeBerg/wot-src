import typing, adisp
from wg_async import wg_async, wg_await, await_callback
from BWUtil import AsyncReturn
from gui.impl.gen.view_models.views.lobby.tank_setup.sub_views.base_setup_model import BaseSetupModel
from gui.impl.gen.view_models.views.lobby.tank_setup.tank_setup_constants import TankSetupConstants
from gui.impl.lobby.dialogs.auxiliary.buy_and_exchange_state_machine import BuyAndExchangeStateEnum
from gui.impl.lobby.tank_setup.interactors.base import BaseInteractor
from gui.impl.lobby.tank_setup.tank_setup_helper import NONE_ID
from gui.shared.event_dispatcher import showTankSetupExitConfirmDialog
from gui.shared.gui_items.items_actions import factory as ActionsFactory
if typing.TYPE_CHECKING:
    from gui.shared.gui_items.artefacts import OptionalDevice

class BaseOptDeviceInteractor(BaseInteractor):
    __slots__ = ()

    def getName(self):
        return TankSetupConstants.OPT_DEVICES

    def getInstalledLayout(self):
        return self.getItem().optDevices.installed

    def getCurrentLayout(self):
        return self.getItem().optDevices.layout

    def getSetupLayout(self):
        return self.getItem().optDevices.setupLayouts

    def getCurrentCategories(self, slotID):
        return self.getItem().optDevices.slots[slotID].categories


class OptDeviceInteractor(BaseOptDeviceInteractor):
    __slots__ = ()

    def getVehicleAfterInstall(self):
        vehicle = super(OptDeviceInteractor, self).getVehicleAfterInstall()
        vehicle.optDevices.setInstalled(*self.getItem().optDevices.layout)
        vehicle.optDevices.dynSlotType = self.getItem().optDevices.dynSlotType
        return vehicle

    def getChangedList(self):
        setOfPrevLayout = set(item.intCD for item in self.getInstalledLayout() if item is not None)
        currentItems = []
        vehicle = self.getItem()
        for slotID, item in enumerate(self.getCurrentLayout()):
            if item and item.intCD not in setOfPrevLayout:
                if self.__canInstall(item, vehicle):
                    currentItems.append(item)
                else:
                    self.setItemInCurrentLayout(slotID, None)
                    self.onSlotAction(actionType=BaseSetupModel.REVERT_SLOT_ACTION, slotID=slotID)
                    self.itemUpdated()

        return currentItems

    def setItemInCurrentLayout(self, slotID, item):
        self.getCurrentLayout()[slotID] = item
        if item is not None:
            self.getItem().descriptor.installOptionalDevice(item.intCD, slotID)
        elif self.getItem().descriptor.optionalDevices[slotID] is not None:
            self.getItem().descriptor.removeOptionalDevice(slotID)
        return

    @adisp.adisp_process
    def demountProcess(self, slotID, isDestroy=False, isFitting=False, everywhere=True, callback=None):
        action = ActionsFactory.getAction(ActionsFactory.REMOVE_OPT_DEVICE, self.getItem(), self.getInstalledLayout()[slotID], slotID, isDestroy, isFitting, everywhere)
        if action is not None:
            result = yield action.doAction()
            callback(result)
        else:
            callback(None)
        return

    @wg_async
    def changeSlotItem(self, slotID, itemIntCD):
        item = self._itemsCache.items.getItemByCD(int(itemIntCD)) if itemIntCD is not None else None
        canChange = True
        removedItem = self.getCurrentLayout()[slotID]
        needToRemoveItem = removedItem is not None and removedItem in self.getInstalledLayout()
        if needToRemoveItem:
            everywhere = self.getSetupLayout().getIntCDs().count(removedItem.intCD) == 1
            canChange = yield await_callback(self.demountProcess)(self.getInstalledLayout().index(removedItem), isFitting=True, everywhere=everywhere)
        if canChange:
            self.setItemInCurrentLayout(slotID, item)
            if needToRemoveItem:
                self.onSlotAction(actionType=BaseSetupModel.DEMOUNT_SLOT_ACTION, intCD=itemIntCD, slotID=slotID)
            elif item is not None:
                self.onSlotAction(actionType=BaseSetupModel.SELECT_SLOT_ACTION, intCD=itemIntCD, slotID=slotID)
            else:
                self.onSlotAction(actionType=BaseSetupModel.REVERT_SLOT_ACTION, slotID=slotID)
            self.itemUpdated()
        return

    def swapSlots(self, leftID, rightID, actionType=BaseSetupModel.SWAP_SLOTS_ACTION):
        optLayout = self.getCurrentLayout()
        leftID, rightID = sorted((leftID, rightID))
        leftItem, rightItem = optLayout[leftID], optLayout[rightID]
        self.setItemInCurrentLayout(rightID, None)
        self.setItemInCurrentLayout(leftID, rightItem)
        self.setItemInCurrentLayout(rightID, leftItem)
        self.onSlotAction(actionType=actionType, leftID=leftID, rightID=rightID, leftIntCD=leftItem.intCD if leftItem else NONE_ID, rightIntCD=rightItem.intCD if rightItem else NONE_ID)
        self.itemUpdated()
        return

    @wg_async
    def demountItem(self, itemIntCD, isDestroy=False, everywhere=True):
        result = None
        item = self._itemsCache.items.getItemByCD(itemIntCD)
        currentSlotID = self.getCurrentLayout().index(item)
        installedSlotID = self.getInstalledLayout().index(item)
        if currentSlotID is not None and installedSlotID is not None:
            result = yield await_callback(self.demountProcess)(installedSlotID, isDestroy=isDestroy, everywhere=everywhere)
            if result:
                self.setItemInCurrentLayout(currentSlotID, None)
                actionType = BaseSetupModel.DESTROY_SLOT_ACTION if isDestroy else BaseSetupModel.DEMOUNT_SLOT_ACTION
                self.onSlotAction(actionType=actionType, intCD=itemIntCD, slotID=currentSlotID)
                self.itemUpdated()
        raise AsyncReturn(result)
        return

    def revert(self):
        for slotID in range(self.getInstalledLayout().getCapacity()):
            self.setItemInCurrentLayout(slotID, None)

        for slotID, optDevice in enumerate(self.getInstalledLayout()):
            self.setItemInCurrentLayout(slotID, optDevice)

        self.onSlotAction(actionType=BaseSetupModel.REVERT_SLOT_ACTION)
        self.itemUpdated()
        return

    @adisp.adisp_process
    def confirm(self, callback, skipDialog=False):
        action = ActionsFactory.getAction(ActionsFactory.BUY_AND_INSTALL_OPT_DEVICES, self.getItem(), confirmOnlyExchange=True, skipConfirm=skipDialog)
        if action is not None:
            result = yield action.doAction()
            callback(result)
        else:
            callback(None)
        return

    @adisp.adisp_process
    def upgradeModule(self, itemIntCD, callback):
        optDevice = self._itemsCache.items.getItemByCD(int(itemIntCD))
        slotIdx = self.getInstalledLayout().index(optDevice)
        setupIdx = None
        for layoutIdx, setup in self.getSetupLayout().setups.iteritems():
            if optDevice in setup:
                setupIdx = layoutIdx
                slotIdx = setup.index(optDevice)
                break

        vehicle = None if setupIdx is None else self.getItem()
        action = ActionsFactory.getAction(ActionsFactory.UPGRADE_OPT_DEVICE, vehicle=vehicle, module=optDevice, setupIdx=setupIdx, slotIdx=slotIdx)
        result = yield action.doAction() if action is not None else None
        if result:
            upgradedIntCD = optDevice.descriptor.upgradeInfo.upgradedCompDescr
            upgradedDevice = self._itemsCache.items.getItemByCD(upgradedIntCD)
            currentSlotIdx = self.getCurrentLayout().index(optDevice)
            if currentSlotIdx is not None:
                self.setItemInCurrentLayout(currentSlotIdx, upgradedDevice)
        self.itemUpdated()
        callback(result)
        return

    def updateFrom(self, vehicle, onlyInstalled=True):
        super(OptDeviceInteractor, self).updateFrom(vehicle, onlyInstalled)
        items = self.getItem().optDevices
        items.setInstalled(*vehicle.optDevices.installed)
        items.setupLayouts.setSetups(vehicle.optDevices.setupLayouts.setups)
        if not onlyInstalled:
            for slotID in range(vehicle.optDevices.layout.getCapacity()):
                self.setItemInCurrentLayout(slotID, None)

            for slotID, optDevice in enumerate(vehicle.optDevices.layout):
                self.setItemInCurrentLayout(slotID, optDevice)

        return

    @wg_async
    def showExitConfirmDialog(self):
        changedList = self.getChangedList()
        result = yield wg_await(showTankSetupExitConfirmDialog(items=changedList, vehicle=self.getItem(), fromSection=self.getName(), startState=(changedList or BuyAndExchangeStateEnum).BUY_NOT_REQUIRED if 1 else None))
        raise AsyncReturn(result)
        return

    def __canInstall--- This code section failed: ---

 L. 237         0  LOAD_FAST             1  'item'
                3  LOAD_ATTR             0  'isHidden'
                6  POP_JUMP_IF_FALSE    81  'to 81'
                9  LOAD_FAST             1  'item'
               12  LOAD_ATTR             1  'isRegular'
               15  UNARY_NOT        
             16_0  COME_FROM             6  '6'
               16  POP_JUMP_IF_FALSE    81  'to 81'

 L. 238        19  LOAD_FAST             1  'item'
               22  LOAD_ATTR             2  'isInInventory'
               25  STORE_FAST            3  'isInInventory'

 L. 240        28  LOAD_FAST             2  'vehicle'
               31  LOAD_ATTR             3  'isPostProgressionExists'
               34  POP_JUMP_IF_FALSE    77  'to 77'
               37  LOAD_FAST             3  'isInInventory'
               40  JUMP_IF_TRUE_OR_POP    80  'to 80'
               43  LOAD_FAST             0  'self'
               46  LOAD_ATTR             4  'getSetupLayout'
               49  CALL_FUNCTION_0       0  None
               52  LOAD_ATTR             5  'getIntCDs'
               55  CALL_FUNCTION_0       0  None
               58  LOAD_ATTR             6  'count'
               61  LOAD_FAST             1  'item'
               64  LOAD_ATTR             7  'intCD'
               67  CALL_FUNCTION_1       1  None
               70  LOAD_CONST               0
               73  COMPARE_OP            4  >
               76  RETURN_END_IF    
             77_0  COME_FROM            40  '40'
             77_1  COME_FROM            34  '34'
               77  LOAD_FAST             3  'isInInventory'
               80  RETURN_VALUE     
             81_0  COME_FROM            16  '16'

 L. 241        81  LOAD_GLOBAL           8  'True'
               84  RETURN_VALUE     
               -1  RETURN_LAST      

Parse error at or near `RETURN_END_IF' instruction at offset 76# Decompile failed :(