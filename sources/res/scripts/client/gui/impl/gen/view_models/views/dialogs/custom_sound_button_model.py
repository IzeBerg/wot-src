from gui.impl.gen.view_models.views.dialogs.dialog_template_button_view_model import DialogTemplateButtonViewModel

class CustomSoundButtonModel(DialogTemplateButtonViewModel):
    __slots__ = ()

    def __init__(self, properties=6, commands=0):
        super(CustomSoundButtonModel, self).__init__(properties=properties, commands=commands)

    def getSoundClick(self):
        return self._getString(5)

    def setSoundClick(self, value):
        self._setString(5, value)

    def _initialize(self):
        super(CustomSoundButtonModel, self)._initialize()
        self._addStringProperty('soundClick', '')