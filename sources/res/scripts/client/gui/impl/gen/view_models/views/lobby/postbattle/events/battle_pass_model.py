from gui.impl.gen.view_models.views.lobby.postbattle.events.base_event_model import BaseEventModel

class BattlePassModel(BaseEventModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=1):
        super(BattlePassModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(BattlePassModel, self)._initialize()