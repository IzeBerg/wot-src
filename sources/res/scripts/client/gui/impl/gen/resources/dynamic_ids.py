from gui.impl.gen_utils import DynAccessor

class DynamicIds(DynAccessor):
    __slots__ = ()

    class _dialog_window(DynAccessor):
        __slots__ = ()
        bottom_content = DynAccessor(61601)
        balance_content = DynAccessor(61602)

    dialog_window = _dialog_window()

    class _tooltip(DynAccessor):
        __slots__ = ()
        normal_content = DynAccessor(61603)
        advanced_content = DynAccessor(61604)

    tooltip = _tooltip()

    class _blueprint_screen(DynAccessor):
        __slots__ = ()
        balance_content = DynAccessor(61605)

    blueprint_screen = _blueprint_screen()

    class _crew_books_buy_dialog(DynAccessor):
        __slots__ = ()
        balance_content = DynAccessor(61606)

    crew_books_buy_dialog = _crew_books_buy_dialog()

    class _prem_dashboard(DynAccessor):
        __slots__ = ()
        header = DynAccessor(61607)
        premium_card = DynAccessor(61608)
        double_xp_card = DynAccessor(61609)
        piggy_bank_card = DynAccessor(61610)
        dog_tags_card = DynAccessor(61611)
        premium_quests_card = DynAccessor(61612)
        maps_black_list_card = DynAccessor(61613)

    prem_dashboard = _prem_dashboard()

    class _demo_window(DynAccessor):
        __slots__ = ()
        image_props = DynAccessor(61614)
        bottom_panel = DynAccessor(61615)

    demo_window = _demo_window()