from visual_script import ASPECT
from visual_script.block import Block, Meta
from visual_script.dependency import dependencyImporter
from visual_script.slot_types import SLOT_TYPE
utils, dependency, cameras = dependencyImporter('skeletons.gui.shared.utils', 'helpers.dependency', 'AvatarInputHandler.cameras')

class CameraMeta(Meta):

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
        return [ASPECT.HANGAR, ASPECT.CLIENT]


class GetCamera(Block, CameraMeta):
    hangarSpace = dependency.descriptor(utils.IHangarSpace)

    def __init__(self, *args, **kwargs):
        super(GetCamera, self).__init__(*args, **kwargs)
        self._position = self._makeDataOutputSlot('position', SLOT_TYPE.VECTOR3, self._getPosition)
        self._direction = self._makeDataOutputSlot('direction', SLOT_TYPE.VECTOR3, self._getDirection)

    def _getPosition(self):
        _, position = cameras.getWorldRayAndPosition()
        self._position.setValue(position)

    def _getDirection(self):
        direction, _ = cameras.getWorldRayAndPosition()
        direction.normalise()
        self._direction.setValue(direction)