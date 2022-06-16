from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(65478)
    _bootcampLesson2 = DynAccessor(65479)
    _bootcampLesson3_1 = DynAccessor(65480)
    _bootcampLesson3_2 = DynAccessor(65481)
    _bootcampLesson4 = DynAccessor(65482)
    _bootcampOutro = DynAccessor(65483)
    _login = DynAccessor(65484)
    _tutorialInitial = DynAccessor(65485)
    _tutorialInitialLoop = DynAccessor(65486)

    class _battle_pass(DynAccessor):
        __slots__ = ()
        c_157260_2 = DynAccessor(65487)
        c_157260_3 = DynAccessor(65488)
        c_157260_4 = DynAccessor(65489)
        c_157516_2 = DynAccessor(65490)
        c_157516_3 = DynAccessor(65491)
        c_157516_4 = DynAccessor(65492)
        c_157772_2 = DynAccessor(65493)
        c_157772_3 = DynAccessor(65494)
        c_157772_4 = DynAccessor(65495)

    battle_pass = _battle_pass()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(65496)
        example_2 = DynAccessor(65497)

    development = _development()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(65498)

    platoon = _platoon()

    class _startup(DynAccessor):
        __slots__ = ()
        ESRB = DynAccessor(65499)
        Logo_All = DynAccessor(65500)

    startup = _startup()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(65501)

    vehicle = _vehicle()