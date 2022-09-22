import BigWorld
from helpers import dependency
from script_component.DynamicScriptComponent import DynamicScriptComponent
from skeletons.gui.battle_session import IBattleSessionProvider
from Event import Event

class StressTimer(object):

    def __init__(self, guid):
        self.update = Event()
        self.leftTime = 0.0
        self.endTime = BigWorld.serverTime()
        self.totalTime = 0.0
        self.factor = 1.0
        self.timerGUID = guid

    def destroy(self):
        self.update.clear()
        self.update = None
        return

    @property
    def isPaused(self):
        return self.factor == 0.0

    @property
    def timeToDelete(self):
        if self.isPaused:
            return self.leftTime
        return max(0.0, self.endTime - BigWorld.serverTime())


class EntityStressTimer(DynamicScriptComponent):

    def _onAvatarReady(self):
        self.entity.entityGameObject.createComponent(StressTimer, self.getGuiID)
        self.set_timerInfo()

    def onDestroy(self):
        super(EntityStressTimer, self).onDestroy()
        if self.update(0.0):
            self.entity.entityGameObject.removeComponentByType(StressTimer)

    @property
    def uiCtrl(self):
        sessionProvider = dependency.instance(IBattleSessionProvider)
        return sessionProvider.dynamic.playersPanel

    @property
    def isPaused(self):
        return self.timerInfo.factor == 0.0

    @property
    def timeToDelete(self):
        if self.isPaused:
            return self.timerInfo.left
        return max(0.0, self.timerInfo.endTime - BigWorld.serverTime())

    @property
    def factor(self):
        return self.timerInfo.factor

    @property
    def getGuiID(self):
        entityInfo = self.entity.dynamicComponents.get('entityInfo')
        if entityInfo is not None:
            return entityInfo.index
        else:
            return 0

    def update(self, leftTime):
        go = self.entity.entityGameObject
        timer = go.findComponentByType(StressTimer)
        if timer:
            timer.leftTime = leftTime
            timer.endTime = self.timerInfo.endTime
            timer.totalTime = self.lifetime / self.factor if self.factor != 0.0 else self.lifetime
            timer.factor = self.factor
            timer.update(timer, go)
        return bool(timer)

    def set_timerInfo(self, prev=None):
        self.uiCtrl.updateStressTimer(self.entity.id)
        self.update(self.timerInfo.left)