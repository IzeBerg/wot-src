from account_helpers.AccountSettings import AccountSettings
from gui.Scaleform.daapi.view.lobby.vehicle_selector_base import VehicleSelectorBase
from gui.Scaleform.daapi.view.lobby.rally.vo_converters import makeVehicleVO, makeFiltersVO, makeVehicleBasicVO
from gui.Scaleform.daapi.view.meta.RosterSlotSettingsWindowMeta import RosterSlotSettingsWindowMeta
from gui.Scaleform.genConsts.CYBER_SPORT_ALIASES import CYBER_SPORT_ALIASES
from gui.Scaleform.locale.CYBERSPORT import CYBERSPORT
from gui.Scaleform.locale.TOOLTIPS import TOOLTIPS
from gui.shared.events import CSRosterSlotSettingsWindow
from gui.shared.formatters import text_styles, icons
from gui.shared.utils.requesters import REQ_CRITERIA
from helpers import dependency
from nation_change.nation_change_helpers import iterVehTypeCDsInNationGroup
from skeletons.gui.shared import IItemsCache
VEHICLE_SELECTOR_TAB_ID = 'vehicleSelectorTab'
RANGE_SELECTOR_TAB_ID = 'rangeSelectorTab'
TAB_ORDER = [
 VEHICLE_SELECTOR_TAB_ID, RANGE_SELECTOR_TAB_ID]
TAB_DATA_MAP = {VEHICLE_SELECTOR_TAB_ID: (
                           CYBER_SPORT_ALIASES.VEHICLE_SELECTOR_VIEW,
                           CYBERSPORT.WINDOW_ROSTERSLOTSETTINGS_TABBTNLBL_VEHICLE), 
   RANGE_SELECTOR_TAB_ID: (
                         CYBER_SPORT_ALIASES.RANGE_ROSTER_SETTINGS_VIEW,
                         CYBERSPORT.WINDOW_ROSTERSLOTSETTINGS_TABBTNLBL_RANGE)}

class RosterSlotSettingsWindow(RosterSlotSettingsWindowMeta, VehicleSelectorBase):
    itemsCache = dependency.descriptor(IItemsCache)

    def __init__(self, ctx=None):
        super(RosterSlotSettingsWindow, self).__init__()
        self._levelsRange = ctx.get('levelsRange', self._levelsRange)
        self.__section = ctx['section']
        self.__levelsLimits = self.__convertLevelsRange(self._levelsRange)
        self.__vehicleTypes = ctx.get('vehicleTypes', None)
        self.__flashSlots = ctx.get('settings')
        return

    def updateSlots(self, slots):
        self.__currentSlot, tabID = self.__makeInitialSlotData(slots.pop())
        self.__setSelection(tabID)

    def onFiltersUpdate(self, nation, vehicleType, isMain, level, compatibleOnly):
        self._updateFilter(nation, vehicleType, isMain, level, compatibleOnly)
        self.updateData()

    def updateData(self):
        result = self._updateData(self.itemsCache.items.getVehicles(~REQ_CRITERIA.SECRET))
        self.as_setListDataS(result)

    def requestVehicleFilters(self):
        filters = AccountSettings.getFilter(self.__section)
        filters['isMain'] = False
        result = self._initFilter(**filters)
        result.update({'compatibleOnlyLabel': CYBERSPORT.WINDOW_VEHICLESELECTOR_FILTERS_MATCHES})
        self.as_updateVehicleFiltersS(result)

    def submitButtonHandler(self, value):
        self.__currentSlot, _ = self.__makeInitialSlotData(value)
        slotSettins = self.__getSlotsSettings()
        self.fireEvent(CSRosterSlotSettingsWindow(CSRosterSlotSettingsWindow.APPLY_SLOT_SETTINGS, slotSettins))
        if self.__currentSlot is not None and 'intCD' in self.__currentSlot:
            self.__addAditionalSlot(slotSettins)
        self.onWindowClose()
        return

    def cancelButtonHandler(self):
        self.onWindowClose()

    def onWindowClose(self):
        self.destroy()

    def _populate(self):
        super(RosterSlotSettingsWindow, self)._populate()
        self.as_setStaticDataS(self.__packStaticData())
        self.__currentSlot, tabID = self.__makeInitialSlotData(self.__flashSlots.pop())
        self.setLimits()
        self.__setSelection(tabID)

    def setLimits(self):
        self.as_setRosterLimitsS({'minLevel': self.__levelsLimits[0], 
           'maxLevel': self.__levelsLimits[1]})

    def _dispose(self):
        currentFilters = self.getFilters()
        if currentFilters:
            filters = {'nation': currentFilters['nation'], 'vehicleType': currentFilters['vehicleType'], 
               'isMain': currentFilters['isMain'], 
               'level': currentFilters['level'], 
               'compatibleOnly': currentFilters['compatibleOnly']}
            AccountSettings.setFilter(self.__section, filters)
        self._levelsRange = None
        self.__currentSlot = None
        self.__flashSlots = None
        self.__section = None
        self.__vehicleTypes = None
        super(RosterSlotSettingsWindow, self)._dispose()
        return

    def _makeVehicleVOAction(self, vehicle):
        return makeVehicleBasicVO(vehicle, self._levelsRange, self.__vehicleTypes)

    def __packStaticData(self):
        text = text_styles.main(CYBERSPORT.WINDOW_ROSTERSLOTSETTINGS_VEHICLETAB_HEADERTEXT)
        return {'windowTitle': CYBERSPORT.WINDOW_ROSTERSLOTSETTINGS_TITLE, 
           'headerText': '%s %s' % (text, icons.info()), 
           'headerTextTooltip': TOOLTIPS.CYBERSPORT_ROSTERSLOTSETTINGS_HEADERTEXT, 
           'selectedTxt': text_styles.middleTitle(CYBERSPORT.WINDOW_ROSTERSLOTSETTINGS_BOTTOMRESULT), 
           'submitBtnLabel': CYBERSPORT.WINDOW_ROSTERSLOTSETTINGS_VEHICLETAB_SUBMITBTN, 
           'cancelBtnLabel': CYBERSPORT.WINDOW_ROSTERSLOTSETTINGS_VEHICLETAB_CANCELBTN, 
           'buttonBarItems': self.__packTabsData()}

    def __packTabsData(self):
        data = []
        for tabID in TAB_ORDER:
            linkage, label = TAB_DATA_MAP[tabID]
            data.append({'label': label, 
               'linkage': linkage})

        return data

    def __setSelection(self, tabID):
        if tabID == VEHICLE_SELECTOR_TAB_ID:
            self.as_setVehicleSelectionS(self.__currentSlot)
            self.as_selectTabS(TAB_ORDER.index(tabID))
        elif tabID == RANGE_SELECTOR_TAB_ID:
            self.as_setRangeSelectionS(self.__currentSlot)
            self.as_selectTabS(TAB_ORDER.index(tabID))
        else:
            self.as_resetSelectionS()
            self.as_selectTabS(TAB_ORDER.index(VEHICLE_SELECTOR_TAB_ID))

    def __makeInitialSlotData(self, currentSlotSetting):
        if currentSlotSetting is None:
            return (None, None)
        else:
            if currentSlotSetting.selectedVehicle > 0:
                vehicle = self.itemsCache.items.getItemByCD(int(currentSlotSetting.selectedVehicle))
                return (
                 makeVehicleVO(vehicle, self.__convertLevelsRange(self._levelsRange), self.__vehicleTypes),
                 VEHICLE_SELECTOR_TAB_ID)
            if currentSlotSetting.nationIDRange or currentSlotSetting.vTypeRange or currentSlotSetting.vLevelRange:
                levelsRange = self.__convertLevelsRange(currentSlotSetting.vLevelRange or self._levelsRange)
                return (
                 makeFiltersVO(currentSlotSetting.nationIDRange, currentSlotSetting.vTypeRange, levelsRange),
                 RANGE_SELECTOR_TAB_ID)
            return (None, None)

    def __convertLevelsRange(self, levels):
        return levels[::len(levels) - 1]

    def __getSlotsSettings(self):
        slotsSettings = []
        slotsSettings.extend(self.__flashSlots)
        slotsSettings.append(self.__currentSlot)
        return slotsSettings

    def __addAditionalSlot(self, slotSettins):
        row = slotSettins[0]
        column = slotSettins[1]
        vehicleCD = self.__currentSlot['intCD']
        vehicle = self.itemsCache.items.getItemByCD(int(vehicleCD))
        if vehicle.hasNationGroup and vehicle.activeInNationGroup:
            addVehCD = iterVehTypeCDsInNationGroup(vehicleCD).next()
            vehicle = self.itemsCache.items.getItemByCD(addVehCD)
            addSlot = makeVehicleVO(vehicle, self.__convertLevelsRange(self._levelsRange), self.__vehicleTypes)
            slotSettings = [row, 1 - column, addSlot]
            self.fireEvent(CSRosterSlotSettingsWindow(CSRosterSlotSettingsWindow.APPLY_SLOT_SETTINGS, slotSettings))