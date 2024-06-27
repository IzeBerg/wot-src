from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(85161)
    _bootcampLesson2 = DynAccessor(85162)
    _bootcampLesson3_1 = DynAccessor(85163)
    _bootcampLesson3_2 = DynAccessor(85164)
    _bootcampLesson4 = DynAccessor(85165)
    _bootcampOutro = DynAccessor(85166)
    _tutorialInitial = DynAccessor(85167)
    _tutorialInitialLoop = DynAccessor(85168)

    class _achievements(DynAccessor):
        __slots__ = ()
        particles = DynAccessor(85169)
        up_particles = DynAccessor(85170)

    achievements = _achievements()

    class _animations(DynAccessor):
        __slots__ = ()

        class _advancedHints(DynAccessor):
            __slots__ = ()
            crewCommander = DynAccessor(85171)
            crewDriver = DynAccessor(85172)
            crewGunner = DynAccessor(85173)
            crewLoader = DynAccessor(85174)
            crewRadioOperator = DynAccessor(85175)
            skillAdrenalineRush = DynAccessor(85176)
            skillArmorer = DynAccessor(85177)
            skillArtLamp = DynAccessor(85178)
            skillBrothersInArms = DynAccessor(85179)
            skillCallForVengeance = DynAccessor(85180)
            skillClutchBraking = DynAccessor(85181)
            skillCommanderBonus = DynAccessor(85182)
            skillConcealment = DynAccessor(85183)
            skillControlledImpact = DynAccessor(85184)
            skillDeadEye = DynAccessor(85185)
            skillDesignatedTarget = DynAccessor(85186)
            skillEagleEye = DynAccessor(85187)
            skillExpert = DynAccessor(85188)
            skillFirefighting = DynAccessor(85189)
            skillIntuition = DynAccessor(85190)
            skillJackOfAllTrades = DynAccessor(85191)
            skillMentor = DynAccessor(85192)
            skillOffRoadDriving = DynAccessor(85193)
            skillPreventativeMaintenance = DynAccessor(85194)
            skillRelaying = DynAccessor(85195)
            skillRepairs = DynAccessor(85196)
            skillSafeStowage = DynAccessor(85197)
            skillSignalBoosting = DynAccessor(85198)
            skillSituationalAwareness = DynAccessor(85199)
            skillSixthSense = DynAccessor(85200)
            skillSmoothRide = DynAccessor(85201)
            skillSnapShot = DynAccessor(85202)
            skillSniper = DynAccessor(85203)
            skillSoundIntelligence = DynAccessor(85204)
            statConcealment = DynAccessor(85205)
            statFirepower = DynAccessor(85206)
            statMobility = DynAccessor(85207)
            statSpotting = DynAccessor(85208)
            statSurvivability = DynAccessor(85209)

        advancedHints = _advancedHints()

    animations = _animations()

    class _armory_yard(DynAccessor):
        __slots__ = ()
        ay_ep3_armour = DynAccessor(85210)
        ay_ep3_gun = DynAccessor(85211)
        ay_ep3_tracks = DynAccessor(85212)
        ay_ep3_turret = DynAccessor(85213)
        video_reward = DynAccessor(85214)
        video_reward_min = DynAccessor(85215)

    armory_yard = _armory_yard()

    class _battle_pass(DynAccessor):
        __slots__ = ()
        c_201292_2 = DynAccessor(85216)
        c_201292_3 = DynAccessor(85217)
        c_201292_4 = DynAccessor(85218)
        c_201548_2 = DynAccessor(85219)
        c_201548_3 = DynAccessor(85220)
        c_201548_4 = DynAccessor(85221)
        c_202316_2 = DynAccessor(85222)
        c_202316_3 = DynAccessor(85223)
        c_202316_4 = DynAccessor(85224)
        v_141_0 = DynAccessor(85225)
        v_142_0 = DynAccessor(85226)
        v_143_0 = DynAccessor(85227)

    battle_pass = _battle_pass()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(85228)
        example_2 = DynAccessor(85229)

    development = _development()

    class _event_loot_boxes(DynAccessor):
        __slots__ = ()

        class _bd2023(DynAccessor):
            __slots__ = ()
            bronze = DynAccessor(85230)
            gold = DynAccessor(85231)
            silver = DynAccessor(85232)
            standart = DynAccessor(85233)

        bd2023 = _bd2023()

        class _cosmic2024(DynAccessor):
            __slots__ = ()
            silver = DynAccessor(85234)
            standart = DynAccessor(85235)

        cosmic2024 = _cosmic2024()

        class _hw2023(DynAccessor):
            __slots__ = ()
            silver = DynAccessor(85236)
            standart = DynAccessor(85237)

        hw2023 = _hw2023()

        class _mt_lootbox(DynAccessor):
            __slots__ = ()
            mtl_1_24 = DynAccessor(85238)
            mt_drops = DynAccessor(85239)

        mt_lootbox = _mt_lootbox()

        class _rp_2024(DynAccessor):
            __slots__ = ()
            large = DynAccessor(85240)
            medium = DynAccessor(85241)
            small = DynAccessor(85242)

        rp_2024 = _rp_2024()

    event_loot_boxes = _event_loot_boxes()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(85243)

    platoon = _platoon()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(85244)

    vehicle = _vehicle()