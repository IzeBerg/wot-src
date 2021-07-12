from tutorial.gui import GUIProxy

class BattleQuestsProxy(GUIProxy):

    def init(self):
        self.onGUILoaded()
        return True

    def fini(self):
        self.eManager.clear()

    def clear(self):
        self.clearChapterInfo()

    def getSceneID(self):
        return 'Battle'

    def playEffect(self, effectName, args):
        return False

    def isEffectRunning(self, effectName, effectID=None, effectSubType=None):
        return False