from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(66331)
    _bootcampLesson2 = DynAccessor(66332)
    _bootcampLesson3_1 = DynAccessor(66333)
    _bootcampLesson3_2 = DynAccessor(66334)
    _bootcampLesson4 = DynAccessor(66335)
    _bootcampOutro = DynAccessor(66336)
    _login = DynAccessor(66337)
    _tutorialInitial = DynAccessor(66338)
    _tutorialInitialLoop = DynAccessor(66339)

    class _battle_pass(DynAccessor):
        __slots__ = ()
        c_157260_2 = DynAccessor(66340)
        c_157260_3 = DynAccessor(66341)
        c_157260_4 = DynAccessor(66342)
        c_157516_2 = DynAccessor(66343)
        c_157516_3 = DynAccessor(66344)
        c_157516_4 = DynAccessor(66345)
        c_157772_2 = DynAccessor(66346)
        c_157772_3 = DynAccessor(66347)
        c_157772_4 = DynAccessor(66348)

    battle_pass = _battle_pass()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(66349)
        example_2 = DynAccessor(66350)

    development = _development()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(66351)

    platoon = _platoon()

    class _startup(DynAccessor):
        __slots__ = ()
        ESRB = DynAccessor(66352)
        Logo_All = DynAccessor(66353)

    startup = _startup()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(66354)

    vehicle = _vehicle()