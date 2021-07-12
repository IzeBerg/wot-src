from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(57084)
    _bootcampLesson2 = DynAccessor(57085)
    _bootcampLesson3_1 = DynAccessor(57086)
    _bootcampLesson3_2 = DynAccessor(57087)
    _bootcampLesson4 = DynAccessor(57088)
    _bootcampOutro = DynAccessor(57089)
    _login = DynAccessor(57090)
    _tutorialInitial = DynAccessor(57091)
    _tutorialInitialLoop = DynAccessor(57092)

    class _battle_pass(DynAccessor):
        __slots__ = ()
        c_128588_2 = DynAccessor(57093)
        c_128588_3 = DynAccessor(57094)
        c_128588_4 = DynAccessor(57095)
        c_67148_2 = DynAccessor(57096)
        c_67148_3 = DynAccessor(57097)
        c_67148_4 = DynAccessor(57098)
        c_67404_2 = DynAccessor(57099)
        c_67404_3 = DynAccessor(57100)
        c_67404_4 = DynAccessor(57101)

    battle_pass = _battle_pass()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(57102)
        example_2 = DynAccessor(57103)

    development = _development()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(57104)

    platoon = _platoon()

    class _startup(DynAccessor):
        __slots__ = ()
        ESRB = DynAccessor(57105)
        Logo_All = DynAccessor(57106)

    startup = _startup()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(57107)

    vehicle = _vehicle()