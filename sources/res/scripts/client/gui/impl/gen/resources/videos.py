from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(70654)
    _bootcampLesson2 = DynAccessor(70655)
    _bootcampLesson3_1 = DynAccessor(70656)
    _bootcampLesson3_2 = DynAccessor(70657)
    _bootcampLesson4 = DynAccessor(70658)
    _bootcampOutro = DynAccessor(70659)
    _login = DynAccessor(70660)
    _tutorialInitial = DynAccessor(70661)
    _tutorialInitialLoop = DynAccessor(70662)

    class _battle_pass(DynAccessor):
        __slots__ = ()
        c_170060_2 = DynAccessor(70663)
        c_170060_3 = DynAccessor(70664)
        c_170060_4 = DynAccessor(70665)
        c_170316_2 = DynAccessor(70666)
        c_170316_3 = DynAccessor(70667)
        c_170316_4 = DynAccessor(70668)
        c_172364_2 = DynAccessor(70669)
        c_172364_3 = DynAccessor(70670)
        c_172364_4 = DynAccessor(70671)

    battle_pass = _battle_pass()

    class _cn_loot_boxes(DynAccessor):
        __slots__ = ()
        cn_lootbox_prem = DynAccessor(70672)

    cn_loot_boxes = _cn_loot_boxes()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(70673)
        example_2 = DynAccessor(70674)

    development = _development()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(70675)

    platoon = _platoon()

    class _startup(DynAccessor):
        __slots__ = ()
        ESRB = DynAccessor(70676)
        Logo_All = DynAccessor(70677)

    startup = _startup()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(70678)

    vehicle = _vehicle()