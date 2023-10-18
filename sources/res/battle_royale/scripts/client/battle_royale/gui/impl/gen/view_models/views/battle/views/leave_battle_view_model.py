from gui.impl.gen.view_models.views.dialogs.dialog_template_view_model import DialogTemplateViewModel

class LeaveBattleViewModel(DialogTemplateViewModel):
    __slots__ = ()

    def __init__(self, properties=6, commands=2):
        super(LeaveBattleViewModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(LeaveBattleViewModel, self)._initialize()