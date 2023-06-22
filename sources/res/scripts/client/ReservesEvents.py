import Event

class ReservesEvents(object):

    def __init__(self):
        self.onShowPanel = Event.Event()
        self.onSelectedReserve = Event.Event()
        self.onUpdate = Event.Event()
        self.onShownPanel = Event.Event()
        self.hidePanel = Event.Event()
        self.showPanel = Event.Event()


randomReservesEvents = ReservesEvents()