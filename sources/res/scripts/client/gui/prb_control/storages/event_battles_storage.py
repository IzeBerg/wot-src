from gui.battle_control.arena_visitor import createByAvatar
from gui.prb_control.storages.selection_storage import SelectionStorage
from helpers import dependency
from skeletons.gui.server_events import IEventsCache

class EventBattlesStorage(SelectionStorage):
    eventsCache = dependency.descriptor(IEventsCache)

    def isModeSelected(self):
        return self._isSelected and self.eventsCache.isEventEnabled()

    def _isInMode(self):
        arenaVisitor = createByAvatar()
        return arenaVisitor.gui.isEventBattle()