from gui.impl.gen_utils import DynAccessor

class DynamicIds(DynAccessor):
    __slots__ = ()

    class _dialog_window(DynAccessor):
        __slots__ = ()
        bottom_content = DynAccessor(88899)
        balance_content = DynAccessor(88900)

    dialog_window = _dialog_window()

    class _tooltip(DynAccessor):
        __slots__ = ()
        normal_content = DynAccessor(88901)
        advanced_content = DynAccessor(88902)

    tooltip = _tooltip()

    class _blueprint_screen(DynAccessor):
        __slots__ = ()
        balance_content = DynAccessor(88903)

    blueprint_screen = _blueprint_screen()

    class _demo_window(DynAccessor):
        __slots__ = ()
        image_props = DynAccessor(88904)
        bottom_panel = DynAccessor(88905)

    demo_window = _demo_window()