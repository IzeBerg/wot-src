import typing
if typing.TYPE_CHECKING:
    from gui.battle_results.reusable import _ReusableInfo
    from gui.impl.gen.view_models.views.lobby.postbattle.events.base_event_model import BaseEventModel

def getQuestsEvents(tooltipData, reusable, result):
    return ()