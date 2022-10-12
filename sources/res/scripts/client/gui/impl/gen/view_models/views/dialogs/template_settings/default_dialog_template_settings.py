from enum import Enum
from frameworks.wulf import ViewModel

class DisplayFlags(Enum):
    RESPONSIVEHEADER = 'responsiveHeader'
    RESPONSIVECLOSEPOSITION = 'responsiveClosePosition'
    DISABLERESPONSIVECONTENTPOSITION = 'disableResponsiveContentPosition'


class DefaultDialogTemplateSettings(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(DefaultDialogTemplateSettings, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(DefaultDialogTemplateSettings, self)._initialize()