from gui.impl.gen_utils import DynAccessor

class DynamicIds(DynAccessor):
    __slots__ = ()

    class _dialog_window(DynAccessor):
        __slots__ = ()
        bottom_content = DynAccessor(65502)
        balance_content = DynAccessor(65503)

    dialog_window = _dialog_window()

    class _tooltip(DynAccessor):
        __slots__ = ()
        normal_content = DynAccessor(65504)
        advanced_content = DynAccessor(65505)

    tooltip = _tooltip()

    class _blueprint_screen(DynAccessor):
        __slots__ = ()
        balance_content = DynAccessor(65506)

    blueprint_screen = _blueprint_screen()

    class _crew_books_buy_dialog(DynAccessor):
        __slots__ = ()
        balance_content = DynAccessor(65507)

    crew_books_buy_dialog = _crew_books_buy_dialog()

    class _prem_dashboard(DynAccessor):
        __slots__ = ()
        header = DynAccessor(65508)
        premium_card = DynAccessor(65509)
        double_xp_card = DynAccessor(65510)
        piggy_bank_card = DynAccessor(65511)
        dog_tags_card = DynAccessor(65512)
        premium_quests_card = DynAccessor(65513)
        maps_black_list_card = DynAccessor(65514)

    prem_dashboard = _prem_dashboard()

    class _demo_window(DynAccessor):
        __slots__ = ()
        image_props = DynAccessor(65515)
        bottom_panel = DynAccessor(65516)

    demo_window = _demo_window()