from frameworks.wulf import ViewModel

class HelpNavigateFrom(ViewModel):
    __slots__ = ()
    QUICKTRAINING = 'QuickTraining'
    PERSONALFILE = 'PersonalFile'
    PERSONALDATA = 'PersonalData'

    def __init__(self, properties=0, commands=0):
        super(HelpNavigateFrom, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(HelpNavigateFrom, self)._initialize()