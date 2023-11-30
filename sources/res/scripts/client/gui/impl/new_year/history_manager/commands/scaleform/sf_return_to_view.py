from gui.Scaleform.framework.managers.loaders import SFViewLoadParams
from gui.shared import g_eventBus, events
from gui.impl.new_year.history_manager.commands.return_to_view import ReturnToView

class SfReturnToView(ReturnToView):

    def execute(self):
        context = self.getContext()
        g_eventBus.handleEvent(events.LoadViewEvent(SFViewLoadParams(context['aliasName']), **context), scope=self._getScope())