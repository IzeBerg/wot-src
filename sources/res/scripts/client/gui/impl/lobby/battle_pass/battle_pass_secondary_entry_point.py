from gui.Scaleform.daapi.view.meta.SecondaryEntryPointMeta import SecondaryEntryPointMeta
from gui.impl.gen import R
from gui.impl import backport
from helpers import dependency
from skeletons.gui.game_control import IBattlePassController
from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.Scaleform.locale.BATTLE_PASS import BATTLE_PASS
from gui.impl.lobby.battle_pass.battle_pass_entry_point_view import BaseBattlePassEntryPointView
_R_TOOLTIPS = R.views.lobby.battle_pass.tooltips
_TOOLTIPS = {_R_TOOLTIPS.BattlePassNotStartedTooltipView(): TOOLTIPS_CONSTANTS.BATTLE_PASS_NOT_STARTED, 
   _R_TOOLTIPS.BattlePassCompletedTooltipView(): TOOLTIPS_CONSTANTS.BATTLE_PASS_COMPLETED, 
   _R_TOOLTIPS.BattlePassInProgressTooltipView(): TOOLTIPS_CONSTANTS.BATTLE_PASS_IN_PROGRESS, 
   _R_TOOLTIPS.BattlePassNoChapterTooltipView(): TOOLTIPS_CONSTANTS.BATTLE_PASS_NO_CHAPTER}

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
            flagIcon = backport.image(R.images.gui.maps.icons.library.hangarEntryPoints.battlePass.dyn(('flag_chapter_{}').format(self.chapterID))()) if self.chapterID > 0 else None
            gameModeIsEnabled = self.__battlePassController.isGameModeEnabled(self.__arenaBonusType)
            isEnabled = gameModeIsEnabled and self.__battlePassController.isActive() and self.__battlePassController.isEnabled()
            data = {'flagIcon': flagIcon, 
               'icon': self.__getIcon(), 
               'altIcon': self.__getAltIcon(isEnabled), 
               'text': str(self.level + 1), 
               'isEnabled': isEnabled, 
               'isBought': self.isBought, 
               'chapterID': self.chapterID, 
               'points': self.freePoints if self.isCompleted else 0}
            self.__updateTooltipData(data, self.__arenaBonusType, gameModeIsEnabled)
            self.as_setDataS(data)
            if isEnabled:
                self.as_setCountS(self._getNotChosenRewardCount())
            return

    def _getCurrentArenaBonusType(self):
        return self.__arenaBonusType

    def __getIcon(self):
        hangarEntryPoints = R.images.gui.maps.icons.library.hangarEntryPoints.battlePass
        if self.isBought or self.isCompleted:
            shieldTemplate = 'shield_blue{}{}'
            color = '_gold' if self.isBought else '_silver'
            postfix = '_closed' if self.isCompleted and self.freePoints == 0 else ''
            icon = hangarEntryPoints.dyn(shieldTemplate.format(color, postfix))()
        else:
            icon = hangarEntryPoints.shield_silver() if self.chapterID != 0 else hangarEntryPoints.shield_silver_empty()
        return backport.image(icon)

    def __getAltIcon(self, isEnabled):
        hangarEntryPoints = R.images.gui.maps.icons.library.hangarEntryPoints.battlePass
        if self.chapterID > 0:
            iconTemplate = 'icon_gold_chapter_{}' if self.isBought else 'icon_silver_chapter_{}'
            icon = hangarEntryPoints.dyn(iconTemplate.format(self.chapterID))()
        elif self.isCompleted:
            icon = hangarEntryPoints.icon_completed_gold() if self.isBought else hangarEntryPoints.icon_completed_silver()
        else:
            icon = hangarEntryPoints.icon_chapter_empty()
        return backport.image(icon)

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