import BigWorld, functools
from ClientSelectableCameraObject import ClientSelectableCameraObject
from cosmic_event.skeletons.battle_controller import ICosmicEventBattleController
from gui.shared.utils.graphics import isRendererPipelineDeferred
from helpers import dependency
_ACTIVATION_DELAY = 18

class ClientSelectableCosmicObject(ClientSelectableCameraObject):
    __cosmicController = dependency.descriptor(ICosmicEventBattleController)

    def __init__(self):
        super(ClientSelectableCosmicObject, self).__init__()
        self.__activationCallbackId = None
        self.__isActivationDelayPassed = False
        return

    def onEnterWorld(self, prereqs):
        super(ClientSelectableCosmicObject, self).onEnterWorld(prereqs)
        self.__cosmicController.onPrimeTimeStatusUpdated += self.__onGameModeStatusUpdate
        if isRendererPipelineDeferred():
            self.setEnable(False)
            self.__activationCallbackId = BigWorld.callback(_ACTIVATION_DELAY, functools.partial(self.__activationCallback))
        else:
            self.setEnable(self.__cosmicController.isAvailable())

    def onMouseClick(self):
        self.__cosmicController.switchPrb(cameraData=(self, self.hangarSpace.spaceID))

    def onLeaveWorld(self):
        self.__cosmicController.onPrimeTimeStatusUpdated -= self.__onGameModeStatusUpdate
        if self.__activationCallbackId:
            BigWorld.cancelCallback(self.__activationCallbackId)
            self.__activationCallbackId = None
        super(ClientSelectableCosmicObject, self).onLeaveWorld()
        return

    def __activationCallback(self):
        self.setEnable(self.__cosmicController.isAvailable())
        self.__isActivationDelayPassed = True
        self.__activationCallbackId = None
        return

    def __onGameModeStatusUpdate(self, *_):
        if self.__isActivationDelayPassed:
            self.setEnable(self.__cosmicController.isAvailable())