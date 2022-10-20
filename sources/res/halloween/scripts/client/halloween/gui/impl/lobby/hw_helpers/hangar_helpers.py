import logging
from adisp import adisp_process
from gui.prb_control.dispatcher import g_prbLoader
from gui.prb_control.entities.base.ctx import PrbAction
from gui.prb_control.settings import PREBATTLE_ACTION_NAME
_logger = logging.getLogger(__name__)

@adisp_process
def closeEvent(callback=None):
    dispatcher = g_prbLoader.getDispatcher()
    if dispatcher is None:
        _logger.error('Prebattle dispatcher is not defined')
        if callback is not None:
            callback(False)
        return
    result = yield dispatcher.doSelectAction(PrbAction(PREBATTLE_ACTION_NAME.RANDOM))
    if callback is not None:
        callback(result)
    return