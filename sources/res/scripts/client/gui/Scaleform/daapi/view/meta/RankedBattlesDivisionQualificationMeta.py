from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class RankedBattlesDivisionQualificationMeta(BaseDAAPIComponent):

    def as_setQualificationEfficiencyDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setQualificationEfficiencyData(data)

    def as_setQualificationStepsDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setQualificationStepsData(data)

    def as_setQualificationDataS(self, imageSrcSmall, imageSrcBig, isFirstEnter):
        if self._isDAAPIInited():
            return self.flashObject.as_setQualificationData(imageSrcSmall, imageSrcBig, isFirstEnter)

    def as_setQualificationProgressS(self, progressTextSmall, progressTextBig, isCompleted, descr):
        if self._isDAAPIInited():
            return self.flashObject.as_setQualificationProgress(progressTextSmall, progressTextBig, isCompleted, descr)