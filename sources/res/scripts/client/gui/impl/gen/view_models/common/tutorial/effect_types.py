from frameworks.wulf import ViewModel

class EffectTypes(ViewModel):
    __slots__ = ()
    HINT = 'hint'
    BOOTCAMP_HINT = 'bootcampHint'
    DISPLAY = 'display'
    TWEEN = 'tween'
    CLIP = 'clip'
    ENABLED = 'enabled'
    OVERLAY = 'overlay'
    DEFAULT_OVERLAY = 'defaultOverlay'
    LAYOUT = 'layout'

    def __init__(self, properties=0, commands=0):
        super(EffectTypes, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(EffectTypes, self)._initialize()