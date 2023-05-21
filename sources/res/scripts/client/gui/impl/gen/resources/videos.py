from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(75831)
    _bootcampLesson2 = DynAccessor(75832)
    _bootcampLesson3_1 = DynAccessor(75833)
    _bootcampLesson3_2 = DynAccessor(75834)
    _bootcampLesson4 = DynAccessor(75835)
    _bootcampOutro = DynAccessor(75836)
    _tutorialInitial = DynAccessor(75837)
    _tutorialInitialLoop = DynAccessor(75838)

    class _achievements(DynAccessor):
        __slots__ = ()
        particles = DynAccessor(75839)
        up_particles = DynAccessor(75840)

    achievements = _achievements()

    class _animations(DynAccessor):
        __slots__ = ()

        class _advancedHints(DynAccessor):
            __slots__ = ()
            skillAdrenalineRush = DynAccessor(75841)
            skillArmorer = DynAccessor(75842)
            skillArtLamp = DynAccessor(75843)
            skillBrothersInArms = DynAccessor(75844)
            skillCallForVengeance = DynAccessor(75845)
            skillClutchBraking = DynAccessor(75846)
            skillConcealment = DynAccessor(75847)
            skillControlledImpact = DynAccessor(75848)
            skillDeadEye = DynAccessor(75849)
            skillDesignatedTarget = DynAccessor(75850)
            skillEagleEye = DynAccessor(75851)
            skillExpert = DynAccessor(75852)
            skillFirefighting = DynAccessor(75853)
            skillIntuition = DynAccessor(75854)
            skillJackOfAllTrades = DynAccessor(75855)
            skillMentor = DynAccessor(75856)
            skillOffRoadDriving = DynAccessor(75857)
            skillPreventativeMaintenance = DynAccessor(75858)
            skillRelaying = DynAccessor(75859)
            skillRepairs = DynAccessor(75860)
            skillSafeStowage = DynAccessor(75861)
            skillSignalBoosting = DynAccessor(75862)
            skillSituationalAwareness = DynAccessor(75863)
            skillSixthSense = DynAccessor(75864)
            skillSmoothRide = DynAccessor(75865)
            skillSnapShot = DynAccessor(75866)
            skillSniper = DynAccessor(75867)
            skillSoundIntelligence = DynAccessor(75868)
            statConcealment = DynAccessor(75869)
            statFirepower = DynAccessor(75870)
            statMobility = DynAccessor(75871)
            statSpotting = DynAccessor(75872)
            statSurvivability = DynAccessor(75873)

        advancedHints = _advancedHints()

    animations = _animations()

    class _armory_yard(DynAccessor):
        __slots__ = ()
        ay_armour = DynAccessor(75874)
        ay_intro = DynAccessor(75875)
        ay_reward = DynAccessor(75876)
        ay_tracks = DynAccessor(75877)
        video_reward = DynAccessor(75878)
        video_reward_min = DynAccessor(75879)

    armory_yard = _armory_yard()

    class _battle_pass(DynAccessor):
        __slots__ = ()
        c_201292_2 = DynAccessor(75880)
        c_201292_3 = DynAccessor(75881)
        c_201292_4 = DynAccessor(75882)
        c_201548_2 = DynAccessor(75883)
        c_201548_3 = DynAccessor(75884)
        c_201548_4 = DynAccessor(75885)
        c_202316_2 = DynAccessor(75886)
        c_202316_3 = DynAccessor(75887)
        c_202316_4 = DynAccessor(75888)

    battle_pass = _battle_pass()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(75889)
        example_2 = DynAccessor(75890)

    development = _development()

    class _event_loot_boxes(DynAccessor):
        __slots__ = ()
        lootbox_prem = DynAccessor(75891)

    event_loot_boxes = _event_loot_boxes()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(75892)

    platoon = _platoon()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(75893)

    vehicle = _vehicle()