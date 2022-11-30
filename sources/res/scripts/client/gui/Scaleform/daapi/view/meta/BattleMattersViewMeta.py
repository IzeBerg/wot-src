from gui.Scaleform.daapi.view.meta.MissionsViewBaseMeta import MissionsViewBaseMeta

class BattleMattersViewMeta(MissionsViewBaseMeta):

    def as_showViewS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_showView()

    def as_hideViewS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideView()