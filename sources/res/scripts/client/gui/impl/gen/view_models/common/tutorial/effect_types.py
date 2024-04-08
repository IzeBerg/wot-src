from frameworks.wulf import ViewModel

class EffectTypes(ViewModel):
    __slots__ = ()
    HINT = 'hint'
    DISPLAY = 'display'
    ENABLED = 'enabled'
    OVERLAY = 'overlay'

    def __init__(self, properties=0, commands=0):
        super(EffectTypes, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(EffectTypes, self)._initialize()