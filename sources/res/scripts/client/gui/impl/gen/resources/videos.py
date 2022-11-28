from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(74210)
    _bootcampLesson2 = DynAccessor(74211)
    _bootcampLesson3_1 = DynAccessor(74212)
    _bootcampLesson3_2 = DynAccessor(74213)
    _bootcampLesson4 = DynAccessor(74214)
    _bootcampOutro = DynAccessor(74215)
    _login = DynAccessor(74216)
    _tutorialInitial = DynAccessor(74217)
    _tutorialInitialLoop = DynAccessor(74218)

    class _battle_pass(DynAccessor):
        __slots__ = ()
        c_170060_2 = DynAccessor(74219)
        c_170060_3 = DynAccessor(74220)
        c_170060_4 = DynAccessor(74221)
        c_170316_2 = DynAccessor(74222)
        c_170316_3 = DynAccessor(74223)
        c_170316_4 = DynAccessor(74224)
        c_172364_2 = DynAccessor(74225)
        c_172364_3 = DynAccessor(74226)
        c_172364_4 = DynAccessor(74227)

    battle_pass = _battle_pass()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(74228)
        example_2 = DynAccessor(74229)

    development = _development()

    class _GuestRewardKitCongrats(DynAccessor):
        __slots__ = ()
        guestC = DynAccessor(74230)

    GuestRewardKitCongrats = _GuestRewardKitCongrats()

    class _lootboxes(DynAccessor):
        __slots__ = ()
        lootbox_delivery = DynAccessor(74231)
        lootbox_entry = DynAccessor(74232)

        class _idles(DynAccessor):
            __slots__ = ()
            Christmas = DynAccessor(74233)
            Fairytale = DynAccessor(74234)
            NewYear = DynAccessor(74235)
            Oriental = DynAccessor(74236)
            premium_empty = DynAccessor(74237)

        idles = _idles()

        class _opening(DynAccessor):
            __slots__ = ()
            Christmas = DynAccessor(74238)
            Fairytale = DynAccessor(74239)
            NewYear = DynAccessor(74240)
            Oriental = DynAccessor(74241)

            class _idles(DynAccessor):
                __slots__ = ()
                Christmas = DynAccessor(74242)
                Fairytale = DynAccessor(74243)
                NewYear = DynAccessor(74244)
                Oriental = DynAccessor(74245)

                class _guestC(DynAccessor):
                    __slots__ = ()
                    Christmas = DynAccessor(74246)
                    Fairytale = DynAccessor(74247)
                    NewYear = DynAccessor(74248)
                    Oriental = DynAccessor(74249)

                guestC = _guestC()

            idles = _idles()

        opening = _opening()

    lootboxes = _lootboxes()

    class _new_year(DynAccessor):
        __slots__ = ()

        class _gift_machine(DynAccessor):
            __slots__ = ()
            idle = DynAccessor(74250)
            idle_has_coins = DynAccessor(74251)
            particles = DynAccessor(74252)
            reward = DynAccessor(74253)
            special_reward = DynAccessor(74254)

        gift_machine = _gift_machine()

        class _level(DynAccessor):
            __slots__ = ()
            rhombs = DynAccessor(74255)

        level = _level()

    new_year = _new_year()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(74256)

    platoon = _platoon()

    class _startup(DynAccessor):
        __slots__ = ()
        ESRB = DynAccessor(74257)
        Logo_All = DynAccessor(74258)

    startup = _startup()

    class _StyleLootBoxCongrats(DynAccessor):
        __slots__ = ()
        A116_XM551 = DynAccessor(74259)
        Cz17_Vz_55 = DynAccessor(74260)
        Cz17_Vz_55_CN = DynAccessor(74261)
        F114_Projet_4_1 = DynAccessor(74262)
        F38_Bat_Chatillon155_58 = DynAccessor(74263)
        GB83_FV4005 = DynAccessor(74264)
        GB91_Super_Conqueror = DynAccessor(74265)
        It15_Rinoceronte = DynAccessor(74266)
        It23_CC_3 = DynAccessor(74267)
        R149_Object_268_4 = DynAccessor(74268)
        R169_ST_II = DynAccessor(74269)
        S11_Strv_103B = DynAccessor(74270)

    StyleLootBoxCongrats = _StyleLootBoxCongrats()

    class _VehicleLootBoxCongrats(DynAccessor):
        __slots__ = ()
        A149_AMBT = DynAccessor(74271)
        A152_M_Project = DynAccessor(74272)
        Ch47_BZ_176 = DynAccessor(74273)
        F118_Char_Mle_75 = DynAccessor(74274)
        It30_CC_mod_64_Prem = DynAccessor(74275)

    VehicleLootBoxCongrats = _VehicleLootBoxCongrats()