from gui.impl.lobby.container_views.base.events import ComponentEventsBase

class ExampleComponentViewEvents(ComponentEventsBase):

    def __init__(self):
        super(ExampleComponentViewEvents, self).__init__()
        self.onSelected = self._createEvent()
        self.onSomethingElse = self._createEvent()