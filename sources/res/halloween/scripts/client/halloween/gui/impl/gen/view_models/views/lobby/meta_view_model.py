from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from halloween.gui.impl.gen.view_models.views.lobby.artefact_view_model import ArtefactViewModel

class MetaViewModel(ViewModel):
    __slots__ = ('onOpenAbout', 'onClose', 'onOpenPreview', 'onSkipArtefact', 'onOpenArtefact',
                 'onChangeArtefact', 'onOpenIntro', 'onMuteSound')

    def __init__(self, properties=7, commands=8):
        super(MetaViewModel, self).__init__(properties=properties, commands=commands)

    @property
    def finalArtefact(self):
        return self._getViewModel(0)

    @staticmethod
    def getFinalArtefactType():
        return ArtefactViewModel

    @property
    def selectedArtefact(self):
        return self._getViewModel(1)

    @staticmethod
    def getSelectedArtefactType():
        return ArtefactViewModel

    def getCurrentProgress(self):
        return self._getNumber(2)

    def setCurrentProgress(self, value):
        self._setNumber(2, value)

    def getMaxProgress(self):
        return self._getNumber(3)

    def setMaxProgress(self, value):
        self._setNumber(3, value)

    def getIsCompleted(self):
        return self._getBool(4)

    def setIsCompleted(self, value):
        self._setBool(4, value)

    def getIsMuted(self):
        return self._getBool(5)

    def setIsMuted(self, value):
        self._setBool(5, value)

    def getArtefacts(self):
        return self._getArray(6)

    def setArtefacts(self, value):
        self._setArray(6, value)

    @staticmethod
    def getArtefactsType():
        return ArtefactViewModel

    def _initialize(self):
        super(MetaViewModel, self)._initialize()
        self._addViewModelProperty('finalArtefact', ArtefactViewModel())
        self._addViewModelProperty('selectedArtefact', ArtefactViewModel())
        self._addNumberProperty('currentProgress', 0)
        self._addNumberProperty('maxProgress', 0)
        self._addBoolProperty('isCompleted', False)
        self._addBoolProperty('isMuted', False)
        self._addArrayProperty('artefacts', Array())
        self.onOpenAbout = self._addCommand('onOpenAbout')
        self.onClose = self._addCommand('onClose')
        self.onOpenPreview = self._addCommand('onOpenPreview')
        self.onSkipArtefact = self._addCommand('onSkipArtefact')
        self.onOpenArtefact = self._addCommand('onOpenArtefact')
        self.onChangeArtefact = self._addCommand('onChangeArtefact')
        self.onOpenIntro = self._addCommand('onOpenIntro')
        self.onMuteSound = self._addCommand('onMuteSound')