from gui.impl.gen_utils import DynAccessor

class DynamicIds(DynAccessor):
    __slots__ = ()

    class _dialog_window(DynAccessor):
        __slots__ = ()
        bottom_content = DynAccessor(66355)
        balance_content = DynAccessor(66356)

    dialog_window = _dialog_window()

    class _tooltip(DynAccessor):
        __slots__ = ()
        normal_content = DynAccessor(66357)
        advanced_content = DynAccessor(66358)

    tooltip = _tooltip()

    class _blueprint_screen(DynAccessor):
        __slots__ = ()
        balance_content = DynAccessor(66359)

    blueprint_screen = _blueprint_screen()

    class _crew_books_buy_dialog(DynAccessor):
        __slots__ = ()
        balance_content = DynAccessor(66360)

    crew_books_buy_dialog = _crew_books_buy_dialog()

    class _prem_dashboard(DynAccessor):
        __slots__ = ()
        header = DynAccessor(66361)
        premium_card = DynAccessor(66362)
        double_xp_card = DynAccessor(66363)
        piggy_bank_card = DynAccessor(66364)
        dog_tags_card = DynAccessor(66365)
        premium_quests_card = DynAccessor(66366)
        maps_black_list_card = DynAccessor(66367)

    prem_dashboard = _prem_dashboard()

    class _demo_window(DynAccessor):
        __slots__ = ()
        image_props = DynAccessor(66368)
        bottom_panel = DynAccessor(66369)

    demo_window = _demo_window()