import BigWorld, Event

class ArenaInfoScoreSystemComponent(BigWorld.DynamicScriptComponent):

    def __init__(self, *args):
        self.onArenaScoreUpdated = Event.Event()

    def set_totalScore(self, *args, **kwargs):
        self.onArenaScoreUpdated(self.totalScore)