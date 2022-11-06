from gui.impl.gen.view_models.views.lobby.platoon.button_model import ButtonModel

class ShowSettingsButtonModel(ButtonModel):
    __slots__ = ()

    def __init__(self, properties=8, commands=1):
        super(ShowSettingsButtonModel, self).__init__(properties=properties, commands=commands)

    def getIsPressed(self):
        return self._getBool(6)

    def setIsPressed(self, value):
        self._setBool(6, value)

    def getHasPopover(self):
        return self._getBool(7)

    def setHasPopover(self, value):
        self._setBool(7, value)

    def _initialize(self):
        super(ShowSettingsButtonModel, self)._initialize()
        self._addBoolProperty('isPressed', False)
        self._addBoolProperty('hasPopover', False)