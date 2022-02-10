from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(62771)
    _bootcampLesson2 = DynAccessor(62772)
    _bootcampLesson3_1 = DynAccessor(62773)
    _bootcampLesson3_2 = DynAccessor(62774)
    _bootcampLesson4 = DynAccessor(62775)
    _bootcampOutro = DynAccessor(62776)
    _login = DynAccessor(62777)
    _tutorialInitial = DynAccessor(62778)
    _tutorialInitialLoop = DynAccessor(62779)

    class _battle_pass(DynAccessor):
        __slots__ = ()
        c_152396_2 = DynAccessor(62780)
        c_152396_3 = DynAccessor(62781)
        c_152396_4 = DynAccessor(62782)
        c_152652_2 = DynAccessor(62783)
        c_152652_3 = DynAccessor(62784)
        c_152652_4 = DynAccessor(62785)
        c_154188_2 = DynAccessor(62786)
        c_154188_3 = DynAccessor(62787)
        c_154188_4 = DynAccessor(62788)

    battle_pass = _battle_pass()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(62789)
        example_2 = DynAccessor(62790)

    development = _development()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(62791)

    platoon = _platoon()

    class _startup(DynAccessor):
        __slots__ = ()
        ESRB = DynAccessor(62792)
        Logo_All = DynAccessor(62793)

    startup = _startup()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(62794)

    vehicle = _vehicle()