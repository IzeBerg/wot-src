from gui.impl.gen_utils import DynAccessor

class DynamicIds(DynAccessor):
    __slots__ = ()

    class _dialog_window(DynAccessor):
        __slots__ = ()
        bottom_content = DynAccessor(60782)
        balance_content = DynAccessor(60783)

    dialog_window = _dialog_window()

    class _tooltip(DynAccessor):
        __slots__ = ()
        normal_content = DynAccessor(60784)
        advanced_content = DynAccessor(60785)

    tooltip = _tooltip()

    class _blueprint_screen(DynAccessor):
        __slots__ = ()
        balance_content = DynAccessor(60786)

    blueprint_screen = _blueprint_screen()

    class _crew_books_buy_dialog(DynAccessor):
        __slots__ = ()
        balance_content = DynAccessor(60787)

    crew_books_buy_dialog = _crew_books_buy_dialog()

    class _prem_dashboard(DynAccessor):
        __slots__ = ()
        header = DynAccessor(60788)
        premium_card = DynAccessor(60789)
        double_xp_card = DynAccessor(60790)
        piggy_bank_card = DynAccessor(60791)
        dog_tags_card = DynAccessor(60792)
        premium_quests_card = DynAccessor(60793)
        maps_black_list_card = DynAccessor(60794)

    prem_dashboard = _prem_dashboard()

    class _demo_window(DynAccessor):
        __slots__ = ()
        image_props = DynAccessor(60795)
        bottom_panel = DynAccessor(60796)

    demo_window = _demo_window()