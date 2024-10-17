from halloween.skeletons.difficulty_level_controller import IDifficultyLevelController
from helpers import dependency
from halloween_common.halloween_constants import QUEUE_TYPE

@dependency.replace_none_kwargs(ctrl=IDifficultyLevelController)
def isHalloweenDefenceSelected(ctrl=None):
    return ctrl.getCurrentQueueType() == QUEUE_TYPE.HALLOWEEN_DEFENCE