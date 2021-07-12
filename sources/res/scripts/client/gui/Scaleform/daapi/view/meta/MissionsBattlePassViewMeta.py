from gui.Scaleform.daapi.view.meta.MissionsViewBaseMeta import MissionsViewBaseMeta

class MissionsBattlePassViewMeta(MissionsViewBaseMeta):

    def as_showViewS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_showView()