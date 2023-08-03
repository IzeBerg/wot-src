import typing
from functools import wraps
import operator, math_utils
from fun_random.gui.doc_loaders.vehicle_gui_parameters_reader import getVehicleParametersConfig
from fun_random.gui.impl.gen.view_models.views.lobby.common.fun_random_progression_state import FunRandomProgressionStatus
from fun_random.gui.impl.gen.view_models.views.lobby.common.fun_random_progression_stage import FunRandomProgressionStage
from fun_random.gui.impl.gen.view_models.views.lobby.common.fun_random_vehicle_parameter import FunRandomVehicleParameter
from gui.impl import backport
from gui.impl.gen import R
from gui.impl.lobby.common.view_helpers import packBonusModelAndTooltipData
from gui.shared.formatters import time_formatters
from gui.shared.formatters.ranges import toRomanRangeString
from gui.shared.missions.packers.bonus import BonusUIPacker, getDefaultBonusPackersMap
from shared_utils import first, findFirst
if typing.TYPE_CHECKING:
    from frameworks.wulf import Array
    from fun_random.gui.doc_loaders import VehicleParameters
    from fun_random.gui.feature.models.progressions import FunProgressionStage, FunProgression
    from fun_random.gui.impl.gen.view_models.views.lobby.common.fun_random_progression_state import FunRandomProgressionState
    from fun_random.gui.impl.gen.view_models.views.lobby.common.fun_random_progression_condition import FunRandomProgressionCondition
    from fun_random.gui.impl.gen.view_models.views.lobby.common.fun_random_strengths_weaknesses import FunRandomStrengthsWeaknesses
    from gui.impl.gen.view_models.common.missions.bonuses.bonus_model import BonusModel
    from gui.impl.gen.view_models.common.missions.bonuses.item_bonus_model import ItemBonusModel
_PROGRESSION_STATUS_MAP = {(False, False): FunRandomProgressionStatus.ACTIVE_RESETTABLE, 
   (True, False): FunRandomProgressionStatus.COMPLETED_RESETTABLE, 
   (False, True): FunRandomProgressionStatus.ACTIVE_FINAL, 
   (True, True): FunRandomProgressionStatus.COMPLETED_FINAL}

def getFormattedTimeLeft(seconds):
    return time_formatters.getTillTimeByResource(seconds, R.strings.fun_random.modeSelector.status.timeLeft, removeLeadingZeros=True)


def getConditionText(rootStrPath, levels):
    battleCondition = rootStrPath.dyn('battleCondition')
    components = [backport.text(battleCondition()) if battleCondition.exists() else '']
    levelCondition = rootStrPath.dyn('levelCondition')
    levels = toRomanRangeString(levels)
    if levelCondition.exists() and levels:
        components.append(backport.text(levelCondition(), levels=levels))
    if len(components) > 1:
        return (' ').join(components)
    return first(components, '')


def getFunRandomBonusPacker():
    mapping = getDefaultBonusPackersMap()
    return BonusUIPacker(mapping)


def hasVehicleConfig(defReturn=None, abortAction=None):

    def decorator(method):

        @wraps(method)
        def wrapper(view, vehicleName, *args, **kwargs):
            config = getVehicleParametersConfig()
            if vehicleName in config.vehicles:
                return method(view, vehicleName, config, *args, **kwargs)
            else:
                if abortAction is not None:
                    return operator.methodcaller(abortAction)(view)
                return defReturn

        return wrapper

    return decorator


def defineProgressionStatus(progression):
    if progression is not None:
        return _PROGRESSION_STATUS_MAP[(progression.state.isCompleted, progression.state.isLastProgression)]
    else:
        return FunRandomProgressionStatus.DISABLED


def packAdditionalRewards(progression, stageIndex, showCount):
    result, packer = [], getFunRandomBonusPacker()
    stage = findFirst(lambda s: s.stageIndex == stageIndex, progression.stages)
    bonuses = stage.bonuses if stage is not None else []
    for bonus in (b for b in bonuses if b.isShowInGUI()):
        result.extend(packer.pack(bonus))

    return result[showCount:]


def packProgressionActiveStage(progression, stageModel, tooltips=None):
    _packProgressionStage(progression, progression.activeStage, stageModel, tooltips)


def packProgressionCondition(progression, conditionModel):
    conditionModel.setText(progression.condition.text)
    conditionModel.setCurrentPoints(progression.condition.counter)
    conditionModel.setMaximumPoints(progression.condition.maximumCounter)
    _packProgressionConditions(progression, conditionModel.getConditions())


def packProgressionStages(progression, stagesModel, tooltips=None):
    stagesModel.clear()
    for stage in progression.stages:
        stageModel = FunRandomProgressionStage()
        _packProgressionStage(progression, stage, stageModel, tooltips)
        stagesModel.addViewModel(stageModel)

    stagesModel.invalidate()


def packProgressionState(progression, stateModel):
    stateModel.setStatus(defineProgressionStatus(progression))
    stateModel.setCurrentStage(progression.state.currentStageIndex + 1)
    stateModel.setMaximumStage(progression.state.maximumStageIndex + 1)
    stateModel.setResetTimer(progression.condition.resetTimer)


def packVehicleParameters(model, allParameters, vehicleParameters):
    _packParametersGroup(model.getStrengths(), allParameters, vehicleParameters.strengths)
    _packParametersGroup(model.getWeaknesses(), allParameters, vehicleParameters.weaknesses)


def _packProgressionConditions(progression, conditionsModel):
    conditionsModel.clear()
    for conditionPointer in progression.condition.conditions:
        conditionsModel.addString(conditionPointer)

    conditionsModel.invalidate()


def _packProgressionStage(progression, stage, stageModel, tooltips=None):
    maximumPoints = stage.requiredCounter - stage.prevRequiredCounter
    currentPoints = progression.condition.counter - stage.prevRequiredCounter
    stageModel.setCurrentPoints(math_utils.clamp(0, maximumPoints, currentPoints))
    stageModel.setMaximumPoints(maximumPoints)
    _packStageRewards(stage, stageModel.getRewards(), tooltips)


def _packStageRewards(stage, rewardsModel, tooltips=None):
    rewardsModel.clear()
    packBonusModelAndTooltipData(stage.bonuses, rewardsModel, tooltipData=tooltips, packer=getFunRandomBonusPacker())
    rewardsModel.invalidate()


def _packParametersGroup(model, allParameters, vehicleParameters):
    model.clear()
    for parameterName in vehicleParameters:
        parameterModel = FunRandomVehicleParameter()
        parameterModel.setParameterName(parameterName)
        parameterModel.setIcon(allParameters[parameterName])
        model.addViewModel(parameterModel)

    model.invalidate()