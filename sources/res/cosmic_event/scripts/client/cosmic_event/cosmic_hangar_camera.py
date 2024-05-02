import BigWorld, CGF
from ClientSelectableCameraObject import ClientSelectableCameraObject
from adisp import adisp_async
from cgf_components.hangar_camera_manager import HangarCameraManager

class CameraMover(object):

    def __init__(self):
        super(CameraMover, self).__init__()
        self.__cbID = None
        self.__callback = None
        return

    def isInProcess(self):
        return self.__cbID is not None

    @adisp_async
    def start(self, cameraData, callback=None):
        if self.isInProcess():
            return
        clientSelectableObject, spaceID = cameraData
        ClientSelectableCameraObject.switchCamera(clientSelectableObject, 'SpaceShipStartCamera', instantly=False)
        self._startPrbAnimationDelay(callback, spaceID)

    def _startPrbAnimationDelay(self, cb, spaceID):
        self.__callback = cb
        cameraManager = CGF.getManager(spaceID, HangarCameraManager)
        currFlightParams = cameraManager.getCurrentFlightParams()
        self.__cbID = BigWorld.callback(currFlightParams.minDuration, self._onFinished)

    def _onFinished(self):
        self._callCallback(success=True)

    def reset(self, instantly=True):
        ClientSelectableCameraObject.switchCamera(instantly=instantly)
        if self.isInProcess() and self.__callback:
            BigWorld.cancelCallback(self.__cbID)
            self._callCallback(success=False)

    def _callCallback(self, success):
        cb = self.__callback
        self.__callback = None
        self.__cbID = None
        cb(success)
        return