from frameworks.wulf import ViewModel

class ChallengeBaseModel(ViewModel):
    __slots__ = ('onAccept', 'onCancel')

    def __init__(self, properties=0, commands=2):
        super(ChallengeBaseModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(ChallengeBaseModel, self)._initialize()
        self.onAccept = self._addCommand('onAccept')
        self.onCancel = self._addCommand('onCancel')