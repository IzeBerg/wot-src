import typing
from fun_random.gui.feature.sub_modes.base_sub_mode import FunBaseSubMode
if typing.TYPE_CHECKING:
    from gui.periodic_battles.models import AlertData

class FunNewYearSubMode(FunBaseSubMode):

    def hasHangarHeaderEntry(self):
        return False

    def getAlertBlock(self):
        return (
         None, self._ALERT_DATA_CLASS(), False)