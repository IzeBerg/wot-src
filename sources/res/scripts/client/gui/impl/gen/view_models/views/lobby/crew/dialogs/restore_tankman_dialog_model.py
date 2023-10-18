from gui.impl.gen.view_models.views.dialogs.dialog_template_view_model import DialogTemplateViewModel
from gui.impl.gen.view_models.views.lobby.crew.tankman_model import TankmanModel

class RestoreTankmanDialogModel(DialogTemplateViewModel):
    __slots__ = ()

    def __init__(self, properties=7, commands=2):
        super(RestoreTankmanDialogModel, self).__init__(properties=properties, commands=commands)

    @property
    def tankman(self):
        return self._getViewModel(6)

    @staticmethod
    def getTankmanType():
        return TankmanModel

    def _initialize(self):
        super(RestoreTankmanDialogModel, self)._initialize()
        self._addViewModelProperty('tankman', TankmanModel())