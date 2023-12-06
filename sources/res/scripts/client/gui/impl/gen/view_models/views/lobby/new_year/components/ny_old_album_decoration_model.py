from gui.impl.gen.view_models.views.lobby.new_year.components.ny_album_decoration_model import NyAlbumDecorationModel

class NyOldAlbumDecorationModel(NyAlbumDecorationModel):
    __slots__ = ()

    def __init__(self, properties=8, commands=0):
        super(NyOldAlbumDecorationModel, self).__init__(properties=properties, commands=commands)

    def getShards(self):
        return self._getNumber(6)

    def setShards(self, value):
        self._setNumber(6, value)

    def getIsCanCraft(self):
        return self._getBool(7)

    def setIsCanCraft(self, value):
        self._setBool(7, value)

    def _initialize(self):
        super(NyOldAlbumDecorationModel, self)._initialize()
        self._addNumberProperty('shards', 0)
        self._addBoolProperty('isCanCraft', False)