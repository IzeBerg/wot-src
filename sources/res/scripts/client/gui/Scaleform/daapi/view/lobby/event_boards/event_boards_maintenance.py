from gui.Scaleform.daapi.view.meta.MaintenanceComponentMeta import MaintenanceComponentMeta
import Event

class EventBoardsMaintenance(MaintenanceComponentMeta):

    def __init__(self):
        super(EventBoardsMaintenance, self).__init__()
        self.onRefresh = Event.Event()

    def refresh(self):
        self.onRefresh()