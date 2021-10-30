from visual_script import ASPECT
from visual_script.block import Block, Meta
from visual_script.dependency import dependencyImporter
from visual_script.misc import errorVScript
from visual_script.slot_types import SLOT_TYPE
utils, dependency = dependencyImporter('skeletons.gui.shared.utils', 'helpers.dependency')

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

    @property
    def _camera(self):
        if self.hangarSpace is None or self.hangarSpace.space is None:
            errorVScript(self, "Can't access the hangar space")
            return
        else:
            return self.hangarSpace.space.camera

    def _getPosition(self):
        camera = self._camera
        if camera is not None:
            self._position.setValue(camera.position)
        return

    def _getDirection(self):
        camera = self._camera
        if camera is not None:
            self._direction.setValue(camera.direction)
        return