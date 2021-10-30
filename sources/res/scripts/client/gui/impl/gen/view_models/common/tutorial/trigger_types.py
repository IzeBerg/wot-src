from frameworks.wulf import ViewModel

class TriggerTypes(ViewModel):
    __slots__ = ()
    CLICK_TYPE = 'click'
    CLICK_OUTSIDE_TYPE = 'clickOutside'
    ESCAPE = 'escape'
    ENABLED = 'enabled'
    DISABLED = 'disabled'
    ENABLED_CHANGE = 'enabled_change'
    VISIBLE_CHANGE = 'visible_change'

    def __init__(self, properties=0, commands=0):
        super(TriggerTypes, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(TriggerTypes, self)._initialize()