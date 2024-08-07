from enum import IntEnum
from gui.impl.gen.view_models.common.missions.bonuses.icon_bonus_model import IconBonusModel

class State(IntEnum):
    LOCKED = 0
    AVAILABLE = 1
    COLLECTED = 2


class LoginBonusModel(IconBonusModel):
    __slots__ = ()

    def __init__(self, properties=10, commands=0):
        super(LoginBonusModel, self).__init__(properties=properties, commands=commands)

    def getState(self):
        return State(self._getNumber(9))

    def setState(self, value):
        self._setNumber(9, value.value)

    def _initialize(self):
        super(LoginBonusModel, self)._initialize()
        self._addNumberProperty('state')