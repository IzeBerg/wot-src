from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(66082)
    _bootcampLesson2 = DynAccessor(66083)
    _bootcampLesson3_1 = DynAccessor(66084)
    _bootcampLesson3_2 = DynAccessor(66085)
    _bootcampLesson4 = DynAccessor(66086)
    _bootcampOutro = DynAccessor(66087)
    _login = DynAccessor(66088)
    _tutorialInitial = DynAccessor(66089)
    _tutorialInitialLoop = DynAccessor(66090)

    class _battle_pass(DynAccessor):
        __slots__ = ()
        c_157260_2 = DynAccessor(66091)
        c_157260_3 = DynAccessor(66092)
        c_157260_4 = DynAccessor(66093)
        c_157516_2 = DynAccessor(66094)
        c_157516_3 = DynAccessor(66095)
        c_157516_4 = DynAccessor(66096)
        c_157772_2 = DynAccessor(66097)
        c_157772_3 = DynAccessor(66098)
        c_157772_4 = DynAccessor(66099)

    battle_pass = _battle_pass()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(66100)
        example_2 = DynAccessor(66101)

    development = _development()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(66102)

    platoon = _platoon()

    class _startup(DynAccessor):
        __slots__ = ()
        ESRB = DynAccessor(66103)
        Logo_All = DynAccessor(66104)

    startup = _startup()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(66105)

    vehicle = _vehicle()