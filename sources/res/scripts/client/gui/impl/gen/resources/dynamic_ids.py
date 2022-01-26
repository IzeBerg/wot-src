from gui.impl.gen_utils import DynAccessor

class DynamicIds(DynAccessor):
    __slots__ = ()

    class _dialog_window(DynAccessor):
        __slots__ = ()
        bottom_content = DynAccessor(73019)
        balance_content = DynAccessor(73020)

    dialog_window = _dialog_window()

    class _tooltip(DynAccessor):
        __slots__ = ()
        normal_content = DynAccessor(73021)
        advanced_content = DynAccessor(73022)

    tooltip = _tooltip()

    class _blueprint_screen(DynAccessor):
        __slots__ = ()
        balance_content = DynAccessor(73023)

    blueprint_screen = _blueprint_screen()

    class _crew_books_buy_dialog(DynAccessor):
        __slots__ = ()
        balance_content = DynAccessor(73024)

    crew_books_buy_dialog = _crew_books_buy_dialog()

    class _prem_dashboard(DynAccessor):
        __slots__ = ()
        header = DynAccessor(73025)
        premium_card = DynAccessor(73026)
        double_xp_card = DynAccessor(73027)
        piggy_bank_card = DynAccessor(73028)
        dog_tags_card = DynAccessor(73029)
        premium_quests_card = DynAccessor(73030)
        maps_black_list_card = DynAccessor(73031)

    prem_dashboard = _prem_dashboard()

    class _demo_window(DynAccessor):
        __slots__ = ()
        image_props = DynAccessor(73032)
        bottom_panel = DynAccessor(73033)

    demo_window = _demo_window()