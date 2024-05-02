import typing, CGF, Math, BigWorld
from EmptyEntity import EmptyEntity
from cosmic_event.gui.shared.events import FragmentEvent
from gui.shared.event_bus import SharedEvent
if typing.TYPE_CHECKING:
    from typing import Optional

class Fragment(EmptyEntity):

    def __init__(self):
        super(Fragment, self).__init__()
        self._fragmentHintGO = None
        self._fragmentGo = None
        return

    def onEnterWorld(self, *_):
        position = Math.Vector3(0, 0, 0)
        if self.isActive:
            if not self.hasHolder():
                CGF.loadGameObjectIntoHierarchy(self.clientPrefab, self.entityGameObject, position, self._mainFragmentCallback)
        else:
            CGF.loadGameObjectIntoHierarchy(self.clientPrefabHint, self.entityGameObject, position, self._hintLoadingCallback)

    def hasHolder(self):
        return self.vehicleId != 0

    def _hintLoadingCallback(self, go):
        if self.isDestroyed:
            CGF.removeGameObject(go)
            return
        self._fragmentHintGO = go

    def _mainFragmentCallback(self, go):
        if self.isDestroyed:
            CGF.removeGameObject(go)
            return
        self._removeHintGO()
        self._fragmentGo = go

    def onLeaveWorld(self):
        self._removeFragmentGO()
        self._removeHintGO()
        super(Fragment, self).onLeaveWorld()

    def set_vehicleId(self, previous):
        if self.vehicleId != 0:
            self._sendEvent(FragmentEvent.FRAGMENT_COLLECTED, self.vehicleId)
            self._removeFragmentGO()
            self._removeHintGO()
        else:
            self._sendEvent(FragmentEvent.FRAGMENT_DROPPED, previous)

    @staticmethod
    def _sendEvent(event, vehicleId):
        from gui.shared import g_eventBus, EVENT_BUS_SCOPE
        vehicle = BigWorld.entities.get(vehicleId, None)
        if vehicle is not None:
            if vehicle.isPlayerVehicle:
                g_eventBus.handleEvent(FragmentEvent(event), scope=EVENT_BUS_SCOPE.BATTLE)
        return

    def onFragmentActivated(self):
        if self.vehicleId != 0:
            return
        position = Math.Vector3(0, 0, 0)
        CGF.loadGameObjectIntoHierarchy(self.clientPrefab, self.entityGameObject, position, self._mainFragmentCallback)

    def onFragmentsFull(self, vehicleId):
        self._sendEvent(FragmentEvent.FRAGMENT_FULL, vehicleId)

    def _removeHintGO(self):
        if self._fragmentHintGO and self._fragmentHintGO.isValid():
            CGF.removeGameObject(self._fragmentHintGO)

    def _removeFragmentGO(self):
        if self._fragmentGo and self._fragmentGo.isValid():
            CGF.removeGameObject(self._fragmentGo)