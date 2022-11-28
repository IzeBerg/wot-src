import Windowing
from frameworks.wulf import ViewSettings, WindowFlags, WindowLayer
from gui.impl.gen import R
from gui.impl.gen.view_models.views.lobby.lootboxes.loot_box_entry_video_view_model import LootBoxEntryVideoViewModel
from frameworks.wulf import ViewFlags
from gui.impl.lobby.loot_box.loot_box_helper import LootBoxHideableView
from gui.impl.pub.lobby_window import LobbyWindow
from gui.shared.gui_items.loot_box import NewYearLootBoxes, NewYearCategories
from helpers import uniprof
from gui.impl.lobby.loot_box.loot_box_sounds import LootBoxVideoStartStopHandler, LootBoxVideos
from gui.shared import EVENT_BUS_SCOPE, g_eventBus
from gui.shared import events
_VIDEO_BUFFER_TIME = 1
_PREMIUM_EMPTY = 'premium_empty'

class LootBoxEntryVideoView(LootBoxHideableView):
    __slots__ = ('__videoStartStopHandler', '__prevBoxName')

    def __init__(self, layoutID):
        settings = ViewSettings(layoutID, flags=ViewFlags.NON_REARRANGE_VIEW, model=LootBoxEntryVideoViewModel())
        super(LootBoxEntryVideoView, self).__init__(settings)
        self.__videoStartStopHandler = LootBoxVideoStartStopHandler()
        self.__prevBoxName = None
        return

    @property
    def viewModel(self):
        return super(LootBoxEntryVideoView, self).getViewModel()

    def _onLoaded(self, *_, **__):
        g_eventBus.handleEvent(events.LootboxesEvent(events.LootboxesEvent.ON_ENTRY_VIEW_LOADED), EVENT_BUS_SCOPE.LOBBY)

    @uniprof.regionDecorator(label='ny.lootbox.entry', scope='enter')
    def _initialize(self):
        super(LootBoxEntryVideoView, self)._initialize()
        self.viewModel.onDeliveryVideoStarted += self.__onDeliveryVideoStarted
        self.viewModel.onDeliveryVideoStopped += self.__onDeliveryVideoStopped
        self.viewModel.onDeliveryVideoInterrupted += self.__onDeliveryVideoInterrupted
        self.viewModel.onDeliveryShowControls += self.__onDeliveryShowControls
        self.viewModel.onVideoLoadError += self.__onVideoLoadError
        self.viewModel.onBoxTransitionEnd += self.__onBoxTransitionEnd
        Windowing.addWindowAccessibilitynHandler(self.__onWindowAccessibilityChanged)
        g_eventBus.addListener(events.LootboxesEvent.ON_TAB_SELECTED, self.__onTabSelected, scope=EVENT_BUS_SCOPE.LOBBY)
        g_eventBus.addListener(events.LootboxesEvent.NEED_DELIVERY_VIDEO_START, self.__onNeedDeliveryStart, scope=EVENT_BUS_SCOPE.LOBBY)
        g_eventBus.addListener(events.LootboxesEvent.NEED_DELIVERY_VIDEO_STOP, self.__onNeedDeliveryStop, scope=EVENT_BUS_SCOPE.LOBBY)
        g_eventBus.addListener(events.LootboxesEvent.SWITCH_BOX_HOVER, self.__onSwitchBoxHover, scope=EVENT_BUS_SCOPE.LOBBY)
        with self.viewModel.transaction() as (model):
            model.setStreamBufferLength(_VIDEO_BUFFER_TIME)
            model.setIsClientFocused(Windowing.isWindowAccessible())

    @uniprof.regionDecorator(label='ny.lootbox.entry', scope='exit')
    def _finalize(self):
        self.viewModel.onDeliveryVideoStarted -= self.__onDeliveryVideoStarted
        self.viewModel.onDeliveryVideoStopped -= self.__onDeliveryVideoStopped
        self.viewModel.onDeliveryVideoInterrupted -= self.__onDeliveryVideoInterrupted
        self.viewModel.onDeliveryShowControls -= self.__onDeliveryShowControls
        self.viewModel.onVideoLoadError -= self.__onVideoLoadError
        self.viewModel.onBoxTransitionEnd -= self.__onBoxTransitionEnd
        Windowing.removeWindowAccessibilityHandler(self.__onWindowAccessibilityChanged)
        g_eventBus.removeListener(events.LootboxesEvent.ON_TAB_SELECTED, self.__onTabSelected, scope=EVENT_BUS_SCOPE.LOBBY)
        g_eventBus.removeListener(events.LootboxesEvent.NEED_DELIVERY_VIDEO_START, self.__onNeedDeliveryStart, scope=EVENT_BUS_SCOPE.LOBBY)
        g_eventBus.removeListener(events.LootboxesEvent.NEED_DELIVERY_VIDEO_STOP, self.__onNeedDeliveryStop, scope=EVENT_BUS_SCOPE.LOBBY)
        g_eventBus.removeListener(events.LootboxesEvent.SWITCH_BOX_HOVER, self.__onSwitchBoxHover, scope=EVENT_BUS_SCOPE.LOBBY)
        self.__stopVideoPlaying()
        super(LootBoxEntryVideoView, self)._finalize()

    def _getVideosList(self):
        if self._isMemoryRiskySystem:
            return [
             'lootboxes/lootbox_delivery.usm',
             'lootboxes/lootbox_entry.usm',
             'lootboxes/idles/Christmas.usm',
             'lootboxes/idles/Fairytale.usm',
             'lootboxes/idles/NewYear.usm',
             'lootboxes/idles/Oriental.usm',
             'lootboxes/idles/premium_empty.usm']
        return [
         'lootboxes/lootbox_delivery.usm',
         'lootboxes/lootbox_entry.usm',
         'lootboxes/idles/Christmas.usm',
         'lootboxes/idles/Fairytale.usm',
         'lootboxes/idles/NewYear.usm',
         'lootboxes/idles/Oriental.usm',
         'lootboxes/idles/premium_empty.usm',
         'lootboxes/opening/Christmas.usm',
         'lootboxes/opening/Fairytale.usm',
         'lootboxes/opening/NewYear.usm',
         'lootboxes/opening/Oriental.usm',
         'lootboxes/opening/idles/Christmas.usm',
         'lootboxes/opening/idles/Fairytale.usm',
         'lootboxes/opening/idles/NewYear.usm',
         'lootboxes/opening/idles/Oriental.usm',
         'StyleLootBoxCongrats/A116_XM551.webm',
         'StyleLootBoxCongrats/Cz17_Vz_55.webm',
         'StyleLootBoxCongrats/Cz17_Vz_55_CN.webm',
         'StyleLootBoxCongrats/F38_Bat_Chatillon155_58.webm',
         'StyleLootBoxCongrats/F114_Projet_4_1.webm',
         'StyleLootBoxCongrats/GB83_FV4005.webm',
         'StyleLootBoxCongrats/GB91_Super_Conqueror.webm',
         'StyleLootBoxCongrats/It15_Rinoceronte.webm',
         'StyleLootBoxCongrats/It23_CC_3.webm',
         'StyleLootBoxCongrats/R149_Object_268_4.webm',
         'StyleLootBoxCongrats/R169_ST_II.webm',
         'StyleLootBoxCongrats/S11_Strv_103B.webm',
         'VehicleLootBoxCongrats/A149_AMBT.webm',
         'VehicleLootBoxCongrats/A152_M_Project.webm',
         'VehicleLootBoxCongrats/Ch47_BZ_176.webm',
         'VehicleLootBoxCongrats/F118_Char_Mle_75.webm',
         'VehicleLootBoxCongrats/It30_CC_mod_64_Prem.webm',
         'GuestRewardKitCongrats/guestC.webm']

    def __update(self, boxName=NewYearLootBoxes.PREMIUM, hasBoxes=False):
        with self.viewModel.transaction() as (model):
            model.setStreamBufferLength(_VIDEO_BUFFER_TIME)
            if hasBoxes:
                model.setIsEmptySwitch(False)
                model.setSelectedBoxName(boxName)
                self.__prevBoxName = boxName
            elif boxName in NewYearCategories.ALL() or boxName == NewYearLootBoxes.PREMIUM:
                model.setIsEmptySwitch(False)
                model.setSelectedBoxName(_PREMIUM_EMPTY)
                self.__prevBoxName = _PREMIUM_EMPTY

    def __onTabSelected(self, event):
        ctx = event.ctx if event is not None else None
        if ctx is None:
            return
        else:
            if 'tabName' in ctx and 'hasBoxes' in ctx:
                self.__update(ctx['tabName'], ctx['hasBoxes'])
            return

    def __onWindowAccessibilityChanged(self, isWindowAccessible):
        self.__videoStartStopHandler.setIsNeedPause(not isWindowAccessible)
        self.viewModel.setIsClientFocused(isWindowAccessible)

    def __onNeedDeliveryStart(self, event=None):
        self.__startVideoPlaying()

    def __onNeedDeliveryStop(self, event=None):
        self.__stopVideoPlaying()

    def __onDeliveryVideoStarted(self, _=None):
        self.__videoStartStopHandler.onVideoStart(LootBoxVideos.DELIVERY)

    def __onDeliveryVideoStopped(self, _=None):
        self.__stopVideoPlaying()

    def __onSwitchBoxHover(self, event):
        isHovered = event.ctx.get('isBoxHovered', False)
        self.viewModel.setIsBoxHovered(isHovered)

    def __onDeliveryVideoInterrupted(self):
        pass

    def __onVideoLoadError(self):
        g_eventBus.handleEvent(events.LootboxesEvent(events.LootboxesEvent.ON_VIDEO_LOAD_ERROR), EVENT_BUS_SCOPE.LOBBY)

    def __onBoxTransitionEnd(self):
        g_eventBus.handleEvent(events.LootboxesEvent(events.LootboxesEvent.ON_BOX_TRANSITION_END), EVENT_BUS_SCOPE.LOBBY)

    def __onDeliveryShowControls(self):
        self.viewModel.setIsDeliveryVideoPlaying(False)
        g_eventBus.handleEvent(events.LootboxesEvent(events.LootboxesEvent.ON_DELIVERY_VIDEO_END), EVENT_BUS_SCOPE.LOBBY)

    def __startVideoPlaying(self):
        if not self.viewModel.getIsDeliveryVideoPlaying():
            self.viewModel.setIsDeliveryVideoPlaying(True)

    def __stopVideoPlaying(self):
        if self.viewModel.getIsDeliveryVideoPlaying():
            self.__videoStartStopHandler.onVideoDone()
            self.viewModel.setIsDeliveryVideoPlaying(False)


class LootBoxEntryVideoWindow(LobbyWindow):
    __slots__ = ()

    def __init__(self, parent=None):
        super(LootBoxEntryVideoWindow, self).__init__(wndFlags=WindowFlags.WINDOW | WindowFlags.WINDOW_FULLSCREEN, content=LootBoxEntryVideoView(R.views.lobby.loot_box.views.loot_box_entry_video_view.LootBoxEntryVideoView()), parent=parent, layer=WindowLayer.WINDOW)