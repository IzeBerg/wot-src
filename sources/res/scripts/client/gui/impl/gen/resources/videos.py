from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(73030)
    _bootcampLesson2 = DynAccessor(73031)
    _bootcampLesson3_1 = DynAccessor(73032)
    _bootcampLesson3_2 = DynAccessor(73033)
    _bootcampLesson4 = DynAccessor(73034)
    _bootcampOutro = DynAccessor(73035)
    _login = DynAccessor(73036)
    _tutorialInitial = DynAccessor(73037)
    _tutorialInitialLoop = DynAccessor(73038)

    class _battle_pass(DynAccessor):
        __slots__ = ()
        c_135244_2 = DynAccessor(73039)
        c_135244_3 = DynAccessor(73040)
        c_135244_4 = DynAccessor(73041)
        c_136268_2 = DynAccessor(73042)
        c_136268_3 = DynAccessor(73043)
        c_136268_4 = DynAccessor(73044)
        c_76364_2 = DynAccessor(73045)
        c_76364_3 = DynAccessor(73046)
        c_76364_4 = DynAccessor(73047)

    battle_pass = _battle_pass()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(73048)
        example_2 = DynAccessor(73049)

    development = _development()

    class _lootboxes(DynAccessor):
        __slots__ = ()
        lootbox_delivery = DynAccessor(73050)
        lootbox_entry = DynAccessor(73051)
        ng_startup = DynAccessor(73052)

        class _idles(DynAccessor):
            __slots__ = ()
            Christmas = DynAccessor(73053)
            Fairytale = DynAccessor(73054)
            NewYear = DynAccessor(73055)
            newYear_usual = DynAccessor(73056)
            Oriental = DynAccessor(73057)
            premium_empty = DynAccessor(73058)
            usual_empty = DynAccessor(73059)

        idles = _idles()

        class _opening(DynAccessor):
            __slots__ = ()
            Christmas = DynAccessor(73060)
            Fairytale = DynAccessor(73061)
            free = DynAccessor(73062)
            NewYear = DynAccessor(73063)
            Oriental = DynAccessor(73064)

            class _idles(DynAccessor):
                __slots__ = ()
                Christmas = DynAccessor(73065)
                Fairytale = DynAccessor(73066)
                free = DynAccessor(73067)
                NewYear = DynAccessor(73068)
                Oriental = DynAccessor(73069)

            idles = _idles()

        opening = _opening()

    lootboxes = _lootboxes()

    class _lunar_ny(DynAccessor):
        __slots__ = ()
        album = DynAccessor(73070)
        red_envelope_event_intro = DynAccessor(73071)

        class _congratulation(DynAccessor):
            __slots__ = ()
            free = DynAccessor(73072)
            paid = DynAccessor(73073)
            premiumPaid = DynAccessor(73074)

        congratulation = _congratulation()

    lunar_ny = _lunar_ny()

    class _new_year(DynAccessor):
        __slots__ = ()
        addPoints = DynAccessor(73075)
        coin = DynAccessor(73076)
        gift_sending = DynAccessor(73077)

    new_year = _new_year()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(73078)

    platoon = _platoon()

    class _startup(DynAccessor):
        __slots__ = ()
        ESRB = DynAccessor(73079)
        Logo_All = DynAccessor(73080)

    startup = _startup()

    class _StyleLootBoxCongrats(DynAccessor):
        __slots__ = ()
        A116_XM551 = DynAccessor(73081)
        Ch41_WZ_111_5A = DynAccessor(73082)
        Cz17_Vz_55 = DynAccessor(73083)
        Cz17_Vz_55_CN = DynAccessor(73084)
        G42_Maus = DynAccessor(73085)
        GB31_Conqueror_Gun = DynAccessor(73086)
        GB83_FV4005 = DynAccessor(73087)
        It15_Rinoceronte = DynAccessor(73088)
        J16_ST_B1 = DynAccessor(73089)
        Pl15_60TP_Lewandowskiego = DynAccessor(73090)
        R149_Object_268_4 = DynAccessor(73091)
        R169_ST_II = DynAccessor(73092)

    StyleLootBoxCongrats = _StyleLootBoxCongrats()

    class _VehicleLootBoxCongrats(DynAccessor):
        __slots__ = ()
        A141_M_IV_Y = DynAccessor(73093)
        Ch43_WZ_122_2 = DynAccessor(73094)
        Cz14_Skoda_T_56 = DynAccessor(73095)
        GB112_Caliban = DynAccessor(73096)
        S32_Bofors_Tornvagn = DynAccessor(73097)

    VehicleLootBoxCongrats = _VehicleLootBoxCongrats()