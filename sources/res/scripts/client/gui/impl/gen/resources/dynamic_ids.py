from gui.impl.gen_utils import DynAccessor

class DynamicIds(DynAccessor):
    __slots__ = ()

    class _dialog_window(DynAccessor):
        __slots__ = ()
        bottom_content = DynAccessor(64283)
        balance_content = DynAccessor(64284)

    dialog_window = _dialog_window()

    class _tooltip(DynAccessor):
        __slots__ = ()
        normal_content = DynAccessor(64285)
        advanced_content = DynAccessor(64286)

    tooltip = _tooltip()

    class _blueprint_screen(DynAccessor):
        __slots__ = ()
        balance_content = DynAccessor(64287)

    blueprint_screen = _blueprint_screen()

    class _crew_books_buy_dialog(DynAccessor):
        __slots__ = ()
        balance_content = DynAccessor(64288)

    crew_books_buy_dialog = _crew_books_buy_dialog()

    class _prem_dashboard(DynAccessor):
        __slots__ = ()
        header = DynAccessor(64289)
        premium_card = DynAccessor(64290)
        double_xp_card = DynAccessor(64291)
        piggy_bank_card = DynAccessor(64292)
        dog_tags_card = DynAccessor(64293)
        premium_quests_card = DynAccessor(64294)
        maps_black_list_card = DynAccessor(64295)

    prem_dashboard = _prem_dashboard()

    class _demo_window(DynAccessor):
        __slots__ = ()
        image_props = DynAccessor(64296)
        bottom_panel = DynAccessor(64297)

    demo_window = _demo_window()