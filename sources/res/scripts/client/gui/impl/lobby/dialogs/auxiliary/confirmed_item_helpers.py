import typing
from enum import IntEnum
from gui.impl.gen.view_models.constants.item_highlight_types import ItemHighlightTypes
from gui.shared.gui_items import GUI_ITEM_TYPE
from gui.shared.utils.requesters import REQ_CRITERIA
if typing.TYPE_CHECKING:
    from gui.shared.gui_items.gui_item import GUIItem

def _equipmentPlusCriteria():
    return REQ_CRITERIA.ITEM_TYPES(GUI_ITEM_TYPE.OPTIONALDEVICE) | REQ_CRITERIA.OPTIONAL_DEVICE.DELUXE


def _equipmentBuiltInCriteria():
    return REQ_CRITERIA.ITEM_TYPES(GUI_ITEM_TYPE.EQUIPMENT) | REQ_CRITERIA.EQUIPMENT.BUILTIN


def _optionalDeviceSimpleCriteria():
    return REQ_CRITERIA.ITEM_TYPES(GUI_ITEM_TYPE.OPTIONALDEVICE) | REQ_CRITERIA.OPTIONAL_DEVICE.SIMPLE


def _optionalDeviceTrophyBasicCriteria():
    return REQ_CRITERIA.ITEM_TYPES(GUI_ITEM_TYPE.OPTIONALDEVICE) | REQ_CRITERIA.OPTIONAL_DEVICE.TROPHY | REQ_CRITERIA.CUSTOM(lambda i: i.isUpgradable)


def _optionalDeviceTrophyUpgradedCriteria():
    return REQ_CRITERIA.ITEM_TYPES(GUI_ITEM_TYPE.OPTIONALDEVICE) | REQ_CRITERIA.OPTIONAL_DEVICE.TROPHY | REQ_CRITERIA.CUSTOM(lambda i: i.isUpgraded)


def _optionalDeviceModernizedWithLevelCriteria(level=None):
    return REQ_CRITERIA.ITEM_TYPES(GUI_ITEM_TYPE.OPTIONALDEVICE) | REQ_CRITERIA.OPTIONAL_DEVICE.MODERNIZED | REQ_CRITERIA.CUSTOM(lambda i: i.level == level if level else True)


_HIGHLIGHTS_TYPE_TO_CRITERIA = {ItemHighlightTypes.BATTLE_BOOSTER: REQ_CRITERIA.BATTLE_BOOSTER.ALL, 
   ItemHighlightTypes.EQUIPMENT_PLUS: _equipmentPlusCriteria(), 
   ItemHighlightTypes.BUILT_IN_EQUIPMENT: _equipmentBuiltInCriteria(), 
   ItemHighlightTypes.OPTIONAL_DEVICE: _optionalDeviceSimpleCriteria(), 
   ItemHighlightTypes.TROPHY_BASIC: _optionalDeviceTrophyBasicCriteria(), 
   ItemHighlightTypes.TROPHY_UPGRADED: _optionalDeviceTrophyUpgradedCriteria(), 
   ItemHighlightTypes.MODERNIZED: _optionalDeviceModernizedWithLevelCriteria()}
_OVERLAY_TYPE_TO_CRITERIA = {ItemHighlightTypes.BATTLE_BOOSTER: REQ_CRITERIA.BATTLE_BOOSTER.ALL, 
   ItemHighlightTypes.EQUIPMENT_PLUS: _equipmentPlusCriteria(), 
   ItemHighlightTypes.BUILT_IN_EQUIPMENT: _equipmentBuiltInCriteria(), 
   ItemHighlightTypes.OPTIONAL_DEVICE: _optionalDeviceSimpleCriteria(), 
   ItemHighlightTypes.TROPHY_BASIC: _optionalDeviceTrophyBasicCriteria(), 
   ItemHighlightTypes.TROPHY_UPGRADED: _optionalDeviceTrophyUpgradedCriteria(), 
   ItemHighlightTypes.MODERNIZED1: _optionalDeviceModernizedWithLevelCriteria(1), 
   ItemHighlightTypes.MODERNIZED2: _optionalDeviceModernizedWithLevelCriteria(2), 
   ItemHighlightTypes.MODERNIZED3: _optionalDeviceModernizedWithLevelCriteria(3)}

def getHighlightsTypeByItem(item, typeToCriteria=None):
    criteriaMap = _HIGHLIGHTS_TYPE_TO_CRITERIA.copy()
    criteriaMap.update(typeToCriteria or {})
    for highlightsType, criteria in criteriaMap.items():
        if criteria(item):
            return highlightsType

    return ''


def getOverlayTypeByItem(item, typeToCriteria=None):
    criteriaMap = _OVERLAY_TYPE_TO_CRITERIA.copy()
    criteriaMap.update(typeToCriteria or {})
    for overlayType, criteria in criteriaMap.items():
        if criteria(item):
            return overlayType

    return ''


class ConfirmedItemWarningTypes(IntEnum):
    DEPENDS_ON_DEVICES = 1
    PAIR_MODIFICATIONS_WILL_BE_DEMOUNT = 2


class BaseConfirmedItemWarning(object):
    __slots__ = ()

    def getType(self):
        raise NotImplementedError


class DependsOnDevicesWarning(BaseConfirmedItemWarning):
    __slots__ = ('__devicesName', )

    def __init__(self, devicesName):
        self.__devicesName = devicesName

    def getType(self):
        return ConfirmedItemWarningTypes.DEPENDS_ON_DEVICES

    def getDevicesName(self):
        return self.__devicesName


class PairModificationsWillBeDemount(BaseConfirmedItemWarning):

    def getType(self):
        return ConfirmedItemWarningTypes.PAIR_MODIFICATIONS_WILL_BE_DEMOUNT