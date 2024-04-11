from typing import Dict
import BigWorld, Event
from Math import Vector3

class HBVehiclePositionsComponent(BigWorld.DynamicScriptComponent):

    def __init__(self):
        self.onReceive = Event.Event()

    def receivePosition(self, vehicleEntityID, position):
        self.onReceive({vehicleEntityID: position})

    def receivePositions(self, package):
        self.onReceive(package)