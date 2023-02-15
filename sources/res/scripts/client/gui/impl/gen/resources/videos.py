from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(70934)
    _bootcampLesson2 = DynAccessor(70935)
    _bootcampLesson3_1 = DynAccessor(70936)
    _bootcampLesson3_2 = DynAccessor(70937)
    _bootcampLesson4 = DynAccessor(70938)
    _bootcampOutro = DynAccessor(70939)
    _login = DynAccessor(70940)
    _tutorialInitial = DynAccessor(70941)
    _tutorialInitialLoop = DynAccessor(70942)

    class _battle_pass(DynAccessor):
        __slots__ = ()
        c_180812_2 = DynAccessor(70943)
        c_180812_3 = DynAccessor(70944)
        c_180812_4 = DynAccessor(70945)
        c_192332_2 = DynAccessor(70946)
        c_192332_3 = DynAccessor(70947)
        c_192332_4 = DynAccessor(70948)
        c_192588_2 = DynAccessor(70949)
        c_192588_3 = DynAccessor(70950)
        c_192588_4 = DynAccessor(70951)

    battle_pass = _battle_pass()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(70952)
        example_2 = DynAccessor(70953)

    development = _development()

    class _event_loot_boxes(DynAccessor):
        __slots__ = ()
        lootbox_prem = DynAccessor(70954)

    event_loot_boxes = _event_loot_boxes()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(70955)

    platoon = _platoon()

    class _startup(DynAccessor):
        __slots__ = ()
        ESRB = DynAccessor(70956)
        Logo_All = DynAccessor(70957)

    startup = _startup()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(70958)

    vehicle = _vehicle()