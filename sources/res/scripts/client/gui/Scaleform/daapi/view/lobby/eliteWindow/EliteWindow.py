from gui.Scaleform.daapi.view.lobby.rally.vo_converters import makeVehicleVO
from gui.Scaleform.daapi.view.meta.EliteWindowMeta import EliteWindowMeta
from helpers import dependency
from skeletons.gui.shared import IItemsCache

class EliteWindow(EliteWindowMeta):
    itemsCache = dependency.descriptor(IItemsCache)

    def __init__(self, ctx=None):
        super(EliteWindow, self).__init__()
        self.vehInvID = ctx['vehTypeCompDescr']

    def _populate(self):
        super(EliteWindow, self)._populate()
        self.as_setVehicleS(makeVehicleVO(self.itemsCache.items.getItemByCD(self.vehInvID)))

    def onWindowClose(self):
        self.destroy()