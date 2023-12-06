import wg_async as future_async
from adisp import adisp_async
from gui import SystemMessages, makeHtmlString
from gui.Scaleform.daapi.view.lobby.rally.vo_converters import makeVehicleBasicVO
from gui.Scaleform.daapi.view.lobby.vehicle_compare.formatters import packHeaderColumnData
from gui.Scaleform.daapi.view.lobby.vehicle_selector_base import VehicleSelectorBase
from gui.Scaleform.daapi.view.meta.NYSelectVehiclePopoverMeta import NYSelectVehiclePopoverMeta
from gui.Scaleform.locale.DIALOGS import DIALOGS
from gui.Scaleform.locale.RES_ICONS import RES_ICONS
from gui.Scaleform.locale.SYSTEM_MESSAGES import SYSTEM_MESSAGES
from gui.SystemMessages import SM_TYPE
from gui.impl import backport
from gui.impl.dialogs import dialogs
from gui.impl.dialogs.builders import ResSimpleDialogBuilder
from gui.impl.gen import R
from gui.impl.new_year.new_year_helper import formatRomanNumber
from gui.Scaleform.framework.entities.DAAPIDataProvider import SortableDAAPIDataProvider
from gui.shared.gui_items import GUI_ITEM_TYPE
from gui.shared.items_cache import CACHE_SYNC_REASON
from gui.shared.notifications import NotificationPriorityLevel
from gui.shared.utils import decorators
from gui.shared.utils.requesters import REQ_CRITERIA
from helpers import dependency, i18n
from new_year.ny_processor import ApplyVehicleDiscountProcessor
from new_year.variadic_discount import VariadicDiscount
from skeletons.gui.shared import IItemsCache
from skeletons.new_year import INewYearController

class NYSelectVehicleForDiscountPopover(VehicleSelectorBase, NYSelectVehiclePopoverMeta):
    __itemsCache = dependency.descriptor(IItemsCache)
    __nyController = dependency.descriptor(INewYearController)

    def __init__(self, ctx=None):
        VehicleSelectorBase.__init__(self)
        NYSelectVehiclePopoverMeta.__init__(self)
        data = ctx.get('data')
        discountID = data.get('variadicID')
        self.__variadicDiscount = VariadicDiscount(discountID)
        self.__vehiclesByDiscount = self.__variadicDiscount.getVehiclesByDiscount()
        self._levelsRange = [self.__variadicDiscount.getTankLevel()]
        self._compatibleOnlyLabel = backport.text(R.strings.ny.applyDiscountWindow.compatibleCheckBox.label())

    def applyFilters(self, nation, vehicleType, level):
        self._updateFilter(nation, vehicleType, False, level)
        self.__updateData()

    def onSelectVehicle(self, vehicleCD):
        self.__onSelectVehicle(vehicleCD)

    def onWindowClose(self):
        self.destroy()

    def _populate(self):
        super(NYSelectVehicleForDiscountPopover, self)._populate()
        self.__vehicleDP = NySelectVehiclePopoverDataProvider()
        self.__vehicleDP.setFlashObject(self.as_getDPS())
        self.__itemsCache.onSyncCompleted += self.__onResync
        self.__initControls()
        self.__updateData()

    def _dispose(self):
        self.__itemsCache.onSyncCompleted -= self.__onResync
        self.__vehicleDP.fini()
        self.__vehicleDP = None
        super(NYSelectVehicleForDiscountPopover, self)._dispose()
        return

    def _makeVehicleVOAction(self, vehicle):
        return makeVehicleBasicVO(vehicle)

    def __onResync(self, reason, diff):
        if reason == CACHE_SYNC_REASON.INVENTORY_RESYNC or GUI_ITEM_TYPE.VEHICLE in diff:
            self.__vehicleDP.clear()
            self.__updateData()

    def __initControls(self):
        headers = [
         packHeaderColumnData('nationID', 49, 40, tooltip=DIALOGS.TRADEINPOPOVER_SORTING_NATION, icon=RES_ICONS.MAPS_ICONS_FILTERS_NATIONS_ALL, enabled=True),
         packHeaderColumnData('typeIndex', 45, 40, tooltip=DIALOGS.TRADEINPOPOVER_SORTING_VEHTYPE, icon=RES_ICONS.MAPS_ICONS_FILTERS_TANKS_ALL, enabled=True),
         packHeaderColumnData('shortUserName', 148, 40, label=DIALOGS.TRADEINPOPOVER_SORTING_VEHNAME_HEADER, tooltip=DIALOGS.TRADEINPOPOVER_SORTING_VEHNAME, enabled=True, verticalTextAlign='center')]
        levelStr = formatRomanNumber(self.__variadicDiscount.getTankLevel())
        discountStr = str(self.__variadicDiscount.getDiscountValue())
        title = backport.text(R.strings.ny.applyDiscountWindow.title(), level=levelStr)
        description = backport.text(R.strings.ny.applyDiscountWindow.infoText(), level=levelStr, discount=discountStr)
        self.as_setInitDataS({'title': title, 
           'description': description, 
           'defaultSortField': 'level', 
           'defaultSortDirection': 'descending', 
           'tableHeaders': headers, 
           'filters': self.__initFilters()})

    def __initFilters(self):
        filters = self._initFilter(nation=-1, vehicleType='none', isMain=False, level=-1, compatibleOnly=False)
        self._updateFilter(filters['nation'], filters['vehicleType'], filters['isMain'], filters['level'], filters['compatibleOnly'])
        return filters

    def __updateData(self):
        allVehicles = self.__itemsCache.items.getVehicles(REQ_CRITERIA.VEHICLE.SPECIFIC_BY_CD(self.__vehiclesByDiscount.keys()) | ~REQ_CRITERIA.INVENTORY)
        vehicles = self._updateData(allVehicles, compatiblePredicate=lambda vo: vo['isUnlocked'])
        self.__vehicleDP.buildList(vehicles)

    @decorators.adisp_process()
    def __onSelectVehicle(self, vehicleCD):
        vehicle = self.__itemsCache.items.getItemByCD(int(vehicleCD))
        discountValue = self.__variadicDiscount.getDiscountValue()
        isOk = yield self.__confirmApplyVehicleDialog(vehicle, discountValue)
        if isOk:
            self.__applyDiscountProcess(vehicle)

    @decorators.adisp_process('newYear/applyVehicleDiscount')
    def __applyDiscountProcess(self, vehicle):
        goodiesID = self.__vehiclesByDiscount[vehicle.intCD]
        discountID = self.__variadicDiscount.getID()
        discountValue = self.__variadicDiscount.getDiscountValue()
        result = yield ApplyVehicleDiscountProcessor(goodiesID, discountID).request()
        if result.success:
            SystemMessages.pushMessage(i18n.makeString(SYSTEM_MESSAGES.NEWYEAR_APPLYVEHICLEDISCOUNT_SUCCESS, discount=discountValue, vehName=vehicle.userName), priority=NotificationPriorityLevel.MEDIUM, type=result.sysMsgType)
            self.__nyController.updateVariadicDiscounts()
        else:
            SystemMessages.pushMessage(result.userMsg, priority=NotificationPriorityLevel.MEDIUM, type=SM_TYPE.Error)
        self.onWindowClose()

    @adisp_async
    @future_async.wg_async
    def __confirmApplyVehicleDialog(self, vehicle, discountValue, callback):
        ctx = {'discount': discountValue, 
           'vehicleName': vehicle.userName, 
           'vehicleType': vehicle.type}
        formattedMessage = makeHtmlString('html_templates:newYear/dialogs', 'confirmVehDiscount', ctx=ctx, sourceKey='text')
        builder = ResSimpleDialogBuilder()
        builder.setMessagesAndButtons(R.strings.dialogs.confirmApplyVehicleDiscount)
        builder.setFormattedMessage(formattedMessage)
        result = yield future_async.wg_await(dialogs.showSimple(builder.build()))
        callback(result)


class NySelectVehiclePopoverDataProvider(SortableDAAPIDataProvider):

    def __init__(self):
        super(NySelectVehiclePopoverDataProvider, self).__init__()
        self.__list = []
        self.__mapping = {}
        self.__selectedID = None
        return

    @property
    def collection(self):
        return self.__list

    def emptyItem(self):
        return

    def clear(self):
        self.__list = []
        self.__mapping.clear()
        self.__selectedID = None
        return

    def fini(self):
        self.clear()
        self.destroy()

    def getSelectedIdx(self):
        if self.__selectedID in self.__mapping:
            return self.__mapping[self.__selectedID]
        return -1

    def setSelectedID(self, selId):
        self.__selectedID = selId

    def buildList(self, vehicleVOs):
        self.__list = vehicleVOs
        self.refresh()

    def pyGetSelectedIdx(self):
        return self.getSelectedIdx()

    def pySortOn(self, fields, order):
        super(NySelectVehiclePopoverDataProvider, self).pySortOn(fields, order)
        self.__rebuildMapping()
        self.refresh()

    def __rebuildMapping(self):
        self.__mapping = {item['intCD']:idx for idx, item in enumerate(self.sortedCollection)}