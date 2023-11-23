from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
from gui.Scaleform.framework.entities.View import ViewKey
from gui.Scaleform.framework.managers.view_lifecycle_watcher import IViewLifecycleHandler
from gui.shared.system_factory import registerCarouselEventEntryPoint
from gui.impl.lobby.new_year.lootbox_entry_point.ny_lootbox_entry_point_view import NyLootBoxesEntryPoint
from gui.impl.gen import R
registerCarouselEventEntryPoint(R.views.lobby.new_year.loot_box.LootBoxEntryView(), NyLootBoxesEntryPoint)

class DiscountPopoverHandler(IViewLifecycleHandler):

    def __init__(self, onViewCreatedCallback, onViewDestroyedCallback):
        super(DiscountPopoverHandler, self).__init__([
         ViewKey(VIEW_ALIAS.NY_SELECT_VEHICLE_FOR_DISCOUNT_POPOVER)])
        self.__onViewCreatedCallback = onViewCreatedCallback
        self.__onViewDestroyedCallback = onViewDestroyedCallback

    def onViewCreated(self, view):
        self.__onViewCreatedCallback()

    def onViewDestroyed(self, _):
        self.__onViewDestroyedCallback()