from frameworks.wulf import ViewModel

class DragonBoatFinishViewModel(ViewModel):
    __slots__ = ('onClose', 'onPickNewTeamBtnClick')

    def __init__(self, properties=1, commands=2):
        super(DragonBoatFinishViewModel, self).__init__(properties=properties, commands=commands)

    def getTeam(self):
        return self._getNumber(0)

    def setTeam(self, value):
        self._setNumber(0, value)

    def _initialize(self):
        super(DragonBoatFinishViewModel, self)._initialize()
        self._addNumberProperty('team', -1)
        self.onClose = self._addCommand('onClose')
        self.onPickNewTeamBtnClick = self._addCommand('onPickNewTeamBtnClick')