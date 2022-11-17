from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(69771)
    _bootcampLesson2 = DynAccessor(69772)
    _bootcampLesson3_1 = DynAccessor(69773)
    _bootcampLesson3_2 = DynAccessor(69774)
    _bootcampLesson4 = DynAccessor(69775)
    _bootcampOutro = DynAccessor(69776)
    _login = DynAccessor(69777)
    _tutorialInitial = DynAccessor(69778)
    _tutorialInitialLoop = DynAccessor(69779)

    class _battle_pass(DynAccessor):
        __slots__ = ()
        c_170060_2 = DynAccessor(69780)
        c_170060_3 = DynAccessor(69781)
        c_170060_4 = DynAccessor(69782)
        c_170316_2 = DynAccessor(69783)
        c_170316_3 = DynAccessor(69784)
        c_170316_4 = DynAccessor(69785)
        c_172364_2 = DynAccessor(69786)
        c_172364_3 = DynAccessor(69787)
        c_172364_4 = DynAccessor(69788)

    battle_pass = _battle_pass()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(69789)
        example_2 = DynAccessor(69790)

    development = _development()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(69791)

    platoon = _platoon()

    class _startup(DynAccessor):
        __slots__ = ()
        ESRB = DynAccessor(69792)
        Logo_All = DynAccessor(69793)

    startup = _startup()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(69794)

    vehicle = _vehicle()