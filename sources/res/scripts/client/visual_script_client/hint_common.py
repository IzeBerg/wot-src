from visual_script.slot_types import SLOT_TYPE
from visual_script.block import Block
from visual_script.misc import errorVScript
from constants import IS_VS_EDITOR
if not IS_VS_EDITOR:
    from HintManager import HintManager

class ProcessHint(Block):

    def __init__(self, *args, **kwargs):
        super(ProcessHint, self).__init__(*args, **kwargs)
        self._in = self._makeEventInputSlot('in', self.__execute)
        self._id = self._makeDataInputSlot('id', SLOT_TYPE.ID)
        self._out = self._makeEventOutputSlot('out')

    def _processHint(self, hint):
        pass

    def __execute(self):
        if not IS_VS_EDITOR:
            hintId = self._id.getValue()
            hint = HintManager.hintManager().getHint(hintId)
            if hint is not None:
                self._processHint(hint)
            else:
                errorVScript(self, 'Unknown hint id')
        self._out.call()
        return