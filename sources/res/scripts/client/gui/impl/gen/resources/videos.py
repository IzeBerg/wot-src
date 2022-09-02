from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(66382)
    _bootcampLesson2 = DynAccessor(66383)
    _bootcampLesson3_1 = DynAccessor(66384)
    _bootcampLesson3_2 = DynAccessor(66385)
    _bootcampLesson4 = DynAccessor(66386)
    _bootcampOutro = DynAccessor(66387)
    _login = DynAccessor(66388)
    _tutorialInitial = DynAccessor(66389)
    _tutorialInitialLoop = DynAccessor(66390)

    class _battle_pass(DynAccessor):
        __slots__ = ()
        c_157260_2 = DynAccessor(66391)
        c_157260_3 = DynAccessor(66392)
        c_157260_4 = DynAccessor(66393)
        c_157516_2 = DynAccessor(66394)
        c_157516_3 = DynAccessor(66395)
        c_157516_4 = DynAccessor(66396)
        c_157772_2 = DynAccessor(66397)
        c_157772_3 = DynAccessor(66398)
        c_157772_4 = DynAccessor(66399)

    battle_pass = _battle_pass()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(66400)
        example_2 = DynAccessor(66401)

    development = _development()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(66402)

    platoon = _platoon()

    class _startup(DynAccessor):
        __slots__ = ()
        ESRB = DynAccessor(66403)
        Logo_All = DynAccessor(66404)

    startup = _startup()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(66405)

    vehicle = _vehicle()