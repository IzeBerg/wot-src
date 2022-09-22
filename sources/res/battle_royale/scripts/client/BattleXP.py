import BigWorld

class BattleXP(BigWorld.DynamicScriptComponent):

    def onEnterWorld(self, *args):
        pass

    def onLeaveWorld(self, *args):
        pass

    def set_battleXP(self, _=None):
        if self.battleXP < 0 or not self.entity.isAlive():
            return
        ctrl = self.entity.guiSessionProvider.dynamic.progression
        if ctrl is not None:
            ctrl.updateXP(self.battleXP, self.entity.id)
        return

    def set_battleXpLvlData(self, _=None):
        pass