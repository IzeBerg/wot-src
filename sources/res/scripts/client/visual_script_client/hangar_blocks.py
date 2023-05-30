from visual_script import ASPECT
from visual_script.block import Block, Meta
from visual_script.dependency import dependencyImporter
from visual_script.slot_types import SLOT_TYPE
utils, dependency, CGF, hangar_camera_manager = dependencyImporter('skeletons.gui.shared.utils', 'helpers.dependency', 'CGF', 'cgf_components.hangar_camera_manager')

class HangarCameraMeta(Meta):

    @classmethod
    def blockColor(cls):
        return 6750207

    @classmethod
    def blockCategory(cls):
        return 'Camera'

    @classmethod
    def blockIcon(cls):
        return ':vse/blocks/camera'

    @classmethod
    def blockAspects(cls):
        return [ASPECT.HANGAR]


class GetCamera(Block, HangarCameraMeta):
    hangarSpace = dependency.descriptor(utils.IHangarSpace)

    def __init__(self, *args, **kwargs):
        super(GetCamera, self).__init__(*args, **kwargs)
        self._position = self._makeDataOutputSlot('position', SLOT_TYPE.VECTOR3, self._getPosition)
        self._direction = self._makeDataOutputSlot('direction', SLOT_TYPE.VECTOR3, self._getDirection)

    def _getPosition(self):
        cameraManager = CGF.getManager(self.hangarSpace.spaceID, hangar_camera_manager.HangarCameraManager)
        if cameraManager:
            self._position.setValue(cameraManager.getCurrentCameraPosition())

    def _getDirection(self):
        cameraManager = CGF.getManager(self.hangarSpace.spaceID, hangar_camera_manager.HangarCameraManager)
        if cameraManager:
            self._direction.setValue(cameraManager.getCurrentCameraDirection())