from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()

    class _achievements(DynAccessor):
        __slots__ = ()
        bg_advanced_achievements = DynAccessor(93980)
        grade_change_particles = DynAccessor(93981)
        particles = DynAccessor(93982)
        up_particles = DynAccessor(93983)

    achievements = _achievements()

    class _animations(DynAccessor):
        __slots__ = ()

        class _advancedHints(DynAccessor):
            __slots__ = ()
            bonusPerkUnlock = DynAccessor(93984)
            crewCommander = DynAccessor(93985)
            crewDriver = DynAccessor(93986)
            crewGunner = DynAccessor(93987)
            crewLoader = DynAccessor(93988)
            crewRadioOperator = DynAccessor(93989)
            skillAdrenalineRush = DynAccessor(93990)
            skillAmbushMaster = DynAccessor(93991)
            skillBrothersInArms = DynAccessor(93992)
            skillCallForVengeance = DynAccessor(93993)
            skillClutchBraking = DynAccessor(93994)
            skillCommanderBonus = DynAccessor(93995)
            skillCommanderCoordination = DynAccessor(93996)
            skillCommanderEmergency = DynAccessor(93997)
            skillCommanderEnemyShotPredictor = DynAccessor(93998)
            skillCommanderPractical = DynAccessor(93999)
            skillCommanderTutor = DynAccessor(94000)
            skillConcealment = DynAccessor(94001)
            skillDesignatedTarget = DynAccessor(94002)
            skillDriverMotorExpert = DynAccessor(94003)
            skillDriverRammingMaster = DynAccessor(94004)
            skillDriverReliablePlacement = DynAccessor(94005)
            skillEagleEye = DynAccessor(94006)
            skillEfficiency = DynAccessor(94007)
            skillFirefighting = DynAccessor(94008)
            skillGunnerArmorer = DynAccessor(94009)
            skillGunnerFocus = DynAccessor(94010)
            skillGunnerQuickAiming = DynAccessor(94011)
            skillIntuition = DynAccessor(94012)
            skillJackOfAllTrades = DynAccessor(94013)
            skillLoaderAmmunitionImprove = DynAccessor(94014)
            skillLoaderMelee = DynAccessor(94015)
            skillLoaderPerfectCharge = DynAccessor(94016)
            skillOffRoadDriving = DynAccessor(94017)
            skillPreventativeMaintenance = DynAccessor(94018)
            skillRadiomanExpert = DynAccessor(94019)
            skillRadiomanInterference = DynAccessor(94020)
            skillRadiomanSideBySide = DynAccessor(94021)
            skillRadiomanSignalInterception = DynAccessor(94022)
            skillRepairs = DynAccessor(94023)
            skillSafeStowage = DynAccessor(94024)
            skillSituationalAwareness = DynAccessor(94025)
            skillSixthSense = DynAccessor(94026)
            skillSmoothRide = DynAccessor(94027)
            skillSnapShot = DynAccessor(94028)
            skillSniper = DynAccessor(94029)
            skillUntrainedPenalty = DynAccessor(94030)
            statConcealment = DynAccessor(94031)
            statFirepower = DynAccessor(94032)
            statMobility = DynAccessor(94033)
            statSpotting = DynAccessor(94034)
            statSurvivability = DynAccessor(94035)

        advancedHints = _advancedHints()

    animations = _animations()

    class _battle_pass(DynAccessor):
        __slots__ = ()
        style_ch1_lvl2 = DynAccessor(94036)
        style_ch1_lvl3 = DynAccessor(94037)
        style_ch1_lvl4 = DynAccessor(94038)
        style_ch2_lvl2 = DynAccessor(94039)
        style_ch2_lvl3 = DynAccessor(94040)
        style_ch2_lvl4 = DynAccessor(94041)
        style_ch3_lvl2 = DynAccessor(94042)
        style_ch3_lvl3 = DynAccessor(94043)
        style_ch3_lvl4 = DynAccessor(94044)

    battle_pass = _battle_pass()

    class _clan_supply(DynAccessor):
        __slots__ = ()
        clouds_1024 = DynAccessor(94045)
        clouds_1366 = DynAccessor(94046)
        clouds_1600 = DynAccessor(94047)
        clouds_1920 = DynAccessor(94048)
        clouds_2560 = DynAccessor(94049)
        spark_white = DynAccessor(94050)
        spark_yellow = DynAccessor(94051)

    clan_supply = _clan_supply()

    class _comp7(DynAccessor):
        __slots__ = ()
        divine_glow = DynAccessor(94052)
        godRaysNew_130x130 = DynAccessor(94053)
        godRaysNew_1600x1600 = DynAccessor(94054)
        rankAnimation_first = DynAccessor(94055)
        rankAnimation_second = DynAccessor(94056)
        rankAnimation_third = DynAccessor(94057)

    comp7 = _comp7()

    class _crew(DynAccessor):
        __slots__ = ()

        class _profile(DynAccessor):
            __slots__ = ()
            veteran_blick = DynAccessor(94058)
            veteran_frame_big = DynAccessor(94059)
            veteran_frame_small = DynAccessor(94060)

        profile = _profile()

    crew = _crew()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(94061)
        example_2 = DynAccessor(94062)

    development = _development()

    class _dogtags(DynAccessor):
        __slots__ = ()
        vehicle_sparks_1 = DynAccessor(94063)
        vehicle_sparks_2 = DynAccessor(94064)
        vehicle_sparks_3 = DynAccessor(94065)

    dogtags = _dogtags()

    class _event_loot_boxes(DynAccessor):
        __slots__ = ()
        lootbox_prem = DynAccessor(94066)

    event_loot_boxes = _event_loot_boxes()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(94067)

    platoon = _platoon()

    class _story_mode(DynAccessor):
        __slots__ = ()
        v_icon_fire = DynAccessor(94068)

    story_mode = _story_mode()

    class _wt(DynAccessor):
        __slots__ = ()
        boss_1_idle_1024 = DynAccessor(94069)
        boss_1_idle_1366 = DynAccessor(94070)
        boss_1_idle_1600 = DynAccessor(94071)
        boss_1_idle_1920 = DynAccessor(94072)
        boss_1_idle_2560 = DynAccessor(94073)
        boss_1_introduction_1024 = DynAccessor(94074)
        boss_1_introduction_1366 = DynAccessor(94075)
        boss_1_introduction_1600 = DynAccessor(94076)
        boss_1_introduction_1920 = DynAccessor(94077)
        boss_1_introduction_2560 = DynAccessor(94078)
        boss_2_idle_1024 = DynAccessor(94079)
        boss_2_idle_1366 = DynAccessor(94080)
        boss_2_idle_1600 = DynAccessor(94081)
        boss_2_idle_1920 = DynAccessor(94082)
        boss_2_idle_2560 = DynAccessor(94083)
        boss_2_introduction_1024 = DynAccessor(94084)
        boss_2_introduction_1366 = DynAccessor(94085)
        boss_2_introduction_1600 = DynAccessor(94086)
        boss_2_introduction_1920 = DynAccessor(94087)
        boss_2_introduction_2560 = DynAccessor(94088)
        boss_3_idle_1024 = DynAccessor(94089)
        boss_3_idle_1366 = DynAccessor(94090)
        boss_3_idle_1600 = DynAccessor(94091)
        boss_3_idle_1920 = DynAccessor(94092)
        boss_3_idle_2560 = DynAccessor(94093)
        boss_3_introduction_1024 = DynAccessor(94094)
        boss_3_introduction_1366 = DynAccessor(94095)
        boss_3_introduction_1600 = DynAccessor(94096)
        boss_3_introduction_1920 = DynAccessor(94097)
        boss_3_introduction_2560 = DynAccessor(94098)
        boss_portal_idle_1024 = DynAccessor(94099)
        boss_portal_idle_1366 = DynAccessor(94100)
        boss_portal_idle_1600 = DynAccessor(94101)
        boss_portal_idle_1920 = DynAccessor(94102)
        boss_portal_idle_2560 = DynAccessor(94103)
        hunter_portal_idle_1024 = DynAccessor(94104)
        hunter_portal_idle_1366 = DynAccessor(94105)
        hunter_portal_idle_1600 = DynAccessor(94106)
        hunter_portal_idle_1920 = DynAccessor(94107)
        hunter_portal_idle_2560 = DynAccessor(94108)
        lootbox_boss_1024 = DynAccessor(94109)
        lootbox_boss_1366 = DynAccessor(94110)
        lootbox_boss_1600 = DynAccessor(94111)
        lootbox_boss_1920 = DynAccessor(94112)
        lootbox_boss_2560 = DynAccessor(94113)
        lootbox_boss_idle_1024 = DynAccessor(94114)
        lootbox_boss_idle_1366 = DynAccessor(94115)
        lootbox_boss_idle_1600 = DynAccessor(94116)
        lootbox_boss_idle_1920 = DynAccessor(94117)
        lootbox_boss_idle_2560 = DynAccessor(94118)
        lootbox_hunter_1024 = DynAccessor(94119)
        lootbox_hunter_1366 = DynAccessor(94120)
        lootbox_hunter_1600 = DynAccessor(94121)
        lootbox_hunter_1920 = DynAccessor(94122)
        lootbox_hunter_2560 = DynAccessor(94123)
        lootbox_hunter_idle_1024 = DynAccessor(94124)
        lootbox_hunter_idle_1366 = DynAccessor(94125)
        lootbox_hunter_idle_1600 = DynAccessor(94126)
        lootbox_hunter_idle_1920 = DynAccessor(94127)
        lootbox_hunter_idle_2560 = DynAccessor(94128)

    wt = _wt()