from gui.Scaleform.daapi.view.meta.GoodieInfoMeta import GoodieInfoMeta
from helpers import dependency
from skeletons.gui.goodies import IGoodiesCache

class GoodieInfoWindow(GoodieInfoMeta):
    goodiesCache = dependency.descriptor(IGoodiesCache)

    def __init__(self, ctx=None):
        super(GoodieInfoWindow, self).__init__()
        self.goodieID = ctx.get('goodieID')

    def onCancelClick(self):
        self.destroy()

    def onWindowClose(self):
        self.destroy()

    def _populate(self):
        super(GoodieInfoWindow, self)._populate()
        goodie = self.goodiesCache.getGoodie(self.goodieID)
        self.as_setInfoS({'windowTitle': goodie.userName, 
           'name': goodie.userName, 
           'icon': goodie.iconInfo, 
           'description': goodie.longDescription})