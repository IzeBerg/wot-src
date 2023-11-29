from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    intro = DynAccessor(85378)
    _bootcampLesson1 = DynAccessor(85379)
    _bootcampLesson2 = DynAccessor(85380)
    _bootcampLesson3_1 = DynAccessor(85381)
    _bootcampLesson3_2 = DynAccessor(85382)
    _bootcampLesson4 = DynAccessor(85383)
    _bootcampOutro = DynAccessor(85384)
    _tutorialInitial = DynAccessor(85385)
    _tutorialInitialLoop = DynAccessor(85386)

    class _achievements(DynAccessor):
        __slots__ = ()
        particles = DynAccessor(85387)
        up_particles = DynAccessor(85388)

    achievements = _achievements()

    class _adventCalendar(DynAccessor):
        __slots__ = ()
        shine = DynAccessor(85389)

    adventCalendar = _adventCalendar()

    class _animations(DynAccessor):
        __slots__ = ()

        class _advancedHints(DynAccessor):
            __slots__ = ()
            crewCommander = DynAccessor(85390)
            crewDriver = DynAccessor(85391)
            crewGunner = DynAccessor(85392)
            crewLoader = DynAccessor(85393)
            crewRadioOperator = DynAccessor(85394)
            skillAdrenalineRush = DynAccessor(85395)
            skillAmbushMaster = DynAccessor(85396)
            skillArmorer = DynAccessor(85397)
            skillArtLamp = DynAccessor(85398)
            skillBrothersInArms = DynAccessor(85399)
            skillCallForVengeance = DynAccessor(85400)
            skillCloseCombat = DynAccessor(85401)
            skillClutchBraking = DynAccessor(85402)
            skillCommanderBonus = DynAccessor(85403)
            skillConcealment = DynAccessor(85404)
            skillConcentration = DynAccessor(85405)
            skillControlledImpact = DynAccessor(85406)
            skillDesignatedTarget = DynAccessor(85407)
            skillEagleEye = DynAccessor(85408)
            skillExpert = DynAccessor(85409)
            skillFirefighting = DynAccessor(85410)
            skillInterference = DynAccessor(85411)
            skillIntuition = DynAccessor(85412)
            skillJackOfAllTrades = DynAccessor(85413)
            skillMentor = DynAccessor(85414)
            skillMotorConnoisseur = DynAccessor(85415)
            skillOffRoadDriving = DynAccessor(85416)
            skillPracticality = DynAccessor(85417)
            skillPreventativeMaintenance = DynAccessor(85418)
            skillQuickAiming = DynAccessor(85419)
            skillRelaying = DynAccessor(85420)
            skillRepairs = DynAccessor(85421)
            skillSafeStowage = DynAccessor(85422)
            skillShellImprovement = DynAccessor(85423)
            skillSignalBoosting = DynAccessor(85424)
            skillSituationalAwareness = DynAccessor(85425)
            skillSixthSense = DynAccessor(85426)
            skillSmoothRide = DynAccessor(85427)
            skillSnapShot = DynAccessor(85428)
            skillSniper = DynAccessor(85429)
            statConcealment = DynAccessor(85430)
            statFirepower = DynAccessor(85431)
            statMobility = DynAccessor(85432)
            statSpotting = DynAccessor(85433)
            statSurvivability = DynAccessor(85434)

        advancedHints = _advancedHints()

    animations = _animations()

    class _battle_pass(DynAccessor):
        __slots__ = ()
        media_ch4 = DynAccessor(85435)
        style_ch1_lvl2 = DynAccessor(85436)
        style_ch1_lvl3 = DynAccessor(85437)
        style_ch1_lvl4 = DynAccessor(85438)
        style_ch2_lvl2 = DynAccessor(85439)
        style_ch2_lvl3 = DynAccessor(85440)
        style_ch2_lvl4 = DynAccessor(85441)
        style_ch3_lvl2 = DynAccessor(85442)
        style_ch3_lvl3 = DynAccessor(85443)
        style_ch3_lvl4 = DynAccessor(85444)

    battle_pass = _battle_pass()

    class _comp7(DynAccessor):
        __slots__ = ()
        rankAnimation = DynAccessor(85445)

    comp7 = _comp7()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(85446)
        example_2 = DynAccessor(85447)

    development = _development()

    class _event_loot_boxes(DynAccessor):
        __slots__ = ()
        lootbox_prem = DynAccessor(85448)

    event_loot_boxes = _event_loot_boxes()

    class _GuestRewardKitCongrats(DynAccessor):
        __slots__ = ()
        guestC = DynAccessor(85449)

    GuestRewardKitCongrats = _GuestRewardKitCongrats()

    class _lootboxes(DynAccessor):
        __slots__ = ()
        lootbox_delivery = DynAccessor(85450)
        lootbox_entry = DynAccessor(85451)

        class _idles(DynAccessor):
            __slots__ = ()
            Christmas = DynAccessor(85452)
            Fairytale = DynAccessor(85453)
            NewYear = DynAccessor(85454)
            Oriental = DynAccessor(85455)
            premium_empty = DynAccessor(85456)

        idles = _idles()

        class _opening(DynAccessor):
            __slots__ = ()
            Christmas = DynAccessor(85457)
            Fairytale = DynAccessor(85458)
            NewYear = DynAccessor(85459)
            Oriental = DynAccessor(85460)

            class _idles(DynAccessor):
                __slots__ = ()
                Christmas = DynAccessor(85461)
                Fairytale = DynAccessor(85462)
                NewYear = DynAccessor(85463)
                Oriental = DynAccessor(85464)

                class _guestC(DynAccessor):
                    __slots__ = ()
                    Christmas = DynAccessor(85465)
                    Fairytale = DynAccessor(85466)
                    NewYear = DynAccessor(85467)
                    Oriental = DynAccessor(85468)

                guestC = _guestC()

            idles = _idles()

        opening = _opening()

    lootboxes = _lootboxes()

    class _new_year(DynAccessor):
        __slots__ = ()

        class _gift_machine(DynAccessor):
            __slots__ = ()
            error = DynAccessor(85469)
            idle = DynAccessor(85470)
            idle_has_coins = DynAccessor(85471)
            particles = DynAccessor(85472)
            reward = DynAccessor(85473)
            second_particles = DynAccessor(85474)
            special_reward = DynAccessor(85475)

        gift_machine = _gift_machine()

        class _level(DynAccessor):
            __slots__ = ()
            rhombs = DynAccessor(85476)

        level = _level()

        class _sacks(DynAccessor):
            __slots__ = ()
            open_particles = DynAccessor(85477)
            open_shine = DynAccessor(85478)
            open_shine_rare = DynAccessor(85479)

            class _idle(DynAccessor):
                __slots__ = ()
                particles = DynAccessor(85480)
                particles_small = DynAccessor(85481)
                shine = DynAccessor(85482)
                shine_small = DynAccessor(85483)

            idle = _idle()

        sacks = _sacks()

        class _snowfall(DynAccessor):
            __slots__ = ()
            snowfall = DynAccessor(85484)

        snowfall = _snowfall()

    new_year = _new_year()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(85485)

    platoon = _platoon()

    class _startup(DynAccessor):
        __slots__ = ()
        Logo_All = DynAccessor(85486)

    startup = _startup()

    class _StyleLootBoxCongrats(DynAccessor):
        __slots__ = ()
        A125_AEP_1 = DynAccessor(85487)
        A125_AEP_1_CN = DynAccessor(85488)
        F108_Panhard_EBR_105 = DynAccessor(85489)
        F114_Projet_4_1 = DynAccessor(85490)
        F38_Bat_Chatillon155_58 = DynAccessor(85491)
        G55_E_75 = DynAccessor(85492)
        G55_E_75_CN = DynAccessor(85493)
        G61_G_E = DynAccessor(85494)
        GB106_Cobra = DynAccessor(85495)
        GB91_Super_Conqueror = DynAccessor(85496)
        It23_CC_3 = DynAccessor(85497)
        S11_Strv_103B = DynAccessor(85498)

    StyleLootBoxCongrats = _StyleLootBoxCongrats()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(85499)

    vehicle = _vehicle()

    class _VehicleLootBoxCongrats(DynAccessor):
        __slots__ = ()
        A153_XM66F = DynAccessor(85500)
        G167_Tiger_Maus_120t = DynAccessor(85501)
        GB121_GSOR_1010_FB = DynAccessor(85502)
        J36_Type_63_HT = DynAccessor(85503)
        R172_Object_752 = DynAccessor(85504)

    VehicleLootBoxCongrats = _VehicleLootBoxCongrats()