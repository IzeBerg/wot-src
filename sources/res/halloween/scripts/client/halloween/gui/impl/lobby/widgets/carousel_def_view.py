import copy, json
from CurrentVehicle import g_currentVehicle
from account_helpers import AccountSettings
from frameworks.wulf import ViewFlags, ViewSettings
from gui import GUI_NATIONS, GUI_NATIONS_ORDER_INDEX
from gui.shared.gui_items.Vehicle import VEHICLE_TYPES_ORDER_INDICES
from gui.ClientUpdateManager import g_clientUpdateManager
from gui.impl.backport import createTooltipData, BackportTooltipWindow
from gui.impl.gen import R
from gui.impl.pub import ViewImpl
from gui.shared.gui_items.Vehicle import getIconResourceName
from halloween.gui.impl.lobby import getDefVehicalState
from halloween.gui.halloween_account_settings import AccountSettingsKeys
from halloween.gui.halloween_gui_constants import HALLOWEEN_CAROUSEL_VEHICLE_TOOLTIP_DEF
from halloween.gui.impl.gen.view_models.views.lobby.widgets.hangar_carousel_def_view_model import HangarCarouselDefViewModel
from halloween.gui.impl.gen.view_models.views.lobby.widgets.hangar_carousel_filter_view_model import FilterKeys
from halloween.gui.shared import isHalloweenDefenceSelected
from halloween.skeletons.difficulty_level_controller import IDifficultyLevelController
from halloween.skeletons.halloween_controller import IHalloweenController
from helpers import dependency
from skeletons.gui.shared import IItemsCache
DEFAULT_FILTER = {FilterKeys.ISFAVORITE.value: False, 
   FilterKeys.ISPREMIUM.value: False, 
   FilterKeys.ISRENT.value: False, 
   FilterKeys.ISELITE.value: False, 
   FilterKeys.VEHICLETYPE.value: [], FilterKeys.NATION.value: [], FilterKeys.SEARCHNAME.value: ''}

class CarouselDefView(ViewImpl):
    _itemsCache = dependency.descriptor(IItemsCache)
    _halloweenCtrl = dependency.descriptor(IHalloweenController)
    _difficultyController = dependency.descriptor(IDifficultyLevelController)

    def __init__(self, layoutID=R.views.halloween.lobby.widgets.CarouselDefView()):
        settings = ViewSettings(layoutID)
        settings.flags = ViewFlags.LOBBY_SUB_VIEW
        settings.model = HangarCarouselDefViewModel()
        super(CarouselDefView, self).__init__(settings)
        self.__filter = {}
        self.__filteredTypes = []
        self.__filteredNations = []

    @property
    def viewModel(self):
        return super(CarouselDefView, self).getViewModel()

    def createToolTip(self, event):
        if event.contentID == R.views.common.tooltip_window.backport_tooltip_content.BackportTooltipContent():
            tooltipId = event.getArgument('tooltipId')
            specialArgs = []
            if tooltipId == HALLOWEEN_CAROUSEL_VEHICLE_TOOLTIP_DEF:
                intCD = event.getArgument('intCD', None)
                if intCD is not None:
                    specialArgs = [
                     int(intCD)]
            window = BackportTooltipWindow(createTooltipData(isSpecial=True, specialAlias=tooltipId, specialArgs=specialArgs), self.getParentWindow())
            window.load()
            return window
        else:
            return super(CarouselDefView, self).createToolTip(event)

    def _onLoading(self, *args, **kwargs):
        super(CarouselDefView, self)._onLoading(*args, **kwargs)
        self.__fillModel()
        self.__loadFilters()
        self.__fillFilter()

    def _subscribe(self):
        super(CarouselDefView, self)._subscribe()
        g_clientUpdateManager.addCallbacks({'cache.vehsLock': self.__onVehicleLockUpdated, 
           'inventory.1': self.__fillVehicles})

    def _unsubscribe(self):
        super(CarouselDefView, self)._unsubscribe()
        g_clientUpdateManager.removeObjectCallbacks(self)

    def _getEvents(self):
        return [
         (
          self.viewModel.onChangeVehicle, self.__onChangeVehicle),
         (
          self.viewModel.filter.onFiltered, self.__onFiltered),
         (
          self.viewModel.filter.onReset, self.__onReset),
         (
          self._difficultyController.onChangeDifficultyLevel, self.__onDifficultyChange),
         (
          g_currentVehicle.onChanged, self.__onCurrentVehicleChanged),
         (
          self._halloweenCtrl.onSettingsUpdate, self.__fillVehicles)]

    def _getVehicles(self):
        hwVehicles = self._halloweenCtrl.getDefenceSuitableVehicles()
        vehicles = []
        for value in sorted(hwVehicles, key=self._vehicleComparisonKey):
            vehicles.append({'name': value.descriptor.type.shortUserString, 
               'intCD': value.intCD, 
               'invID': value.invID, 
               'nation': value.nationName, 
               'icon': getIconResourceName(value.name), 
               'type': value.type.replace('-', '_'), 
               'isFavorite': value.isFavorite, 
               'isPremium': value.isPremium, 
               'isPremiumIGR': value.isPremiumIGR, 
               'isElite': value.isElite, 
               'isRent': value.isRented, 
               'vehicleState': getDefVehicalState(value)})

        return json.dumps(vehicles)

    @classmethod
    def _vehicleComparisonKey(cls, vehicle):
        return (not vehicle.isFavorite,
         GUI_NATIONS_ORDER_INDEX[vehicle.nationName],
         VEHICLE_TYPES_ORDER_INDICES[vehicle.type],
         vehicle.level,
         vehicle.userName)

    def __fillVehicles(self, *args, **kwargs):
        vehicles = self._getVehicles()
        self.viewModel.setVehicles(str(vehicles))

    def __fillModel(self):
        if not isHalloweenDefenceSelected():
            return
        if g_currentVehicle.item:
            self.viewModel.setSelectedVehicle(g_currentVehicle.invID)
        self.__fillVehicles()
        self.viewModel.getOrderedNations().clear()
        for nation in GUI_NATIONS:
            self.viewModel.getOrderedNations().addString(nation)

    def __onReset(self):
        self.__filteredTypes = []
        self.__filteredNations = []
        self.__filter = copy.deepcopy(DEFAULT_FILTER)
        self.__fillFilter()
        self.__saveFilter()

    def __onDifficultyChange(self, _):
        self.__fillModel()

    def __onChangeVehicle(self, args):
        if args is not None:
            self._halloweenCtrl.selectVehicle(int(args.get('invID')))
        return

    def __onFiltered(self, args):
        key = args.get('key', None)
        value = args.get('value', None)
        if key is None or value is None:
            return
        if key == FilterKeys.ISFAVORITE.value:
            self.viewModel.filter.setIsFavorite(value)
            self.__filter[FilterKeys.ISFAVORITE.value] = value
        if key == FilterKeys.ISPREMIUM.value:
            self.viewModel.filter.setIsPremium(value)
            self.__filter[FilterKeys.ISPREMIUM.value] = value
        if key == FilterKeys.ISRENT.value:
            self.viewModel.filter.setIsRent(value)
            self.__filter[FilterKeys.ISRENT.value] = value
        if key == FilterKeys.ISELITE.value:
            self.viewModel.filter.setIsElite(value)
            self.__filter[FilterKeys.ISELITE.value] = value
        if key == FilterKeys.VEHICLETYPE.value:
            self.__addOrRemove(self.__filteredTypes, value)
            self.viewModel.filter.setTypes(json.dumps(self.__filteredTypes))
            self.__filter[FilterKeys.VEHICLETYPE.value] = self.__filteredTypes
        if key == FilterKeys.NATION.value:
            self.__addOrRemove(self.__filteredNations, value)
            self.viewModel.filter.setNations(json.dumps(self.__filteredNations))
            self.__filter[FilterKeys.NATION.value] = self.__filteredNations
        if key == FilterKeys.SEARCHNAME.value:
            self.viewModel.filter.setName(value)
            self.__filter[FilterKeys.SEARCHNAME.value] = value
        self.__saveFilter()
        return

    def __loadFilters(self):
        settings = AccountSettings.getSettings(AccountSettingsKeys.EVENT_KEY)
        self.__filter = settings.get(AccountSettingsKeys.CAROUSEL_FILTER_DEF, None)
        if self.__filter is None or self.__filter == {}:
            self.__filter = copy.deepcopy(DEFAULT_FILTER)
        self.__filteredTypes = self.__filter.get(FilterKeys.VEHICLETYPE.value)
        self.__filteredNations = self.__filter.get(FilterKeys.NATION.value)
        return

    def __fillFilter(self):
        if self.__filter is None or self.__filter == {}:
            self.__filter = copy.deepcopy(DEFAULT_FILTER)
        with self.viewModel.transaction() as (tx):
            tx.filter.setIsPremium(self.__filter.get(FilterKeys.ISPREMIUM.value))
            tx.filter.setIsFavorite(self.__filter.get(FilterKeys.ISFAVORITE.value))
            tx.filter.setName(self.__filter.get(FilterKeys.SEARCHNAME.value, ''))
            tx.filter.setNations(json.dumps(self.__filter.get(FilterKeys.NATION.value)))
            tx.filter.setTypes(json.dumps(self.__filter.get(FilterKeys.VEHICLETYPE.value)))
            tx.filter.setIsRent(self.__filter.get(FilterKeys.ISRENT.value))
            tx.filter.setIsElite(self.__filter.get(FilterKeys.ISELITE.value))
        return

    def __saveFilter(self):
        settings = AccountSettings.getSettings(AccountSettingsKeys.EVENT_KEY)
        settings[AccountSettingsKeys.CAROUSEL_FILTER_DEF] = self.__filter
        AccountSettings.setSettings(AccountSettingsKeys.EVENT_KEY, settings)

    def __addOrRemove(self, arr, value):
        if value in arr:
            arr.remove(value)
        else:
            arr.append(value)

    def __onCurrentVehicleChanged(self):
        if g_currentVehicle.item is None:
            return
        else:
            self.viewModel.setSelectedVehicle(g_currentVehicle.invID)
            return

    def __onVehicleLockUpdated(self, *args):
        self.__fillVehicles()