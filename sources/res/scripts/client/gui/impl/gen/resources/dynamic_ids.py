from gui.impl.gen_utils import DynAccessor

class DynamicIds(DynAccessor):
    __slots__ = ()

    class _dialog_window(DynAccessor):
        __slots__ = ()
        bottom_content = DynAccessor(94129)
        balance_content = DynAccessor(94130)

    dialog_window = _dialog_window()

    class _tooltip(DynAccessor):
        __slots__ = ()
        normal_content = DynAccessor(94131)
        advanced_content = DynAccessor(94132)

    tooltip = _tooltip()

    class _blueprint_screen(DynAccessor):
        __slots__ = ()
        balance_content = DynAccessor(94133)

    blueprint_screen = _blueprint_screen()

    class _demo_window(DynAccessor):
        __slots__ = ()
        image_props = DynAccessor(94134)
        bottom_panel = DynAccessor(94135)

    demo_window = _demo_window()