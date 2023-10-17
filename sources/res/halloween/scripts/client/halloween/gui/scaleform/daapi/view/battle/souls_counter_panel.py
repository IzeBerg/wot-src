import BigWorld
from helpers import dependency
from skeletons.gui.battle_session import IBattleSessionProvider
from gui.shared.utils.graphics import isRendererPipelineDeferred
from halloween.gui.scaleform.daapi.view.meta.PointCounterMeta import PointCounterMeta

class HWSoulsCounter(PointCounterMeta):
    __sessionProvider = dependency.descriptor(IBattleSessionProvider)

    def __init__(self):
        super(HWSoulsCounter, self).__init__()
        self.prevSoulsCount = 0

    def _populate(self):
        super(HWSoulsCounter, self)._populate()
        self.__enableAnimation()
        vehicleSoulsContainer = self._getPlayerVehicleSoulsContainer()
        if vehicleSoulsContainer:
            self.__onSoulsChanged(vehicleSoulsContainer.souls, 0)
            vehicleSoulsContainer.onChangeSoulsCount += self.__onSoulsChanged

    def _dispose(self):
        vehicleSoulsContainer = self._getPlayerVehicleSoulsContainer()
        if vehicleSoulsContainer:
            vehicleSoulsContainer.onChangeSoulsCount -= self.__onSoulsChanged
        super(HWSoulsCounter, self)._dispose()

    def _getPlayerVehicleSoulsContainer(self):
        vehicle = BigWorld.player().vehicle if BigWorld.player() else None
        if vehicle:
            return vehicle.dynamicComponents.get('hwSoulsContainer')
        else:
            return

    def __onSoulsChanged(self, newCount, reason):
        self.as_updateCountS(newCount, reason)
        if newCount > self.prevSoulsCount:
            self.__sessionProvider.shared.messages.onShowPlayerMessageByKey('PICKUP_SOULS', {'souls': newCount - self.prevSoulsCount})
        self.prevSoulsCount = newCount

    def __enableAnimation(self):
        self.as_enableAnimationS(isRendererPipelineDeferred())