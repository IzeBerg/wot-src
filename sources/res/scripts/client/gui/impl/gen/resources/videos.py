from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(69403)
    _bootcampLesson2 = DynAccessor(69404)
    _bootcampLesson3_1 = DynAccessor(69405)
    _bootcampLesson3_2 = DynAccessor(69406)
    _bootcampLesson4 = DynAccessor(69407)
    _bootcampOutro = DynAccessor(69408)
    _login = DynAccessor(69409)
    _tutorialInitial = DynAccessor(69410)
    _tutorialInitialLoop = DynAccessor(69411)

    class _battle_pass(DynAccessor):
        __slots__ = ()
        c_170060_2 = DynAccessor(69412)
        c_170060_3 = DynAccessor(69413)
        c_170060_4 = DynAccessor(69414)
        c_170316_2 = DynAccessor(69415)
        c_170316_3 = DynAccessor(69416)
        c_170316_4 = DynAccessor(69417)
        c_172364_2 = DynAccessor(69418)
        c_172364_3 = DynAccessor(69419)
        c_172364_4 = DynAccessor(69420)

    battle_pass = _battle_pass()

    class _cn_loot_boxes(DynAccessor):
        __slots__ = ()
        cn_lootbox_prem = DynAccessor(69421)

    cn_loot_boxes = _cn_loot_boxes()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(69422)
        example_2 = DynAccessor(69423)

    development = _development()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(69424)

    platoon = _platoon()

    class _startup(DynAccessor):
        __slots__ = ()
        ESRB = DynAccessor(69425)
        Logo_All = DynAccessor(69426)

    startup = _startup()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(69427)

    vehicle = _vehicle()