from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(71017)
    _bootcampLesson2 = DynAccessor(71018)
    _bootcampLesson3_1 = DynAccessor(71019)
    _bootcampLesson3_2 = DynAccessor(71020)
    _bootcampLesson4 = DynAccessor(71021)
    _bootcampOutro = DynAccessor(71022)
    _login = DynAccessor(71023)
    _tutorialInitial = DynAccessor(71024)
    _tutorialInitialLoop = DynAccessor(71025)

    class _battle_pass(DynAccessor):
        __slots__ = ()
        c_180812_2 = DynAccessor(71026)
        c_180812_3 = DynAccessor(71027)
        c_180812_4 = DynAccessor(71028)
        c_192332_2 = DynAccessor(71029)
        c_192332_3 = DynAccessor(71030)
        c_192332_4 = DynAccessor(71031)
        c_192588_2 = DynAccessor(71032)
        c_192588_3 = DynAccessor(71033)
        c_192588_4 = DynAccessor(71034)

    battle_pass = _battle_pass()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(71035)
        example_2 = DynAccessor(71036)

    development = _development()

    class _event_loot_boxes(DynAccessor):
        __slots__ = ()
        lootbox_prem = DynAccessor(71037)

    event_loot_boxes = _event_loot_boxes()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(71038)

    platoon = _platoon()

    class _startup(DynAccessor):
        __slots__ = ()
        ESRB = DynAccessor(71039)
        Logo_All = DynAccessor(71040)

    startup = _startup()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(71041)

    vehicle = _vehicle()