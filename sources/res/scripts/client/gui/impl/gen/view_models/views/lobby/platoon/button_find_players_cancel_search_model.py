from gui.impl.gen.view_models.views.lobby.platoon.custom_sound_button_model import CustomSoundButtonModel

class ButtonFindPlayersCancelSearchModel(CustomSoundButtonModel):
    __slots__ = ()

    def __init__(self, properties=8, commands=1):
        super(ButtonFindPlayersCancelSearchModel, self).__init__(properties=properties, commands=commands)

    def getIsLight(self):
        return self._getBool(7)

    def setIsLight(self, value):
        self._setBool(7, value)

    def _initialize(self):
        super(ButtonFindPlayersCancelSearchModel, self)._initialize()
        self._addBoolProperty('isLight', True)