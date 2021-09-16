from gui.impl.gen import R
from frameworks.wulf import ViewModel
from gui.impl.wrappers.user_list_model import UserListModel
from gui.impl.gen.view_models.views.lobby.tooltips.role_action_model import RoleActionModel

class RolesViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=4, commands=0):
        super(RolesViewModel, self).__init__(properties=properties, commands=commands)

    @property
    def roleActions(self):
        return self._getViewModel(0)

    def getRoleType(self):
        return self._getString(1)

    def setRoleType(self, value):
        self._setString(1, value)

    def getRoleBgImage(self):
        return self._getResource(2)

    def setRoleBgImage(self, value):
        self._setResource(2, value)

    def getIsRoleActionsEnabled(self):
        return self._getBool(3)

    def setIsRoleActionsEnabled(self, value):
        self._setBool(3, value)

    def _initialize(self):
        super(RolesViewModel, self)._initialize()
        self._addViewModelProperty('roleActions', UserListModel())
        self._addStringProperty('roleType', '')
        self._addResourceProperty('roleBgImage', R.invalid())
        self._addBoolProperty('isRoleActionsEnabled', True)