import BigWorld, Event

class MapImageComponent(BigWorld.DynamicScriptComponent):
    onMapUpdate = Event.Event()

    def __init__(self):
        super(MapImageComponent, self).__init__()
        self.onMapUpdate()

    def set_mapImage(self, prev):
        self.onMapUpdate()