from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(76959)
    _bootcampLesson2 = DynAccessor(76960)
    _bootcampLesson3_1 = DynAccessor(76961)
    _bootcampLesson3_2 = DynAccessor(76962)
    _bootcampLesson4 = DynAccessor(76963)
    _bootcampOutro = DynAccessor(76964)
    _tutorialInitial = DynAccessor(76965)
    _tutorialInitialLoop = DynAccessor(76966)

    class _achievements(DynAccessor):
        __slots__ = ()
        particles = DynAccessor(76967)
        up_particles = DynAccessor(76968)

    achievements = _achievements()

    class _animations(DynAccessor):
        __slots__ = ()

        class _advancedHints(DynAccessor):
            __slots__ = ()
            skillAdrenalineRush = DynAccessor(76969)
            skillArmorer = DynAccessor(76970)
            skillArtLamp = DynAccessor(76971)
            skillBrothersInArms = DynAccessor(76972)
            skillCallForVengeance = DynAccessor(76973)
            skillClutchBraking = DynAccessor(76974)
            skillConcealment = DynAccessor(76975)
            skillControlledImpact = DynAccessor(76976)
            skillDeadEye = DynAccessor(76977)
            skillDesignatedTarget = DynAccessor(76978)
            skillEagleEye = DynAccessor(76979)
            skillExpert = DynAccessor(76980)
            skillFirefighting = DynAccessor(76981)
            skillIntuition = DynAccessor(76982)
            skillJackOfAllTrades = DynAccessor(76983)
            skillMentor = DynAccessor(76984)
            skillOffRoadDriving = DynAccessor(76985)
            skillPreventativeMaintenance = DynAccessor(76986)
            skillRelaying = DynAccessor(76987)
            skillRepairs = DynAccessor(76988)
            skillSafeStowage = DynAccessor(76989)
            skillSignalBoosting = DynAccessor(76990)
            skillSituationalAwareness = DynAccessor(76991)
            skillSixthSense = DynAccessor(76992)
            skillSmoothRide = DynAccessor(76993)
            skillSnapShot = DynAccessor(76994)
            skillSniper = DynAccessor(76995)
            skillSoundIntelligence = DynAccessor(76996)
            statConcealment = DynAccessor(76997)
            statFirepower = DynAccessor(76998)
            statMobility = DynAccessor(76999)
            statSpotting = DynAccessor(77000)
            statSurvivability = DynAccessor(77001)

        advancedHints = _advancedHints()

    animations = _animations()

    class _armory_yard(DynAccessor):
        __slots__ = ()
        ay_armour = DynAccessor(77002)
        ay_intro = DynAccessor(77003)
        ay_reward = DynAccessor(77004)
        ay_tracks = DynAccessor(77005)
        video_reward = DynAccessor(77006)
        video_reward_min = DynAccessor(77007)

    armory_yard = _armory_yard()

    class _battle_pass(DynAccessor):
        __slots__ = ()
        c_201292_2 = DynAccessor(77008)
        c_201292_3 = DynAccessor(77009)
        c_201292_4 = DynAccessor(77010)
        c_201548_2 = DynAccessor(77011)
        c_201548_3 = DynAccessor(77012)
        c_201548_4 = DynAccessor(77013)
        c_202316_2 = DynAccessor(77014)
        c_202316_3 = DynAccessor(77015)
        c_202316_4 = DynAccessor(77016)

    battle_pass = _battle_pass()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(77017)
        example_2 = DynAccessor(77018)

    development = _development()

    class _event_loot_boxes(DynAccessor):
        __slots__ = ()
        lootbox_prem = DynAccessor(77019)

        class _bd2023(DynAccessor):
            __slots__ = ()
            bronze = DynAccessor(77020)
            gold = DynAccessor(77021)
            silver = DynAccessor(77022)
            standart = DynAccessor(77023)

        bd2023 = _bd2023()

    event_loot_boxes = _event_loot_boxes()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(77024)

    platoon = _platoon()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(77025)

    vehicle = _vehicle()