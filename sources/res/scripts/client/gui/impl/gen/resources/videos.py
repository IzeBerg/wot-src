from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()

    class _achievements(DynAccessor):
        __slots__ = ()
        bg_advanced_achievements = DynAccessor(88902)
        grade_change_particles = DynAccessor(88903)
        particles = DynAccessor(88904)
        up_particles = DynAccessor(88905)

    achievements = _achievements()

    class _animations(DynAccessor):
        __slots__ = ()

        class _advancedHints(DynAccessor):
            __slots__ = ()
            crewCommander = DynAccessor(88906)
            crewDriver = DynAccessor(88907)
            crewGunner = DynAccessor(88908)
            crewLoader = DynAccessor(88909)
            crewRadioOperator = DynAccessor(88910)
            skillAdrenalineRush = DynAccessor(88911)
            skillAmbushMaster = DynAccessor(88912)
            skillArmorer = DynAccessor(88913)
            skillArtLamp = DynAccessor(88914)
            skillBrothersInArms = DynAccessor(88915)
            skillCallForVengeance = DynAccessor(88916)
            skillCloseCombat = DynAccessor(88917)
            skillClutchBraking = DynAccessor(88918)
            skillCommanderBonus = DynAccessor(88919)
            skillConcealment = DynAccessor(88920)
            skillConcentration = DynAccessor(88921)
            skillControlledImpact = DynAccessor(88922)
            skillDesignatedTarget = DynAccessor(88923)
            skillEagleEye = DynAccessor(88924)
            skillEfficiency = DynAccessor(88925)
            skillExpert = DynAccessor(88926)
            skillFirefighting = DynAccessor(88927)
            skillInterference = DynAccessor(88928)
            skillIntuition = DynAccessor(88929)
            skillJackOfAllTrades = DynAccessor(88930)
            skillMentor = DynAccessor(88931)
            skillMotorConnoisseur = DynAccessor(88932)
            skillOffRoadDriving = DynAccessor(88933)
            skillPracticality = DynAccessor(88934)
            skillPreventativeMaintenance = DynAccessor(88935)
            skillQuickAiming = DynAccessor(88936)
            skillRelaying = DynAccessor(88937)
            skillRepairs = DynAccessor(88938)
            skillSafeStowage = DynAccessor(88939)
            skillShellImprovement = DynAccessor(88940)
            skillSignalBoosting = DynAccessor(88941)
            skillSituationalAwareness = DynAccessor(88942)
            skillSixthSense = DynAccessor(88943)
            skillSmoothRide = DynAccessor(88944)
            skillSnapShot = DynAccessor(88945)
            skillSniper = DynAccessor(88946)
            skillUntrainedPenalty = DynAccessor(88947)
            statConcealment = DynAccessor(88948)
            statFirepower = DynAccessor(88949)
            statMobility = DynAccessor(88950)
            statSpotting = DynAccessor(88951)
            statSurvivability = DynAccessor(88952)

        advancedHints = _advancedHints()

    animations = _animations()

    class _battle_pass(DynAccessor):
        __slots__ = ()
        style_ch1_lvl2 = DynAccessor(88953)
        style_ch1_lvl3 = DynAccessor(88954)
        style_ch1_lvl4 = DynAccessor(88955)
        style_ch2_lvl2 = DynAccessor(88956)
        style_ch2_lvl3 = DynAccessor(88957)
        style_ch2_lvl4 = DynAccessor(88958)
        style_ch3_lvl2 = DynAccessor(88959)
        style_ch3_lvl3 = DynAccessor(88960)
        style_ch3_lvl4 = DynAccessor(88961)

    battle_pass = _battle_pass()

    class _clan_supply(DynAccessor):
        __slots__ = ()
        clouds_1024 = DynAccessor(88962)
        clouds_1366 = DynAccessor(88963)
        clouds_1600 = DynAccessor(88964)
        clouds_1920 = DynAccessor(88965)
        clouds_2560 = DynAccessor(88966)
        spark_white = DynAccessor(88967)
        spark_yellow = DynAccessor(88968)

    clan_supply = _clan_supply()

    class _comp7(DynAccessor):
        __slots__ = ()
        godRaysNew_130x130 = DynAccessor(88969)
        godRaysNew_1600x1600 = DynAccessor(88970)
        rankAnimation_first = DynAccessor(88971)
        rankAnimation_second = DynAccessor(88972)
        rankAnimation_third = DynAccessor(88973)

    comp7 = _comp7()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(88974)
        example_2 = DynAccessor(88975)

    development = _development()

    class _dogtags(DynAccessor):
        __slots__ = ()
        vehicle_sparks_1 = DynAccessor(88976)
        vehicle_sparks_2 = DynAccessor(88977)
        vehicle_sparks_3 = DynAccessor(88978)

    dogtags = _dogtags()

    class _event_loot_boxes(DynAccessor):
        __slots__ = ()
        lootbox_prem = DynAccessor(88979)

    event_loot_boxes = _event_loot_boxes()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(88980)

    platoon = _platoon()

    class _story_mode(DynAccessor):
        __slots__ = ()
        v_icon_fire = DynAccessor(88981)

    story_mode = _story_mode()