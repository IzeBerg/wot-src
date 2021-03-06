from gui.impl.gen_utils import DynAccessor

class DynamicIds(DynAccessor):
    __slots__ = ()

    class _dialog_window(DynAccessor):
        __slots__ = ()
        bottom_content = DynAccessor(66106)
        balance_content = DynAccessor(66107)

    dialog_window = _dialog_window()

    class _tooltip(DynAccessor):
        __slots__ = ()
        normal_content = DynAccessor(66108)
        advanced_content = DynAccessor(66109)

    tooltip = _tooltip()

    class _blueprint_screen(DynAccessor):
        __slots__ = ()
        balance_content = DynAccessor(66110)

    blueprint_screen = _blueprint_screen()

    class _crew_books_buy_dialog(DynAccessor):
        __slots__ = ()
        balance_content = DynAccessor(66111)

    crew_books_buy_dialog = _crew_books_buy_dialog()

    class _prem_dashboard(DynAccessor):
        __slots__ = ()
        header = DynAccessor(66112)
        premium_card = DynAccessor(66113)
        double_xp_card = DynAccessor(66114)
        piggy_bank_card = DynAccessor(66115)
        dog_tags_card = DynAccessor(66116)
        premium_quests_card = DynAccessor(66117)
        maps_black_list_card = DynAccessor(66118)

    prem_dashboard = _prem_dashboard()

    class _demo_window(DynAccessor):
        __slots__ = ()
        image_props = DynAccessor(66119)
        bottom_panel = DynAccessor(66120)

    demo_window = _demo_window()