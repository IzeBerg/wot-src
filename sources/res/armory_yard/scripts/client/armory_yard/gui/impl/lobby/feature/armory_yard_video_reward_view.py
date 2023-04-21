import Windowing
from CurrentVehicle import g_currentVehicle
from armory_yard.gui.Scaleform.daapi.view.lobby.hangar.sound_constants import ARMORY_YARD_REWARD_VIDEO_SOUND_SPACE
from armory_yard.gui.Scaleform.daapi.view.lobby.hangar.sounds import ArmoryYardRewardVideoSoundControl
from helpers import dependency
from frameworks.wulf import ViewFlags, ViewSettings, WindowFlags
from gui.impl.gen import R
from armory_yard.gui.impl.gen.view_models.views.lobby.feature.armory_yard_video_reward_view_model import ArmoryYardVideoRewardViewModel
from gui.impl.pub import ViewImpl
from gui.impl.pub.lobby_window import LobbyWindow
from skeletons.gui.shared import IItemsCache
from gui.shared.event_dispatcher import showHangar
from items.vehicles import getVehicleClassFromVehicleType

class ArmoryYardVideoRewardView(ViewImpl):
    __slots__ = ('__vehicle', '__soundControl')
    __itemsCache = dependency.descriptor(IItemsCache)
    _COMMON_SOUND_SPACE = ARMORY_YARD_REWARD_VIDEO_SOUND_SPACE

    def __init__(self, layoutID, vehicle):
        settings = ViewSettings(layoutID)
        settings.flags = ViewFlags.VIEW
        settings.model = ArmoryYardVideoRewardViewModel()
        super(ArmoryYardVideoRewardView, self).__init__(settings)
        self.__vehicle = vehicle
        self.__soundControl = ArmoryYardRewardVideoSoundControl()

    def _finalize(self):
        Windowing.removeWindowAccessibilityHandler(self.__onWindowAccessibilityChanged)
        self.__soundControl.stop()
        super(ArmoryYardVideoRewardView, self)._finalize()

    @property
    def viewModel(self):
        return super(ArmoryYardVideoRewardView, self).getViewModel()

    def _onLoading(self, *args, **kwargs):
        super(ArmoryYardVideoRewardView, self)._onLoading(*args, **kwargs)
        with self.viewModel.transaction() as (vm):
            vm.setVehicleName(self.__vehicle.userName)
            vm.setVehicleLvl(self.__vehicle.level)
            vm.setVehicleType(getVehicleClassFromVehicleType(self.__vehicle.descriptor.type))
            vm.setIsElite(self.__vehicle.isElite)
            vm.setIsWindowAccessible(Windowing.isWindowAccessible())
        Windowing.addWindowAccessibilitynHandler(self.__onWindowAccessibilityChanged)

    def _getEvents(self):
        return (
         (
          self.viewModel.onClose, self.__onClose),
         (
          self.viewModel.onShowVehicle, self.__onShowVehicle),
         (
          self.viewModel.onVideoStarted, self.__onVideoStarted))

    def __onShowVehicle(self):
        vehicle = self.__itemsCache.items.getItemByCD(self.__vehicle.intCD)
        if vehicle.isInInventory:
            showHangar()
            g_currentVehicle.selectVehicle(vehicle.invID)
            self.destroyWindow()

    def __onClose(self):
        self.destroyWindow()

    def __onVideoStarted(self):
        self.__soundControl.start()
        if not Windowing.isWindowAccessible():
            self.__soundControl.pause()

    def __onWindowAccessibilityChanged(self, isWindowAccessible):
        if isWindowAccessible:
            self.__soundControl.unpause()
        else:
            self.__soundControl.pause()
        self.viewModel.setIsWindowAccessible(isWindowAccessible)


class ArmoryYardVideoRewardWindow(LobbyWindow):
    __slots__ = ()

    def __init__(self, vehicle, parent=None):
        super(ArmoryYardVideoRewardWindow, self).__init__(wndFlags=WindowFlags.WINDOW | WindowFlags.WINDOW_FULLSCREEN, content=ArmoryYardVideoRewardView(R.views.armory_yard.lobby.feature.ArmoryYardVideoRewardView(), vehicle=vehicle), parent=parent)