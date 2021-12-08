from frameworks.wulf import ViewModel

class NewYearMainWidgetAnimTypes(ViewModel):
    __slots__ = ()
    ANIM_TYPE_NONE = 'none'
    ANIM_TYPE_UP_LONG = 'upLong'

    def __init__(self, properties=0, commands=0):
        super(NewYearMainWidgetAnimTypes, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(NewYearMainWidgetAnimTypes, self)._initialize()