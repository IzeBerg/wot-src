import BigWorld, Event

class ArenaInfoScoreSystemComponent(BigWorld.DynamicScriptComponent):

    def __init__(self, *args):
        self.onArenaScoreUpdated = Event.Event()
        self.onVictimToKillerInfoUpdated = Event.Event()

    def set_totalScore(self, *args, **kwargs):
        self.onArenaScoreUpdated(self.totalScore)

    def set_victimToKiller(self, *args, **kwargs):
        self.onVictimToKillerInfoUpdated(self.victimToKiller)