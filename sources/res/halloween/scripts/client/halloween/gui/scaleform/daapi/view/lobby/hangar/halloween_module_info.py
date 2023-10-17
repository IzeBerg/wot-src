from gui.Scaleform.framework.entities.View import View
from gui.Scaleform.locale.MENU import MENU
from gui.shared.tooltips import contexts
from gui.shared.tooltips.module import ModuleBlockTooltipData
from helpers import dependency
from helpers.i18n import makeString as _ms
from skeletons.gui.shared import IItemsCache
from gui.Scaleform.daapi.view.lobby.ModuleInfoWindow import ModuleInfoWindow
from gui.impl import backport
from gui.impl.gen import R

class HalloweenModuleInfoWindow(ModuleInfoWindow):
    itemsCache = dependency.descriptor(IItemsCache)

    def __init__(self, ctx=None):
        super(HalloweenModuleInfoWindow, self).__init__(ctx=ctx)
        self.__vehicleDescr = ctx.get('vehicleDescr')

    def _populate(self):
        super(View, self)._populate()
        module = self.itemsCache.items.getItemByCD(self.moduleCompactDescr)
        tooltipArgs = [self.moduleCompactDescr, self.__vehicleDescr]
        dataProvider = ModuleBlockTooltipData(context=contexts.ModuleInfoContext())
        data = dataProvider.buildToolTip(*tooltipArgs)
        titleArr = [backport.text(R.strings.tank_setup.menu.hw_equipment.title()),
         module.shortUserName, _ms(MENU.MODULEINFO_TITLE)]
        data['windowTitle'] = (' ').join(titleArr)
        data['overlayType'] = module.getOverlayType()
        data['highlightType'] = module.getBigHighlightType()
        self._updateModuleInfo(data)