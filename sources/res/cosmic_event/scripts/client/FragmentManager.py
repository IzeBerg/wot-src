import Event
from script_component.DynamicScriptComponent import DynamicScriptComponent

class FragmentManager(DynamicScriptComponent):

    def __init__(self, *args):
        super(FragmentManager, self).__init__(*args)
        self.onFragmentsUpdate = Event.Event()

    def set_vehiclesFragments(self, prev):
        vehicleIDs = self.getVehiclesWithFragments()
        for item in prev:
            vehicleIDs.add(item['vehicleID'])

        self.onFragmentsUpdate(vehicleIDs)

    def setNested_vehiclesFragments(self, path, prev):
        vehicleIDs = set()
        idx = path[0]
        vehicleIDs.add(self.vehiclesFragments[idx]['vehicleID'])
        self.onFragmentsUpdate(vehicleIDs)

    def setSlice_vehiclesFragments(self, path, prev):
        vehicleIDs = set()
        fromIndex, toIndex = path[(-1)]
        for item in self.vehiclesFragments[fromIndex:toIndex]:
            vehicleIDs.add(item['vehicleID'])

        for item in prev:
            vehicleIDs.add(item['vehicleID'])

        self.onFragmentsUpdate(vehicleIDs)

    def getVehiclesWithFragments(self):
        return {item['vehicleID'] for item in self.vehiclesFragments}

    def getFragmentsByVehicleID(self, vehicleID):
        for item in self.vehiclesFragments:
            if item['vehicleID'] == vehicleID:
                return item['fragmentsCount']

        return 0