from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(82212)
    _bootcampLesson2 = DynAccessor(82213)
    _bootcampLesson3_1 = DynAccessor(82214)
    _bootcampLesson3_2 = DynAccessor(82215)
    _bootcampLesson4 = DynAccessor(82216)
    _bootcampOutro = DynAccessor(82217)
    _tutorialInitial = DynAccessor(82218)
    _tutorialInitialLoop = DynAccessor(82219)

    class _achievements(DynAccessor):
        __slots__ = ()
        particles = DynAccessor(82220)
        up_particles = DynAccessor(82221)

    achievements = _achievements()

    class _animations(DynAccessor):
        __slots__ = ()

        class _advancedHints(DynAccessor):
            __slots__ = ()
            crewCommander = DynAccessor(82222)
            crewDriver = DynAccessor(82223)
            crewGunner = DynAccessor(82224)
            crewLoader = DynAccessor(82225)
            crewRadioOperator = DynAccessor(82226)
            skillAdrenalineRush = DynAccessor(82227)
            skillArmorer = DynAccessor(82228)
            skillArtLamp = DynAccessor(82229)
            skillBrothersInArms = DynAccessor(82230)
            skillCallForVengeance = DynAccessor(82231)
            skillClutchBraking = DynAccessor(82232)
            skillCommanderBonus = DynAccessor(82233)
            skillConcealment = DynAccessor(82234)
            skillControlledImpact = DynAccessor(82235)
            skillDeadEye = DynAccessor(82236)
            skillDesignatedTarget = DynAccessor(82237)
            skillEagleEye = DynAccessor(82238)
            skillExpert = DynAccessor(82239)
            skillFirefighting = DynAccessor(82240)
            skillIntuition = DynAccessor(82241)
            skillJackOfAllTrades = DynAccessor(82242)
            skillMentor = DynAccessor(82243)
            skillOffRoadDriving = DynAccessor(82244)
            skillPreventativeMaintenance = DynAccessor(82245)
            skillRelaying = DynAccessor(82246)
            skillRepairs = DynAccessor(82247)
            skillSafeStowage = DynAccessor(82248)
            skillSignalBoosting = DynAccessor(82249)
            skillSituationalAwareness = DynAccessor(82250)
            skillSixthSense = DynAccessor(82251)
            skillSmoothRide = DynAccessor(82252)
            skillSnapShot = DynAccessor(82253)
            skillSniper = DynAccessor(82254)
            skillSoundIntelligence = DynAccessor(82255)
            statConcealment = DynAccessor(82256)
            statFirepower = DynAccessor(82257)
            statMobility = DynAccessor(82258)
            statSpotting = DynAccessor(82259)
            statSurvivability = DynAccessor(82260)

        advancedHints = _advancedHints()

    animations = _animations()

    class _armory_yard(DynAccessor):
        __slots__ = ()
        ay_ep2_armour = DynAccessor(82261)
        ay_ep2_gun = DynAccessor(82262)
        ay_ep2_intro = DynAccessor(82263)
        ay_ep2_tracks = DynAccessor(82264)
        ay_ep2_turret = DynAccessor(82265)
        video_reward = DynAccessor(82266)
        video_reward_min = DynAccessor(82267)

    armory_yard = _armory_yard()

    class _battle_pass(DynAccessor):
        __slots__ = ()
        c_201292_2 = DynAccessor(82268)
        c_201292_3 = DynAccessor(82269)
        c_201292_4 = DynAccessor(82270)
        c_201548_2 = DynAccessor(82271)
        c_201548_3 = DynAccessor(82272)
        c_201548_4 = DynAccessor(82273)
        c_202316_2 = DynAccessor(82274)
        c_202316_3 = DynAccessor(82275)
        c_202316_4 = DynAccessor(82276)
        v_121_0 = DynAccessor(82277)
        v_121_2 = DynAccessor(82278)
        v_121_3 = DynAccessor(82279)
        v_121_4 = DynAccessor(82280)
        v_122_0 = DynAccessor(82281)
        v_122_2 = DynAccessor(82282)
        v_122_3 = DynAccessor(82283)
        v_122_4 = DynAccessor(82284)
        v_123_0 = DynAccessor(82285)
        v_123_2 = DynAccessor(82286)
        v_123_3 = DynAccessor(82287)
        v_123_4 = DynAccessor(82288)

    battle_pass = _battle_pass()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(82289)
        example_2 = DynAccessor(82290)

    development = _development()

    class _event_loot_boxes(DynAccessor):
        __slots__ = ()

        class _bd2023(DynAccessor):
            __slots__ = ()
            bronze = DynAccessor(82291)
            gold = DynAccessor(82292)
            silver = DynAccessor(82293)
            standart = DynAccessor(82294)

        bd2023 = _bd2023()

        class _hw2023(DynAccessor):
            __slots__ = ()
            silver = DynAccessor(82295)
            standart = DynAccessor(82296)

        hw2023 = _hw2023()

        class _mt_lootbox(DynAccessor):
            __slots__ = ()
            mtl_1_24 = DynAccessor(82297)

        mt_lootbox = _mt_lootbox()

    event_loot_boxes = _event_loot_boxes()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(82298)

    platoon = _platoon()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(82299)

    vehicle = _vehicle()