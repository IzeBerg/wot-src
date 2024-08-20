from gui.impl.gen_utils import DynAccessor

class Videos(DynAccessor):
    __slots__ = ()

    class _achievements(DynAccessor):
        __slots__ = ()
        bg_advanced_achievements = DynAccessor(90778)
        grade_change_particles = DynAccessor(90779)
        particles = DynAccessor(90780)
        up_particles = DynAccessor(90781)

    achievements = _achievements()

    class _animations(DynAccessor):
        __slots__ = ()

        class _advancedHints(DynAccessor):
            __slots__ = ()
            crewCommander = DynAccessor(90782)
            crewDriver = DynAccessor(90783)
            crewGunner = DynAccessor(90784)
            crewLoader = DynAccessor(90785)
            crewRadioOperator = DynAccessor(90786)
            skillAdrenalineRush = DynAccessor(90787)
            skillAmbushMaster = DynAccessor(90788)
            skillArmorer = DynAccessor(90789)
            skillArtLamp = DynAccessor(90790)
            skillBrothersInArms = DynAccessor(90791)
            skillCallForVengeance = DynAccessor(90792)
            skillCloseCombat = DynAccessor(90793)
            skillClutchBraking = DynAccessor(90794)
            skillCommanderBonus = DynAccessor(90795)
            skillConcealment = DynAccessor(90796)
            skillConcentration = DynAccessor(90797)
            skillControlledImpact = DynAccessor(90798)
            skillDesignatedTarget = DynAccessor(90799)
            skillEagleEye = DynAccessor(90800)
            skillEfficiency = DynAccessor(90801)
            skillExpert = DynAccessor(90802)
            skillFirefighting = DynAccessor(90803)
            skillInterference = DynAccessor(90804)
            skillIntuition = DynAccessor(90805)
            skillJackOfAllTrades = DynAccessor(90806)
            skillMentor = DynAccessor(90807)
            skillMotorConnoisseur = DynAccessor(90808)
            skillOffRoadDriving = DynAccessor(90809)
            skillPracticality = DynAccessor(90810)
            skillPreventativeMaintenance = DynAccessor(90811)
            skillQuickAiming = DynAccessor(90812)
            skillRelaying = DynAccessor(90813)
            skillRepairs = DynAccessor(90814)
            skillSafeStowage = DynAccessor(90815)
            skillShellImprovement = DynAccessor(90816)
            skillSignalBoosting = DynAccessor(90817)
            skillSituationalAwareness = DynAccessor(90818)
            skillSixthSense = DynAccessor(90819)
            skillSmoothRide = DynAccessor(90820)
            skillSnapShot = DynAccessor(90821)
            skillSniper = DynAccessor(90822)
            skillUntrainedPenalty = DynAccessor(90823)
            statConcealment = DynAccessor(90824)
            statFirepower = DynAccessor(90825)
            statMobility = DynAccessor(90826)
            statSpotting = DynAccessor(90827)
            statSurvivability = DynAccessor(90828)

        advancedHints = _advancedHints()

    animations = _animations()

    class _battle_pass(DynAccessor):
        __slots__ = ()
        style_ch1_lvl2 = DynAccessor(90829)
        style_ch1_lvl3 = DynAccessor(90830)
        style_ch1_lvl4 = DynAccessor(90831)
        style_ch2_lvl2 = DynAccessor(90832)
        style_ch2_lvl3 = DynAccessor(90833)
        style_ch2_lvl4 = DynAccessor(90834)
        style_ch3_lvl2 = DynAccessor(90835)
        style_ch3_lvl3 = DynAccessor(90836)
        style_ch3_lvl4 = DynAccessor(90837)

    battle_pass = _battle_pass()

    class _clan_supply(DynAccessor):
        __slots__ = ()
        clouds_1024 = DynAccessor(90838)
        clouds_1366 = DynAccessor(90839)
        clouds_1600 = DynAccessor(90840)
        clouds_1920 = DynAccessor(90841)
        clouds_2560 = DynAccessor(90842)
        spark_white = DynAccessor(90843)
        spark_yellow = DynAccessor(90844)

    clan_supply = _clan_supply()

    class _comp7(DynAccessor):
        __slots__ = ()
        godRaysNew_130x130 = DynAccessor(90845)
        godRaysNew_1600x1600 = DynAccessor(90846)
        rankAnimation_first = DynAccessor(90847)
        rankAnimation_second = DynAccessor(90848)
        rankAnimation_third = DynAccessor(90849)

    comp7 = _comp7()

    class _development(DynAccessor):
        __slots__ = ()
        example = DynAccessor(90850)
        example_2 = DynAccessor(90851)

    development = _development()

    class _dogtags(DynAccessor):
        __slots__ = ()
        vehicle_sparks_1 = DynAccessor(90852)
        vehicle_sparks_2 = DynAccessor(90853)
        vehicle_sparks_3 = DynAccessor(90854)

    dogtags = _dogtags()

    class _event_loot_boxes(DynAccessor):
        __slots__ = ()
        lootbox_prem = DynAccessor(90855)

    event_loot_boxes = _event_loot_boxes()

    class _lootbox(DynAccessor):
        __slots__ = ()

        class _customizable(DynAccessor):
            __slots__ = ()

            class _anniversaryCN(DynAccessor):
                __slots__ = ()

                class _awardViews(DynAccessor):
                    __slots__ = ()

                    class _openingBoxVideo(DynAccessor):
                        __slots__ = ()
                        bronze_common = DynAccessor(90856)
                        bronze_rare = DynAccessor(90857)
                        gold_common = DynAccessor(90858)
                        gold_rare = DynAccessor(90859)
                        silver_common = DynAccessor(90860)
                        silver_rare = DynAccessor(90861)

                    openingBoxVideo = _openingBoxVideo()

                    class _raritySimpleAnimations(DynAccessor):
                        __slots__ = ()
                        epic = DynAccessor(90862)
                        epic_small = DynAccessor(90863)
                        rare = DynAccessor(90864)
                        rare_small = DynAccessor(90865)

                    raritySimpleAnimations = _raritySimpleAnimations()

                awardViews = _awardViews()

                class _hasBoxesView(DynAccessor):
                    __slots__ = ()
                    background = DynAccessor(90866)

                    class _layers(DynAccessor):
                        __slots__ = ()

                        class _box(DynAccessor):
                            __slots__ = ()
                            bronze = DynAccessor(90867)
                            gold = DynAccessor(90868)
                            silver = DynAccessor(90869)

                        box = _box()

                    layers = _layers()

                hasBoxesView = _hasBoxesView()

                class _noBoxesView(DynAccessor):
                    __slots__ = ()
                    background = DynAccessor(90870)

                noBoxesView = _noBoxesView()

            anniversaryCN = _anniversaryCN()

            class _default(DynAccessor):
                __slots__ = ()

                class _awardViews(DynAccessor):
                    __slots__ = ()
                    compensationGlow = DynAccessor(90871)

                    class _openingBoxVideo(DynAccessor):
                        __slots__ = ()
                        common = DynAccessor(90872)
                        rare = DynAccessor(90873)

                    openingBoxVideo = _openingBoxVideo()
                    rareGlow = DynAccessor(90874)

                    class _raritySimpleAnimations(DynAccessor):
                        __slots__ = ()
                        epic = DynAccessor(90875)
                        epic_small = DynAccessor(90876)
                        rare = DynAccessor(90877)
                        rare_small = DynAccessor(90878)

                    raritySimpleAnimations = _raritySimpleAnimations()

                awardViews = _awardViews()

                class _hasBoxesView(DynAccessor):
                    __slots__ = ()
                    background = DynAccessor(90879)
                    box = DynAccessor(90880)
                    hover = DynAccessor(90881)
                    idle = DynAccessor(90882)

                    class _layers(DynAccessor):
                        __slots__ = ()

                        class _background(DynAccessor):
                            __slots__ = ()
                            default = DynAccessor(90883)

                        background = _background()

                        class _box(DynAccessor):
                            __slots__ = ()
                            default = DynAccessor(90884)

                        box = _box()

                        class _hover(DynAccessor):
                            __slots__ = ()
                            default = DynAccessor(90885)

                        hover = _hover()

                        class _idle(DynAccessor):
                            __slots__ = ()
                            default = DynAccessor(90886)

                        idle = _idle()

                    layers = _layers()

                hasBoxesView = _hasBoxesView()

                class _noBoxesView(DynAccessor):
                    __slots__ = ()
                    background = DynAccessor(90887)

                noBoxesView = _noBoxesView()

            default = _default()

        customizable = _customizable()

        class _events(DynAccessor):
            __slots__ = ()

            class _anniversaryCN(DynAccessor):
                __slots__ = ()

                class _rarityOverlay(DynAccessor):
                    __slots__ = ()
                    lootBox_2408201 = DynAccessor(90888)

                rarityOverlay = _rarityOverlay()

            anniversaryCN = _anniversaryCN()

        events = _events()

    lootbox = _lootbox()

    class _platoon(DynAccessor):
        __slots__ = ()
        VoiceChat = DynAccessor(90889)

    platoon = _platoon()

    class _story_mode(DynAccessor):
        __slots__ = ()
        v_icon_fire = DynAccessor(90890)

    story_mode = _story_mode()