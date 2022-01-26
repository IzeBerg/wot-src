from gui.Scaleform.daapi.view.lobby.vehicle_preview.items_kit_helper import lookupItem, showItemTooltip
from gui.Scaleform.daapi.view.meta.PackItemsPopoverMeta import PackItemsPopoverMeta
from gui.impl import backport
from gui.impl.gen import R
from gui.shared.formatters import text_styles
from gui.shared.utils import flashObject2Dict
from helpers import dependency
from skeletons.gui.app_loader import IAppLoader
from skeletons.gui.goodies import IGoodiesCache
from skeletons.gui.shared import IItemsCache
from web.web_client_api.common import ItemPackEntry
_R_SHOP_PACK = R.strings.tooltips.vehiclePreview.shopPack

class PackItemsPopover(PackItemsPopoverMeta):
    appLoader = dependency.descriptor(IAppLoader)
    itemsCache = dependency.descriptor(IItemsCache)
    goodiesCache = dependency.descriptor(IGoodiesCache)

    def __init__(self, ctx=None):
        super(PackItemsPopover, self).__init__(ctx)
        self.__data = flashObject2Dict(ctx.get('data'))
        self.__rawItems = []
        for item in self.__data.get('items'):
            item = flashObject2Dict(item)
            self.__rawItems.append(ItemPackEntry(type=item.get('type'), id=int(item.get('id')), count=item.get('rawCount') or 0, groupID=item.get('groupID'), title=item.get('title'), description=item.get('description')))

    def showTooltip(self, intCD, itemType):
        toolTipMgr = self.appLoader.getApp().getToolTipMgr()
        itemId = int(intCD)
        rawItem = [ item for item in self.__rawItems if item.id == itemId and item.type == itemType ][0]
        item = lookupItem(rawItem, self.itemsCache, self.goodiesCache)
        showItemTooltip(toolTipMgr, rawItem, item)

    def _populate(self):
        super(PackItemsPopover, self)._populate()
        title = text_styles.highTitle(self.__data.get('title', backport.text(_R_SHOP_PACK.title())))
        items = []
        for item in self.__data.get('items'):
            item = flashObject2Dict(item)
            count = item.get('count') or 0
            items.append({'id': item.get('id'), 
               'type': item.get('type'), 
               'value': backport.text(_R_SHOP_PACK.count()).format(count=count) if count > 1 else None, 
               'icon': item.get('icon'), 
               'overlayType': item.get('overlayType'), 
               'description': item.get('description'), 
               'hasCompensation': item.get('hasCompensation', False)})

        self.as_setItemsS(title, items)
        return

    def _dispose(self):
        self.__rawData = None
        super(PackItemsPopover, self)._dispose()
        return