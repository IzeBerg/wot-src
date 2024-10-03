from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(90806)
    _bootcampLesson2 = DynAccessor(90807)
    _bootcampLesson3_1 = DynAccessor(90808)
    _bootcampLesson3_2 = DynAccessor(90809)
    _bootcampLesson4 = DynAccessor(90810)
    _bootcampOutro = DynAccessor(90811)
    _tutorialInitial = DynAccessor(90812)
    _tutorialInitialLoop = DynAccessor(90813)

    class _achievements(DynAccessor):
        __slots__ = ()
        particles = DynAccessor(90814)
        up_particles = DynAccessor(90815)

    achievements = _achievements()

    class _animations(DynAccessor):
        __slots__ = ()

        class _advancedHints(DynAccessor):
            __slots__ = ()
            abilityPreview = DynAccessor(90816)
            crewCommander = DynAccessor(90817)
            crewDriver = DynAccessor(90818)
            crewGunner = DynAccessor(90819)
            crewLoader = DynAccessor(90820)
            crewRadioOperator = DynAccessor(90821)
            skillAdrenalineRush = DynAccessor(90822)
            skillArmorer = DynAccessor(90823)
            skillArtLamp = DynAccessor(90824)
            skillBrothersInArms = DynAccessor(90825)
            skillCallForVengeance = DynAccessor(90826)
            skillClutchBraking = DynAccessor(90827)
            skillCommanderBonus = DynAccessor(90828)
            skillConcealment = DynAccessor(90829)
            skillControlledImpact = DynAccessor(90830)
            skillDeadEye = DynAccessor(90831)
            skillDesignatedTarget = DynAccessor(90832)
            skillEagleEye = DynAccessor(90833)
            skillExpert = DynAccessor(90834)
            skillFirefighting = DynAccessor(90835)
            skillIntuition = DynAccessor(90836)
            skillJackOfAllTrades = DynAccessor(90837)
            skillMentor = DynAccessor(90838)
            skillOffRoadDriving = DynAccessor(90839)
            skillPreventativeMaintenance = DynAccessor(90840)
            skillRelaying = DynAccessor(90841)
            skillRepairs = DynAccessor(90842)
            skillSafeStowage = DynAccessor(90843)
            skillSignalBoosting = DynAccessor(90844)
            skillSituationalAwareness = DynAccessor(90845)
            skillSixthSense = DynAccessor(90846)
            skillSmoothRide = DynAccessor(90847)
            skillSnapShot = DynAccessor(90848)
            skillSniper = DynAccessor(90849)
            skillSoundIntelligence = DynAccessor(90850)
            statConcealment = DynAccessor(90851)
            statFirepower = DynAccessor(90852)
            statMobility = DynAccessor(90853)
            statSpotting = DynAccessor(90854)
            statSurvivability = DynAccessor(90855)

        advancedHints = _advancedHints()

    animations = _animations()

    class _armory_yard(DynAccessor):
        __slots__ = ()
        ay_armour = DynAccessor(90856)
        ay_gun = DynAccessor(90857)
        ay_tracks = DynAccessor(90858)
        ay_turret = DynAccessor(90859)
        video_reward = DynAccessor(90860)
        video_reward_min = DynAccessor(90861)

    armory_yard = _armory_yard()

    class _battle_pass(DynAccessor):
        __slots__ = ()
        c_201292_2 = DynAccessor(90862)
        c_201292_3 = DynAccessor(90863)
        c_201292_4 = DynAccessor(90864)
        c_201548_2 = DynAccessor(90865)
        c_201548_3 = DynAccessor(90866)
        c_201548_4 = DynAccessor(90867)
        c_202316_2 = DynAccessor(90868)
        c_202316_3 = DynAccessor(90869)
        c_202316_4 = DynAccessor(90870)
        v_151_0 = DynAccessor(90871)
        v_152_0 = DynAccessor(90872)
        v_153_0 = DynAccessor(90873)

    battle_pass = _battle_pass()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(90874)
        example_2 = DynAccessor(90875)
        example_3 = DynAccessor(90876)

    development = _development()

    class _event_loot_boxes(DynAccessor):
        __slots__ = ()
        lootbox_prem = DynAccessor(90877)

        class _bd2023(DynAccessor):
            __slots__ = ()
            bronze = DynAccessor(90878)
            gold = DynAccessor(90879)
            silver = DynAccessor(90880)
            standart = DynAccessor(90881)

        bd2023 = _bd2023()

        class _bd2024(DynAccessor):
            __slots__ = ()
            lootbox = DynAccessor(90882)

        bd2024 = _bd2024()

        class _cosmic2024(DynAccessor):
            __slots__ = ()
            silver = DynAccessor(90883)
            standart = DynAccessor(90884)

        cosmic2024 = _cosmic2024()

        class _hw2023(DynAccessor):
            __slots__ = ()
            silver = DynAccessor(90885)
            standart = DynAccessor(90886)

        hw2023 = _hw2023()

        class _mt_lootbox(DynAccessor):
            __slots__ = ()
            mtl_1_24 = DynAccessor(90887)
            mt_drops = DynAccessor(90888)

        mt_lootbox = _mt_lootbox()

        class _rp_2024(DynAccessor):
            __slots__ = ()
            large = DynAccessor(90889)
            medium = DynAccessor(90890)
            small = DynAccessor(90891)

        rp_2024 = _rp_2024()

    event_loot_boxes = _event_loot_boxes()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(90892)

    platoon = _platoon()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(90893)

    vehicle = _vehicle()

    class _wt_event(DynAccessor):
        __slots__ = ()
        boss_portal_idle = DynAccessor(90894)
        boss_portal_open = DynAccessor(90895)
        boss_tank_portal_idle = DynAccessor(90896)
        boss_tank_portal_show = DynAccessor(90897)
        hunter_portal_idle = DynAccessor(90898)
        hunter_portal_open = DynAccessor(90899)
        main_tank_portal_idle = DynAccessor(90900)
        main_tank_portal_show = DynAccessor(90901)
        primary_tank_portal_idle = DynAccessor(90902)
        primary_tank_portal_show = DynAccessor(90903)
        secondary_tank_portal_idle = DynAccessor(90904)
        secondary_tank_portal_show = DynAccessor(90905)
        wt_intro = DynAccessor(90906)
        wt_outro = DynAccessor(90907)

    wt_event = _wt_event()