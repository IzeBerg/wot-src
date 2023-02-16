from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(71256)
    _bootcampLesson2 = DynAccessor(71257)
    _bootcampLesson3_1 = DynAccessor(71258)
    _bootcampLesson3_2 = DynAccessor(71259)
    _bootcampLesson4 = DynAccessor(71260)
    _bootcampOutro = DynAccessor(71261)
    _login = DynAccessor(71262)
    _tutorialInitial = DynAccessor(71263)
    _tutorialInitialLoop = DynAccessor(71264)

    class _battle_pass(DynAccessor):
        __slots__ = ()
        c_180812_2 = DynAccessor(71265)
        c_180812_3 = DynAccessor(71266)
        c_180812_4 = DynAccessor(71267)
        c_192332_2 = DynAccessor(71268)
        c_192332_3 = DynAccessor(71269)
        c_192332_4 = DynAccessor(71270)
        c_192588_2 = DynAccessor(71271)
        c_192588_3 = DynAccessor(71272)
        c_192588_4 = DynAccessor(71273)

    battle_pass = _battle_pass()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(71274)
        example_2 = DynAccessor(71275)

    development = _development()

    class _event_loot_boxes(DynAccessor):
        __slots__ = ()
        lootbox_prem = DynAccessor(71276)

    event_loot_boxes = _event_loot_boxes()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(71277)

    platoon = _platoon()

    class _startup(DynAccessor):
        __slots__ = ()
        ESRB = DynAccessor(71278)

    startup = _startup()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(71279)

    vehicle = _vehicle()