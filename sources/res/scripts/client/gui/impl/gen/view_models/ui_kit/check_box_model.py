from gui.impl.gen.view_models.ui_kit.button_common_model import ButtonCommonModel

class CheckBoxModel(ButtonCommonModel):
    __slots__ = ()

    def __init__(self, properties=6, commands=2):
        super(CheckBoxModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(CheckBoxModel, self)._initialize()