from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(70816)
    _bootcampLesson2 = DynAccessor(70817)
    _bootcampLesson3_1 = DynAccessor(70818)
    _bootcampLesson3_2 = DynAccessor(70819)
    _bootcampLesson4 = DynAccessor(70820)
    _bootcampOutro = DynAccessor(70821)
    _login = DynAccessor(70822)
    _tutorialInitial = DynAccessor(70823)
    _tutorialInitialLoop = DynAccessor(70824)

    class _battle_pass(DynAccessor):
        __slots__ = ()
        final_video = DynAccessor(70825)

    battle_pass = _battle_pass()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(70826)
        example_2 = DynAccessor(70827)

    development = _development()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(70828)

    platoon = _platoon()

    class _startup(DynAccessor):
        __slots__ = ()
        ESRB = DynAccessor(70829)
        Logo_All = DynAccessor(70830)

    startup = _startup()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(70831)

    vehicle = _vehicle()