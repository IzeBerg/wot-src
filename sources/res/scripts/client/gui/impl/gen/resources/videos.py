from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    intro = DynAccessor(80161)
    _bootcampLesson1 = DynAccessor(80162)
    _bootcampLesson2 = DynAccessor(80163)
    _bootcampLesson3_1 = DynAccessor(80164)
    _bootcampLesson3_2 = DynAccessor(80165)
    _bootcampLesson4 = DynAccessor(80166)
    _bootcampOutro = DynAccessor(80167)
    _tutorialInitial = DynAccessor(80168)
    _tutorialInitialLoop = DynAccessor(80169)

    class _achievements(DynAccessor):
        __slots__ = ()
        particles = DynAccessor(80170)
        up_particles = DynAccessor(80171)

    achievements = _achievements()

    class _animations(DynAccessor):
        __slots__ = ()

        class _advancedHints(DynAccessor):
            __slots__ = ()
            crewCommander = DynAccessor(80172)
            crewDriver = DynAccessor(80173)
            crewGunner = DynAccessor(80174)
            crewLoader = DynAccessor(80175)
            crewRadioOperator = DynAccessor(80176)
            skillAdrenalineRush = DynAccessor(80177)
            skillAmbushMaster = DynAccessor(80178)
            skillArmorer = DynAccessor(80179)
            skillArtLamp = DynAccessor(80180)
            skillBrothersInArms = DynAccessor(80181)
            skillCallForVengeance = DynAccessor(80182)
            skillCloseCombat = DynAccessor(80183)
            skillClutchBraking = DynAccessor(80184)
            skillCommanderBonus = DynAccessor(80185)
            skillConcealment = DynAccessor(80186)
            skillConcentration = DynAccessor(80187)
            skillControlledImpact = DynAccessor(80188)
            skillDesignatedTarget = DynAccessor(80189)
            skillEagleEye = DynAccessor(80190)
            skillExpert = DynAccessor(80191)
            skillFirefighting = DynAccessor(80192)
            skillInterference = DynAccessor(80193)
            skillIntuition = DynAccessor(80194)
            skillJackOfAllTrades = DynAccessor(80195)
            skillMentor = DynAccessor(80196)
            skillMotorConnoisseur = DynAccessor(80197)
            skillOffRoadDriving = DynAccessor(80198)
            skillPracticality = DynAccessor(80199)
            skillPreventativeMaintenance = DynAccessor(80200)
            skillQuickAiming = DynAccessor(80201)
            skillRelaying = DynAccessor(80202)
            skillRepairs = DynAccessor(80203)
            skillSafeStowage = DynAccessor(80204)
            skillShellImprovement = DynAccessor(80205)
            skillSignalBoosting = DynAccessor(80206)
            skillSituationalAwareness = DynAccessor(80207)
            skillSixthSense = DynAccessor(80208)
            skillSmoothRide = DynAccessor(80209)
            skillSnapShot = DynAccessor(80210)
            skillSniper = DynAccessor(80211)
            statConcealment = DynAccessor(80212)
            statFirepower = DynAccessor(80213)
            statMobility = DynAccessor(80214)
            statSpotting = DynAccessor(80215)
            statSurvivability = DynAccessor(80216)

        advancedHints = _advancedHints()

    animations = _animations()

    class _battle_pass(DynAccessor):
        __slots__ = ()
        media_ch4 = DynAccessor(80217)
        style_ch1_lvl2 = DynAccessor(80218)
        style_ch1_lvl3 = DynAccessor(80219)
        style_ch1_lvl4 = DynAccessor(80220)
        style_ch2_lvl2 = DynAccessor(80221)
        style_ch2_lvl3 = DynAccessor(80222)
        style_ch2_lvl4 = DynAccessor(80223)
        style_ch3_lvl2 = DynAccessor(80224)
        style_ch3_lvl3 = DynAccessor(80225)
        style_ch3_lvl4 = DynAccessor(80226)

    battle_pass = _battle_pass()

    class _comp7(DynAccessor):
        __slots__ = ()
        rankAnimation = DynAccessor(80227)

    comp7 = _comp7()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(80228)
        example_2 = DynAccessor(80229)

    development = _development()

    class _event_loot_boxes(DynAccessor):
        __slots__ = ()
        lootbox_prem = DynAccessor(80230)

    event_loot_boxes = _event_loot_boxes()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(80231)

    platoon = _platoon()

    class _startup(DynAccessor):
        __slots__ = ()
        Logo_All = DynAccessor(80232)

    startup = _startup()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(80233)

    vehicle = _vehicle()