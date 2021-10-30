from collections import namedtuple
from adisp import process
from frameworks.wulf import ViewFlags, ViewSettings
from account_helpers.AccountSettings import AccountSettings, BATTLE_ROYALE_HANGAR_BOTTOM_PANEL_VIEWED
from CurrentVehicle import g_currentVehicle
from gui import SystemMessages, DialogsInterface, makeHtmlString
from gui.ClientUpdateManager import g_clientUpdateManager
from gui.Scaleform.daapi.view.dialogs import I18nConfirmDialogMeta
from gui.battle_control.controllers.consumables.br_equipment_ctrl import createEquipmentById
from gui.battle_royale.constants import AmmoTypes
from gui.impl import backport
from gui.impl.backport.backport_system_locale import getIntegralFormat
from gui.impl.backport.backport_tooltip import createTooltipData, BackportTooltipWindow
from gui.impl.gen import R
from gui.impl.gen.view_models.views.battle_royale.battle_royale_consumable_model import BattleRoyaleConsumableModel
from gui.impl.gen.view_models.views.battle_royale.equipment_panel_cmp_tooltips import EquipmentPanelCmpTooltips
from gui.impl.gen.view_models.views.battle_royale.hangar_bottom_panel_view_model import HangarBottomPanelViewModel
from gui.impl.pub import ViewImpl
from gui.prb_control.entities.listener import IGlobalListener
from gui.Scaleform.daapi.view.common.battle_royale.br_helpers import isIncorrectVehicle
from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor
from gui.shared import event_dispatcher
from gui.shared.formatters.tankmen import getItemPricesViewModel
from gui.shared.gui_items.Vehicle import Vehicle
from gui.shared.gui_items.gui_item_economics import ItemPrice
from gui.shared.gui_items.processors.vehicle import VehicleRepairer
from gui.shared.items_parameters.params import ShellParams
from gui.shared.money import Money, Currency
from gui.shared.utils import decorators
from helpers import dependency
from skeletons.gui.game_control import IBattleRoyaleController
from skeletons.gui.shared import IItemsCache
_DEFAULT_SLOT_VALUE = 1
_ArtefactData = namedtuple('_ArtefactData', ('intCD', 'quantity', 'icon', 'tooltip'))

class HangarBottomPanelComponent(InjectComponentAdaptor):

    def _makeInjectView(self):
        return HangarBottomPanelView(R.views.lobby.battleRoyale.hangar_bottom_panel_cmp.HangarBottomPanelCmp())


class HangarBottomPanelView(ViewImpl, IGlobalListener):
    __battleRoyaleController = dependency.descriptor(IBattleRoyaleController)
    __itemsCache = dependency.descriptor(IItemsCache)

    def __init__(self, viewKey, viewModelClazz=HangarBottomPanelViewModel):
        settings = ViewSettings(viewKey)
        settings.flags = ViewFlags.COMPONENT
        settings.model = viewModelClazz()
        super(HangarBottomPanelView, self).__init__(settings)
        self.__isModuleViewed = False

    @property
    def viewModel(self):
        return super(HangarBottomPanelView, self).getViewModel()

    def createToolTip(self, event):
        if event.contentID == R.views.common.tooltip_window.backport_tooltip_content.BackportTooltipContent():
            tooltipData = self.__getTooltipData(event)
            window = BackportTooltipWindow(tooltipData, self.getParentWindow()) if tooltipData is not None else None
            if window is not None:
                window.load()
            return window
        return super(HangarBottomPanelView, self).createToolTip(event)

    def onPrbEntitySwitched(self):
        self.__updateVehicleStatus()

    def _initialize(self, *args, **kwargs):
        super(HangarBottomPanelView, self)._initialize(*args, **kwargs)
        self.__setRepairPrice()
        self.__addListeners()
        self.__updateModel()

    def _finalize(self):
        self.__removeListeners()
        super(HangarBottomPanelView, self)._finalize()

    @decorators.process('updateMyVehicles')
    def __repair(self):
        vehicle = g_currentVehicle.item
        result = yield VehicleRepairer(vehicle).request()
        if result and result.userMsg:
            SystemMessages.pushI18nMessage(result.userMsg, type=result.sysMsgType)

    def __addListeners(self):
        self.viewModel.onModuleBtnClicked += self.__onModuleBtnClicked
        self.viewModel.onRepairBtnClicked += self.__onRepairBtnClicked
        g_currentVehicle.onChanged += self.__onCurrentVehicleChanged
        g_clientUpdateManager.addMoneyCallback(self.__moneyUpdateCallback)
        self.__battleRoyaleController.onUpdated += self.__updateModel
        self.startGlobalListening()

    def __removeListeners(self):
        self.viewModel.onModuleBtnClicked -= self.__onModuleBtnClicked
        self.viewModel.onModuleBtnClicked -= self.__onRepairBtnClicked
        g_currentVehicle.onChanged -= self.__onCurrentVehicleChanged
        g_clientUpdateManager.removeObjectCallbacks(self)
        self.__battleRoyaleController.onUpdated -= self.__updateModel
        self.stopGlobalListening()

    def __onModuleBtnClicked(self):
        event_dispatcher.showHangarVehicleConfigurator(not self.__isModuleViewed)

    @process
    def __onRepairBtnClicked(self):
        msg = backport.text(R.strings.dialogs.technicalMaintenanceConfirm.msg_repair())
        isConfirmed = yield DialogsInterface.showDialog(I18nConfirmDialogMeta('technicalMaintenanceConfirm', messageCtx={'content': msg}))
        if isConfirmed and g_currentVehicle.item.isBroken:
            self.__repair()

    def __onCurrentVehicleChanged(self):
        self.__updateModel()

    def __moneyUpdateCallback(self, *_):
        self.__updateRepairPrice()

    def __updateModel(self):
        vehicle = g_currentVehicle.item
        if isIncorrectVehicle(vehicle):
            return
        self.__setAmmo(vehicle)
        self.__setAbilities(vehicle)
        self.__setRepairPrice()
        self.__updateRepairPrice()
        self.__updateVehicleStatus()
        self.__updateModuleButtonBubble()

    def __setAmmo(self, vehicle):
        items = self.viewModel.ammunition.getItems()
        self.__fillArtefactGroup(items, vehicle.shells.installed, False, vehicle)

    def __setAbilities(self, vehicle):
        vehicleEquipment = []
        vehicleEquipmentIds = self.__battleRoyaleController.getBrVehicleEquipmentIds(vehicle.name)
        if vehicleEquipmentIds is not None:
            vehicleEquipment = [ createEquipmentById(eqId) for eqId in vehicleEquipmentIds ]
        items = self.viewModel.abilities.getItems()
        self.__fillArtefactGroup(items, vehicleEquipment, True, vehicle)
        return

    def __setRepairPrice(self):
        vehicle = g_currentVehicle.item
        if isIncorrectVehicle(vehicle):
            return
        items = self.viewModel.repairPrice.getItems()
        items.clear()
        repairCost = vehicle.repairCost
        itemPrice = ItemPrice(price=Money(credits=repairCost), defPrice=Money(credits=repairCost))
        actionPriceModels = getItemPricesViewModel(self.__itemsCache.items.stats.money, itemPrice)[0]
        for model in actionPriceModels:
            items.addViewModel(model)

        items.invalidate()

    def __updateRepairPrice(self):
        vehicle = g_currentVehicle.item
        if isIncorrectVehicle(vehicle):
            return
        repairCost = vehicle.repairCost
        if repairCost <= 0:
            self.viewModel.setIsRepairBtnVisible(False)
            return
        with self.viewModel.transaction() as (vm):
            vm.setIsRepairBtnVisible(True)
            for priceModel in vm.repairPrice.getItems():
                currencyType = priceModel.getType()
                if currencyType == Currency.CREDITS:
                    isEnough = repairCost <= self.__itemsCache.items.stats.money.get(currencyType)
                    with priceModel.transaction() as (pm):
                        pm.setPrice(getIntegralFormat(repairCost))
                        pm.setIsEnough(isEnough)
                    vm.setIsRepairBtnDisabled(not isEnough)
                    break

    def __updateVehicleStatus(self):
        if g_currentVehicle.isPresent():
            state, msgLvl = g_currentVehicle.item.getState()
            if state == Vehicle.VEHICLE_STATE.LOCKED:
                return
            message = R.strings.menu.currentVehicleStatus.dyn(state)()
            msgString = makeHtmlString('html_templates:vehicleStatus', msgLvl, {'message': backport.text(message)})
            if self.viewModel.getVehStatus() == msgString:
                return
            self.viewModel.setVehStatus(msgString)

    def __updateModuleButtonBubble(self):
        self.__isModuleViewed = AccountSettings.getSettings(BATTLE_ROYALE_HANGAR_BOTTOM_PANEL_VIEWED)
        self.viewModel.setIsModuleFirstEnter(not self.__isModuleViewed)

    def __fillArtefactGroup(self, items, artefactGroup, isEquipment, vehicle):
        if items is None:
            return
        else:
            items.clear()
            for artefact in artefactGroup:
                data = self.__getArtefactData(artefact, vehicle, isEquipment)
                itemModel = BattleRoyaleConsumableModel()
                itemModel.setIconSource(data.icon)
                itemModel.setQuantity(data.quantity)
                itemModel.setIntCD(data.intCD)
                itemModel.setTooltipType(data.tooltip)
                items.addViewModel(itemModel)

            items.invalidate()
            return

    def __getArtefactData(self, artefact, vehicle, isEquipment):
        if isEquipment:
            return self.__getEquipmentData(artefact, vehicle.name)
        return self.__getAmmoData(artefact, vehicle)

    def __getAmmoData(self, shell, vehicle):
        isBasic = ShellParams(shell.descriptor, vehicle.descriptor).isBasic
        ammoType = AmmoTypes.BASIC_SHELL if isBasic else AmmoTypes.PREMIUM_SHELL
        count = self.__getEquipmentCount(ammoType) * vehicle.gun.maxAmmo
        return _ArtefactData(intCD=shell.intCD, quantity=count, icon=R.images.gui.maps.icons.shell.small.dyn(shell.descriptor.iconName)(), tooltip=EquipmentPanelCmpTooltips.TOOLTIP_SHELL)

    def __getEquipmentData(self, equipment, vehicleName):
        intCD = equipment.id[1]
        count = self.__getEquipmentCount(AmmoTypes.ITEM, intCD, vehicleName)
        return _ArtefactData(intCD=intCD, quantity=count, icon=R.images.gui.maps.icons.battleRoyale.artefact.dyn(equipment.iconName)(), tooltip=EquipmentPanelCmpTooltips.TOOLTIP_EQUIPMENT)

    def __getEquipmentCount(self, typeKey, intCD=None, vehicleName=None):
        return self.__battleRoyaleController.getDefaultAmmoCount(typeKey, intCD, vehicleName)

    @staticmethod
    def __getTooltipData(event):
        tooltipType = event.getArgument('tooltipType')
        intCD = event.getArgument('intCD')
        if not tooltipType or not intCD:
            return None
        return createTooltipData(isSpecial=True, specialAlias=tooltipType, specialArgs=(
         intCD, _DEFAULT_SLOT_VALUE))