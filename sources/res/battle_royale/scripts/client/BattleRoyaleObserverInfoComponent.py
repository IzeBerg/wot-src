import BigWorld, Event

class BattleRoyaleObserverInfoComponent(BigWorld.DynamicScriptComponent):
    onTeamsMayRespawnChanged = Event.Event()

    def set_teamsMayRespawn(self, prev):
        self.onTeamsMayRespawnChanged(self.teamsMayRespawn)