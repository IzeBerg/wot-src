import weakref
from helpers import dependency
from skeletons.gui.battle_session import IBattleSessionProvider
from gui.shared.utils.graphics import isRendererPipelineDeferred
from halloween.gui.scaleform.daapi.view.meta.PointCounterMeta import PointCounterMeta
from halloween.gui.halloween_gui_constants import BATTLE_CTRL_ID

class HWSoulsCounter(PointCounterMeta):
    __sessionProvider = dependency.descriptor(IBattleSessionProvider)

    def __init__(self):
        super(HWSoulsCounter, self).__init__()
        self.prevSoulsCount = 0
        self.capacity = -1
        self._soulsContainer = None
        return

    def _populate(self):
        super(HWSoulsCounter, self)._populate()
        hwBattleGuiCtrl = self.__sessionProvider.dynamic.getControllerByID(BATTLE_CTRL_ID.HW_BATTLE_GUI_CTRL)
        if hwBattleGuiCtrl:
            hwBattleGuiCtrl.onSoulsContainerReady += self._onSoulsContainerReady

    def _dispose(self):
        hwBattleGuiCtrl = self.__sessionProvider.dynamic.getControllerByID(BATTLE_CTRL_ID.HW_BATTLE_GUI_CTRL)
        if hwBattleGuiCtrl:
            hwBattleGuiCtrl.onSoulsContainerReady -= self._onSoulsContainerReady
        soulsContainer = self._soulsContainer() if self._soulsContainer is not None else None
        if soulsContainer is not None:
            soulsContainer.onChangeSoulsCount -= self.__onSoulsChanged
        self._soulsContainer = None
        super(HWSoulsCounter, self)._dispose()
        return

    def _onSoulsContainerReady(self, vehicleSoulsContainer):
        self._soulsContainer = weakref.ref(vehicleSoulsContainer)
        hwBattleGuiCtrl = self.__sessionProvider.dynamic.getControllerByID(BATTLE_CTRL_ID.HW_BATTLE_GUI_CTRL)
        if hwBattleGuiCtrl:
            hwBattleGuiCtrl.onSoulsContainerReady -= self._onSoulsContainerReady
        self.__enableAnimation()
        self.capacity = vehicleSoulsContainer.capacity
        self.as_setSoulsCapS(vehicleSoulsContainer.capacity)
        self.__onSoulsChanged(vehicleSoulsContainer.souls, 0)
        vehicleSoulsContainer.onChangeSoulsCount += self.__onSoulsChanged

    def __onSoulsChanged(self, newCount, reason):
        vehicleSoulsContainer = self._soulsContainer()
        if vehicleSoulsContainer and self.capacity != vehicleSoulsContainer.capacity:
            self.capacity = vehicleSoulsContainer.capacity
            self.as_setSoulsCapS(self.capacity)
        self.as_updateCountS(newCount, reason)
        if newCount > self.prevSoulsCount:
            self.__sessionProvider.shared.messages.onShowPlayerMessageByKey('PICKUP_SOULS', {'souls': newCount - self.prevSoulsCount})
        self.prevSoulsCount = newCount

    def __enableAnimation(self):
        self.as_enableAnimationS(isRendererPipelineDeferred())