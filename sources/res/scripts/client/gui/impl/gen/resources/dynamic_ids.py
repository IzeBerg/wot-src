from gui.impl.gen_utils import DynAccessor

class DynamicIds(DynAccessor):
    __slots__ = ()

    class _dialog_window(DynAccessor):
        __slots__ = ()
        bottom_content = DynAccessor(61644)
        balance_content = DynAccessor(61645)

    dialog_window = _dialog_window()

    class _tooltip(DynAccessor):
        __slots__ = ()
        normal_content = DynAccessor(61646)
        advanced_content = DynAccessor(61647)

    tooltip = _tooltip()

    class _blueprint_screen(DynAccessor):
        __slots__ = ()
        balance_content = DynAccessor(61648)

    blueprint_screen = _blueprint_screen()

    class _crew_books_buy_dialog(DynAccessor):
        __slots__ = ()
        balance_content = DynAccessor(61649)

    crew_books_buy_dialog = _crew_books_buy_dialog()

    class _prem_dashboard(DynAccessor):
        __slots__ = ()
        header = DynAccessor(61650)
        premium_card = DynAccessor(61651)
        double_xp_card = DynAccessor(61652)
        piggy_bank_card = DynAccessor(61653)
        dog_tags_card = DynAccessor(61654)
        premium_quests_card = DynAccessor(61655)
        maps_black_list_card = DynAccessor(61656)

    prem_dashboard = _prem_dashboard()

    class _demo_window(DynAccessor):
        __slots__ = ()
        image_props = DynAccessor(61657)
        bottom_panel = DynAccessor(61658)

    demo_window = _demo_window()