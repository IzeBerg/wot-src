from gui.shared.events import HasCtxEvent

class BuffGUIEvent(HasCtxEvent):
    ON_APPLY = 'hw22buff_onApply'
    ON_UNAPPLY = 'hw22buff_onUnapply'
    ON_GLOBAL_APPLY = 'hw22buff_onGlobalApply'
    ON_GLOBAL_UNAPPLY = 'hw22buff_onGlobalUnapply'