from gui.impl.gen_utils import DynAccessor

class DynamicIds(DynAccessor):
    __slots__ = ()

    class _dialog_window(DynAccessor):
        __slots__ = ()
        bottom_content = DynAccessor(62795)
        balance_content = DynAccessor(62796)

    dialog_window = _dialog_window()

    class _tooltip(DynAccessor):
        __slots__ = ()
        normal_content = DynAccessor(62797)
        advanced_content = DynAccessor(62798)

    tooltip = _tooltip()

    class _blueprint_screen(DynAccessor):
        __slots__ = ()
        balance_content = DynAccessor(62799)

    blueprint_screen = _blueprint_screen()

    class _crew_books_buy_dialog(DynAccessor):
        __slots__ = ()
        balance_content = DynAccessor(62800)

    crew_books_buy_dialog = _crew_books_buy_dialog()

    class _prem_dashboard(DynAccessor):
        __slots__ = ()
        header = DynAccessor(62801)
        premium_card = DynAccessor(62802)
        double_xp_card = DynAccessor(62803)
        piggy_bank_card = DynAccessor(62804)
        dog_tags_card = DynAccessor(62805)
        premium_quests_card = DynAccessor(62806)
        maps_black_list_card = DynAccessor(62807)

    prem_dashboard = _prem_dashboard()

    class _demo_window(DynAccessor):
        __slots__ = ()
        image_props = DynAccessor(62808)
        bottom_panel = DynAccessor(62809)

    demo_window = _demo_window()