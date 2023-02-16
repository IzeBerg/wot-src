from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(71150)
    _bootcampLesson2 = DynAccessor(71151)
    _bootcampLesson3_1 = DynAccessor(71152)
    _bootcampLesson3_2 = DynAccessor(71153)
    _bootcampLesson4 = DynAccessor(71154)
    _bootcampOutro = DynAccessor(71155)
    _login = DynAccessor(71156)
    _tutorialInitial = DynAccessor(71157)
    _tutorialInitialLoop = DynAccessor(71158)

    class _battle_pass(DynAccessor):
        __slots__ = ()
        final_video = DynAccessor(71159)

    battle_pass = _battle_pass()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(71160)
        example_2 = DynAccessor(71161)

    development = _development()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(71162)

    platoon = _platoon()

    class _startup(DynAccessor):
        __slots__ = ()
        ESRB = DynAccessor(71163)

    startup = _startup()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(71164)

    vehicle = _vehicle()