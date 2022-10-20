from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(70655)
    _bootcampLesson2 = DynAccessor(70656)
    _bootcampLesson3_1 = DynAccessor(70657)
    _bootcampLesson3_2 = DynAccessor(70658)
    _bootcampLesson4 = DynAccessor(70659)
    _bootcampOutro = DynAccessor(70660)
    _login = DynAccessor(70661)
    _tutorialInitial = DynAccessor(70662)
    _tutorialInitialLoop = DynAccessor(70663)

    class _battle_pass(DynAccessor):
        __slots__ = ()
        c_170060_2 = DynAccessor(70664)
        c_170060_3 = DynAccessor(70665)
        c_170060_4 = DynAccessor(70666)
        c_170316_2 = DynAccessor(70667)
        c_170316_3 = DynAccessor(70668)
        c_170316_4 = DynAccessor(70669)
        c_172364_2 = DynAccessor(70670)
        c_172364_3 = DynAccessor(70671)
        c_172364_4 = DynAccessor(70672)

    battle_pass = _battle_pass()

    class _cn_loot_boxes(DynAccessor):
        __slots__ = ()
        cn_lootbox_prem = DynAccessor(70673)

    cn_loot_boxes = _cn_loot_boxes()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(70674)
        example_2 = DynAccessor(70675)

    development = _development()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(70676)

    platoon = _platoon()

    class _startup(DynAccessor):
        __slots__ = ()
        ESRB = DynAccessor(70677)
        Logo_All = DynAccessor(70678)

    startup = _startup()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(70679)

    vehicle = _vehicle()