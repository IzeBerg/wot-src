import battle_modifier_readers
from soft_exception import SoftException
from battle_modifier_constants import UseType, ModifierRestriction
from typing import TYPE_CHECKING, Any, Set
if TYPE_CHECKING:
    from battle_modifiers import BattleModifier
    from ResMgr import DataSection

class IModifierValidator(object):
    __slots__ = ('arg', )

    def __init__(self, config, paramId):
        self.arg = self._readConfig(config, paramId)

    def __call__(self, battleModifier):
        if not self._validate(battleModifier):
            paramName = battleModifier.param.name
            errorMsg = self._errorMessage(battleModifier)
            raise SoftException(("[BattleModifier] Validation error for param '{}': {}").format(paramName, errorMsg))

    def _readConfig(self, config, paramId):
        return

    def _validate(self, battleModifier):
        raise NotImplementedError

    def _errorMessage(self, battleModifier):
        return ''


class UseTypeValidator(IModifierValidator):

    def _readConfig(self, config, _):
        useTypes = []
        for useTypeName in config.asString.split():
            if useTypeName not in UseType.NAMES:
                raise SoftException(("[BattleParams] Unknown use type '{}'").format(useTypeName))
            useTypes.append(UseType.NAME_TO_ID[useTypeName])

        return set(useTypes)

    def _validate(self, battleModifier):
        return battleModifier.useType in self.arg

    def _errorMessage(self, battleModifier):
        return ("use type '{}' is not allowed").format(UseType.ID_TO_NAME[battleModifier.useType])


class IValueValidator(IModifierValidator):

    def _readConfig(self, config, paramId):
        return battle_modifier_readers.g_cache[paramId][UseType.VAL](config)

    def _validate(self, battleModifier):
        if battleModifier.useType != UseType.VAL:
            return True
        return self._validateValue(battleModifier.value)

    def _validateValue(self, value):
        raise NotImplementedError


class MinValidator(IValueValidator):

    def _validateValue(self, value):
        return value >= self.arg

    def _errorMessage(self, battleModifier):
        return ('value should be at least {}, given value - {}').format(self.arg, battleModifier.value)


class MaxValidator(IValueValidator):

    def _validateValue(self, value):
        return value <= self.arg

    def _errorMessage(self, battleModifier):
        return ('value should be no more than {}, given value - {}').format(self.arg, battleModifier.value)


class IValueLimiter(object):

    def __call__(self, value):
        raise NotImplementedError


class MinLimiter(IValueLimiter):
    __slots__ = ('__min', )

    def __init__(self, value):
        self.__min = value

    def __call__(self, value):
        if value < self.__min:
            return self.__min
        return value


class MaxLimiter(IValueLimiter):
    __slots__ = ('__max', )

    def __init__(self, value):
        self.__max = value

    def __call__(self, value):
        if value > self.__max:
            return self.__max
        return value


class MinMaxLimiter(IValueLimiter):
    __slots__ = ('__min', '__max')

    def __init__(self, minValue, maxValue):
        self.__min = minValue
        self.__max = maxValue

    def __call__(self, value):
        if value < self.__min:
            return self.__min
        if value > self.__max:
            return self.__max
        return value


g_modifierValidators = {ModifierRestriction.MIN: MinValidator, 
   ModifierRestriction.MAX: MaxValidator, 
   ModifierRestriction.USE_TYPES: UseTypeValidator}