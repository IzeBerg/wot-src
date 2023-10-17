from gui.shared import g_eventBus, events, EVENT_BUS_SCOPE
from halloween.gui.impl.gen.view_models.views.lobby.vehicle_title_view_model import VehicleStates
from halloween.skeletons.halloween_controller import IHalloweenController
from helpers import dependency

def updateHeaderMenu(state):
    g_eventBus.handleEvent(events.LobbyHeaderMenuEvent(events.LobbyHeaderMenuEvent.TOGGLE_VISIBILITY, ctx={'state': state}), scope=EVENT_BUS_SCOPE.LOBBY)


@dependency.replace_none_kwargs(ctrl=IHalloweenController)
def getVehicleState(vehicle, ctrl=None):
    state = VehicleStates.DEFAULT
    if not ctrl.hasAccessToVehicle(vehicle.intCD):
        state = VehicleStates.LOCKED
    elif vehicle.isInBattle:
        state = VehicleStates.INBATTLE
    elif vehicle.isInUnit:
        state = VehicleStates.INPLATOON
    return state