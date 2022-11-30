from gui.impl.gen_utils import DynAccessor

class DynamicIds(DynAccessor):
    __slots__ = ()

    class _dialog_window(DynAccessor):
        __slots__ = ()
        bottom_content = DynAccessor(74276)
        balance_content = DynAccessor(74277)

    dialog_window = _dialog_window()

    class _tooltip(DynAccessor):
        __slots__ = ()
        normal_content = DynAccessor(74278)
        advanced_content = DynAccessor(74279)

    tooltip = _tooltip()

    class _blueprint_screen(DynAccessor):
        __slots__ = ()
        balance_content = DynAccessor(74280)

    blueprint_screen = _blueprint_screen()

    class _crew_books_buy_dialog(DynAccessor):
        __slots__ = ()
        balance_content = DynAccessor(74281)

    crew_books_buy_dialog = _crew_books_buy_dialog()

    class _demo_window(DynAccessor):
        __slots__ = ()
        image_props = DynAccessor(74282)
        bottom_panel = DynAccessor(74283)

    demo_window = _demo_window()