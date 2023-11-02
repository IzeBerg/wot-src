from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()
    intro = DynAccessor(80374)
    _bootcampLesson1 = DynAccessor(80375)
    _bootcampLesson2 = DynAccessor(80376)
    _bootcampLesson3_1 = DynAccessor(80377)
    _bootcampLesson3_2 = DynAccessor(80378)
    _bootcampLesson4 = DynAccessor(80379)
    _bootcampOutro = DynAccessor(80380)
    _tutorialInitial = DynAccessor(80381)
    _tutorialInitialLoop = DynAccessor(80382)

    class _achievements(DynAccessor):
        __slots__ = ()
        particles = DynAccessor(80383)
        up_particles = DynAccessor(80384)

    achievements = _achievements()

    class _animations(DynAccessor):
        __slots__ = ()

        class _advancedHints(DynAccessor):
            __slots__ = ()
            crewCommander = DynAccessor(80385)
            crewDriver = DynAccessor(80386)
            crewGunner = DynAccessor(80387)
            crewLoader = DynAccessor(80388)
            crewRadioOperator = DynAccessor(80389)
            skillAdrenalineRush = DynAccessor(80390)
            skillAmbushMaster = DynAccessor(80391)
            skillArmorer = DynAccessor(80392)
            skillArtLamp = DynAccessor(80393)
            skillBrothersInArms = DynAccessor(80394)
            skillCallForVengeance = DynAccessor(80395)
            skillCloseCombat = DynAccessor(80396)
            skillClutchBraking = DynAccessor(80397)
            skillCommanderBonus = DynAccessor(80398)
            skillConcealment = DynAccessor(80399)
            skillConcentration = DynAccessor(80400)
            skillControlledImpact = DynAccessor(80401)
            skillDesignatedTarget = DynAccessor(80402)
            skillEagleEye = DynAccessor(80403)
            skillExpert = DynAccessor(80404)
            skillFirefighting = DynAccessor(80405)
            skillInterference = DynAccessor(80406)
            skillIntuition = DynAccessor(80407)
            skillJackOfAllTrades = DynAccessor(80408)
            skillMentor = DynAccessor(80409)
            skillMotorConnoisseur = DynAccessor(80410)
            skillOffRoadDriving = DynAccessor(80411)
            skillPracticality = DynAccessor(80412)
            skillPreventativeMaintenance = DynAccessor(80413)
            skillQuickAiming = DynAccessor(80414)
            skillRelaying = DynAccessor(80415)
            skillRepairs = DynAccessor(80416)
            skillSafeStowage = DynAccessor(80417)
            skillShellImprovement = DynAccessor(80418)
            skillSignalBoosting = DynAccessor(80419)
            skillSituationalAwareness = DynAccessor(80420)
            skillSixthSense = DynAccessor(80421)
            skillSmoothRide = DynAccessor(80422)
            skillSnapShot = DynAccessor(80423)
            skillSniper = DynAccessor(80424)
            statConcealment = DynAccessor(80425)
            statFirepower = DynAccessor(80426)
            statMobility = DynAccessor(80427)
            statSpotting = DynAccessor(80428)
            statSurvivability = DynAccessor(80429)

        advancedHints = _advancedHints()

    animations = _animations()

    class _battle_pass(DynAccessor):
        __slots__ = ()
        media_ch4 = DynAccessor(80430)
        style_ch1_lvl2 = DynAccessor(80431)
        style_ch1_lvl3 = DynAccessor(80432)
        style_ch1_lvl4 = DynAccessor(80433)
        style_ch2_lvl2 = DynAccessor(80434)
        style_ch2_lvl3 = DynAccessor(80435)
        style_ch2_lvl4 = DynAccessor(80436)
        style_ch3_lvl2 = DynAccessor(80437)
        style_ch3_lvl3 = DynAccessor(80438)
        style_ch3_lvl4 = DynAccessor(80439)

    battle_pass = _battle_pass()

    class _comp7(DynAccessor):
        __slots__ = ()
        rankAnimation = DynAccessor(80440)

    comp7 = _comp7()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(80441)
        example_2 = DynAccessor(80442)

    development = _development()

    class _event_loot_boxes(DynAccessor):
        __slots__ = ()
        lootbox_prem = DynAccessor(80443)

    event_loot_boxes = _event_loot_boxes()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(80444)

    platoon = _platoon()

    class _startup(DynAccessor):
        __slots__ = ()
        Logo_All = DynAccessor(80445)

    startup = _startup()

    class _vehicle(DynAccessor):
        __slots__ = ()
        A122_TS_5 = DynAccessor(80446)

    vehicle = _vehicle()