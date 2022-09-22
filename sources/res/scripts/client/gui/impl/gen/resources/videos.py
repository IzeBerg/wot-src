from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(69047)
    _bootcampLesson2 = DynAccessor(69048)
    _bootcampLesson3_1 = DynAccessor(69049)
    _bootcampLesson3_2 = DynAccessor(69050)
    _bootcampLesson4 = DynAccessor(69051)
    _bootcampOutro = DynAccessor(69052)
    _login = DynAccessor(69053)
    _tutorialInitial = DynAccessor(69054)
    _tutorialInitialLoop = DynAccessor(69055)

    class _battle_pass(DynAccessor):
        __slots__ = ()
        c_170060_2 = DynAccessor(69056)
        c_170060_3 = DynAccessor(69057)
        c_170060_4 = DynAccessor(69058)
        c_170316_2 = DynAccessor(69059)
        c_170316_3 = DynAccessor(69060)
        c_170316_4 = DynAccessor(69061)
        c_172364_2 = DynAccessor(69062)
        c_172364_3 = DynAccessor(69063)
        c_172364_4 = DynAccessor(69064)

    battle_pass = _battle_pass()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(69065)
        example_2 = DynAccessor(69066)

    development = _development()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(69067)

    platoon = _platoon()

    class _startup(DynAccessor):
        __slots__ = ()
        ESRB = DynAccessor(69068)
        Logo_All = DynAccessor(69069)

    startup = _startup()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(69070)

    vehicle = _vehicle()