from tutorial.gui.Scaleform.pop_ups import TutorialDialog

class BCNationsWindowMeta(TutorialDialog):

    def onNationSelected(self, nationId):
        self._printOverrideError('onNationSelected')

    def onNationShow(self, nationId):
        self._printOverrideError('onNationShow')

    def as_selectNationS(self, selectedIndex, nationsList):
        if self._isDAAPIInited():
            return self.flashObject.as_selectNation(selectedIndex, nationsList)