import typing
from fun_random.gui.feature.util.fun_mixins import FunAssetPacksMixin, FunSubModesWatcher
from fun_random.gui.impl.lobby.common.fun_view_helpers import getConditionText
from shared_utils import first
if typing.TYPE_CHECKING:
    from fun_random.gui.feature.sub_modes.base_sub_mode import IFunSubMode

class IModeSelectorHelper(object):
    __slots__ = ()

    def isDisabled(self):
        raise NotImplementedError

    def getConditionText(self):
        raise NotImplementedError

    def clear(self):
        pass


class _SingleModeSelectorHelper(IModeSelectorHelper, FunAssetPacksMixin, FunSubModesWatcher):
    __slots__ = ('__subMode', )

    def __init__(self, subMode):
        self.__subMode = subMode

    def isDisabled(self):
        isFrozen = self.__subMode.isBattlesPossible() and self.__subMode.isFrozen()
        self._funRandomCtrl.notifications.markSeenAsFrozen([self.__subMode.getSubModeID()] if isFrozen else [])
        return isFrozen

    def getConditionText(self):
        return getConditionText(self.getModeLocalsResRoot().mode_selector, self.__subMode.getSettings().filtration.levels)

    def clear(self):
        self.__subMode = None
        return


class _MultiModesSelectorHelper(IModeSelectorHelper):
    __slots__ = ()

    def isDisabled(self):
        return False

    def getConditionText(self):
        return ''


def createSelectorHelper(subModes):
    if len(subModes) == 1:
        return _SingleModeSelectorHelper(first(subModes))
    return _MultiModesSelectorHelper()