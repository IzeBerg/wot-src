from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(70889)
    _bootcampLesson2 = DynAccessor(70890)
    _bootcampLesson3_1 = DynAccessor(70891)
    _bootcampLesson3_2 = DynAccessor(70892)
    _bootcampLesson4 = DynAccessor(70893)
    _bootcampOutro = DynAccessor(70894)
    _login = DynAccessor(70895)
    _tutorialInitial = DynAccessor(70896)
    _tutorialInitialLoop = DynAccessor(70897)

    class _battle_pass(DynAccessor):
        __slots__ = ()
        c_180812_2 = DynAccessor(70898)
        c_180812_3 = DynAccessor(70899)
        c_180812_4 = DynAccessor(70900)
        c_192332_2 = DynAccessor(70901)
        c_192332_3 = DynAccessor(70902)
        c_192332_4 = DynAccessor(70903)
        c_192588_2 = DynAccessor(70904)
        c_192588_3 = DynAccessor(70905)
        c_192588_4 = DynAccessor(70906)

    battle_pass = _battle_pass()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(70907)
        example_2 = DynAccessor(70908)

    development = _development()

    class _event_loot_boxes(DynAccessor):
        __slots__ = ()
        lootbox_prem = DynAccessor(70909)

    event_loot_boxes = _event_loot_boxes()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(70910)

    platoon = _platoon()

    class _startup(DynAccessor):
        __slots__ = ()
        ESRB = DynAccessor(70911)
        Logo_All = DynAccessor(70912)

    startup = _startup()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(70913)

    vehicle = _vehicle()