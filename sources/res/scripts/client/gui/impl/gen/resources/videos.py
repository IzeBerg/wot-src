from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(86430)
    _bootcampLesson2 = DynAccessor(86431)
    _bootcampLesson3_1 = DynAccessor(86432)
    _bootcampLesson3_2 = DynAccessor(86433)
    _bootcampLesson4 = DynAccessor(86434)
    _bootcampOutro = DynAccessor(86435)
    _tutorialInitial = DynAccessor(86436)
    _tutorialInitialLoop = DynAccessor(86437)

    class _achievements(DynAccessor):
        __slots__ = ()
        particles = DynAccessor(86438)
        up_particles = DynAccessor(86439)

    achievements = _achievements()

    class _animations(DynAccessor):
        __slots__ = ()

        class _advancedHints(DynAccessor):
            __slots__ = ()
            crewCommander = DynAccessor(86440)
            crewDriver = DynAccessor(86441)
            crewGunner = DynAccessor(86442)
            crewLoader = DynAccessor(86443)
            crewRadioOperator = DynAccessor(86444)
            skillAdrenalineRush = DynAccessor(86445)
            skillArmorer = DynAccessor(86446)
            skillArtLamp = DynAccessor(86447)
            skillBrothersInArms = DynAccessor(86448)
            skillCallForVengeance = DynAccessor(86449)
            skillClutchBraking = DynAccessor(86450)
            skillCommanderBonus = DynAccessor(86451)
            skillConcealment = DynAccessor(86452)
            skillControlledImpact = DynAccessor(86453)
            skillDeadEye = DynAccessor(86454)
            skillDesignatedTarget = DynAccessor(86455)
            skillEagleEye = DynAccessor(86456)
            skillExpert = DynAccessor(86457)
            skillFirefighting = DynAccessor(86458)
            skillIntuition = DynAccessor(86459)
            skillJackOfAllTrades = DynAccessor(86460)
            skillMentor = DynAccessor(86461)
            skillOffRoadDriving = DynAccessor(86462)
            skillPreventativeMaintenance = DynAccessor(86463)
            skillRelaying = DynAccessor(86464)
            skillRepairs = DynAccessor(86465)
            skillSafeStowage = DynAccessor(86466)
            skillSignalBoosting = DynAccessor(86467)
            skillSituationalAwareness = DynAccessor(86468)
            skillSixthSense = DynAccessor(86469)
            skillSmoothRide = DynAccessor(86470)
            skillSnapShot = DynAccessor(86471)
            skillSniper = DynAccessor(86472)
            skillSoundIntelligence = DynAccessor(86473)
            statConcealment = DynAccessor(86474)
            statFirepower = DynAccessor(86475)
            statMobility = DynAccessor(86476)
            statSpotting = DynAccessor(86477)
            statSurvivability = DynAccessor(86478)

        advancedHints = _advancedHints()

    animations = _animations()

    class _armory_yard(DynAccessor):
        __slots__ = ()
        ay_ep3_armour = DynAccessor(86479)
        ay_ep3_gun = DynAccessor(86480)
        ay_ep3_tracks = DynAccessor(86481)
        ay_ep3_turret = DynAccessor(86482)
        video_reward = DynAccessor(86483)
        video_reward_min = DynAccessor(86484)

    armory_yard = _armory_yard()

    class _battle_pass(DynAccessor):
        __slots__ = ()
        c_201292_2 = DynAccessor(86485)
        c_201292_3 = DynAccessor(86486)
        c_201292_4 = DynAccessor(86487)
        c_201548_2 = DynAccessor(86488)
        c_201548_3 = DynAccessor(86489)
        c_201548_4 = DynAccessor(86490)
        c_202316_2 = DynAccessor(86491)
        c_202316_3 = DynAccessor(86492)
        c_202316_4 = DynAccessor(86493)
        v_141_0 = DynAccessor(86494)
        v_142_0 = DynAccessor(86495)
        v_143_0 = DynAccessor(86496)
        v_145_0 = DynAccessor(86497)

    battle_pass = _battle_pass()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(86498)
        example_2 = DynAccessor(86499)

    development = _development()

    class _event_loot_boxes(DynAccessor):
        __slots__ = ()

        class _bd2023(DynAccessor):
            __slots__ = ()
            bronze = DynAccessor(86500)
            gold = DynAccessor(86501)
            silver = DynAccessor(86502)
            standart = DynAccessor(86503)

        bd2023 = _bd2023()

        class _bd2024(DynAccessor):
            __slots__ = ()
            lootbox = DynAccessor(86504)

        bd2024 = _bd2024()

        class _cosmic2024(DynAccessor):
            __slots__ = ()
            silver = DynAccessor(86505)
            standart = DynAccessor(86506)

        cosmic2024 = _cosmic2024()

        class _hw2023(DynAccessor):
            __slots__ = ()
            silver = DynAccessor(86507)
            standart = DynAccessor(86508)

        hw2023 = _hw2023()

        class _mt_lootbox(DynAccessor):
            __slots__ = ()
            mtl_1_24 = DynAccessor(86509)
            mt_drops = DynAccessor(86510)

        mt_lootbox = _mt_lootbox()

        class _rp_2024(DynAccessor):
            __slots__ = ()
            large = DynAccessor(86511)
            medium = DynAccessor(86512)
            small = DynAccessor(86513)

        rp_2024 = _rp_2024()

    event_loot_boxes = _event_loot_boxes()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(86514)

    platoon = _platoon()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(86515)

    vehicle = _vehicle()