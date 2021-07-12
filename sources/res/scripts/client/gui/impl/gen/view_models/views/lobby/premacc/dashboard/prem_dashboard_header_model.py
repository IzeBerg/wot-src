from gui.impl.gen import R
from frameworks.wulf import ViewModel
from gui.impl.wrappers.user_list_model import UserListModel
from gui.impl.gen.view_models.common.user_name_model import UserNameModel
from gui.impl.gen.view_models.views.lobby.premacc.dashboard.prem_dashboard_header_clan_info_model import PremDashboardHeaderClanInfoModel

class PremDashboardHeaderModel(ViewModel):
    __slots__ = ('onShowBadges', 'onEmailButtonClicked')

    def __init__(self, properties=13, commands=2):
        super(PremDashboardHeaderModel, self).__init__(properties=properties, commands=commands)

    @property
    def userName(self):
        return self._getViewModel(0)

    @property
    def clanInfo(self):
        return self._getViewModel(1)

    @property
    def personalReserves(self):
        return self._getViewModel(2)

    @property
    def clanReserves(self):
        return self._getViewModel(3)

    def getPrefixBadgeId(self):
        return self._getString(4)

    def setPrefixBadgeId(self, value):
        self._setString(4, value)

    def getSuffixBadgeId(self):
        return self._getString(5)

    def setSuffixBadgeId(self, value):
        self._setString(5, value)

    def getBadgeContent(self):
        return self._getString(6)

    def setBadgeContent(self, value):
        self._setString(6, value)

    def getIsDynamicBadge(self):
        return self._getBool(7)

    def setIsDynamicBadge(self, value):
        self._setBool(7, value)

    def getIsInClan(self):
        return self._getBool(8)

    def setIsInClan(self, value):
        self._setBool(8, value)

    def getHasClanReserves(self):
        return self._getBool(9)

    def setHasClanReserves(self, value):
        self._setBool(9, value)

    def getIsWarningIconVisible(self):
        return self._getBool(10)

    def setIsWarningIconVisible(self, value):
        self._setBool(10, value)

    def getEmailButtonLabel(self):
        return self._getResource(11)

    def setEmailButtonLabel(self, value):
        self._setResource(11, value)

    def getShowEmailActionTooltip(self):
        return self._getBool(12)

    def setShowEmailActionTooltip(self, value):
        self._setBool(12, value)

    def _initialize(self):
        super(PremDashboardHeaderModel, self)._initialize()
        self._addViewModelProperty('userName', UserNameModel())
        self._addViewModelProperty('clanInfo', PremDashboardHeaderClanInfoModel())
        self._addViewModelProperty('personalReserves', UserListModel())
        self._addViewModelProperty('clanReserves', UserListModel())
        self._addStringProperty('prefixBadgeId', '')
        self._addStringProperty('suffixBadgeId', '')
        self._addStringProperty('badgeContent', '')
        self._addBoolProperty('isDynamicBadge', False)
        self._addBoolProperty('isInClan', False)
        self._addBoolProperty('hasClanReserves', False)
        self._addBoolProperty('isWarningIconVisible', False)
        self._addResourceProperty('emailButtonLabel', R.invalid())
        self._addBoolProperty('showEmailActionTooltip', False)
        self.onShowBadges = self._addCommand('onShowBadges')
        self.onEmailButtonClicked = self._addCommand('onEmailButtonClicked')