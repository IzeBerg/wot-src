from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(90818)
    _bootcampLesson2 = DynAccessor(90819)
    _bootcampLesson3_1 = DynAccessor(90820)
    _bootcampLesson3_2 = DynAccessor(90821)
    _bootcampLesson4 = DynAccessor(90822)
    _bootcampOutro = DynAccessor(90823)
    _tutorialInitial = DynAccessor(90824)
    _tutorialInitialLoop = DynAccessor(90825)

    class _achievements(DynAccessor):
        __slots__ = ()
        particles = DynAccessor(90826)
        up_particles = DynAccessor(90827)

    achievements = _achievements()

    class _animations(DynAccessor):
        __slots__ = ()

        class _advancedHints(DynAccessor):
            __slots__ = ()
            abilityPreview = DynAccessor(90828)
            crewCommander = DynAccessor(90829)
            crewDriver = DynAccessor(90830)
            crewGunner = DynAccessor(90831)
            crewLoader = DynAccessor(90832)
            crewRadioOperator = DynAccessor(90833)
            skillAdrenalineRush = DynAccessor(90834)
            skillArmorer = DynAccessor(90835)
            skillArtLamp = DynAccessor(90836)
            skillBrothersInArms = DynAccessor(90837)
            skillCallForVengeance = DynAccessor(90838)
            skillClutchBraking = DynAccessor(90839)
            skillCommanderBonus = DynAccessor(90840)
            skillConcealment = DynAccessor(90841)
            skillControlledImpact = DynAccessor(90842)
            skillDeadEye = DynAccessor(90843)
            skillDesignatedTarget = DynAccessor(90844)
            skillEagleEye = DynAccessor(90845)
            skillExpert = DynAccessor(90846)
            skillFirefighting = DynAccessor(90847)
            skillIntuition = DynAccessor(90848)
            skillJackOfAllTrades = DynAccessor(90849)
            skillMentor = DynAccessor(90850)
            skillOffRoadDriving = DynAccessor(90851)
            skillPreventativeMaintenance = DynAccessor(90852)
            skillRelaying = DynAccessor(90853)
            skillRepairs = DynAccessor(90854)
            skillSafeStowage = DynAccessor(90855)
            skillSignalBoosting = DynAccessor(90856)
            skillSituationalAwareness = DynAccessor(90857)
            skillSixthSense = DynAccessor(90858)
            skillSmoothRide = DynAccessor(90859)
            skillSnapShot = DynAccessor(90860)
            skillSniper = DynAccessor(90861)
            skillSoundIntelligence = DynAccessor(90862)
            statConcealment = DynAccessor(90863)
            statFirepower = DynAccessor(90864)
            statMobility = DynAccessor(90865)
            statSpotting = DynAccessor(90866)
            statSurvivability = DynAccessor(90867)

        advancedHints = _advancedHints()

    animations = _animations()

    class _armory_yard(DynAccessor):
        __slots__ = ()
        ay_armour = DynAccessor(90868)
        ay_gun = DynAccessor(90869)
        ay_tracks = DynAccessor(90870)
        ay_turret = DynAccessor(90871)
        video_reward = DynAccessor(90872)
        video_reward_min = DynAccessor(90873)

    armory_yard = _armory_yard()

    class _battle_pass(DynAccessor):
        __slots__ = ()
        c_201292_2 = DynAccessor(90874)
        c_201292_3 = DynAccessor(90875)
        c_201292_4 = DynAccessor(90876)
        c_201548_2 = DynAccessor(90877)
        c_201548_3 = DynAccessor(90878)
        c_201548_4 = DynAccessor(90879)
        c_202316_2 = DynAccessor(90880)
        c_202316_3 = DynAccessor(90881)
        c_202316_4 = DynAccessor(90882)
        v_151_0 = DynAccessor(90883)
        v_152_0 = DynAccessor(90884)
        v_153_0 = DynAccessor(90885)

    battle_pass = _battle_pass()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(90886)
        example_2 = DynAccessor(90887)
        example_3 = DynAccessor(90888)

    development = _development()

    class _event_loot_boxes(DynAccessor):
        __slots__ = ()
        lootbox_prem = DynAccessor(90889)

        class _bd2023(DynAccessor):
            __slots__ = ()
            bronze = DynAccessor(90890)
            gold = DynAccessor(90891)
            silver = DynAccessor(90892)
            standart = DynAccessor(90893)

        bd2023 = _bd2023()

        class _bd2024(DynAccessor):
            __slots__ = ()
            lootbox = DynAccessor(90894)

        bd2024 = _bd2024()

        class _cosmic2024(DynAccessor):
            __slots__ = ()
            silver = DynAccessor(90895)
            standart = DynAccessor(90896)

        cosmic2024 = _cosmic2024()

        class _hw2023(DynAccessor):
            __slots__ = ()
            silver = DynAccessor(90897)
            standart = DynAccessor(90898)

        hw2023 = _hw2023()

        class _mt_lootbox(DynAccessor):
            __slots__ = ()
            mtl_1_24 = DynAccessor(90899)
            mt_drops = DynAccessor(90900)

        mt_lootbox = _mt_lootbox()

        class _rp_2024(DynAccessor):
            __slots__ = ()
            large = DynAccessor(90901)
            medium = DynAccessor(90902)
            small = DynAccessor(90903)

        rp_2024 = _rp_2024()

    event_loot_boxes = _event_loot_boxes()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(90904)

    platoon = _platoon()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(90905)

    vehicle = _vehicle()

    class _wt_event(DynAccessor):
        __slots__ = ()
        boss_portal_idle = DynAccessor(90906)
        boss_portal_open = DynAccessor(90907)
        boss_tank_portal_idle = DynAccessor(90908)
        boss_tank_portal_show = DynAccessor(90909)
        hunter_portal_idle = DynAccessor(90910)
        hunter_portal_open = DynAccessor(90911)
        main_tank_portal_idle = DynAccessor(90912)
        main_tank_portal_show = DynAccessor(90913)
        primary_tank_portal_idle = DynAccessor(90914)
        primary_tank_portal_show = DynAccessor(90915)
        secondary_tank_portal_idle = DynAccessor(90916)
        secondary_tank_portal_show = DynAccessor(90917)
        wt_intro = DynAccessor(90918)
        wt_outro = DynAccessor(90919)

    wt_event = _wt_event()