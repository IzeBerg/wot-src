import BigWorld
from visual_script.misc import ASPECT
from visual_script.multi_plan_provider import MultiPlanCache

class VisualScriptCache(BigWorld.DynamicScriptComponent):

    def __init__(self):
        super(VisualScriptCache, self).__init__()
        self._multiPlanCache = MultiPlanCache(ASPECT.CLIENT)

    def _destroy(self):
        if self._multiPlanCache:
            self._multiPlanCache.destroy()
            self._multiPlanCache = None
        return

    def onLeaveWorld(self):
        self._destroy()

    def onDestroy(self):
        self._destroy()

    def getPlan(self, componentName, planNames):
        return self._multiPlanCache.getPlan(componentName, planNames)