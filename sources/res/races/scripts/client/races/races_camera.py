from AvatarInputHandler.DynamicCameras.ArcadeCamera import ArcadeCamera

class RacesCamera(ArcadeCamera):

    @staticmethod
    def _getConfigsKey():
        return RacesCamera.__name__