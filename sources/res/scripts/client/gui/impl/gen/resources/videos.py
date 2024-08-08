from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()

    class _achievements(DynAccessor):
        __slots__ = ()
        bg_advanced_achievements = DynAccessor(91050)
        grade_change_particles = DynAccessor(91051)
        particles = DynAccessor(91052)
        up_particles = DynAccessor(91053)

    achievements = _achievements()

    class _animations(DynAccessor):
        __slots__ = ()

        class _advancedHints(DynAccessor):
            __slots__ = ()
            bonusPerkUnlock = DynAccessor(91054)
            crewCommander = DynAccessor(91055)
            crewDriver = DynAccessor(91056)
            crewGunner = DynAccessor(91057)
            crewLoader = DynAccessor(91058)
            crewRadioOperator = DynAccessor(91059)
            skillAdrenalineRush = DynAccessor(91060)
            skillAmbushMaster = DynAccessor(91061)
            skillBrothersInArms = DynAccessor(91062)
            skillCallForVengeance = DynAccessor(91063)
            skillClutchBraking = DynAccessor(91064)
            skillCommanderBonus = DynAccessor(91065)
            skillCommanderCoordination = DynAccessor(91066)
            skillCommanderEmergency = DynAccessor(91067)
            skillCommanderEnemyShotPredictor = DynAccessor(91068)
            skillCommanderPractical = DynAccessor(91069)
            skillCommanderTutor = DynAccessor(91070)
            skillConcealment = DynAccessor(91071)
            skillDesignatedTarget = DynAccessor(91072)
            skillDriverMotorExpert = DynAccessor(91073)
            skillDriverRammingMaster = DynAccessor(91074)
            skillDriverReliablePlacement = DynAccessor(91075)
            skillEagleEye = DynAccessor(91076)
            skillEfficiency = DynAccessor(91077)
            skillFirefighting = DynAccessor(91078)
            skillGunnerArmorer = DynAccessor(91079)
            skillGunnerFocus = DynAccessor(91080)
            skillGunnerQuickAiming = DynAccessor(91081)
            skillIntuition = DynAccessor(91082)
            skillJackOfAllTrades = DynAccessor(91083)
            skillLoaderAmmunitionImprove = DynAccessor(91084)
            skillLoaderMelee = DynAccessor(91085)
            skillLoaderPerfectCharge = DynAccessor(91086)
            skillOffRoadDriving = DynAccessor(91087)
            skillPreventativeMaintenance = DynAccessor(91088)
            skillRadiomanExpert = DynAccessor(91089)
            skillRadiomanInterference = DynAccessor(91090)
            skillRadiomanSideBySide = DynAccessor(91091)
            skillRadiomanSignalInterception = DynAccessor(91092)
            skillRepairs = DynAccessor(91093)
            skillSafeStowage = DynAccessor(91094)
            skillSituationalAwareness = DynAccessor(91095)
            skillSixthSense = DynAccessor(91096)
            skillSmoothRide = DynAccessor(91097)
            skillSnapShot = DynAccessor(91098)
            skillSniper = DynAccessor(91099)
            skillUntrainedPenalty = DynAccessor(91100)
            statConcealment = DynAccessor(91101)
            statFirepower = DynAccessor(91102)
            statMobility = DynAccessor(91103)
            statSpotting = DynAccessor(91104)
            statSurvivability = DynAccessor(91105)

        advancedHints = _advancedHints()

    animations = _animations()

    class _battle_pass(DynAccessor):
        __slots__ = ()
        style_ch1_lvl2 = DynAccessor(91106)
        style_ch1_lvl3 = DynAccessor(91107)
        style_ch1_lvl4 = DynAccessor(91108)
        style_ch2_lvl2 = DynAccessor(91109)
        style_ch2_lvl3 = DynAccessor(91110)
        style_ch2_lvl4 = DynAccessor(91111)
        style_ch3_lvl2 = DynAccessor(91112)
        style_ch3_lvl3 = DynAccessor(91113)
        style_ch3_lvl4 = DynAccessor(91114)

    battle_pass = _battle_pass()

    class _clan_supply(DynAccessor):
        __slots__ = ()
        clouds_1024 = DynAccessor(91115)
        clouds_1366 = DynAccessor(91116)
        clouds_1600 = DynAccessor(91117)
        clouds_1920 = DynAccessor(91118)
        clouds_2560 = DynAccessor(91119)
        spark_white = DynAccessor(91120)
        spark_yellow = DynAccessor(91121)

    clan_supply = _clan_supply()

    class _comp7(DynAccessor):
        __slots__ = ()
        divine_glow = DynAccessor(91122)
        godRaysNew_130x130 = DynAccessor(91123)
        godRaysNew_1600x1600 = DynAccessor(91124)
        rankAnimation_first = DynAccessor(91125)
        rankAnimation_second = DynAccessor(91126)
        rankAnimation_third = DynAccessor(91127)

    comp7 = _comp7()

    class _crew(DynAccessor):
        __slots__ = ()

        class _profile(DynAccessor):
            __slots__ = ()
            veteran_blick = DynAccessor(91128)
            veteran_frame_big = DynAccessor(91129)
            veteran_frame_small = DynAccessor(91130)

        profile = _profile()

    crew = _crew()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(91131)
        example_2 = DynAccessor(91132)

    development = _development()

    class _dogtags(DynAccessor):
        __slots__ = ()
        vehicle_sparks_1 = DynAccessor(91133)
        vehicle_sparks_2 = DynAccessor(91134)
        vehicle_sparks_3 = DynAccessor(91135)

    dogtags = _dogtags()

    class _event_loot_boxes(DynAccessor):
        __slots__ = ()
        lootbox_prem = DynAccessor(91136)

    event_loot_boxes = _event_loot_boxes()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(91137)

    platoon = _platoon()

    class _story_mode(DynAccessor):
        __slots__ = ()
        v_icon_fire = DynAccessor(91138)

    story_mode = _story_mode()