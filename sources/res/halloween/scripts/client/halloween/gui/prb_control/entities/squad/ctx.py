from gui.prb_control.entities.base.unit.ctx import UnitRequestCtx
from gui.shared.utils.decorators import ReprInjector

@ReprInjector.withParent(('_queueType', ))
class SetDifficultyLevelUnitCtx(UnitRequestCtx):
    __slots__ = ('_queueType', )

    def __init__(self, queueType, waitingID=''):
        super(SetDifficultyLevelUnitCtx, self).__init__(waitingID=waitingID)
        self._queueType = queueType

    def getQueueType(self):
        return self._queueType