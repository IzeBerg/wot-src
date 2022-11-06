from gui.Scaleform.framework.managers.loaders import SFViewLoadParams
from gui.shared import g_eventBus, events
from tutorial.control.functional import FunctionalEffect

class LoadViewEffect(FunctionalEffect):

    def __init__(self, effect):
        self._isRunning = False
        super(LoadViewEffect, self).__init__(effect)

    def triggerEffect(self):
        viewData = self.getTarget()
        if viewData is not None:
            g_eventBus.handleEvent(events.LoadViewEvent(SFViewLoadParams(viewData.getAlias()), ctx=viewData.getCtx()), scope=viewData.getScope())
            return True
        else:
            return False