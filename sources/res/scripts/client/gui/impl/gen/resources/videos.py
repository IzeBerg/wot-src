from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(90828)
    _bootcampLesson2 = DynAccessor(90829)
    _bootcampLesson3_1 = DynAccessor(90830)
    _bootcampLesson3_2 = DynAccessor(90831)
    _bootcampLesson4 = DynAccessor(90832)
    _bootcampOutro = DynAccessor(90833)
    _tutorialInitial = DynAccessor(90834)
    _tutorialInitialLoop = DynAccessor(90835)

    class _achievements(DynAccessor):
        __slots__ = ()
        particles = DynAccessor(90836)
        up_particles = DynAccessor(90837)

    achievements = _achievements()

    class _animations(DynAccessor):
        __slots__ = ()

        class _advancedHints(DynAccessor):
            __slots__ = ()
            abilityPreview = DynAccessor(90838)
            crewCommander = DynAccessor(90839)
            crewDriver = DynAccessor(90840)
            crewGunner = DynAccessor(90841)
            crewLoader = DynAccessor(90842)
            crewRadioOperator = DynAccessor(90843)
            skillAdrenalineRush = DynAccessor(90844)
            skillArmorer = DynAccessor(90845)
            skillArtLamp = DynAccessor(90846)
            skillBrothersInArms = DynAccessor(90847)
            skillCallForVengeance = DynAccessor(90848)
            skillClutchBraking = DynAccessor(90849)
            skillCommanderBonus = DynAccessor(90850)
            skillConcealment = DynAccessor(90851)
            skillControlledImpact = DynAccessor(90852)
            skillDeadEye = DynAccessor(90853)
            skillDesignatedTarget = DynAccessor(90854)
            skillEagleEye = DynAccessor(90855)
            skillExpert = DynAccessor(90856)
            skillFirefighting = DynAccessor(90857)
            skillIntuition = DynAccessor(90858)
            skillJackOfAllTrades = DynAccessor(90859)
            skillMentor = DynAccessor(90860)
            skillOffRoadDriving = DynAccessor(90861)
            skillPreventativeMaintenance = DynAccessor(90862)
            skillRelaying = DynAccessor(90863)
            skillRepairs = DynAccessor(90864)
            skillSafeStowage = DynAccessor(90865)
            skillSignalBoosting = DynAccessor(90866)
            skillSituationalAwareness = DynAccessor(90867)
            skillSixthSense = DynAccessor(90868)
            skillSmoothRide = DynAccessor(90869)
            skillSnapShot = DynAccessor(90870)
            skillSniper = DynAccessor(90871)
            skillSoundIntelligence = DynAccessor(90872)
            statConcealment = DynAccessor(90873)
            statFirepower = DynAccessor(90874)
            statMobility = DynAccessor(90875)
            statSpotting = DynAccessor(90876)
            statSurvivability = DynAccessor(90877)

        advancedHints = _advancedHints()

    animations = _animations()

    class _armory_yard(DynAccessor):
        __slots__ = ()
        ay_armour = DynAccessor(90878)
        ay_gun = DynAccessor(90879)
        ay_tracks = DynAccessor(90880)
        ay_turret = DynAccessor(90881)
        video_reward = DynAccessor(90882)
        video_reward_min = DynAccessor(90883)

    armory_yard = _armory_yard()

    class _battle_pass(DynAccessor):
        __slots__ = ()
        c_201292_2 = DynAccessor(90884)
        c_201292_3 = DynAccessor(90885)
        c_201292_4 = DynAccessor(90886)
        c_201548_2 = DynAccessor(90887)
        c_201548_3 = DynAccessor(90888)
        c_201548_4 = DynAccessor(90889)
        c_202316_2 = DynAccessor(90890)
        c_202316_3 = DynAccessor(90891)
        c_202316_4 = DynAccessor(90892)
        v_151_0 = DynAccessor(90893)
        v_152_0 = DynAccessor(90894)
        v_153_0 = DynAccessor(90895)

    battle_pass = _battle_pass()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(90896)
        example_2 = DynAccessor(90897)
        example_3 = DynAccessor(90898)

    development = _development()

    class _event_loot_boxes(DynAccessor):
        __slots__ = ()
        lootbox_prem = DynAccessor(90899)

        class _bd2023(DynAccessor):
            __slots__ = ()
            bronze = DynAccessor(90900)
            gold = DynAccessor(90901)
            silver = DynAccessor(90902)
            standart = DynAccessor(90903)

        bd2023 = _bd2023()

        class _bd2024(DynAccessor):
            __slots__ = ()
            lootbox = DynAccessor(90904)

        bd2024 = _bd2024()

        class _cosmic2024(DynAccessor):
            __slots__ = ()
            silver = DynAccessor(90905)
            standart = DynAccessor(90906)

        cosmic2024 = _cosmic2024()

        class _hw2023(DynAccessor):
            __slots__ = ()
            silver = DynAccessor(90907)
            standart = DynAccessor(90908)

        hw2023 = _hw2023()

        class _mt_lootbox(DynAccessor):
            __slots__ = ()
            mtl_1_24 = DynAccessor(90909)
            mt_drops = DynAccessor(90910)

        mt_lootbox = _mt_lootbox()

        class _rp_2024(DynAccessor):
            __slots__ = ()
            large = DynAccessor(90911)
            medium = DynAccessor(90912)
            small = DynAccessor(90913)

        rp_2024 = _rp_2024()

    event_loot_boxes = _event_loot_boxes()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(90914)

    platoon = _platoon()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(90915)

    vehicle = _vehicle()

    class _wt_event(DynAccessor):
        __slots__ = ()
        boss_portal_idle = DynAccessor(90916)
        boss_portal_open = DynAccessor(90917)
        boss_tank_portal_idle = DynAccessor(90918)
        boss_tank_portal_show = DynAccessor(90919)
        hunter_portal_idle = DynAccessor(90920)
        hunter_portal_open = DynAccessor(90921)
        main_tank_portal_idle = DynAccessor(90922)
        main_tank_portal_show = DynAccessor(90923)
        primary_tank_portal_idle = DynAccessor(90924)
        primary_tank_portal_show = DynAccessor(90925)
        secondary_tank_portal_idle = DynAccessor(90926)
        secondary_tank_portal_show = DynAccessor(90927)
        wt_intro = DynAccessor(90928)
        wt_outro = DynAccessor(90929)

    wt_event = _wt_event()