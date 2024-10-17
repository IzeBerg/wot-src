from CurrentVehicle import g_currentVehicle
from frameworks.wulf import ViewSettings, ViewFlags, WindowLayer
from gui.ClientUpdateManager import g_clientUpdateManager
from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
from gui.Scaleform.framework.managers.containers import POP_UP_CRITERIA
from gui.app_loader import sf_lobby
from gui.impl import backport
from gui.impl.backport import createTooltipData, BackportTooltipWindow
from gui.impl.gen import R
from gui.impl.pub import ViewImpl
from gui.shared.utils.functions import replaceHyphenToUnderscore
from halloween.gui.halloween_gui_constants import HALLOWEEN_CAROUSEL_VEHICLE_TOOLTIP
from halloween.gui.impl.gen.view_models.views.lobby.widgets.hangar_carousel_vehicle_view_model import HangarCarouselVehicleViewModel, VehicleTypes
from halloween.gui.impl.gen.view_models.views.lobby.widgets.hangar_carousel_view_model import HangarCarouselViewModel
from halloween.gui.impl.lobby import getVehicleState
from halloween.gui.impl.lobby.hw_helpers import isDailyKeyQuestCompleted, getDailyKeyQuestDescription
from halloween.gui.impl.lobby.tooltips.simple_format_tooltip import SimpleFormatTooltipView
from halloween.gui.shared import isHalloweenDefenceSelected
from halloween.skeletons.halloween_artefacts_controller import IHalloweenArtefactsController
from halloween.skeletons.halloween_controller import IHalloweenController
from halloween.skeletons.difficulty_level_controller import IDifficultyLevelController
from helpers import dependency
from skeletons.gui.shared import IItemsCache

class CarouselView(ViewImpl):
    _itemsCache = dependency.descriptor(IItemsCache)
    _halloweenCtrl = dependency.descriptor(IHalloweenController)
    _halloweenArtefactsCtrl = dependency.descriptor(IHalloweenArtefactsController)
    _difficultyLevelCtrl = dependency.descriptor(IDifficultyLevelController)

    def __init__(self, layoutID=R.views.halloween.lobby.widgets.CarouselView()):
        settings = ViewSettings(layoutID)
        settings.flags = ViewFlags.LOBBY_SUB_VIEW
        settings.model = HangarCarouselViewModel()
        super(CarouselView, self).__init__(settings)

    def createToolTip(self, event):
        dialogsContainer = self.__app.containerManager.getContainer(WindowLayer.TOP_WINDOW)
        if dialogsContainer.getView(criteria={POP_UP_CRITERIA.VIEW_ALIAS: VIEW_ALIAS.LOBBY_MENU}):
            return
        else:
            if event.contentID == R.views.common.tooltip_window.backport_tooltip_content.BackportTooltipContent():
                tooltipId = event.getArgument('tooltipId')
                specialArgs = []
                if tooltipId == HALLOWEEN_CAROUSEL_VEHICLE_TOOLTIP:
                    intCD = event.getArgument('intCD', None)
                    if intCD is not None:
                        specialArgs = [
                         int(intCD)]
                window = BackportTooltipWindow(createTooltipData(isSpecial=True, specialAlias=tooltipId, specialArgs=specialArgs), self.getParentWindow())
                window.load()
                return window
            return super(CarouselView, self).createToolTip(event)

    def createToolTipContent(self, event, contentID):
        if contentID == R.views.halloween.lobby.tooltips.SimpleFormatTooltip():
            if event.getArgument('id', '') == 'dailyQuest' and g_currentVehicle.item:
                return SimpleFormatTooltipView(header=backport.text(R.strings.halloween_lobby.carousel.daily.header()), body=getDailyKeyQuestDescription(g_currentVehicle.intCD))
        return super(CarouselView, self).createToolTipContent(event, contentID)

    @property
    def viewModel(self):
        return super(CarouselView, self).getViewModel()

    @sf_lobby
    def __app(self):
        return

    def _getVehicles(self):
        hwVehicles = [ self._itemsCache.items.getItemByCD(intCD) for intCD in self._halloweenCtrl.getModeSettings().vehicles
                     ]
        return hwVehicles

    def _onLoading(self, *args, **kwargs):
        super(CarouselView, self)._onLoading(*args, **kwargs)
        self.__fillVehicles()

    def _subscribe(self):
        super(CarouselView, self)._subscribe()
        g_clientUpdateManager.addCallbacks({'cache.vehsLock': self.__onVehicleLockUpdated})
        g_currentVehicle.onChanged += self.__onCurrentVehicleChanged
        self._halloweenArtefactsCtrl.onArtefactSettingsUpdated += self.__onRentVehicleStatusUpdate
        self.viewModel.onChangeVehicle += self.__onTankChanged
        self._difficultyLevelCtrl.onChangeDifficultyLevel += self.__fillVehicles

    def _unsubscribe(self):
        super(CarouselView, self)._unsubscribe()
        g_clientUpdateManager.removeObjectCallbacks(self)
        g_currentVehicle.onChanged -= self.__onCurrentVehicleChanged
        self._halloweenArtefactsCtrl.onArtefactSettingsUpdated -= self.__onRentVehicleStatusUpdate
        self.viewModel.onChangeVehicle -= self.__onTankChanged
        self._difficultyLevelCtrl.onChangeDifficultyLevel -= self.__fillVehicles

    def __onVehicleLockUpdated(self, *args):
        self.__fillVehicles()

    def __onRentVehicleStatusUpdate(self):
        self.__fillVehicles()

    def __fillVehicles(self, *args):
        if isHalloweenDefenceSelected():
            return
        with self.viewModel.transaction() as (vm):
            if g_currentVehicle.item:
                vm.setSelectedVehicle(g_currentVehicle.invID)
            vm.getVehicles().clear()
            for vehicle in self._getVehicles():
                model = HangarCarouselVehicleViewModel()
                model.setName(vehicle.userName)
                model.setIntCD(vehicle.intCD)
                model.setInvID(vehicle.invID)
                model.setIconName(replaceHyphenToUnderscore(vehicle.name.replace(':', '-')))
                model.setVehicleType(VehicleTypes(vehicle.type) if vehicle.type != '' else VehicleTypes.NONE)
                model.setVehicleState(getVehicleState(vehicle))
                model.setHasDaily(not isDailyKeyQuestCompleted(vehicle.intCD))
                vm.getVehicles().addViewModel(model)

            vm.getVehicles().invalidate()

    def __onCurrentVehicleChanged(self):
        if g_currentVehicle.item is None:
            return
        else:
            self.viewModel.setSelectedVehicle(g_currentVehicle.invID)
            return

    def __onTankChanged(self, args):
        if args is not None:
            self.__selectVehicle(int(args.get('invID')))
        return

    def __selectVehicle(self, invID):
        self._halloweenCtrl.selectVehicle(invID)