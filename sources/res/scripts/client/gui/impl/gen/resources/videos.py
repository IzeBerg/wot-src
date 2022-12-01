from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(74218)
    _bootcampLesson2 = DynAccessor(74219)
    _bootcampLesson3_1 = DynAccessor(74220)
    _bootcampLesson3_2 = DynAccessor(74221)
    _bootcampLesson4 = DynAccessor(74222)
    _bootcampOutro = DynAccessor(74223)
    _login = DynAccessor(74224)
    _tutorialInitial = DynAccessor(74225)
    _tutorialInitialLoop = DynAccessor(74226)

    class _battle_pass(DynAccessor):
        __slots__ = ()
        c_170060_2 = DynAccessor(74227)
        c_170060_3 = DynAccessor(74228)
        c_170060_4 = DynAccessor(74229)
        c_170316_2 = DynAccessor(74230)
        c_170316_3 = DynAccessor(74231)
        c_170316_4 = DynAccessor(74232)
        c_172364_2 = DynAccessor(74233)
        c_172364_3 = DynAccessor(74234)
        c_172364_4 = DynAccessor(74235)

    battle_pass = _battle_pass()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(74236)
        example_2 = DynAccessor(74237)

    development = _development()

    class _GuestRewardKitCongrats(DynAccessor):
        __slots__ = ()
        guestC = DynAccessor(74238)

    GuestRewardKitCongrats = _GuestRewardKitCongrats()

    class _lootboxes(DynAccessor):
        __slots__ = ()
        lootbox_delivery = DynAccessor(74239)
        lootbox_entry = DynAccessor(74240)

        class _idles(DynAccessor):
            __slots__ = ()
            Christmas = DynAccessor(74241)
            Fairytale = DynAccessor(74242)
            NewYear = DynAccessor(74243)
            Oriental = DynAccessor(74244)
            premium_empty = DynAccessor(74245)

        idles = _idles()

        class _opening(DynAccessor):
            __slots__ = ()
            Christmas = DynAccessor(74246)
            Fairytale = DynAccessor(74247)
            NewYear = DynAccessor(74248)
            Oriental = DynAccessor(74249)

            class _idles(DynAccessor):
                __slots__ = ()
                Christmas = DynAccessor(74250)
                Fairytale = DynAccessor(74251)
                NewYear = DynAccessor(74252)
                Oriental = DynAccessor(74253)

                class _guestC(DynAccessor):
                    __slots__ = ()
                    Christmas = DynAccessor(74254)
                    Fairytale = DynAccessor(74255)
                    NewYear = DynAccessor(74256)
                    Oriental = DynAccessor(74257)

                guestC = _guestC()

            idles = _idles()

        opening = _opening()

    lootboxes = _lootboxes()

    class _new_year(DynAccessor):
        __slots__ = ()

        class _gift_machine(DynAccessor):
            __slots__ = ()
            idle = DynAccessor(74258)
            idle_has_coins = DynAccessor(74259)
            particles = DynAccessor(74260)
            reward = DynAccessor(74261)
            special_reward = DynAccessor(74262)

        gift_machine = _gift_machine()

        class _level(DynAccessor):
            __slots__ = ()
            rhombs = DynAccessor(74263)

        level = _level()

    new_year = _new_year()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(74264)

    platoon = _platoon()

    class _startup(DynAccessor):
        __slots__ = ()
        ESRB = DynAccessor(74265)
        Logo_All = DynAccessor(74266)

    startup = _startup()

    class _StyleLootBoxCongrats(DynAccessor):
        __slots__ = ()
        A116_XM551 = DynAccessor(74267)
        Cz17_Vz_55 = DynAccessor(74268)
        Cz17_Vz_55_CN = DynAccessor(74269)
        F114_Projet_4_1 = DynAccessor(74270)
        F38_Bat_Chatillon155_58 = DynAccessor(74271)
        GB83_FV4005 = DynAccessor(74272)
        GB91_Super_Conqueror = DynAccessor(74273)
        It15_Rinoceronte = DynAccessor(74274)
        It23_CC_3 = DynAccessor(74275)
        R149_Object_268_4 = DynAccessor(74276)
        R169_ST_II = DynAccessor(74277)
        S11_Strv_103B = DynAccessor(74278)

    StyleLootBoxCongrats = _StyleLootBoxCongrats()

    class _VehicleLootBoxCongrats(DynAccessor):
        __slots__ = ()
        A149_AMBT = DynAccessor(74279)
        A152_M_Project = DynAccessor(74280)
        Ch47_BZ_176 = DynAccessor(74281)
        F118_Char_Mle_75 = DynAccessor(74282)
        It30_CC_mod_64_Prem = DynAccessor(74283)

    VehicleLootBoxCongrats = _VehicleLootBoxCongrats()