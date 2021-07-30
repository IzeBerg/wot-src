import logging, typing, BigWorld
from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from helpers import dependency
from skeletons.gui.app_loader import IAppLoader
from uilogging.base.logger import BaseLogger, ifUILoggingEnabled
from uilogging.base.mixins import TimedActionMixin
from uilogging.core.core_constants import LogLevels
from uilogging.veh_post_progression.constants import FEATURE, LogGroups, LogAdditionalInfo, LogActions, ParentScreens
from wotdecorators import noexcept
_logger = logging.getLogger(__name__)

class VehPostProgressionLogger(TimedActionMixin, BaseLogger):

    def __init__(self, group):
        super(VehPostProgressionLogger, self).__init__(FEATURE, group.value)

    @noexcept
    @ifUILoggingEnabled()
    def log(self, action, additionalInfo=None, parentScreen=None, loglevel=LogLevels.INFO, timeSpent=0):
        data = {'additional_info': additionalInfo, 
           'parent_screen': parentScreen}
        data = {k:v.value for k, v in data.iteritems() if v is not None if v is not None}
        super(VehPostProgressionLogger, self).log(action=action.value, loglevel=loglevel, timeSpent=timeSpent, **data)

    @noexcept
    @ifUILoggingEnabled()
    def logClick(self, parentScreen, additionalInfo=None):
        self.log(action=LogActions.CLICK, additionalInfo=additionalInfo, parentScreen=parentScreen)


class VehPostProgressionEntryPointLogger(VehPostProgressionLogger):
    __TOOLTIP_TIME_LIMIT = 0.3

    def __init__(self):
        super(VehPostProgressionEntryPointLogger, self).__init__(LogGroups.ENTRY_POINT)
        self.__parentScreen = None
        self.__isUnlocked = None
        return

    @noexcept
    @ifUILoggingEnabled()
    def log(self, action, parentScreen, isUnlocked=None, loglevel=LogLevels.INFO, timeSpent=0):
        if isUnlocked is not None:
            additionalInfo = LogAdditionalInfo.UNLOCKED if isUnlocked else LogAdditionalInfo.LOCKED
        else:
            additionalInfo = None
        super(VehPostProgressionEntryPointLogger, self).log(action=action, additionalInfo=additionalInfo, parentScreen=ParentScreens(parentScreen), loglevel=loglevel, timeSpent=timeSpent)
        return

    @noexcept
    @ifUILoggingEnabled()
    def logEnter(self):
        self.log(action=LogActions.CLICK, parentScreen=ParentScreens.VEH_COMPARE)

    @noexcept
    @ifUILoggingEnabled()
    def onTooltipOpened(self, parentScreen, isUnlocked):
        self.__parentScreen = parentScreen
        self.__isUnlocked = isUnlocked
        self.startAction(LogActions.TOOLTIP_WATCHED)

    @noexcept
    @ifUILoggingEnabled()
    def onTooltipClosed(self):
        self.stopAction(action=LogActions.TOOLTIP_WATCHED, timeLimit=self.__TOOLTIP_TIME_LIMIT, parentScreen=self.__parentScreen, isUnlocked=self.__isUnlocked)
        self.__parentScreen = None
        self.__isUnlocked = None
        return


class VehPostProgressionSpecSlotLogger(VehPostProgressionLogger):
    _appLoader = dependency.descriptor(IAppLoader)
    __TOOLTIP_DELAY_COMPENSATION = 0.4
    __TOOLTIP_TIME_LIMIT = 0

    def __init__(self):
        super(VehPostProgressionSpecSlotLogger, self).__init__(LogGroups.CUSTOM_SLOT_SPECIALIZATION)
        self.__isClickable = None
        return

    def initialize(self):
        app = self._appLoader.getApp()
        if app is not None:
            tooltipMgr = app.getToolTipMgr()
            if tooltipMgr is not None:
                tooltipMgr.onHide += self.__onHideTooltip
                tooltipMgr.onShow += self.__onShowTooltip
        return

    def reset(self):
        super(VehPostProgressionSpecSlotLogger, self).reset()
        self.__isClickable = None
        app = self._appLoader.getApp()
        if app is not None:
            tooltipMgr = app.getToolTipMgr()
            if tooltipMgr is not None:
                tooltipMgr.onHide -= self.__onHideTooltip
                tooltipMgr.onShow -= self.__onShowTooltip
        return

    @noexcept
    def __onHideTooltip(self, tooltip):
        if tooltip == TOOLTIPS_CONSTANTS.HANGAR_SLOT_SPEC:
            parentScreen = ParentScreens.TANK_SETUP if self.__isClickable else ParentScreens.HANGAR
            action = LogActions.TOOLTIP_WATCHED
            startTime = self._timedActions.pop(action, None)
            if startTime is None:
                _logger.debug('%s action: %s is not started.', self, action)
                return
            timeSpent = BigWorld.time() - startTime - self.__TOOLTIP_DELAY_COMPENSATION
            if timeSpent > self.__TOOLTIP_TIME_LIMIT:
                self.log(action, timeSpent=timeSpent, parentScreen=parentScreen)
            self.__isClickable = None
        return

    @noexcept
    def __onShowTooltip(self, tooltip, args, _):
        if tooltip == TOOLTIPS_CONSTANTS.HANGAR_SLOT_SPEC:
            _, isDyn, isClickable = args
            if isDyn:
                self.__isClickable = isClickable
                self.startAction(LogActions.TOOLTIP_WATCHED)


class VehPostProgressionPrebattleSwitchPanelLogger(VehPostProgressionLogger):

    def __init__(self):
        super(VehPostProgressionPrebattleSwitchPanelLogger, self).__init__(LogGroups.SWITCH_PANEL)

    @noexcept
    @ifUILoggingEnabled()
    def logClick(self):
        super(VehPostProgressionPrebattleSwitchPanelLogger, self).logClick(parentScreen=ParentScreens.HUD)

    @noexcept
    @ifUILoggingEnabled()
    def logHotkey(self):
        super(VehPostProgressionPrebattleSwitchPanelLogger, self).log(action=LogActions.HOTKEY, parentScreen=ParentScreens.HUD)


class VehPostProgressionModificationTooltipLogger(VehPostProgressionLogger):

    @noexcept
    @ifUILoggingEnabled()
    def onTooltipOpened(self):
        self.startAction(LogActions.TOOLTIP_WATCHED)

    @noexcept
    @ifUILoggingEnabled()
    def onTooltipClosed(self, parentScreen):
        self.stopAction(action=LogActions.TOOLTIP_WATCHED, parentScreen=parentScreen)


class VehPostProgressionCmpViewLogger(VehPostProgressionLogger):

    def __init__(self):
        super(VehPostProgressionCmpViewLogger, self).__init__(LogGroups.COMPARE_MODIFICATIONS_TREE)

    @noexcept
    @ifUILoggingEnabled()
    def onViewOpened(self):
        self.startAction(LogActions.CLOSE)

    @noexcept
    @ifUILoggingEnabled()
    def onViewClosed(self):
        self.stopAction(action=LogActions.CLOSE, parentScreen=ParentScreens.COMPARE_MODIFICATIONS_TREE)