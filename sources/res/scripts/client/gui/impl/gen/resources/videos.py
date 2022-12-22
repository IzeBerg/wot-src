from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(70554)
    _bootcampLesson2 = DynAccessor(70555)
    _bootcampLesson3_1 = DynAccessor(70556)
    _bootcampLesson3_2 = DynAccessor(70557)
    _bootcampLesson4 = DynAccessor(70558)
    _bootcampOutro = DynAccessor(70559)
    _login = DynAccessor(70560)
    _tutorialInitial = DynAccessor(70561)
    _tutorialInitialLoop = DynAccessor(70562)

    class _battle_pass(DynAccessor):
        __slots__ = ()
        c_170060_2 = DynAccessor(70563)
        c_170060_3 = DynAccessor(70564)
        c_170060_4 = DynAccessor(70565)
        c_170316_2 = DynAccessor(70566)
        c_170316_3 = DynAccessor(70567)
        c_170316_4 = DynAccessor(70568)
        c_172364_2 = DynAccessor(70569)
        c_172364_3 = DynAccessor(70570)
        c_172364_4 = DynAccessor(70571)

    battle_pass = _battle_pass()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(70572)
        example_2 = DynAccessor(70573)

    development = _development()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(70574)

    platoon = _platoon()

    class _startup(DynAccessor):
        __slots__ = ()
        ESRB = DynAccessor(70575)
        Logo_All = DynAccessor(70576)

    startup = _startup()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(70577)

    vehicle = _vehicle()