from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(70910)
    _bootcampLesson2 = DynAccessor(70911)
    _bootcampLesson3_1 = DynAccessor(70912)
    _bootcampLesson3_2 = DynAccessor(70913)
    _bootcampLesson4 = DynAccessor(70914)
    _bootcampOutro = DynAccessor(70915)
    _login = DynAccessor(70916)
    _tutorialInitial = DynAccessor(70917)
    _tutorialInitialLoop = DynAccessor(70918)

    class _battle_pass(DynAccessor):
        __slots__ = ()
        final_video = DynAccessor(70919)

    battle_pass = _battle_pass()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(70920)
        example_2 = DynAccessor(70921)

    development = _development()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(70922)

    platoon = _platoon()

    class _startup(DynAccessor):
        __slots__ = ()
        ESRB = DynAccessor(70923)
        Logo_All = DynAccessor(70924)

    startup = _startup()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(70925)

    vehicle = _vehicle()