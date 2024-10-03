from frameworks.wulf import ViewModel
from gui.impl.wrappers.user_list_model import UserListModel
from white_tiger.gui.impl.gen.view_models.views.lobby.wt_equipment_slot_model import WtEquipmentSlotModel

class WtEquipmentGroupModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(WtEquipmentGroupModel, self).__init__(properties=properties, commands=commands)

    @property
    def group(self):
        return self._getViewModel(0)

    @staticmethod
    def getGroupType():
        return WtEquipmentSlotModel

    def _initialize(self):
        super(WtEquipmentGroupModel, self)._initialize()
        self._addViewModelProperty('group', UserListModel())