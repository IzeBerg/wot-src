from gui.Scaleform.daapi.view.meta.EventGlobalProgressionEntryPointMeta import EventGlobalProgressionEntryPointMeta
from gui.prb_control.entities.listener import IGlobalListener
from gui.impl import backport
from gui.impl.gen import R
from gui.shared.utils.functions import makeTooltip
from helpers import dependency
from skeletons.gui.server_events import IEventsCache
from skeletons.gui.game_control import IHalloweenController
from halloween.gui.shared.event_dispatcher import showGlobalProgression
from halloween.hw_constants import INVALID_PHASE_INDEX

class EventGlobalProgressionEntryPoint(EventGlobalProgressionEntryPointMeta, IGlobalListener):
    _eventsCache = dependency.descriptor(IEventsCache)
    _hwController = dependency.descriptor(IHalloweenController)

    def onClick(self):
        showGlobalProgression()

    def _populate(self):
        super(EventGlobalProgressionEntryPoint, self)._populate()
        self.startGlobalListening()
        self._eventsCache.onSyncCompleted += self.__onSyncCompleted
        self._hwController.onChangeActivePhase += self.__onChangeActivePhase
        self._hwController.onQuestsUpdated += self.__onQuestUpdated
        self.__update()

    def _dispose(self):
        self.stopGlobalListening()
        self._eventsCache.onSyncCompleted -= self.__onSyncCompleted
        self._hwController.onChangeActivePhase -= self.__onChangeActivePhase
        self._hwController.onQuestsUpdated -= self.__onQuestUpdated
        super(EventGlobalProgressionEntryPoint, self)._dispose()

    def __onSyncCompleted(self):
        self.__update()

    def __onChangeActivePhase(self, _):
        self.__update()

    def __onQuestUpdated(self):
        self.__update()

    def __update(self):
        phases = self._hwController.phases
        activePhaseIndex = phases.getActivePhaseIndex()
        if activePhaseIndex == INVALID_PHASE_INDEX:
            return
        self.as_setDataS({'phaseIndex': activePhaseIndex, 
           'isSpecial': False, 
           'tooltip': makeTooltip(header=backport.text(R.strings.hw_tooltips.globalProgression.entry_point.tooltip.header()), body=backport.text(R.strings.hw_tooltips.globalProgression.entry_point.tooltip.body())), 
           'specialArgs': []})