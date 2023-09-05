import typing
from gui.shared.events import HasCtxEvent
if typing.TYPE_CHECKING:
    from animated_hints.constants import EventAction

class HintActionEvent(HasCtxEvent):
    EVENT_TYPE = 'animated_hint_action_event'

    def __init__(self, action, ctx=None):
        super(HintActionEvent, self).__init__(eventType=self.EVENT_TYPE, ctx=ctx)
        self.action = action