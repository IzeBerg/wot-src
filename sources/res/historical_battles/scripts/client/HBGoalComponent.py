import logging, BigWorld, Event
log = logging.getLogger(__name__)

class HBGoalComponent(BigWorld.DynamicScriptComponent):
    onGoalsUpdated = Event.Event()

    def __init__(self):
        self.onGoalsUpdated(self.goalsInfo)

    def set_goalsInfo(self, prev):
        self.onGoalsUpdated(self.goalsInfo)