from gui.impl.gen.view_models.views.lobby.dog_tags.dt_dog_tag import DtDogTag

class DogTagMarkerViewModel(DtDogTag):
    __slots__ = ()

    def __init__(self, properties=5, commands=0):
        super(DogTagMarkerViewModel, self).__init__(properties=properties, commands=commands)

    def getAnimation(self):
        return self._getString(4)

    def setAnimation(self, value):
        self._setString(4, value)

    def _initialize(self):
        super(DogTagMarkerViewModel, self)._initialize()
        self._addStringProperty('animation', '')