from fun_random.gui.feature.util.fun_mixins import FunAssetPacksMixin, FunSubModeHolder
from fun_random.gui.feature.util.fun_wrappers import hasHoldingSubMode, filterHoldingSubModeUpdates
from fun_random.gui.fun_gui_constants import PREBATTLE_ACTION_NAME
from gui.Scaleform.daapi.view.lobby.prime_time_view_base import ServerListItemPresenter
from gui.Scaleform.daapi.view.meta.RankedPrimeTimeMeta import RankedPrimeTimeMeta
from gui.impl import backport
from gui.impl.gen import R
from helpers import dependency
from skeletons.connection_mgr import IConnectionManager

class FunRandomServerPresenter(ServerListItemPresenter):
    _RES_ROOT = R.strings.fun_random.primeTimes.serverTooltip
    _connectionMgr = dependency.descriptor(IConnectionManager)

    def __cmp__(self, other):
        peripheryID = self._connectionMgr.peripheryID
        result = cmp(self.getPeripheryID() == peripheryID, other.getPeripheryID() == peripheryID)
        if result:
            return result
        return self.orderID - other.orderID


class FunRandomPrimeTimeView(RankedPrimeTimeMeta, FunAssetPacksMixin, FunSubModeHolder):
    _RES_ROOT = R.strings.fun_random.primeTimes
    _serverPresenterClass = FunRandomServerPresenter

    def __init__(self, ctx):
        super(FunRandomPrimeTimeView, self).__init__(ctx)
        self.catchSubMode(ctx['subModeID'])

    def _dispose(self):
        super(FunRandomPrimeTimeView, self)._dispose()
        self.releaseSubMode()

    @hasHoldingSubMode(abortAction='closeView')
    def _initView(self):
        super(FunRandomPrimeTimeView, self)._initView()
        subModeName = backport.text(self.getHoldingSubMode().getLocalsResRoot().userName())
        self.as_setHeaderDataS({'title': self.getModeDetailedUserName(subModeName=subModeName)})
        self.as_setBackgroundSourceS(backport.image(self.getModeIconsResRoot().library.prime_times_bg()))

    @hasHoldingSubMode()
    def _clearView(self):
        super(FunRandomPrimeTimeView, self)._clearView()

    def _isAlertBGVisible(self):
        return False

    def _getController(self):
        return self.getHoldingSubMode()

    def _getPrbActionName(self):
        return self._getPrbForcedActionName()

    def _getPrbForcedActionName(self):
        return PREBATTLE_ACTION_NAME.FUN_RANDOM

    def _getServerText(self, serverList, serverInfo, isServerNameShort=False):
        if any(server.isAvailable() for server in serverList):
            availableKey = 'availableServers' if len(serverList) > 1 else 'availableServer'
            return backport.text(R.strings.fun_random.primeTimes.dyn(availableKey)())
        return super(FunRandomPrimeTimeView, self)._getServerText(serverList, serverInfo, isServerNameShort)

    @filterHoldingSubModeUpdates
    def _onControllerUpdated(self, *args):
        super(FunRandomPrimeTimeView, self)._onControllerUpdated(*args)

    def _startControllerListening(self):
        self.startSubSettingsListening(self._onControllerUpdated)

    def _stopControllerListening(self):
        self.stopSubSettingsListening(self._onControllerUpdated)