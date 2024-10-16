from typing import TYPE_CHECKING
if TYPE_CHECKING:
    from gui.prb_control.items import FunctionalState

class ICarouselEventEntry(object):

    @staticmethod
    def getIsActive(state):
        raise NotImplementedError