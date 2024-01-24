from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(82211)
    _bootcampLesson2 = DynAccessor(82212)
    _bootcampLesson3_1 = DynAccessor(82213)
    _bootcampLesson3_2 = DynAccessor(82214)
    _bootcampLesson4 = DynAccessor(82215)
    _bootcampOutro = DynAccessor(82216)
    _tutorialInitial = DynAccessor(82217)
    _tutorialInitialLoop = DynAccessor(82218)

    class _achievements(DynAccessor):
        __slots__ = ()
        particles = DynAccessor(82219)
        up_particles = DynAccessor(82220)

    achievements = _achievements()

    class _animations(DynAccessor):
        __slots__ = ()

        class _advancedHints(DynAccessor):
            __slots__ = ()
            crewCommander = DynAccessor(82221)
            crewDriver = DynAccessor(82222)
            crewGunner = DynAccessor(82223)
            crewLoader = DynAccessor(82224)
            crewRadioOperator = DynAccessor(82225)
            skillAdrenalineRush = DynAccessor(82226)
            skillArmorer = DynAccessor(82227)
            skillArtLamp = DynAccessor(82228)
            skillBrothersInArms = DynAccessor(82229)
            skillCallForVengeance = DynAccessor(82230)
            skillClutchBraking = DynAccessor(82231)
            skillCommanderBonus = DynAccessor(82232)
            skillConcealment = DynAccessor(82233)
            skillControlledImpact = DynAccessor(82234)
            skillDeadEye = DynAccessor(82235)
            skillDesignatedTarget = DynAccessor(82236)
            skillEagleEye = DynAccessor(82237)
            skillExpert = DynAccessor(82238)
            skillFirefighting = DynAccessor(82239)
            skillIntuition = DynAccessor(82240)
            skillJackOfAllTrades = DynAccessor(82241)
            skillMentor = DynAccessor(82242)
            skillOffRoadDriving = DynAccessor(82243)
            skillPreventativeMaintenance = DynAccessor(82244)
            skillRelaying = DynAccessor(82245)
            skillRepairs = DynAccessor(82246)
            skillSafeStowage = DynAccessor(82247)
            skillSignalBoosting = DynAccessor(82248)
            skillSituationalAwareness = DynAccessor(82249)
            skillSixthSense = DynAccessor(82250)
            skillSmoothRide = DynAccessor(82251)
            skillSnapShot = DynAccessor(82252)
            skillSniper = DynAccessor(82253)
            skillSoundIntelligence = DynAccessor(82254)
            statConcealment = DynAccessor(82255)
            statFirepower = DynAccessor(82256)
            statMobility = DynAccessor(82257)
            statSpotting = DynAccessor(82258)
            statSurvivability = DynAccessor(82259)

        advancedHints = _advancedHints()

    animations = _animations()

    class _armory_yard(DynAccessor):
        __slots__ = ()
        ay_ep2_armour = DynAccessor(82260)
        ay_ep2_gun = DynAccessor(82261)
        ay_ep2_intro = DynAccessor(82262)
        ay_ep2_tracks = DynAccessor(82263)
        ay_ep2_turret = DynAccessor(82264)
        video_reward = DynAccessor(82265)
        video_reward_min = DynAccessor(82266)

    armory_yard = _armory_yard()

    class _battle_pass(DynAccessor):
        __slots__ = ()
        c_201292_2 = DynAccessor(82267)
        c_201292_3 = DynAccessor(82268)
        c_201292_4 = DynAccessor(82269)
        c_201548_2 = DynAccessor(82270)
        c_201548_3 = DynAccessor(82271)
        c_201548_4 = DynAccessor(82272)
        c_202316_2 = DynAccessor(82273)
        c_202316_3 = DynAccessor(82274)
        c_202316_4 = DynAccessor(82275)
        v_121_0 = DynAccessor(82276)
        v_121_2 = DynAccessor(82277)
        v_121_3 = DynAccessor(82278)
        v_121_4 = DynAccessor(82279)
        v_122_0 = DynAccessor(82280)
        v_122_2 = DynAccessor(82281)
        v_122_3 = DynAccessor(82282)
        v_122_4 = DynAccessor(82283)
        v_123_0 = DynAccessor(82284)
        v_123_2 = DynAccessor(82285)
        v_123_3 = DynAccessor(82286)
        v_123_4 = DynAccessor(82287)

    battle_pass = _battle_pass()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(82288)
        example_2 = DynAccessor(82289)

    development = _development()

    class _event_loot_boxes(DynAccessor):
        __slots__ = ()

        class _bd2023(DynAccessor):
            __slots__ = ()
            bronze = DynAccessor(82290)
            gold = DynAccessor(82291)
            silver = DynAccessor(82292)
            standart = DynAccessor(82293)

        bd2023 = _bd2023()

        class _hw2023(DynAccessor):
            __slots__ = ()
            silver = DynAccessor(82294)
            standart = DynAccessor(82295)

        hw2023 = _hw2023()

        class _mt_lootbox(DynAccessor):
            __slots__ = ()
            mtl_1_24 = DynAccessor(82296)

        mt_lootbox = _mt_lootbox()

    event_loot_boxes = _event_loot_boxes()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(82297)

    platoon = _platoon()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(82298)

    vehicle = _vehicle()