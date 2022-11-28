from fun_random.gui.impl.lobby.feature.fun_random_hangar_widget_view import FunRandomHangarWidgetView
from gui.impl.gen import R
from gui.Scaleform.daapi.view.meta.FunRandomHangarWidgetMeta import FunRandomHangarWidgetMeta
from gui.Scaleform.framework.entities.inject_component_adaptor import hasAliveInject
from frameworks.wulf import ViewStatus
from shared_utils import nextTick

class FunRandomHangarWidgetComponent(FunRandomHangarWidgetMeta):

    @nextTick
    @hasAliveInject()
    def updateLoaded(self):
        self.as_updateHitAreaS()

    def _addInjectContentListeners(self):
        self._injectView.onStatusChanged += self._onViewReady

    def _removeInjectContentListeners(self):
        self._injectView.onStatusChanged -= self._onViewReady

    def _makeInjectView(self):
        return FunRandomHangarWidgetView(R.views.fun_random.lobby.feature.FunRandomHangarWidgetView())

    def _onViewReady(self, state):
        if state == ViewStatus.LOADED:
            self.updateLoaded()