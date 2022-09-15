from typing import Callable, Union, Dict
from battle_modifier_constants import UseType

def makeUseTypeMethods(method, copy=False):
    if isinstance(method, dict):
        if copy:
            return method.copy()
        return method
    return dict((useType, method) for useType in UseType.ALL)