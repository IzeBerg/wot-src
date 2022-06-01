from frameworks.wulf import ViewModel

class ChapterConfirmViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=4, commands=0):
        super(ChapterConfirmViewModel, self).__init__(properties=properties, commands=commands)

    def getPrevChapter(self):
        return self._getNumber(0)

    def setPrevChapter(self, value):
        self._setNumber(0, value)

    def getPrevFinalReward(self):
        return self._getString(1)

    def setPrevFinalReward(self, value):
        self._setString(1, value)

    def getNextChapter(self):
        return self._getNumber(2)

    def setNextChapter(self, value):
        self._setNumber(2, value)

    def getNextFinalReward(self):
        return self._getString(3)

    def setNextFinalReward(self, value):
        self._setString(3, value)

    def _initialize(self):
        super(ChapterConfirmViewModel, self)._initialize()
        self._addNumberProperty('prevChapter', 0)
        self._addStringProperty('prevFinalReward', 'style')
        self._addNumberProperty('nextChapter', 0)
        self._addStringProperty('nextFinalReward', '')