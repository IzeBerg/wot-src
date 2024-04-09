from enum import IntEnum
from pve_battle_hud import WidgetType

class BaseWidgetSettingsModel(object):
    __slots__ = ('id', 'type', 'state')

    def __init__(self, id, type, state):
        super(BaseWidgetSettingsModel, self).__init__()
        self.id = id
        self.type = WidgetType(type)
        self.state = state

    def setState(self, state):
        self.state = state