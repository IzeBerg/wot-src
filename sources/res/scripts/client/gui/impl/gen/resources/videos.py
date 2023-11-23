from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(92117)
    _bootcampLesson2 = DynAccessor(92118)
    _bootcampLesson3_1 = DynAccessor(92119)
    _bootcampLesson3_2 = DynAccessor(92120)
    _bootcampLesson4 = DynAccessor(92121)
    _bootcampOutro = DynAccessor(92122)
    _tutorialInitial = DynAccessor(92123)
    _tutorialInitialLoop = DynAccessor(92124)

    class _achievements(DynAccessor):
        __slots__ = ()
        particles = DynAccessor(92125)
        up_particles = DynAccessor(92126)

    achievements = _achievements()

    class _animations(DynAccessor):
        __slots__ = ()

        class _advancedHints(DynAccessor):
            __slots__ = ()
            crewCommander = DynAccessor(92127)
            crewDriver = DynAccessor(92128)
            crewGunner = DynAccessor(92129)
            crewLoader = DynAccessor(92130)
            crewRadioOperator = DynAccessor(92131)
            skillAdrenalineRush = DynAccessor(92132)
            skillArmorer = DynAccessor(92133)
            skillArtLamp = DynAccessor(92134)
            skillBrothersInArms = DynAccessor(92135)
            skillCallForVengeance = DynAccessor(92136)
            skillClutchBraking = DynAccessor(92137)
            skillCommanderBonus = DynAccessor(92138)
            skillConcealment = DynAccessor(92139)
            skillControlledImpact = DynAccessor(92140)
            skillDeadEye = DynAccessor(92141)
            skillDesignatedTarget = DynAccessor(92142)
            skillEagleEye = DynAccessor(92143)
            skillExpert = DynAccessor(92144)
            skillFirefighting = DynAccessor(92145)
            skillIntuition = DynAccessor(92146)
            skillJackOfAllTrades = DynAccessor(92147)
            skillMentor = DynAccessor(92148)
            skillOffRoadDriving = DynAccessor(92149)
            skillPreventativeMaintenance = DynAccessor(92150)
            skillRelaying = DynAccessor(92151)
            skillRepairs = DynAccessor(92152)
            skillSafeStowage = DynAccessor(92153)
            skillSignalBoosting = DynAccessor(92154)
            skillSituationalAwareness = DynAccessor(92155)
            skillSixthSense = DynAccessor(92156)
            skillSmoothRide = DynAccessor(92157)
            skillSnapShot = DynAccessor(92158)
            skillSniper = DynAccessor(92159)
            skillSoundIntelligence = DynAccessor(92160)
            statConcealment = DynAccessor(92161)
            statFirepower = DynAccessor(92162)
            statMobility = DynAccessor(92163)
            statSpotting = DynAccessor(92164)
            statSurvivability = DynAccessor(92165)

        advancedHints = _advancedHints()

    animations = _animations()

    class _armory_yard(DynAccessor):
        __slots__ = ()
        ay_ep2_armour = DynAccessor(92166)
        ay_ep2_gun = DynAccessor(92167)
        ay_ep2_intro = DynAccessor(92168)
        ay_ep2_tracks = DynAccessor(92169)
        ay_ep2_turret = DynAccessor(92170)
        video_reward = DynAccessor(92171)
        video_reward_min = DynAccessor(92172)

    armory_yard = _armory_yard()

    class _battle_pass(DynAccessor):
        __slots__ = ()
        c_201292_2 = DynAccessor(92173)
        c_201292_3 = DynAccessor(92174)
        c_201292_4 = DynAccessor(92175)
        c_201548_2 = DynAccessor(92176)
        c_201548_3 = DynAccessor(92177)
        c_201548_4 = DynAccessor(92178)
        c_202316_2 = DynAccessor(92179)
        c_202316_3 = DynAccessor(92180)
        c_202316_4 = DynAccessor(92181)
        v_121_0 = DynAccessor(92182)
        v_121_2 = DynAccessor(92183)
        v_121_3 = DynAccessor(92184)
        v_121_4 = DynAccessor(92185)
        v_122_0 = DynAccessor(92186)
        v_122_2 = DynAccessor(92187)
        v_122_3 = DynAccessor(92188)
        v_122_4 = DynAccessor(92189)
        v_123_0 = DynAccessor(92190)
        v_123_2 = DynAccessor(92191)
        v_123_3 = DynAccessor(92192)
        v_123_4 = DynAccessor(92193)

    battle_pass = _battle_pass()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(92194)
        example_2 = DynAccessor(92195)

    development = _development()

    class _event_loot_boxes(DynAccessor):
        __slots__ = ()
        lootbox_prem = DynAccessor(92196)

        class _bd2023(DynAccessor):
            __slots__ = ()
            bronze = DynAccessor(92197)
            gold = DynAccessor(92198)
            silver = DynAccessor(92199)
            standart = DynAccessor(92200)

        bd2023 = _bd2023()

        class _hw2023(DynAccessor):
            __slots__ = ()
            silver = DynAccessor(92201)
            standart = DynAccessor(92202)

        hw2023 = _hw2023()

        class _ny2024(DynAccessor):
            __slots__ = ()
            china = DynAccessor(92203)
            magic = DynAccessor(92204)
            standart = DynAccessor(92205)
            ussr = DynAccessor(92206)
            xmas = DynAccessor(92207)

        ny2024 = _ny2024()

    event_loot_boxes = _event_loot_boxes()

    class _new_year(DynAccessor):
        __slots__ = ()
        ng_startup = DynAccessor(92208)

    new_year = _new_year()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(92209)

    platoon = _platoon()

    class _VehicleLootBoxCongrats(DynAccessor):
        __slots__ = ()
        A33_MTLS_1G14 = DynAccessor(92210)
        A93_T7_Combat_Car = DynAccessor(92211)
        Ch01_Type59_Gold = DynAccessor(92212)
        F27_FCM_36Pak40 = DynAccessor(92213)
        G36_PzII_J = DynAccessor(92214)
        GB68_Matilda_Black_Prince = DynAccessor(92215)
        intro = DynAccessor(92216)
        R118_T28_F30 = DynAccessor(92217)
        R34_BT_SV = DynAccessor(92218)

    VehicleLootBoxCongrats = _VehicleLootBoxCongrats()