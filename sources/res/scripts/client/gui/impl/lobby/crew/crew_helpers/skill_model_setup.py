import typing
from gui.impl.gen.view_models.views.lobby.crew.common.skill.skill_model import BattleBooster, SkillModel
from helpers import dependency
from shared_utils import CONST_CONTAINER
from skeletons.gui.shared import IItemsCache
from gui.shared.gui_items.Tankman import Tankman, getBattleBooster, isSkillLearnt
if typing.TYPE_CHECKING:
    from gui.impl.gen.view_models.views.lobby.crew.common.skill.skill_simple_model import SkillSimpleModel
    from gui.shared.gui_items.Vehicle import Vehicle
    from gui.shared.gui_items.Tankman import TankmanSkill
    from gui.shared.items_cache import ItemsCache

class ModelProps(CONST_CONTAINER):
    NAME = 'name'
    LEVEL = 'level'
    ICON_NAME = 'iconName'
    IS_ZERO = 'isZero'
    IS_IRRELEVANT = 'isIrrelevant'
    BATTLE_BOOSTER = 'battleBooster'


def getSkillName(skill, skillName=None, **__):
    if skillName is not None:
        return skillName
    else:
        return skill.name


def getSkillLevel(skill, skillLevel=None, **__):
    if skillLevel is not None:
        return skillLevel
    else:
        return skill.level


def getSkillIconName(skill, iconName=None, **__):
    if iconName is not None:
        return iconName
    else:
        return skill.extensionLessIconName


def skillSimpleModelSetup(model, customGetters=None, **kwargs):
    if customGetters is None:
        customGetters = {}
    getters = defaultPropsGetters.copy()
    getters.update(customGetters)
    nameGetter = getters.get(ModelProps.NAME, None)
    if nameGetter:
        model.setName(nameGetter(**kwargs))
    levelGetter = getters.get(ModelProps.LEVEL, None)
    if levelGetter:
        model.setLevel(levelGetter(**kwargs))
    iconGetter = getters.get(ModelProps.ICON_NAME, None)
    if iconGetter:
        model.setIconName(iconGetter(**kwargs))
    return getters


def getIsZero(skill, tankman, role, isZero=None, **__):
    isMajor = role == tankman.role
    if isZero is not None:
        return isZero
    else:
        if not isMajor:
            return False
        return skill.isZero


def getIsIrrelevant(skill, role, **__):
    return not skill.isRelevantForRole(role)


@dependency.replace_none_kwargs(itemsCache=IItemsCache)
def getModelBattleBooster(skill, tankman, itemsCache=None, **__):
    if tankman.vehicleInvID == Tankman.NO_VEHICLE_INV_ID:
        return BattleBooster.NONE
    else:
        tankmanCurrentVehicle = itemsCache.items.getVehicle(tankman.vehicleInvID)
        battleBooster = getBattleBooster(tankmanCurrentVehicle, skill.name)
        if battleBooster is None:
            return BattleBooster.NONE
        if isSkillLearnt(skill.name, tankmanCurrentVehicle):
            return BattleBooster.IMPROVED
        return BattleBooster.LEARNED


def skillModelSetup(model, customGetters=None, **kwargs):
    getters = skillSimpleModelSetup(model, customGetters, **kwargs)
    isZeroGetter = getters.get(ModelProps.IS_ZERO, None)
    if isZeroGetter:
        model.setIsZero(isZeroGetter(**kwargs))
    isIrrelevantGetter = getters.get(ModelProps.IS_IRRELEVANT, None)
    if isIrrelevantGetter:
        model.setIsIrrelevant(isIrrelevantGetter(**kwargs))
    battleBoosterGetter = getters.get(ModelProps.BATTLE_BOOSTER, None)
    if battleBoosterGetter:
        model.setBattleBooster(battleBoosterGetter(**kwargs))
    return getters


defaultPropsGetters = {ModelProps.NAME: getSkillName, 
   ModelProps.LEVEL: getSkillLevel, 
   ModelProps.ICON_NAME: getSkillIconName, 
   ModelProps.IS_ZERO: getIsZero, 
   ModelProps.IS_IRRELEVANT: getIsIrrelevant, 
   ModelProps.BATTLE_BOOSTER: getModelBattleBooster}