from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(82131)
    _bootcampLesson2 = DynAccessor(82132)
    _bootcampLesson3_1 = DynAccessor(82133)
    _bootcampLesson3_2 = DynAccessor(82134)
    _bootcampLesson4 = DynAccessor(82135)
    _bootcampOutro = DynAccessor(82136)
    _tutorialInitial = DynAccessor(82137)
    _tutorialInitialLoop = DynAccessor(82138)

    class _achievements(DynAccessor):
        __slots__ = ()
        particles = DynAccessor(82139)
        up_particles = DynAccessor(82140)

    achievements = _achievements()

    class _animations(DynAccessor):
        __slots__ = ()

        class _advancedHints(DynAccessor):
            __slots__ = ()
            crewCommander = DynAccessor(82141)
            crewDriver = DynAccessor(82142)
            crewGunner = DynAccessor(82143)
            crewLoader = DynAccessor(82144)
            crewRadioOperator = DynAccessor(82145)
            skillAdrenalineRush = DynAccessor(82146)
            skillArmorer = DynAccessor(82147)
            skillArtLamp = DynAccessor(82148)
            skillBrothersInArms = DynAccessor(82149)
            skillCallForVengeance = DynAccessor(82150)
            skillClutchBraking = DynAccessor(82151)
            skillCommanderBonus = DynAccessor(82152)
            skillConcealment = DynAccessor(82153)
            skillControlledImpact = DynAccessor(82154)
            skillDeadEye = DynAccessor(82155)
            skillDesignatedTarget = DynAccessor(82156)
            skillEagleEye = DynAccessor(82157)
            skillExpert = DynAccessor(82158)
            skillFirefighting = DynAccessor(82159)
            skillIntuition = DynAccessor(82160)
            skillJackOfAllTrades = DynAccessor(82161)
            skillMentor = DynAccessor(82162)
            skillOffRoadDriving = DynAccessor(82163)
            skillPreventativeMaintenance = DynAccessor(82164)
            skillRelaying = DynAccessor(82165)
            skillRepairs = DynAccessor(82166)
            skillSafeStowage = DynAccessor(82167)
            skillSignalBoosting = DynAccessor(82168)
            skillSituationalAwareness = DynAccessor(82169)
            skillSixthSense = DynAccessor(82170)
            skillSmoothRide = DynAccessor(82171)
            skillSnapShot = DynAccessor(82172)
            skillSniper = DynAccessor(82173)
            skillSoundIntelligence = DynAccessor(82174)
            statConcealment = DynAccessor(82175)
            statFirepower = DynAccessor(82176)
            statMobility = DynAccessor(82177)
            statSpotting = DynAccessor(82178)
            statSurvivability = DynAccessor(82179)

        advancedHints = _advancedHints()

    animations = _animations()

    class _armory_yard(DynAccessor):
        __slots__ = ()
        ay_armour = DynAccessor(82180)
        ay_intro = DynAccessor(82181)
        ay_reward = DynAccessor(82182)
        ay_tracks = DynAccessor(82183)
        video_reward = DynAccessor(82184)
        video_reward_min = DynAccessor(82185)

    armory_yard = _armory_yard()

    class _battle_pass(DynAccessor):
        __slots__ = ()
        c_201292_2 = DynAccessor(82186)
        c_201292_3 = DynAccessor(82187)
        c_201292_4 = DynAccessor(82188)
        c_201548_2 = DynAccessor(82189)
        c_201548_3 = DynAccessor(82190)
        c_201548_4 = DynAccessor(82191)
        c_202316_2 = DynAccessor(82192)
        c_202316_3 = DynAccessor(82193)
        c_202316_4 = DynAccessor(82194)
        v_121_0 = DynAccessor(82195)
        v_121_2 = DynAccessor(82196)
        v_121_3 = DynAccessor(82197)
        v_121_4 = DynAccessor(82198)
        v_122_0 = DynAccessor(82199)
        v_122_2 = DynAccessor(82200)
        v_122_3 = DynAccessor(82201)
        v_122_4 = DynAccessor(82202)
        v_123_0 = DynAccessor(82203)
        v_123_2 = DynAccessor(82204)
        v_123_3 = DynAccessor(82205)
        v_123_4 = DynAccessor(82206)

    battle_pass = _battle_pass()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(82207)
        example_2 = DynAccessor(82208)

    development = _development()

    class _event_loot_boxes(DynAccessor):
        __slots__ = ()
        lootbox_prem = DynAccessor(82209)

        class _bd2023(DynAccessor):
            __slots__ = ()
            bronze = DynAccessor(82210)
            gold = DynAccessor(82211)
            silver = DynAccessor(82212)
            standart = DynAccessor(82213)

        bd2023 = _bd2023()

        class _hw2023(DynAccessor):
            __slots__ = ()
            silver = DynAccessor(82214)
            standart = DynAccessor(82215)

        hw2023 = _hw2023()

    event_loot_boxes = _event_loot_boxes()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(82216)

    platoon = _platoon()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(82217)

    vehicle = _vehicle()