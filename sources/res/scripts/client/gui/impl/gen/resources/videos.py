from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(70748)
    _bootcampLesson2 = DynAccessor(70749)
    _bootcampLesson3_1 = DynAccessor(70750)
    _bootcampLesson3_2 = DynAccessor(70751)
    _bootcampLesson4 = DynAccessor(70752)
    _bootcampOutro = DynAccessor(70753)
    _login = DynAccessor(70754)
    _tutorialInitial = DynAccessor(70755)
    _tutorialInitialLoop = DynAccessor(70756)

    class _battle_pass(DynAccessor):
        __slots__ = ()
        c_170060_2 = DynAccessor(70757)
        c_170060_3 = DynAccessor(70758)
        c_170060_4 = DynAccessor(70759)
        c_170316_2 = DynAccessor(70760)
        c_170316_3 = DynAccessor(70761)
        c_170316_4 = DynAccessor(70762)
        c_172364_2 = DynAccessor(70763)
        c_172364_3 = DynAccessor(70764)
        c_172364_4 = DynAccessor(70765)

    battle_pass = _battle_pass()

    class _cn_loot_boxes(DynAccessor):
        __slots__ = ()
        cn_lootbox_prem = DynAccessor(70766)

    cn_loot_boxes = _cn_loot_boxes()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(70767)
        example_2 = DynAccessor(70768)

    development = _development()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(70769)

    platoon = _platoon()

    class _startup(DynAccessor):
        __slots__ = ()
        ESRB = DynAccessor(70770)
        Logo_All = DynAccessor(70771)

    startup = _startup()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(70772)

    vehicle = _vehicle()