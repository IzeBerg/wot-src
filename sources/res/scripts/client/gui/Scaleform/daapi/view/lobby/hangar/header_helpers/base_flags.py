import typing
from typing import Dict, List, Optional, Union
if typing.TYPE_CHECKING:
    from gui.shared.gui_items.Vehicle import Vehicle

class IQuestsFlag(object):

    @classmethod
    def isFlagSuitable(cls, questType):
        raise NotImplementedError

    @classmethod
    def formatQuests(cls, vehicle, params):
        raise NotImplementedError

    @classmethod
    def showQuestsInfo(cls, questType, questID):
        raise NotImplementedError