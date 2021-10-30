from gui.Scaleform.daapi.view.meta.SecondaryEntryPointMeta import SecondaryEntryPointMeta
from gui.impl.gen import R
from gui.impl import backport
from helpers import dependency
from skeletons.gui.game_control import IBattlePassController
from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.Scaleform.locale.BATTLE_PASS import BATTLE_PASS
from gui.impl.lobby.battle_pass.battle_pass_entry_point_view import BaseBattlePassEntryPointView
_TOOLTIPS = {R.views.lobby.battle_pass.tooltips.BattlePassNotStartedTooltipView(): TOOLTIPS_CONSTANTS.BATTLE_PASS_NOT_STARTED, 
   R.views.lobby.battle_pass.tooltips.BattlePassCompletedTooltipView(): TOOLTIPS_CONSTANTS.BATTLE_PASS_COMPLETED, 
   R.views.lobby.battle_pass.tooltips.BattlePass3dStyleNotChosenTooltip(): TOOLTIPS_CONSTANTS.BATTLE_PASS_3D_NOT_CHOOSEN, 
   R.views.lobby.battle_pass.tooltips.BattlePassInProgressTooltipView(): TOOLTIPS_CONSTANTS.BATTLE_PASS_IN_PROGRESS}

class BattlePassSecondaryEntryPointWidget(SecondaryEntryPointMeta, BaseBattlePassEntryPointView):
    __battlePassController = dependency.descriptor(IBattlePassController)
    __slots__ = ('__arenaBonusType', )

    def __init__(self):
        super(BattlePassSecondaryEntryPointWidget, self).__init__()
        self.__arenaBonusType = None
        return

    def onClick(self):
        self._onClick()

    def update(self, currentArenaBonusType):
        self.__arenaBonusType = currentArenaBonusType
        self._updateData()

    def _populate(self):
        super(BattlePassSecondaryEntryPointWidget, self)._populate()
        self._start()

    def _dispose(self):
        self._stop()
        super(BattlePassSecondaryEntryPointWidget, self)._dispose()

    def _updateData(self, *_):
        super(BattlePassSecondaryEntryPointWidget, self)._updateData()
        if self.__arenaBonusType is None:
            return
        else:
            currentLevel = ''
            if not self._isCompleted():
                currentLevel = min(self._widgetLevel + 1, self._battlePassController.getMaxLevel())
            flagIcon = backport.image(R.images.gui.maps.icons.library.hangarEntryPoints.dyn(('chapter_{}').format(self._widgetChapter), R.images.gui.maps.icons.library.hangarEntryPoints.chapter_1)())
            gameModeIsEnabled = self.__battlePassController.isGameModeEnabled(self.__arenaBonusType)
            isEnabled = gameModeIsEnabled and self.__battlePassController.isActive() and self.__battlePassController.isEnabled()
            data = {'flagIcon': flagIcon, 
               'icon': self.__getIcon(), 
               'altIcon': self.__getAltIcon(isEnabled), 
               'text': str(currentLevel), 
               'isEnabled': isEnabled, 
               'isBought': self._isBought(), 
               'is3DStyleChosen': self._is3DStyleChosen()}
            self.__updateTooltipData(data, self.__arenaBonusType, gameModeIsEnabled)
            self.as_setDataS(data)
            if isEnabled:
                self.as_setCountS(self._getNotChosenRewardCountWith3d())
            return

    def _getCurrentArenaBonusType(self):
        return self.__arenaBonusType

    def __getIcon(self):
        hangarEntryPoints = R.images.gui.maps.icons.library.hangarEntryPoints
        if self._isBought() or self._isCompleted():
            icon = hangarEntryPoints.bp_entry_icon_purple_gold() if self._isCompleted() else hangarEntryPoints.bp_entry_icon_grey_gold()
        else:
            icon = hangarEntryPoints.bp_entry_icon_brown_silver()
        return backport.image(icon)

    def __getAltIcon(self, isEnabled):
        altIcon = ''
        if not self._is3DStyleChosen() and isEnabled:
            altIcon = backport.image(R.images.gui.maps.icons.library.hangarEntryPoints.c_3dStyles())
        elif self._isCompleted():
            altIcon = backport.image(R.images.gui.maps.icons.library.hangarEntryPoints.completedGold())
        return altIcon

    def __updateTooltipData(self, data, currentArenaBonusType, gameModeIsEnabled):
        if gameModeIsEnabled and self.__battlePassController.isEnabled():
            tooltip = _TOOLTIPS.get(self._getTooltip(), '')
            tooltipType = TOOLTIPS_CONSTANTS.WULF
        elif not self.__battlePassController.isEnabled():
            tooltip = BATTLE_PASS.TOOLTIPS_ENTRYPOINT_DISABLED
            tooltipType = TOOLTIPS_CONSTANTS.COMPLEX
        else:
            tooltip = backport.text(R.strings.battle_pass.tooltips.secondaryEntryPoint.disabled.num(currentArenaBonusType)())
            if tooltip:
                tooltipType = TOOLTIPS_CONSTANTS.SIMPLE
            else:
                tooltip = BATTLE_PASS.TOOLTIPS_ENTRYPOINT_DISABLED
                tooltipType = TOOLTIPS_CONSTANTS.COMPLEX
        data['tooltip'] = str(tooltip)
        data['tooltipType'] = tooltipType