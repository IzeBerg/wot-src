from frameworks.wulf import ViewModel

class NySceneRotatableView(ViewModel):
    __slots__ = ('onMouseOver3dScene', 'onMoveSpace')

    def __init__(self, properties=1, commands=2):
        super(NySceneRotatableView, self).__init__(properties=properties, commands=commands)

    def getIsMoveSpaceEnable(self):
        return self._getBool(0)

    def setIsMoveSpaceEnable(self, value):
        self._setBool(0, value)

    def _initialize(self):
        super(NySceneRotatableView, self)._initialize()
        self._addBoolProperty('isMoveSpaceEnable', True)
        self.onMouseOver3dScene = self._addCommand('onMouseOver3dScene')
        self.onMoveSpace = self._addCommand('onMoveSpace')