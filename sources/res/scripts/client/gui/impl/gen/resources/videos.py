from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(86455)
    _bootcampLesson2 = DynAccessor(86456)
    _bootcampLesson3_1 = DynAccessor(86457)
    _bootcampLesson3_2 = DynAccessor(86458)
    _bootcampLesson4 = DynAccessor(86459)
    _bootcampOutro = DynAccessor(86460)
    _tutorialInitial = DynAccessor(86461)
    _tutorialInitialLoop = DynAccessor(86462)

    class _achievements(DynAccessor):
        __slots__ = ()
        particles = DynAccessor(86463)
        up_particles = DynAccessor(86464)

    achievements = _achievements()

    class _animations(DynAccessor):
        __slots__ = ()

        class _advancedHints(DynAccessor):
            __slots__ = ()
            crewCommander = DynAccessor(86465)
            crewDriver = DynAccessor(86466)
            crewGunner = DynAccessor(86467)
            crewLoader = DynAccessor(86468)
            crewRadioOperator = DynAccessor(86469)
            skillAdrenalineRush = DynAccessor(86470)
            skillArmorer = DynAccessor(86471)
            skillArtLamp = DynAccessor(86472)
            skillBrothersInArms = DynAccessor(86473)
            skillCallForVengeance = DynAccessor(86474)
            skillClutchBraking = DynAccessor(86475)
            skillCommanderBonus = DynAccessor(86476)
            skillConcealment = DynAccessor(86477)
            skillControlledImpact = DynAccessor(86478)
            skillDeadEye = DynAccessor(86479)
            skillDesignatedTarget = DynAccessor(86480)
            skillEagleEye = DynAccessor(86481)
            skillExpert = DynAccessor(86482)
            skillFirefighting = DynAccessor(86483)
            skillIntuition = DynAccessor(86484)
            skillJackOfAllTrades = DynAccessor(86485)
            skillMentor = DynAccessor(86486)
            skillOffRoadDriving = DynAccessor(86487)
            skillPreventativeMaintenance = DynAccessor(86488)
            skillRelaying = DynAccessor(86489)
            skillRepairs = DynAccessor(86490)
            skillSafeStowage = DynAccessor(86491)
            skillSignalBoosting = DynAccessor(86492)
            skillSituationalAwareness = DynAccessor(86493)
            skillSixthSense = DynAccessor(86494)
            skillSmoothRide = DynAccessor(86495)
            skillSnapShot = DynAccessor(86496)
            skillSniper = DynAccessor(86497)
            skillSoundIntelligence = DynAccessor(86498)
            statConcealment = DynAccessor(86499)
            statFirepower = DynAccessor(86500)
            statMobility = DynAccessor(86501)
            statSpotting = DynAccessor(86502)
            statSurvivability = DynAccessor(86503)

        advancedHints = _advancedHints()

    animations = _animations()

    class _armory_yard(DynAccessor):
        __slots__ = ()
        ay_ep3_armour = DynAccessor(86504)
        ay_ep3_gun = DynAccessor(86505)
        ay_ep3_tracks = DynAccessor(86506)
        ay_ep3_turret = DynAccessor(86507)
        video_reward = DynAccessor(86508)
        video_reward_min = DynAccessor(86509)

    armory_yard = _armory_yard()

    class _battle_pass(DynAccessor):
        __slots__ = ()
        c_201292_2 = DynAccessor(86510)
        c_201292_3 = DynAccessor(86511)
        c_201292_4 = DynAccessor(86512)
        c_201548_2 = DynAccessor(86513)
        c_201548_3 = DynAccessor(86514)
        c_201548_4 = DynAccessor(86515)
        c_202316_2 = DynAccessor(86516)
        c_202316_3 = DynAccessor(86517)
        c_202316_4 = DynAccessor(86518)
        v_141_0 = DynAccessor(86519)
        v_142_0 = DynAccessor(86520)
        v_143_0 = DynAccessor(86521)
        v_145_0 = DynAccessor(86522)

    battle_pass = _battle_pass()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(86523)
        example_2 = DynAccessor(86524)

    development = _development()

    class _event_loot_boxes(DynAccessor):
        __slots__ = ()

        class _bd2023(DynAccessor):
            __slots__ = ()
            bronze = DynAccessor(86525)
            gold = DynAccessor(86526)
            silver = DynAccessor(86527)
            standart = DynAccessor(86528)

        bd2023 = _bd2023()

        class _bd2024(DynAccessor):
            __slots__ = ()
            lootbox = DynAccessor(86529)

        bd2024 = _bd2024()

        class _cosmic2024(DynAccessor):
            __slots__ = ()
            silver = DynAccessor(86530)
            standart = DynAccessor(86531)

        cosmic2024 = _cosmic2024()

        class _hw2023(DynAccessor):
            __slots__ = ()
            silver = DynAccessor(86532)
            standart = DynAccessor(86533)

        hw2023 = _hw2023()

        class _mt_lootbox(DynAccessor):
            __slots__ = ()
            mtl_1_24 = DynAccessor(86534)
            mt_drops = DynAccessor(86535)

        mt_lootbox = _mt_lootbox()

        class _rp_2024(DynAccessor):
            __slots__ = ()
            large = DynAccessor(86536)
            medium = DynAccessor(86537)
            small = DynAccessor(86538)

        rp_2024 = _rp_2024()

    event_loot_boxes = _event_loot_boxes()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(86539)

    platoon = _platoon()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(86540)

    vehicle = _vehicle()