import logging, BigWorld
from ClientSelectableObject import ClientSelectableObject
from helpers import dependency
from skeletons.gui.game_control import IBattleRoyaleController
from skeletons.gui.shared.utils import IHangarSpace
from constants import FESTIVAL_SCENE, BATTLE_ROYALE_SCENE
from gui.shared import g_eventBus
from gui.hangar_cameras.hangar_camera_common import CameraMovementStates, CameraRelatedEvents
_logger = logging.getLogger(__name__)

class ClientSelectableHangarsSwitcher(ClientSelectableObject):
    battleRoyale = dependency.descriptor(IBattleRoyaleController)
    hangarSpace = dependency.descriptor(IHangarSpace)

    def __init__(self):
        super(ClientSelectableHangarsSwitcher, self).__init__()
        self.__postponedMouseClickCallbackID = None
        self.__modeSelector = {}
        return

    def onEnterWorld(self, prereqs):
        super(ClientSelectableHangarsSwitcher, self).onEnterWorld(prereqs)
        self.__modeSelector = {BATTLE_ROYALE_SCENE: self.__selectRoyaleBattle, 
           FESTIVAL_SCENE: self.__selectRandomBattle}
        g_eventBus.addListener(CameraRelatedEvents.CAMERA_ENTITY_UPDATED, self.__onCameraEntityUpdated)

    def onLeaveWorld(self):
        g_eventBus.removeListener(CameraRelatedEvents.CAMERA_ENTITY_UPDATED, self.__onCameraEntityUpdated)
        self.__clear()
        super(ClientSelectableHangarsSwitcher, self).onLeaveWorld()

    def onMouseClick(self):
        super(ClientSelectableHangarsSwitcher, self).onMouseClick()
        if not self.destHangar:
            return
        else:
            if self.destHangar not in self.__modeSelector:
                _logger.error('Unknown destination hangar: "%s"', self.destHangar)
                return
            if self.__postponedMouseClickCallbackID is not None:
                return
            selectorFunc = self.__modeSelector[self.destHangar]
            self.__postponedMouseClickCallbackID = BigWorld.callback(0, selectorFunc)
            return

    def __selectRoyaleBattle(self):
        self.__postponedMouseClickCallbackID = None
        self.battleRoyale.selectRoyaleBattle()
        return

    def __selectRandomBattle(self):
        self.__postponedMouseClickCallbackID = None
        self.battleRoyale.selectRandomBattle()
        return

    def __clear(self):
        if self.__postponedMouseClickCallbackID is not None:
            BigWorld.cancelCallback(self.__postponedMouseClickCallbackID)
            self.__postponedMouseClickCallbackID = None
        self.__modeSelector.clear()
        return

    def __onCameraEntityUpdated(self, event):
        ctx = event.ctx
        state = ctx['state']
        entityId = ctx['entityId']
        if state == CameraMovementStates.FROM_OBJECT:
            if self.__isHangarVehicleEntity(entityId):
                self.setEnable(False)
        elif state == CameraMovementStates.ON_OBJECT:
            if self.__isHangarVehicleEntity(entityId):
                if not self.enabled:
                    self.setEnable(True)

    def __isHangarVehicleEntity(self, entityId):
        return entityId == self.hangarSpace.space.vehicleEntityId