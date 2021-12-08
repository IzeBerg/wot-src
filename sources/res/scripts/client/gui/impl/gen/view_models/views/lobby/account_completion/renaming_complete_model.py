from gui.impl.gen.view_models.views.lobby.account_completion.complete_model import CompleteModel

class RenamingCompleteModel(CompleteModel):
    __slots__ = ()

    def __init__(self, properties=5, commands=2):
        super(RenamingCompleteModel, self).__init__(properties=properties, commands=commands)

    def getName(self):
        return self._getString(4)

    def setName(self, value):
        self._setString(4, value)

    def _initialize(self):
        super(RenamingCompleteModel, self)._initialize()
        self._addStringProperty('name', '')