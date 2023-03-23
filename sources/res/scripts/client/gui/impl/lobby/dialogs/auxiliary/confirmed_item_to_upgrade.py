from gui.impl.lobby.dialogs.auxiliary.confirmed_item import ConfirmedItem, ConfirmedArtefact, ConfirmedOptDevice
from gui.impl.lobby.dialogs.auxiliary.confirmed_item_helpers import getOverlayTypeByItem
from gui.impl.gen.view_models.constants.item_highlight_types import ItemHighlightTypes
from gui.shared.gui_items import GUI_ITEM_TYPE
from gui.shared.utils.requesters import REQ_CRITERIA

class ConfirmedItemToUpgrade(ConfirmedItem):

    @classmethod
    def createFromGUIItem(cls, item, ctx=None):
        if item.itemTypeID in GUI_ITEM_TYPE.ARTEFACTS:
            return ConfirmedArtefactToUpgrade.createFromGUIItem(item, ctx)
        return super(ConfirmedItemToUpgrade, cls).createFromGUIItem(item)


class ConfirmedArtefactToUpgrade(ConfirmedArtefact):

    @classmethod
    def createFromGUIItem(cls, item, ctx=None):
        if item.itemTypeID == GUI_ITEM_TYPE.OPTIONALDEVICE:
            return ConfirmedOptDeviceToUpgrade(item, ctx)
        return super(ConfirmedArtefactToUpgrade, cls).createFromGUIItem(item, ctx)


class ConfirmedOptDeviceToUpgrade(ConfirmedOptDevice):

    def getOverlayType(self):
        return getOverlayTypeByItem(self._item, self.__getOptDeviceCriteria())

    @classmethod
    def createFromGUIItem(cls, item, ctx=None):
        return ConfirmedOptDeviceToUpgrade(item, ctx)

    @staticmethod
    def __getOptDeviceCriteria():
        return {ItemHighlightTypes.TROPHY_UPGRADED: REQ_CRITERIA.ITEM_TYPES(GUI_ITEM_TYPE.OPTIONALDEVICE) | REQ_CRITERIA.OPTIONAL_DEVICE.TROPHY | REQ_CRITERIA.CUSTOM(lambda i: i.isUpgradable or i.isUpgraded), 
           ItemHighlightTypes.TROPHY_BASIC: REQ_CRITERIA.NONE}