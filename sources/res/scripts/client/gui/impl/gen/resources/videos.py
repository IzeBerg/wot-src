from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(76956)
    _bootcampLesson2 = DynAccessor(76957)
    _bootcampLesson3_1 = DynAccessor(76958)
    _bootcampLesson3_2 = DynAccessor(76959)
    _bootcampLesson4 = DynAccessor(76960)
    _bootcampOutro = DynAccessor(76961)
    _tutorialInitial = DynAccessor(76962)
    _tutorialInitialLoop = DynAccessor(76963)

    class _achievements(DynAccessor):
        __slots__ = ()
        particles = DynAccessor(76964)
        up_particles = DynAccessor(76965)

    achievements = _achievements()

    class _animations(DynAccessor):
        __slots__ = ()

        class _advancedHints(DynAccessor):
            __slots__ = ()
            skillAdrenalineRush = DynAccessor(76966)
            skillArmorer = DynAccessor(76967)
            skillArtLamp = DynAccessor(76968)
            skillBrothersInArms = DynAccessor(76969)
            skillCallForVengeance = DynAccessor(76970)
            skillClutchBraking = DynAccessor(76971)
            skillConcealment = DynAccessor(76972)
            skillControlledImpact = DynAccessor(76973)
            skillDeadEye = DynAccessor(76974)
            skillDesignatedTarget = DynAccessor(76975)
            skillEagleEye = DynAccessor(76976)
            skillExpert = DynAccessor(76977)
            skillFirefighting = DynAccessor(76978)
            skillIntuition = DynAccessor(76979)
            skillJackOfAllTrades = DynAccessor(76980)
            skillMentor = DynAccessor(76981)
            skillOffRoadDriving = DynAccessor(76982)
            skillPreventativeMaintenance = DynAccessor(76983)
            skillRelaying = DynAccessor(76984)
            skillRepairs = DynAccessor(76985)
            skillSafeStowage = DynAccessor(76986)
            skillSignalBoosting = DynAccessor(76987)
            skillSituationalAwareness = DynAccessor(76988)
            skillSixthSense = DynAccessor(76989)
            skillSmoothRide = DynAccessor(76990)
            skillSnapShot = DynAccessor(76991)
            skillSniper = DynAccessor(76992)
            skillSoundIntelligence = DynAccessor(76993)
            statConcealment = DynAccessor(76994)
            statFirepower = DynAccessor(76995)
            statMobility = DynAccessor(76996)
            statSpotting = DynAccessor(76997)
            statSurvivability = DynAccessor(76998)

        advancedHints = _advancedHints()

    animations = _animations()

    class _armory_yard(DynAccessor):
        __slots__ = ()
        ay_armour = DynAccessor(76999)
        ay_intro = DynAccessor(77000)
        ay_reward = DynAccessor(77001)
        ay_tracks = DynAccessor(77002)
        video_reward = DynAccessor(77003)
        video_reward_min = DynAccessor(77004)

    armory_yard = _armory_yard()

    class _battle_pass(DynAccessor):
        __slots__ = ()
        c_201292_2 = DynAccessor(77005)
        c_201292_3 = DynAccessor(77006)
        c_201292_4 = DynAccessor(77007)
        c_201548_2 = DynAccessor(77008)
        c_201548_3 = DynAccessor(77009)
        c_201548_4 = DynAccessor(77010)
        c_202316_2 = DynAccessor(77011)
        c_202316_3 = DynAccessor(77012)
        c_202316_4 = DynAccessor(77013)

    battle_pass = _battle_pass()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(77014)
        example_2 = DynAccessor(77015)

    development = _development()

    class _event_loot_boxes(DynAccessor):
        __slots__ = ()
        lootbox_prem = DynAccessor(77016)

        class _bd2023(DynAccessor):
            __slots__ = ()
            bronze = DynAccessor(77017)
            gold = DynAccessor(77018)
            silver = DynAccessor(77019)
            standart = DynAccessor(77020)

        bd2023 = _bd2023()

    event_loot_boxes = _event_loot_boxes()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(77021)

    platoon = _platoon()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(77022)

    vehicle = _vehicle()