from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(70865)
    _bootcampLesson2 = DynAccessor(70866)
    _bootcampLesson3_1 = DynAccessor(70867)
    _bootcampLesson3_2 = DynAccessor(70868)
    _bootcampLesson4 = DynAccessor(70869)
    _bootcampOutro = DynAccessor(70870)
    _login = DynAccessor(70871)
    _tutorialInitial = DynAccessor(70872)
    _tutorialInitialLoop = DynAccessor(70873)

    class _battle_pass(DynAccessor):
        __slots__ = ()
        final_video = DynAccessor(70874)

    battle_pass = _battle_pass()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(70875)
        example_2 = DynAccessor(70876)

    development = _development()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(70877)

    platoon = _platoon()

    class _startup(DynAccessor):
        __slots__ = ()
        ESRB = DynAccessor(70878)
        Logo_All = DynAccessor(70879)

    startup = _startup()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(70880)

    vehicle = _vehicle()