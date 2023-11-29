from __future__ import absolute_import
from adisp import adisp_process
from constants import QUEUE_TYPE, PREBATTLE_TYPE
from fun_random.gui.feature.fun_constants import FunSubModesState
from fun_random.gui.feature.util.fun_mixins import FunAssetPacksMixin, FunSubModesWatcher
from fun_random.gui.fun_gui_constants import PREBATTLE_ACTION_NAME, SELECTOR_BATTLE_TYPES
from gui.impl import backport
from gui.impl.gen import R
from gui.Scaleform.daapi.view.lobby.header.battle_selector_item import SelectorItem
from gui.Scaleform.daapi.view.lobby.header.battle_selector_items import SpecialSquadItem
from gui.shared.utils.functions import makeTooltip
from helpers import dependency
from skeletons.gui.game_control import IBootcampController

def addFunRandomBattleType(items):
    items.append(_FunRandomItem(PREBATTLE_ACTION_NAME.FUN_RANDOM, 2, SELECTOR_BATTLE_TYPES.FUN_RANDOM))


def addFunRandomSquadType(items):
    items.append(_FunRandomSquadItem('', PREBATTLE_ACTION_NAME.FUN_RANDOM_SQUAD, 2))


class _FunRandomItem(SelectorItem, FunAssetPacksMixin, FunSubModesWatcher):
    __bootcampController = dependency.descriptor(IBootcampController)
    _HIDDEN_STATES = (
     FunSubModesState.UNDEFINED, FunSubModesState.AFTER_SEASON)

    def __init__(self, data, order, selectorType=None, isVisible=True):
        super(_FunRandomItem, self).__init__('', data, order, selectorType, isVisible)
        self._isVisible = self.__getIsVisible()

    def getLabel(self):
        return self.getModeUserName()

    def getLargerIcon(self):
        return backport.image(self.getModeIconsResRoot().battle_type.c_64x64.dyn(self._data)())

    def getSmallIcon(self):
        return backport.image(self.getModeIconsResRoot().battle_type.c_40x40.dyn(self._data)())

    def _update(self, state):
        self._isVisible, self._isDisabled = self.__getIsVisible(), state.hasLockedState
        self._isSelected = state.isQueueSelected(QUEUE_TYPE.FUN_RANDOM)

    @adisp_process
    def _doSelect(self, dispatcher):
        yield self.selectFunRandomBattle()

    def __getIsVisible(self):
        subModesState = self._funRandomCtrl.subModesInfo.getSubModesStatus().state
        return not self.__bootcampController.isInBootcamp() and subModesState not in self._HIDDEN_STATES


class _FunRandomSquadItem(SpecialSquadItem, FunAssetPacksMixin, FunSubModesWatcher):
    _RES_SHORTCUT = R.strings.fun_random.headerButton

    def __init__(self, label, data, order, selectorType=None, isVisible=True):
        super(_FunRandomSquadItem, self).__init__(label, data, order, selectorType, isVisible)
        self._isVisible = self._funRandomCtrl.isFunRandomPrbActive()
        self._prebattleType = PREBATTLE_TYPE.FUN_RANDOM

    @property
    def squadIcon(self):
        return backport.image(self.getModeIconsResRoot().battle_type.c_40x40.fun_random_squad())

    @property
    def tooltip(self):
        return self._createTooltip()

    def getFormattedLabel(self):
        return ''

    def _createTooltip(self):
        return makeTooltip(backport.text(self._RES_SHORTCUT.tooltips.funRandomSquad.header()), backport.text(self._RES_SHORTCUT.tooltips.funRandomSquad.body(), modeName=self.getModeUserName()))

    def _update(self, state):
        super(_FunRandomSquadItem, self)._update(state)
        self._isVisible = self._funRandomCtrl.isFunRandomPrbActive()
        self._isSelected = self._isSelected or self._isVisible