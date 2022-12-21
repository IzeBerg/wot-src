from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(74262)
    _bootcampLesson2 = DynAccessor(74263)
    _bootcampLesson3_1 = DynAccessor(74264)
    _bootcampLesson3_2 = DynAccessor(74265)
    _bootcampLesson4 = DynAccessor(74266)
    _bootcampOutro = DynAccessor(74267)
    _login = DynAccessor(74268)
    _tutorialInitial = DynAccessor(74269)
    _tutorialInitialLoop = DynAccessor(74270)

    class _battle_pass(DynAccessor):
        __slots__ = ()
        c_170060_2 = DynAccessor(74271)
        c_170060_3 = DynAccessor(74272)
        c_170060_4 = DynAccessor(74273)
        c_170316_2 = DynAccessor(74274)
        c_170316_3 = DynAccessor(74275)
        c_170316_4 = DynAccessor(74276)
        c_172364_2 = DynAccessor(74277)
        c_172364_3 = DynAccessor(74278)
        c_172364_4 = DynAccessor(74279)

    battle_pass = _battle_pass()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(74280)
        example_2 = DynAccessor(74281)

    development = _development()

    class _GuestRewardKitCongrats(DynAccessor):
        __slots__ = ()
        guestC = DynAccessor(74282)

    GuestRewardKitCongrats = _GuestRewardKitCongrats()

    class _lootboxes(DynAccessor):
        __slots__ = ()
        lootbox_delivery = DynAccessor(74283)
        lootbox_entry = DynAccessor(74284)

        class _idles(DynAccessor):
            __slots__ = ()
            Christmas = DynAccessor(74285)
            Fairytale = DynAccessor(74286)
            NewYear = DynAccessor(74287)
            Oriental = DynAccessor(74288)
            premium_empty = DynAccessor(74289)

        idles = _idles()

        class _opening(DynAccessor):
            __slots__ = ()
            Christmas = DynAccessor(74290)
            Fairytale = DynAccessor(74291)
            NewYear = DynAccessor(74292)
            Oriental = DynAccessor(74293)

            class _idles(DynAccessor):
                __slots__ = ()
                Christmas = DynAccessor(74294)
                Fairytale = DynAccessor(74295)
                NewYear = DynAccessor(74296)
                Oriental = DynAccessor(74297)

                class _guestC(DynAccessor):
                    __slots__ = ()
                    Christmas = DynAccessor(74298)
                    Fairytale = DynAccessor(74299)
                    NewYear = DynAccessor(74300)
                    Oriental = DynAccessor(74301)

                guestC = _guestC()

            idles = _idles()

        opening = _opening()

    lootboxes = _lootboxes()

    class _new_year(DynAccessor):
        __slots__ = ()

        class _gift_machine(DynAccessor):
            __slots__ = ()
            idle = DynAccessor(74302)
            idle_has_coins = DynAccessor(74303)
            particles = DynAccessor(74304)
            reward = DynAccessor(74305)
            special_reward = DynAccessor(74306)

        gift_machine = _gift_machine()

        class _level(DynAccessor):
            __slots__ = ()
            rhombs = DynAccessor(74307)

        level = _level()

    new_year = _new_year()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(74308)

    platoon = _platoon()

    class _startup(DynAccessor):
        __slots__ = ()
        ESRB = DynAccessor(74309)
        Logo_All = DynAccessor(74310)

    startup = _startup()

    class _StyleLootBoxCongrats(DynAccessor):
        __slots__ = ()
        A116_XM551 = DynAccessor(74311)
        Cz17_Vz_55 = DynAccessor(74312)
        Cz17_Vz_55_CN = DynAccessor(74313)
        F114_Projet_4_1 = DynAccessor(74314)
        F38_Bat_Chatillon155_58 = DynAccessor(74315)
        GB83_FV4005 = DynAccessor(74316)
        GB91_Super_Conqueror = DynAccessor(74317)
        It15_Rinoceronte = DynAccessor(74318)
        It23_CC_3 = DynAccessor(74319)
        R149_Object_268_4 = DynAccessor(74320)
        R169_ST_II = DynAccessor(74321)
        S11_Strv_103B = DynAccessor(74322)

    StyleLootBoxCongrats = _StyleLootBoxCongrats()

    class _VehicleLootBoxCongrats(DynAccessor):
        __slots__ = ()
        A149_AMBT = DynAccessor(74323)
        A152_M_Project = DynAccessor(74324)
        Ch47_BZ_176 = DynAccessor(74325)
        F118_Char_Mle_75 = DynAccessor(74326)
        It30_CC_mod_64_Prem = DynAccessor(74327)

    VehicleLootBoxCongrats = _VehicleLootBoxCongrats()