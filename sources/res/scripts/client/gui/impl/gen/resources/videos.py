from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(85140)
    _bootcampLesson2 = DynAccessor(85141)
    _bootcampLesson3_1 = DynAccessor(85142)
    _bootcampLesson3_2 = DynAccessor(85143)
    _bootcampLesson4 = DynAccessor(85144)
    _bootcampOutro = DynAccessor(85145)
    _tutorialInitial = DynAccessor(85146)
    _tutorialInitialLoop = DynAccessor(85147)

    class _achievements(DynAccessor):
        __slots__ = ()
        particles = DynAccessor(85148)
        up_particles = DynAccessor(85149)

    achievements = _achievements()

    class _animations(DynAccessor):
        __slots__ = ()

        class _advancedHints(DynAccessor):
            __slots__ = ()
            crewCommander = DynAccessor(85150)
            crewDriver = DynAccessor(85151)
            crewGunner = DynAccessor(85152)
            crewLoader = DynAccessor(85153)
            crewRadioOperator = DynAccessor(85154)
            skillAdrenalineRush = DynAccessor(85155)
            skillArmorer = DynAccessor(85156)
            skillArtLamp = DynAccessor(85157)
            skillBrothersInArms = DynAccessor(85158)
            skillCallForVengeance = DynAccessor(85159)
            skillClutchBraking = DynAccessor(85160)
            skillCommanderBonus = DynAccessor(85161)
            skillConcealment = DynAccessor(85162)
            skillControlledImpact = DynAccessor(85163)
            skillDeadEye = DynAccessor(85164)
            skillDesignatedTarget = DynAccessor(85165)
            skillEagleEye = DynAccessor(85166)
            skillExpert = DynAccessor(85167)
            skillFirefighting = DynAccessor(85168)
            skillIntuition = DynAccessor(85169)
            skillJackOfAllTrades = DynAccessor(85170)
            skillMentor = DynAccessor(85171)
            skillOffRoadDriving = DynAccessor(85172)
            skillPreventativeMaintenance = DynAccessor(85173)
            skillRelaying = DynAccessor(85174)
            skillRepairs = DynAccessor(85175)
            skillSafeStowage = DynAccessor(85176)
            skillSignalBoosting = DynAccessor(85177)
            skillSituationalAwareness = DynAccessor(85178)
            skillSixthSense = DynAccessor(85179)
            skillSmoothRide = DynAccessor(85180)
            skillSnapShot = DynAccessor(85181)
            skillSniper = DynAccessor(85182)
            skillSoundIntelligence = DynAccessor(85183)
            statConcealment = DynAccessor(85184)
            statFirepower = DynAccessor(85185)
            statMobility = DynAccessor(85186)
            statSpotting = DynAccessor(85187)
            statSurvivability = DynAccessor(85188)

        advancedHints = _advancedHints()

    animations = _animations()

    class _armory_yard(DynAccessor):
        __slots__ = ()
        ay_ep3_armour = DynAccessor(85189)
        ay_ep3_gun = DynAccessor(85190)
        ay_ep3_tracks = DynAccessor(85191)
        ay_ep3_turret = DynAccessor(85192)
        video_reward = DynAccessor(85193)
        video_reward_min = DynAccessor(85194)

    armory_yard = _armory_yard()

    class _battle_pass(DynAccessor):
        __slots__ = ()
        c_201292_2 = DynAccessor(85195)
        c_201292_3 = DynAccessor(85196)
        c_201292_4 = DynAccessor(85197)
        c_201548_2 = DynAccessor(85198)
        c_201548_3 = DynAccessor(85199)
        c_201548_4 = DynAccessor(85200)
        c_202316_2 = DynAccessor(85201)
        c_202316_3 = DynAccessor(85202)
        c_202316_4 = DynAccessor(85203)
        v_141_0 = DynAccessor(85204)
        v_142_0 = DynAccessor(85205)
        v_143_0 = DynAccessor(85206)

    battle_pass = _battle_pass()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(85207)
        example_2 = DynAccessor(85208)

    development = _development()

    class _event_loot_boxes(DynAccessor):
        __slots__ = ()

        class _bd2023(DynAccessor):
            __slots__ = ()
            bronze = DynAccessor(85209)
            gold = DynAccessor(85210)
            silver = DynAccessor(85211)
            standart = DynAccessor(85212)

        bd2023 = _bd2023()

        class _cosmic2024(DynAccessor):
            __slots__ = ()
            silver = DynAccessor(85213)
            standart = DynAccessor(85214)

        cosmic2024 = _cosmic2024()

        class _hw2023(DynAccessor):
            __slots__ = ()
            silver = DynAccessor(85215)
            standart = DynAccessor(85216)

        hw2023 = _hw2023()

        class _mt_lootbox(DynAccessor):
            __slots__ = ()
            mtl_1_24 = DynAccessor(85217)
            mt_drops = DynAccessor(85218)

        mt_lootbox = _mt_lootbox()

        class _rp_2024(DynAccessor):
            __slots__ = ()
            large = DynAccessor(85219)
            medium = DynAccessor(85220)
            small = DynAccessor(85221)

        rp_2024 = _rp_2024()

    event_loot_boxes = _event_loot_boxes()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(85222)

    platoon = _platoon()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(85223)

    vehicle = _vehicle()