from Event import Event
from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class BCVehicleBuyView(BaseDAAPIComponent):

    def __init__(self):
        super(BCVehicleBuyView, self).__init__()
        self.__academySelected = False
        self.onAcademyClicked = Event()

    def onAcademyClick(self):
        if not self.__academySelected:
            self.__academySelected = True
            self.onAcademyClicked()

    def _dispose(self):
        self.onAcademyClicked.clear()
        super(BCVehicleBuyView, self)._dispose()