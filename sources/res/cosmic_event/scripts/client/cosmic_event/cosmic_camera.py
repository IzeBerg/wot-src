from AvatarInputHandler.DynamicCameras.ArcadeCamera import ArcadeCamera

class CosmicCamera(ArcadeCamera):

    @staticmethod
    def _getConfigsKey():
        return CosmicCamera.__name__