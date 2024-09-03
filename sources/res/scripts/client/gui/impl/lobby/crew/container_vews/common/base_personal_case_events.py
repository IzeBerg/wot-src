from gui.impl.lobby.container_views.base.events import ComponentEventsBase

class BasePersonalCaseComponentViewEvents(ComponentEventsBase):

    def __init__(self):
        super(BasePersonalCaseComponentViewEvents, self).__init__()
        self.onChangeVehicleClick = self._createEvent()
        self.onRetrainClick = self._createEvent()