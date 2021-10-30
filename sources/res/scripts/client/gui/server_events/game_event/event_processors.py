import logging, BigWorld
from gui.shared.gui_items.processors import Processor
_logger = logging.getLogger(__name__)

class ChangeSelectedDifficultyLevel(Processor):

    def __init__(self, level, force=False):
        super(ChangeSelectedDifficultyLevel, self).__init__(plugins=None)
        self._level = level
        self._force = force
        return

    def _request(self, callback):
        _logger.debug('Make server request to change difficulty level -> %d', self._level)
        BigWorld.player().changeSelectedDifficultyLevel(self._level, self._force, lambda code, errorCode: self._response(code, callback, errorCode))