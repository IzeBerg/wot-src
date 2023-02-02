from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(70847)
    _bootcampLesson2 = DynAccessor(70848)
    _bootcampLesson3_1 = DynAccessor(70849)
    _bootcampLesson3_2 = DynAccessor(70850)
    _bootcampLesson4 = DynAccessor(70851)
    _bootcampOutro = DynAccessor(70852)
    _login = DynAccessor(70853)
    _tutorialInitial = DynAccessor(70854)
    _tutorialInitialLoop = DynAccessor(70855)

    class _battle_pass(DynAccessor):
        __slots__ = ()
        c_157260_2 = DynAccessor(70856)
        c_157260_3 = DynAccessor(70857)
        c_157260_4 = DynAccessor(70858)
        c_157516_2 = DynAccessor(70859)
        c_157516_3 = DynAccessor(70860)
        c_157516_4 = DynAccessor(70861)
        c_157772_2 = DynAccessor(70862)
        c_157772_3 = DynAccessor(70863)
        c_157772_4 = DynAccessor(70864)

    battle_pass = _battle_pass()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(70865)
        example_2 = DynAccessor(70866)

    development = _development()

    class _event_loot_boxes(DynAccessor):
        __slots__ = ()
        lootbox_prem = DynAccessor(70867)

    event_loot_boxes = _event_loot_boxes()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(70868)

    platoon = _platoon()

    class _startup(DynAccessor):
        __slots__ = ()
        ESRB = DynAccessor(70869)
        Logo_All = DynAccessor(70870)

    startup = _startup()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(70871)

    vehicle = _vehicle()