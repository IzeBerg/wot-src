from gui.shared import g_eventBus
from gui.hangar_cameras.hangar_camera_common import CameraRelatedEvents
from gui.impl.new_year.sounds import NewYearSoundVars, NewYearSoundsManager
_RTPC_MUSIC_POSITION_CONTROL_MIN_VALUE = 0
_RTPC_MUSIC_POSITION_CONTROL_MAX_VALUE = 100
_RTPC_GIFT_AVAILABILITY_MIN_VALUE = 0
_RTPC_GIFT_AVAILABILITY_MAX_VALUE = 100

class SoundRTPCController(object):
    __slots__ = ('__currentLocation', )

    def __init__(self):
        self.__currentLocation = None
        return

    def init(self, location):
        g_eventBus.addListener(CameraRelatedEvents.IDLE_CAMERA, self.__handleIdleCameraActivation)
        self.setCurrentLocation(location, True)

    def fini(self):
        NewYearSoundsManager.setRTPC(NewYearSoundVars.RTPC_MUSIC_POSITION_CONTROL, _RTPC_MUSIC_POSITION_CONTROL_MIN_VALUE)
        g_eventBus.removeListener(CameraRelatedEvents.IDLE_CAMERA, self.__handleIdleCameraActivation)

    def setCurrentLocation(self, location, force=False):
        if force or self.__currentLocation != location:
            self.__currentLocation = location
            if self.__currentLocation is not None:
                positionControlValue = _RTPC_MUSIC_POSITION_CONTROL_MAX_VALUE
            else:
                positionControlValue = _RTPC_MUSIC_POSITION_CONTROL_MIN_VALUE
            NewYearSoundsManager.setRTPC(NewYearSoundVars.RTPC_MUSIC_POSITION_CONTROL, positionControlValue)
        NewYearSoundsManager.setRTPC(NewYearSoundVars.RTPC_GIFT_AVAILABILITY, _RTPC_GIFT_AVAILABILITY_MIN_VALUE)
        return

    @staticmethod
    def setLevelAtmosphere(level):
        NewYearSoundsManager.setRTPC(NewYearSoundVars.RTPC_LEVEL_ATMOSPHERE, level)

    def __handleIdleCameraActivation(self, event):
        if self.__currentLocation is not None:
            return
        else:
            positionControlValue = _RTPC_MUSIC_POSITION_CONTROL_MAX_VALUE if event.ctx['started'] else _RTPC_MUSIC_POSITION_CONTROL_MIN_VALUE
            NewYearSoundsManager.setRTPC(NewYearSoundVars.RTPC_MUSIC_POSITION_CONTROL, positionControlValue)
            return