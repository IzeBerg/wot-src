from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(75657)
    _bootcampLesson2 = DynAccessor(75658)
    _bootcampLesson3_1 = DynAccessor(75659)
    _bootcampLesson3_2 = DynAccessor(75660)
    _bootcampLesson4 = DynAccessor(75661)
    _bootcampOutro = DynAccessor(75662)
    _tutorialInitial = DynAccessor(75663)
    _tutorialInitialLoop = DynAccessor(75664)

    class _achievements(DynAccessor):
        __slots__ = ()
        particles = DynAccessor(75665)
        up_particles = DynAccessor(75666)

    achievements = _achievements()

    class _animations(DynAccessor):
        __slots__ = ()

        class _advancedHints(DynAccessor):
            __slots__ = ()
            skillAdrenalineRush = DynAccessor(75667)
            skillAmbushMaster = DynAccessor(75668)
            skillArmorer = DynAccessor(75669)
            skillArtLamp = DynAccessor(75670)
            skillBrothersInArms = DynAccessor(75671)
            skillCallForVengeance = DynAccessor(75672)
            skillCloseCombat = DynAccessor(75673)
            skillClutchBraking = DynAccessor(75674)
            skillConcealment = DynAccessor(75675)
            skillConcentration = DynAccessor(75676)
            skillControlledImpact = DynAccessor(75677)
            skillDesignatedTarget = DynAccessor(75678)
            skillEagleEye = DynAccessor(75679)
            skillExpert = DynAccessor(75680)
            skillFirefighting = DynAccessor(75681)
            skillInterference = DynAccessor(75682)
            skillIntuition = DynAccessor(75683)
            skillJackOfAllTrades = DynAccessor(75684)
            skillMentor = DynAccessor(75685)
            skillMotorConnoisseur = DynAccessor(75686)
            skillOffRoadDriving = DynAccessor(75687)
            skillPracticality = DynAccessor(75688)
            skillPreventativeMaintenance = DynAccessor(75689)
            skillQuickAiming = DynAccessor(75690)
            skillRelaying = DynAccessor(75691)
            skillRepairs = DynAccessor(75692)
            skillSafeStowage = DynAccessor(75693)
            skillShellImprovement = DynAccessor(75694)
            skillSignalBoosting = DynAccessor(75695)
            skillSituationalAwareness = DynAccessor(75696)
            skillSixthSense = DynAccessor(75697)
            skillSmoothRide = DynAccessor(75698)
            skillSnapShot = DynAccessor(75699)
            skillSniper = DynAccessor(75700)
            statConcealment = DynAccessor(75701)
            statFirepower = DynAccessor(75702)
            statMobility = DynAccessor(75703)
            statSpotting = DynAccessor(75704)
            statSurvivability = DynAccessor(75705)

        advancedHints = _advancedHints()

    animations = _animations()

    class _battle_pass(DynAccessor):
        __slots__ = ()
        c_201292_2 = DynAccessor(75706)
        c_201292_3 = DynAccessor(75707)
        c_201292_4 = DynAccessor(75708)
        c_201548_2 = DynAccessor(75709)
        c_201548_3 = DynAccessor(75710)
        c_201548_4 = DynAccessor(75711)
        c_202316_2 = DynAccessor(75712)
        c_202316_3 = DynAccessor(75713)
        c_202316_4 = DynAccessor(75714)

    battle_pass = _battle_pass()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(75715)
        example_2 = DynAccessor(75716)

    development = _development()

    class _event_loot_boxes(DynAccessor):
        __slots__ = ()
        lootbox_prem = DynAccessor(75717)

    event_loot_boxes = _event_loot_boxes()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(75718)

    platoon = _platoon()

    class _startup(DynAccessor):
        __slots__ = ()
        Logo_All = DynAccessor(75719)

    startup = _startup()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(75720)

    vehicle = _vehicle()