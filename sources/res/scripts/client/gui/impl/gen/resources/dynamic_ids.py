from gui.impl.gen_utils import DynAccessor

class DynamicIds(DynAccessor):
    __slots__ = ()

    class _dialog_window(DynAccessor):
        __slots__ = ()
        bottom_content = DynAccessor(73098)
        balance_content = DynAccessor(73099)

    dialog_window = _dialog_window()

    class _tooltip(DynAccessor):
        __slots__ = ()
        normal_content = DynAccessor(73100)
        advanced_content = DynAccessor(73101)

    tooltip = _tooltip()

    class _blueprint_screen(DynAccessor):
        __slots__ = ()
        balance_content = DynAccessor(73102)

    blueprint_screen = _blueprint_screen()

    class _crew_books_buy_dialog(DynAccessor):
        __slots__ = ()
        balance_content = DynAccessor(73103)

    crew_books_buy_dialog = _crew_books_buy_dialog()

    class _prem_dashboard(DynAccessor):
        __slots__ = ()
        header = DynAccessor(73104)
        premium_card = DynAccessor(73105)
        double_xp_card = DynAccessor(73106)
        piggy_bank_card = DynAccessor(73107)
        dog_tags_card = DynAccessor(73108)
        premium_quests_card = DynAccessor(73109)
        maps_black_list_card = DynAccessor(73110)

    prem_dashboard = _prem_dashboard()

    class _demo_window(DynAccessor):
        __slots__ = ()
        image_props = DynAccessor(73111)
        bottom_panel = DynAccessor(73112)

    demo_window = _demo_window()