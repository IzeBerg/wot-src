from AvatarInputHandler.control_modes import ArcadeControlMode
from races_camera import RacesCamera

class RacesControlMode(ArcadeControlMode):

    def _setupCamera(self, dataSection):
        self._cam = RacesCamera(dataSection['camera'], defaultOffset=self._defaultOffset)