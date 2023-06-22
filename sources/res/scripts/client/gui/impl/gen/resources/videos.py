from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(75324)
    _bootcampLesson2 = DynAccessor(75325)
    _bootcampLesson3_1 = DynAccessor(75326)
    _bootcampLesson3_2 = DynAccessor(75327)
    _bootcampLesson4 = DynAccessor(75328)
    _bootcampOutro = DynAccessor(75329)
    _tutorialInitial = DynAccessor(75330)
    _tutorialInitialLoop = DynAccessor(75331)

    class _achievements(DynAccessor):
        __slots__ = ()
        particles = DynAccessor(75332)
        up_particles = DynAccessor(75333)

    achievements = _achievements()

    class _animations(DynAccessor):
        __slots__ = ()

        class _advancedHints(DynAccessor):
            __slots__ = ()
            skillAdrenalineRush = DynAccessor(75334)
            skillAmbushMaster = DynAccessor(75335)
            skillArmorer = DynAccessor(75336)
            skillArtLamp = DynAccessor(75337)
            skillBrothersInArms = DynAccessor(75338)
            skillCallForVengeance = DynAccessor(75339)
            skillCloseCombat = DynAccessor(75340)
            skillClutchBraking = DynAccessor(75341)
            skillConcealment = DynAccessor(75342)
            skillConcentration = DynAccessor(75343)
            skillControlledImpact = DynAccessor(75344)
            skillDesignatedTarget = DynAccessor(75345)
            skillEagleEye = DynAccessor(75346)
            skillExpert = DynAccessor(75347)
            skillFirefighting = DynAccessor(75348)
            skillInterference = DynAccessor(75349)
            skillIntuition = DynAccessor(75350)
            skillJackOfAllTrades = DynAccessor(75351)
            skillMentor = DynAccessor(75352)
            skillMotorConnoisseur = DynAccessor(75353)
            skillOffRoadDriving = DynAccessor(75354)
            skillPracticality = DynAccessor(75355)
            skillPreventativeMaintenance = DynAccessor(75356)
            skillQuickAiming = DynAccessor(75357)
            skillRelaying = DynAccessor(75358)
            skillRepairs = DynAccessor(75359)
            skillSafeStowage = DynAccessor(75360)
            skillShellImprovement = DynAccessor(75361)
            skillSignalBoosting = DynAccessor(75362)
            skillSituationalAwareness = DynAccessor(75363)
            skillSixthSense = DynAccessor(75364)
            skillSmoothRide = DynAccessor(75365)
            skillSnapShot = DynAccessor(75366)
            skillSniper = DynAccessor(75367)
            statConcealment = DynAccessor(75368)
            statFirepower = DynAccessor(75369)
            statMobility = DynAccessor(75370)
            statSpotting = DynAccessor(75371)
            statSurvivability = DynAccessor(75372)

        advancedHints = _advancedHints()

    animations = _animations()

    class _battle_pass(DynAccessor):
        __slots__ = ()
        c_201292_2 = DynAccessor(75373)
        c_201292_3 = DynAccessor(75374)
        c_201292_4 = DynAccessor(75375)
        c_201548_2 = DynAccessor(75376)
        c_201548_3 = DynAccessor(75377)
        c_201548_4 = DynAccessor(75378)
        c_202316_2 = DynAccessor(75379)
        c_202316_3 = DynAccessor(75380)
        c_202316_4 = DynAccessor(75381)

    battle_pass = _battle_pass()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(75382)
        example_2 = DynAccessor(75383)

    development = _development()

    class _event_loot_boxes(DynAccessor):
        __slots__ = ()
        lootbox_prem = DynAccessor(75384)

    event_loot_boxes = _event_loot_boxes()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(75385)

    platoon = _platoon()

    class _startup(DynAccessor):
        __slots__ = ()
        Logo_All = DynAccessor(75386)

    startup = _startup()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(75387)

    vehicle = _vehicle()