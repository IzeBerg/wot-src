from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(70986)
    _bootcampLesson2 = DynAccessor(70987)
    _bootcampLesson3_1 = DynAccessor(70988)
    _bootcampLesson3_2 = DynAccessor(70989)
    _bootcampLesson4 = DynAccessor(70990)
    _bootcampOutro = DynAccessor(70991)
    _login = DynAccessor(70992)
    _tutorialInitial = DynAccessor(70993)
    _tutorialInitialLoop = DynAccessor(70994)

    class _battle_pass(DynAccessor):
        __slots__ = ()
        c_180812_2 = DynAccessor(70995)
        c_180812_3 = DynAccessor(70996)
        c_180812_4 = DynAccessor(70997)
        c_192332_2 = DynAccessor(70998)
        c_192332_3 = DynAccessor(70999)
        c_192332_4 = DynAccessor(71000)
        c_192588_2 = DynAccessor(71001)
        c_192588_3 = DynAccessor(71002)
        c_192588_4 = DynAccessor(71003)

    battle_pass = _battle_pass()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(71004)
        example_2 = DynAccessor(71005)

    development = _development()

    class _event_loot_boxes(DynAccessor):
        __slots__ = ()
        lootbox_prem = DynAccessor(71006)

    event_loot_boxes = _event_loot_boxes()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(71007)

    platoon = _platoon()

    class _startup(DynAccessor):
        __slots__ = ()
        ESRB = DynAccessor(71008)
        Logo_All = DynAccessor(71009)

    startup = _startup()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(71010)

    vehicle = _vehicle()