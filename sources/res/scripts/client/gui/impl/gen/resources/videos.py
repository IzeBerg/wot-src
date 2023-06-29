from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    _bootcampLesson1 = DynAccessor(75325)
    _bootcampLesson2 = DynAccessor(75326)
    _bootcampLesson3_1 = DynAccessor(75327)
    _bootcampLesson3_2 = DynAccessor(75328)
    _bootcampLesson4 = DynAccessor(75329)
    _bootcampOutro = DynAccessor(75330)
    _tutorialInitial = DynAccessor(75331)
    _tutorialInitialLoop = DynAccessor(75332)

    class _achievements(DynAccessor):
        __slots__ = ()
        particles = DynAccessor(75333)
        up_particles = DynAccessor(75334)

    achievements = _achievements()

    class _animations(DynAccessor):
        __slots__ = ()

        class _advancedHints(DynAccessor):
            __slots__ = ()
            skillAdrenalineRush = DynAccessor(75335)
            skillAmbushMaster = DynAccessor(75336)
            skillArmorer = DynAccessor(75337)
            skillArtLamp = DynAccessor(75338)
            skillBrothersInArms = DynAccessor(75339)
            skillCallForVengeance = DynAccessor(75340)
            skillCloseCombat = DynAccessor(75341)
            skillClutchBraking = DynAccessor(75342)
            skillConcealment = DynAccessor(75343)
            skillConcentration = DynAccessor(75344)
            skillControlledImpact = DynAccessor(75345)
            skillDesignatedTarget = DynAccessor(75346)
            skillEagleEye = DynAccessor(75347)
            skillExpert = DynAccessor(75348)
            skillFirefighting = DynAccessor(75349)
            skillInterference = DynAccessor(75350)
            skillIntuition = DynAccessor(75351)
            skillJackOfAllTrades = DynAccessor(75352)
            skillMentor = DynAccessor(75353)
            skillMotorConnoisseur = DynAccessor(75354)
            skillOffRoadDriving = DynAccessor(75355)
            skillPracticality = DynAccessor(75356)
            skillPreventativeMaintenance = DynAccessor(75357)
            skillQuickAiming = DynAccessor(75358)
            skillRelaying = DynAccessor(75359)
            skillRepairs = DynAccessor(75360)
            skillSafeStowage = DynAccessor(75361)
            skillShellImprovement = DynAccessor(75362)
            skillSignalBoosting = DynAccessor(75363)
            skillSituationalAwareness = DynAccessor(75364)
            skillSixthSense = DynAccessor(75365)
            skillSmoothRide = DynAccessor(75366)
            skillSnapShot = DynAccessor(75367)
            skillSniper = DynAccessor(75368)
            statConcealment = DynAccessor(75369)
            statFirepower = DynAccessor(75370)
            statMobility = DynAccessor(75371)
            statSpotting = DynAccessor(75372)
            statSurvivability = DynAccessor(75373)

        advancedHints = _advancedHints()

    animations = _animations()

    class _battle_pass(DynAccessor):
        __slots__ = ()
        c_201292_2 = DynAccessor(75374)
        c_201292_3 = DynAccessor(75375)
        c_201292_4 = DynAccessor(75376)
        c_201548_2 = DynAccessor(75377)
        c_201548_3 = DynAccessor(75378)
        c_201548_4 = DynAccessor(75379)
        c_202316_2 = DynAccessor(75380)
        c_202316_3 = DynAccessor(75381)
        c_202316_4 = DynAccessor(75382)

    battle_pass = _battle_pass()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(75383)
        example_2 = DynAccessor(75384)

    development = _development()

    class _event_loot_boxes(DynAccessor):
        __slots__ = ()
        lootbox_prem = DynAccessor(75385)

    event_loot_boxes = _event_loot_boxes()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(75386)

    platoon = _platoon()

    class _startup(DynAccessor):
        __slots__ = ()
        Logo_All = DynAccessor(75387)

    startup = _startup()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(75388)

    vehicle = _vehicle()