from gui.impl.gen_utils import DynAccessor

class Views(DynAccessor):
    __slots__ = ()

    class _battle(DynAccessor):
        __slots__ = ()

        class _battleRoyale(DynAccessor):
            __slots__ = ()

            class _select_respawn(DynAccessor):
                __slots__ = ()
                SelectRespawn = DynAccessor(8)

            select_respawn = _select_respawn()

        battleRoyale = _battleRoyale()

        class _battle_notifier(DynAccessor):
            __slots__ = ()
            BattleNotifierView = DynAccessor(79)

        battle_notifier = _battle_notifier()

        class _battle_page(DynAccessor):
            __slots__ = ()
            EpicRespawnAmmunitionPanelView = DynAccessor(80)
            PersonalReservesTabView = DynAccessor(81)
            PrebattleAmmunitionPanelView = DynAccessor(82)

        battle_page = _battle_page()

        class _death_cam(DynAccessor):
            __slots__ = ()
            DeathCamHudView = DynAccessor(83)
            DeathCamUIView = DynAccessor(84)
            MarkerView = DynAccessor(85)

        death_cam = _death_cam()

        class _dog_tags(DynAccessor):
            __slots__ = ()
            DogTagMarkerView = DynAccessor(86)

        dog_tags = _dog_tags()

        class _postmortem_panel(DynAccessor):
            __slots__ = ()
            PostmortemPanelView = DynAccessor(87)

        postmortem_panel = _postmortem_panel()

        class _prebattle(DynAccessor):
            __slots__ = ()
            PrebattleHintsView = DynAccessor(88)

        prebattle = _prebattle()

        class _timer(DynAccessor):
            __slots__ = ()
            TimerView = DynAccessor(89)

        timer = _timer()

    battle = _battle()

    class _common(DynAccessor):
        __slots__ = ()

        class _context_menu_window(DynAccessor):
            __slots__ = ()

            class _context_menu_content(DynAccessor):
                __slots__ = ()
                ContextMenuContent = DynAccessor(9)

            context_menu_content = _context_menu_content()

            class _context_menu_window(DynAccessor):
                __slots__ = ()
                ContextMenuWindow = DynAccessor(10)

            context_menu_window = _context_menu_window()

        context_menu_window = _context_menu_window()

        class _dialog_view(DynAccessor):
            __slots__ = ()

            class _dialog_window(DynAccessor):
                __slots__ = ()
                DialogWindow = DynAccessor(11)

            dialog_window = _dialog_window()

            class _simple_dialog_content(DynAccessor):
                __slots__ = ()
                SimpleDialogContent = DynAccessor(12)

            simple_dialog_content = _simple_dialog_content()

            class _components(DynAccessor):
                __slots__ = ()

                class _balance_contents(DynAccessor):
                    __slots__ = ()
                    CommonBalanceContent = DynAccessor(13)

                balance_contents = _balance_contents()

                class _checkbox_content(DynAccessor):
                    __slots__ = ()
                    CheckBoxDialogContent = DynAccessor(14)

                checkbox_content = _checkbox_content()

                class _dialog_prices_content(DynAccessor):
                    __slots__ = ()
                    DialogPricesContent = DynAccessor(15)

                dialog_prices_content = _dialog_prices_content()

                class _dialog_prices_tooltip(DynAccessor):
                    __slots__ = ()
                    DialogPricesTooltip = DynAccessor(16)

                dialog_prices_tooltip = _dialog_prices_tooltip()

            components = _components()

        dialog_view = _dialog_view()

        class _drop_down_menu_window(DynAccessor):
            __slots__ = ()

            class _drop_down_menu_content(DynAccessor):
                __slots__ = ()
                DropDownMenuContent = DynAccessor(17)

            drop_down_menu_content = _drop_down_menu_content()

            class _drop_down_menu_window(DynAccessor):
                __slots__ = ()
                DropDownMenuWindow = DynAccessor(18)

            drop_down_menu_window = _drop_down_menu_window()

        drop_down_menu_window = _drop_down_menu_window()

        class _pop_over_window(DynAccessor):
            __slots__ = ()

            class _backport_pop_over(DynAccessor):
                __slots__ = ()
                BackportPopOverContent = DynAccessor(19)
                BackportPopOverWindow = DynAccessor(20)

            backport_pop_over = _backport_pop_over()

            class _pop_over_window(DynAccessor):
                __slots__ = ()
                PopOverWindow = DynAccessor(21)

            pop_over_window = _pop_over_window()

        pop_over_window = _pop_over_window()

        class _standard_window(DynAccessor):
            __slots__ = ()

            class _standard_window(DynAccessor):
                __slots__ = ()
                StandardWindow = DynAccessor(22)

            standard_window = _standard_window()

        standard_window = _standard_window()

        class _tooltip_window(DynAccessor):
            __slots__ = ()

            class _advanced_tooltip_content(DynAccessor):
                __slots__ = ()
                AdvandcedTooltipContent = DynAccessor(23)
                AdvandcedAnimatedTooltipContent = DynAccessor(24)

            advanced_tooltip_content = _advanced_tooltip_content()

            class _backport_tooltip_content(DynAccessor):
                __slots__ = ()
                BackportTooltipContent = DynAccessor(25)

            backport_tooltip_content = _backport_tooltip_content()

            class _loot_box_compensation_tooltip(DynAccessor):
                __slots__ = ()
                LootBoxCompensationTooltipContent = DynAccessor(26)
                CrewSkinsCompensationTooltipContent = DynAccessor(27)
                LootBoxVehicleCompensationTooltipContent = DynAccessor(28)

            loot_box_compensation_tooltip = _loot_box_compensation_tooltip()

            class _simple_tooltip_content(DynAccessor):
                __slots__ = ()
                SimpleTooltipContent = DynAccessor(29)
                SimpleTooltipHtmlContent = DynAccessor(30)

            simple_tooltip_content = _simple_tooltip_content()

            class _tooltip_window(DynAccessor):
                __slots__ = ()
                TooltipWindow = DynAccessor(31)

            tooltip_window = _tooltip_window()

        tooltip_window = _tooltip_window()
        BackportContextMenu = DynAccessor(90)
        Browser = DynAccessor(91)
        FadingCoverView = DynAccessor(92)
        HintButton = DynAccessor(93)

        class _personal_reserves(DynAccessor):
            __slots__ = ()
            ReservesDisabledTooltip = DynAccessor(94)

        personal_reserves = _personal_reserves()

    common = _common()

    class _lobby(DynAccessor):
        __slots__ = ()

        class _battleRoyale(DynAccessor):
            __slots__ = ()

            class _event_info(DynAccessor):
                __slots__ = ()
                EventInfo = DynAccessor(32)

            event_info = _event_info()

        battleRoyale = _battleRoyale()

        class _battle_pass(DynAccessor):
            __slots__ = ()

            class _trophy_device_confirm_dialog(DynAccessor):
                __slots__ = ()
                TrophyDeviceConfirmDialogContent = DynAccessor(33)

            trophy_device_confirm_dialog = _trophy_device_confirm_dialog()
            BattlePassAwardsView = DynAccessor(149)
            BattlePassBuyLevelView = DynAccessor(150)
            BattlePassBuyView = DynAccessor(151)
            BattlePassDailyQuestsIntroView = DynAccessor(152)
            BattlePassEntryPointView = DynAccessor(153)
            BattlePassHowToEarnPointsView = DynAccessor(154)
            BattlePassIntroView = DynAccessor(155)
            BattlePassProgressionsView = DynAccessor(156)
            BattlePassVehicleAwardView = DynAccessor(157)
            ChapterChoiceView = DynAccessor(158)

            class _dialogs(DynAccessor):
                __slots__ = ()
                ChapterConfirm = DynAccessor(159)

            dialogs = _dialogs()
            ExtraIntroView = DynAccessor(160)
            FullscreenVideoView = DynAccessor(161)
            PostProgressionView = DynAccessor(162)
            RewardsSelectionView = DynAccessor(163)
            RewardsViewContent = DynAccessor(164)

            class _sharedComponents(DynAccessor):
                __slots__ = ()
                AnimatedReward = DynAccessor(165)
                AwardsWidget = DynAccessor(166)
                BuyButtons = DynAccessor(167)
                ChapterBackground = DynAccessor(168)
                CurrencyReward = DynAccessor(169)
                Emblem = DynAccessor(170)
                FormatRemainingDate = DynAccessor(171)
                Header = DynAccessor(172)
                Identity = DynAccessor(173)
                LoupeButton = DynAccessor(174)
                RewardsBlock = DynAccessor(175)
                ScrollWithLips = DynAccessor(176)
                Slider = DynAccessor(177)
                Title = DynAccessor(178)
                VehicleBonusList = DynAccessor(179)
                VehicleInfo = DynAccessor(180)
                VehicleList = DynAccessor(181)

            sharedComponents = _sharedComponents()
            TankmenVoiceoverView = DynAccessor(182)

            class _tooltips(DynAccessor):
                __slots__ = ()
                BattlePassCoinTooltipView = DynAccessor(183)
                BattlePassCompletedTooltipView = DynAccessor(184)
                BattlePassGoldMissionTooltipView = DynAccessor(185)
                BattlePassInProgressTooltipView = DynAccessor(186)
                BattlePassLockIconTooltipView = DynAccessor(187)
                BattlePassNoChapterTooltipView = DynAccessor(188)
                BattlePassNotStartedTooltipView = DynAccessor(189)
                BattlePassOnPauseTooltipView = DynAccessor(190)
                BattlePassPointsView = DynAccessor(191)
                BattlePassQuestsChainTooltipView = DynAccessor(192)
                BattlePassUpgradeStyleTooltipView = DynAccessor(193)
                RandomQuestTooltip = DynAccessor(194)

                class _sharedComponents(DynAccessor):
                    __slots__ = ()
                    BlockCompleted = DynAccessor(195)
                    Chose = DynAccessor(196)
                    FinalLevel = DynAccessor(197)
                    IconTextBlock = DynAccessor(198)
                    PerBattlePointsTable = DynAccessor(199)
                    Point = DynAccessor(200)

                sharedComponents = _sharedComponents()
                VehiclePointsTooltipView = DynAccessor(201)

            tooltips = _tooltips()

        battle_pass = _battle_pass()

        class _blueprints(DynAccessor):
            __slots__ = ()

            class _fragments_balance_content(DynAccessor):
                __slots__ = ()
                FragmentsBalanceContent = DynAccessor(34)

            fragments_balance_content = _fragments_balance_content()

            class _blueprint_screen(DynAccessor):
                __slots__ = ()

                class _blueprint_screen(DynAccessor):
                    __slots__ = ()
                    BlueprintScreen = DynAccessor(35)

                blueprint_screen = _blueprint_screen()

            blueprint_screen = _blueprint_screen()
            Confirm = DynAccessor(206)

            class _tooltips(DynAccessor):
                __slots__ = ()
                BlueprintsAlliancesTooltipView = DynAccessor(207)

            tooltips = _tooltips()

        blueprints = _blueprints()

        class _common(DynAccessor):
            __slots__ = ()

            class _congrats(DynAccessor):
                __slots__ = ()

                class _common_congrats_view(DynAccessor):
                    __slots__ = ()
                    CommonCongratsView = DynAccessor(36)

                common_congrats_view = _common_congrats_view()

            congrats = _congrats()
            AwardsView = DynAccessor(216)
            BrowserView = DynAccessor(217)
            RewardSelection = DynAccessor(218)
            SelectableRewardBase = DynAccessor(219)
            SelectSlotSpecDialog = DynAccessor(220)

            class _tooltips(DynAccessor):
                __slots__ = ()
                ExtendedTextTooltip = DynAccessor(221)
                SelectedRewardsTooltipView = DynAccessor(222)

            tooltips = _tooltips()

        common = _common()

        class _marathon(DynAccessor):
            __slots__ = ()

            class _marathon_reward_view(DynAccessor):
                __slots__ = ()
                MarathonRewardView = DynAccessor(37)

            marathon_reward_view = _marathon_reward_view()
            EntryPoint = DynAccessor(358)
            RewardWindow = DynAccessor(359)

            class _tooltips(DynAccessor):
                __slots__ = ()
                RestRewardTooltip = DynAccessor(360)

            tooltips = _tooltips()

        marathon = _marathon()

        class _missions(DynAccessor):
            __slots__ = ()

            class _missions_tab_bar_view(DynAccessor):
                __slots__ = ()
                MissionsTabBarView = DynAccessor(38)

            missions_tab_bar_view = _missions_tab_bar_view()

            class _common(DynAccessor):
                __slots__ = ()
                BattleConditions = DynAccessor(362)
                Countdown = DynAccessor(363)
                PendingDots = DynAccessor(364)

            common = _common()
            Daily = DynAccessor(365)
            DailyQuestsTooltip = DynAccessor(366)
            DailyQuestsWidget = DynAccessor(367)
            RerollTooltip = DynAccessor(368)
            RerollTooltipWithCountdown = DynAccessor(369)

        missions = _missions()

        class _nation_change(DynAccessor):
            __slots__ = ()

            class _nation_change_screen(DynAccessor):
                __slots__ = ()
                NationChangeScreen = DynAccessor(39)

            nation_change_screen = _nation_change_screen()

        nation_change = _nation_change()

        class _premacc(DynAccessor):
            __slots__ = ()

            class _daily_experience_view(DynAccessor):
                __slots__ = ()
                DailyExperiencePage = DynAccessor(40)

            daily_experience_view = _daily_experience_view()

            class _maps_blacklist_view(DynAccessor):
                __slots__ = ()
                MapsBlacklistView = DynAccessor(41)

            maps_blacklist_view = _maps_blacklist_view()

            class _piggybank(DynAccessor):
                __slots__ = ()
                Piggybank = DynAccessor(42)

            piggybank = _piggybank()

            class _dashboard(DynAccessor):
                __slots__ = ()

                class _prem_dashboard_parent_control_info(DynAccessor):
                    __slots__ = ()
                    PremDashboardParentControlInfoContent = DynAccessor(43)

                prem_dashboard_parent_control_info = _prem_dashboard_parent_control_info()

                class _piggy_bank_cards(DynAccessor):
                    __slots__ = ()

                    class _prem_piggy_bank(DynAccessor):
                        __slots__ = ()
                        PremPiggyBankCard = DynAccessor(44)

                    prem_piggy_bank = _prem_piggy_bank()

                    class _wot_plus_piggy_bank(DynAccessor):
                        __slots__ = ()
                        WotPlusPiggyBankCard = DynAccessor(45)

                    wot_plus_piggy_bank = _wot_plus_piggy_bank()

                piggy_bank_cards = _piggy_bank_cards()

            dashboard = _dashboard()

            class _maps_blacklist(DynAccessor):
                __slots__ = ()

                class _maps_blacklist_confirm_dialog(DynAccessor):
                    __slots__ = ()
                    MapsBlacklistConfirmDialogContent = DynAccessor(46)

                maps_blacklist_confirm_dialog = _maps_blacklist_confirm_dialog()

                class _maps_blacklist_tooltips(DynAccessor):
                    __slots__ = ()
                    MapsBlacklistInfoTooltipContent = DynAccessor(47)

                maps_blacklist_tooltips = _maps_blacklist_tooltips()

            maps_blacklist = _maps_blacklist()

            class _tooltips(DynAccessor):
                __slots__ = ()
                SquadBonusTooltip = DynAccessor(406)

            tooltips = _tooltips()

        premacc = _premacc()

        class _progressive_reward(DynAccessor):
            __slots__ = ()

            class _progressive_reward_award(DynAccessor):
                __slots__ = ()
                ProgressiveRewardAward = DynAccessor(48)

            progressive_reward_award = _progressive_reward_award()

            class _progressive_reward_view(DynAccessor):
                __slots__ = ()
                ProgressiveRewardView = DynAccessor(49)

            progressive_reward_view = _progressive_reward_view()

        progressive_reward = _progressive_reward()

        class _ranked(DynAccessor):
            __slots__ = ()

            class _ranked_year_award(DynAccessor):
                __slots__ = ()
                RankedYearAward = DynAccessor(50)

            ranked_year_award = _ranked_year_award()
            EntryPoint = DynAccessor(415)
            QualificationRewardsView = DynAccessor(416)
            RankedSelectableRewardView = DynAccessor(417)

            class _tooltips(DynAccessor):
                __slots__ = ()
                RankedBattlesRolesTooltipView = DynAccessor(418)

            tooltips = _tooltips()
            YearLeaderboardView = DynAccessor(419)

        ranked = _ranked()

        class _reward_window(DynAccessor):
            __slots__ = ()

            class _clan_reward_window_content(DynAccessor):
                __slots__ = ()
                ClanRewardWindowContent = DynAccessor(51)

            clan_reward_window_content = _clan_reward_window_content()

            class _piggy_bank_reward_window_content(DynAccessor):
                __slots__ = ()
                PiggyBankRewardWindowContent = DynAccessor(52)

            piggy_bank_reward_window_content = _piggy_bank_reward_window_content()

            class _reward_window_content(DynAccessor):
                __slots__ = ()
                RewardWindowContent = DynAccessor(53)

            reward_window_content = _reward_window_content()

            class _twitch_reward_window_content(DynAccessor):
                __slots__ = ()
                TwitchRewardWindowContent = DynAccessor(54)

            twitch_reward_window_content = _twitch_reward_window_content()

        reward_window = _reward_window()

        class _tooltips(DynAccessor):
            __slots__ = ()

            class _clans(DynAccessor):
                __slots__ = ()
                ClanShortInfoTooltipContent = DynAccessor(55)

            clans = _clans()
            AdditionalRewardsTooltip = DynAccessor(498)
            BattleResultsStatsTooltipView = DynAccessor(499)
            TankmanTooltipView = DynAccessor(500)
            VehPostProgressionEntryPointTooltip = DynAccessor(501)

        tooltips = _tooltips()

        class _video(DynAccessor):
            __slots__ = ()

            class _video_view(DynAccessor):
                __slots__ = ()
                VideoView = DynAccessor(56)

            video_view = _video_view()

        video = _video()

        class _account_completion(DynAccessor):
            __slots__ = ()
            AddCredentialsView = DynAccessor(115)
            ConfirmCredentialsView = DynAccessor(116)
            CurtainView = DynAccessor(117)
            SteamEmailConfirmRewardsView = DynAccessor(118)

            class _tooltips(DynAccessor):
                __slots__ = ()
                HangarTooltip = DynAccessor(119)

            tooltips = _tooltips()

        account_completion = _account_completion()

        class _account_dashboard(DynAccessor):
            __slots__ = ()
            AccountDashboard = DynAccessor(120)
            DailyExperienceView = DynAccessor(121)

        account_dashboard = _account_dashboard()

        class _achievements(DynAccessor):
            __slots__ = ()
            AchievementsMainView = DynAccessor(122)
            CatalogView = DynAccessor(123)

            class _dialogs(DynAccessor):
                __slots__ = ()
                EditConfirm = DynAccessor(124)

            dialogs = _dialogs()
            EarningPopUpView = DynAccessor(125)
            EditView = DynAccessor(126)
            RewardView = DynAccessor(127)

            class _tooltips(DynAccessor):
                __slots__ = ()
                AutoSettingTooltip = DynAccessor(128)
                BattlesKPITooltip = DynAccessor(129)
                EditingTooltip = DynAccessor(130)
                KPITooltip = DynAccessor(131)
                WOTPRMainTooltip = DynAccessor(132)
                WTRInfoTooltip = DynAccessor(133)
                WTRMainTooltip = DynAccessor(134)

            tooltips = _tooltips()

        achievements = _achievements()

        class _awards(DynAccessor):
            __slots__ = ()
            BadgeAwardView = DynAccessor(135)
            MultipleAwardsView = DynAccessor(136)

            class _tooltips(DynAccessor):
                __slots__ = ()
                RewardCompensationTooltip = DynAccessor(137)
                VehicleForChooseTooltip = DynAccessor(138)

            tooltips = _tooltips()

        awards = _awards()

        class _battle_matters(DynAccessor):
            __slots__ = ()
            BattleMattersEntryPointView = DynAccessor(139)
            BattleMattersExchangeRewards = DynAccessor(140)
            BattleMattersMainRewardView = DynAccessor(141)
            BattleMattersMainView = DynAccessor(142)
            BattleMattersPausedView = DynAccessor(143)
            BattleMattersRewardsView = DynAccessor(144)
            BattleMattersVehicleSelectionView = DynAccessor(145)

            class _popovers(DynAccessor):
                __slots__ = ()
                BattleMattersFilterPopoverView = DynAccessor(146)

            popovers = _popovers()

            class _tooltips(DynAccessor):
                __slots__ = ()
                BattleMattersEntryTooltipView = DynAccessor(147)
                BattleMattersTokenTooltipView = DynAccessor(148)

            tooltips = _tooltips()

        battle_matters = _battle_matters()

        class _battle_royale(DynAccessor):
            __slots__ = ()
            CommanderView = DynAccessor(202)

            class _sharedComponents(DynAccessor):
                __slots__ = ()
                CurrencyResolver = DynAccessor(203)
                PriceResolver = DynAccessor(204)

            sharedComponents = _sharedComponents()
            TechParametersVIew = DynAccessor(205)

        battle_royale = _battle_royale()

        class _clan_supply(DynAccessor):
            __slots__ = ()
            ClanSupply = DynAccessor(208)
            RewardsView = DynAccessor(209)

        clan_supply = _clan_supply()

        class _collection(DynAccessor):
            __slots__ = ()
            AwardsView = DynAccessor(210)
            CollectionItemPreview = DynAccessor(211)
            CollectionsMainView = DynAccessor(212)
            CollectionView = DynAccessor(213)
            IntroView = DynAccessor(214)

            class _tooltips(DynAccessor):
                __slots__ = ()
                CollectionItemTooltipView = DynAccessor(215)

            tooltips = _tooltips()

        collection = _collection()

        class _comp7(DynAccessor):
            __slots__ = ()
            Banner = DynAccessor(223)

            class _dialogs(DynAccessor):
                __slots__ = ()
                PurchaseDialog = DynAccessor(224)

            dialogs = _dialogs()
            IntroScreen = DynAccessor(225)
            MainWidget = DynAccessor(226)
            MetaRootView = DynAccessor(227)
            NoVehiclesScreen = DynAccessor(228)
            RewardsScreen = DynAccessor(229)
            SeasonModifier = DynAccessor(230)
            SeasonStatistics = DynAccessor(231)

            class _tooltips(DynAccessor):
                __slots__ = ()
                DivisionTooltip = DynAccessor(232)
                FifthRankTooltip = DynAccessor(233)
                GeneralRankTooltip = DynAccessor(234)
                LastUpdateTooltip = DynAccessor(235)
                MainWidgetTooltip = DynAccessor(236)
                RankInactivityTooltip = DynAccessor(237)
                SeasonPointTooltip = DynAccessor(238)
                SixthRankTooltip = DynAccessor(239)
                WidgetTooltipView = DynAccessor(240)

            tooltips = _tooltips()
            TournamentsWidget = DynAccessor(241)
            WhatsNewView = DynAccessor(242)
            YearlyRewardsSelectionScreen = DynAccessor(243)

        comp7 = _comp7()

        class _craft_machine(DynAccessor):
            __slots__ = ()
            CraftmachineEntryPointView = DynAccessor(244)

        craft_machine = _craft_machine()

        class _crew(DynAccessor):
            __slots__ = ()
            BarracksView = DynAccessor(245)
            ConversionConfirmView = DynAccessor(246)
            CrewHeaderTooltipView = DynAccessor(247)
            CrewIntroView = DynAccessor(248)

            class _dialogs(DynAccessor):
                __slots__ = ()
                CrewBooksPurchaseDialog = DynAccessor(249)
                DismissTankmanDialog = DynAccessor(250)
                DocumentChangeDialog = DynAccessor(251)
                EnlargeBarracksDialog = DynAccessor(252)
                PerksResetDialog = DynAccessor(253)
                RecruitDialog = DynAccessor(254)
                RecruitNewTankmanDialog = DynAccessor(255)
                RestoreTankmanDialog = DynAccessor(256)
                RetrainMassiveDialog = DynAccessor(257)
                RetrainSingleDialog = DynAccessor(258)
                SkinApplyDialog = DynAccessor(259)

            dialogs = _dialogs()
            HangarCrewWidget = DynAccessor(260)
            HelpView = DynAccessor(261)
            JunkTankmenView = DynAccessor(262)
            MemberChangeView = DynAccessor(263)

            class _personal_case(DynAccessor):
                __slots__ = ()

                class _component(DynAccessor):
                    __slots__ = ()
                    ScrollWithLips = DynAccessor(264)
                    TankmanInfoWrapper = DynAccessor(265)

                component = _component()
                PersonalDataView = DynAccessor(266)
                PersonalFileView = DynAccessor(267)
                ServiceRecordView = DynAccessor(268)

            personal_case = _personal_case()

            class _popovers(DynAccessor):
                __slots__ = ()
                FilterPopoverView = DynAccessor(269)

            popovers = _popovers()
            QuickTrainingView = DynAccessor(270)
            TankChangeView = DynAccessor(271)
            TankmanContainerView = DynAccessor(272)

            class _tooltips(DynAccessor):
                __slots__ = ()
                AdvancedTooltipView = DynAccessor(273)
                BunksConfirmDiscountTooltip = DynAccessor(274)
                ConversionTooltip = DynAccessor(275)
                CrewPerksAdditionalTooltip = DynAccessor(276)
                CrewPerksTooltip = DynAccessor(277)
                DismissedToggleTooltip = DynAccessor(278)
                ExperienceStepperTooltip = DynAccessor(279)
                PerkAvailableTooltip = DynAccessor(280)
                PremiumVehicleTooltip = DynAccessor(281)
                QuickTrainingDiscountTooltip = DynAccessor(282)
                SkillsEfficiencyTooltip = DynAccessor(283)
                SkillUntrainedAdditionalTooltip = DynAccessor(284)
                SkillUntrainedTooltip = DynAccessor(285)
                TankmanTooltip = DynAccessor(286)
                VehCmpSkillsTooltip = DynAccessor(287)
                VehicleParamsTooltipView = DynAccessor(288)

            tooltips = _tooltips()

            class _widgets(DynAccessor):
                __slots__ = ()
                ConversionBannerWidget = DynAccessor(289)
                CrewWidget = DynAccessor(290)
                FilterPanelWidget = DynAccessor(291)
                PriceList = DynAccessor(292)
                TankmanInfo = DynAccessor(293)

            widgets = _widgets()

        crew = _crew()

        class _crystalsPromo(DynAccessor):
            __slots__ = ()
            CrystalsPromoView = DynAccessor(294)

        crystalsPromo = _crystalsPromo()

        class _currency_reserves(DynAccessor):
            __slots__ = ()
            CurrencyReserves = DynAccessor(295)
            ReservesAwardView = DynAccessor(296)

        currency_reserves = _currency_reserves()

        class _customization(DynAccessor):
            __slots__ = ()
            CustomizationCart = DynAccessor(297)

            class _progression_styles(DynAccessor):
                __slots__ = ()
                OnboardingView = DynAccessor(298)
                StageSwitcher = DynAccessor(299)

            progression_styles = _progression_styles()

            class _progressive_items_reward(DynAccessor):
                __slots__ = ()
                ProgressiveItemsUpgradeView = DynAccessor(300)

            progressive_items_reward = _progressive_items_reward()

            class _progressive_items_view(DynAccessor):
                __slots__ = ()
                ProgressiveItemsView = DynAccessor(301)

            progressive_items_view = _progressive_items_view()

            class _style_unlocked_view(DynAccessor):
                __slots__ = ()
                StyleUnlockedView = DynAccessor(302)

            style_unlocked_view = _style_unlocked_view()

        customization = _customization()

        class _dedication(DynAccessor):
            __slots__ = ()
            DedicationRewardView = DynAccessor(303)

        dedication = _dedication()

        class _dog_tags(DynAccessor):
            __slots__ = ()
            AnimatedDogTagGradeTooltip = DynAccessor(304)
            AnimatedDogTagsView = DynAccessor(305)
            CatalogAnimatedDogTagTooltip = DynAccessor(306)
            CustomizationConfirmDialog = DynAccessor(307)
            DedicationTooltip = DynAccessor(308)
            DogTagsView = DynAccessor(309)
            RankedEfficiencyTooltip = DynAccessor(310)
            ThreeMonthsTooltip = DynAccessor(311)
            TriumphTooltip = DynAccessor(312)

        dog_tags = _dog_tags()

        class _elite_window(DynAccessor):
            __slots__ = ()
            EliteView = DynAccessor(313)

        elite_window = _elite_window()

        class _excluded_maps(DynAccessor):
            __slots__ = ()
            ExcludedMapsView = DynAccessor(314)

        excluded_maps = _excluded_maps()

        class _frontline(DynAccessor):
            __slots__ = ()

            class _dialogs(DynAccessor):
                __slots__ = ()
                BlankPrice = DynAccessor(315)

            dialogs = _dialogs()
            IntroScreen = DynAccessor(316)
            RewardsSelectionView = DynAccessor(317)

        frontline = _frontline()

        class _hangar(DynAccessor):
            __slots__ = ()
            BuyVehicleView = DynAccessor(318)

            class _notifications(DynAccessor):
                __slots__ = ()
                PunishmentView = DynAccessor(319)

            notifications = _notifications()

            class _subViews(DynAccessor):
                __slots__ = ()
                VehicleParams = DynAccessor(320)

            subViews = _subViews()
            VehicleParamsWidget = DynAccessor(321)

        hangar = _hangar()

        class _instructions(DynAccessor):
            __slots__ = ()
            BuyWindow = DynAccessor(322)
            SellWindow = DynAccessor(323)

        instructions = _instructions()

        class _live_ops_web_events(DynAccessor):
            __slots__ = ()
            EntryPoint = DynAccessor(324)
            EntryPointTooltip = DynAccessor(325)

        live_ops_web_events = _live_ops_web_events()

        class _lootbox_system(DynAccessor):
            __slots__ = ()
            AutoOpenView = DynAccessor(326)

            class _baseComponents(DynAccessor):
                __slots__ = ()
                AnimationCheckbox = DynAccessor(327)
                BigButton = DynAccessor(328)
                BigButtonIco = DynAccessor(329)

                class _common(DynAccessor):
                    __slots__ = ()
                    AlertIcon = DynAccessor(330)
                    Icon = DynAccessor(331)

                common = _common()
                Loader = DynAccessor(332)
                LoupeButton = DynAccessor(333)
                PurchaseButton = DynAccessor(334)
                ScrollWithLips = DynAccessor(335)
                SubTitle = DynAccessor(336)
                TankName = DynAccessor(337)
                Title = DynAccessor(338)
                VehicleInfo = DynAccessor(339)

            baseComponents = _baseComponents()
            EntryPointView = DynAccessor(340)
            InfoPage = DynAccessor(341)
            MainView = DynAccessor(342)

            class _tooltips(DynAccessor):
                __slots__ = ()
                BoxTooltip = DynAccessor(343)
                EntryPointTooltip = DynAccessor(344)
                GuaranteedRewardInfoTooltip = DynAccessor(345)
                RandomNationalBonusTooltipView = DynAccessor(346)
                StatisticsCategoryTooltipView = DynAccessor(347)

            tooltips = _tooltips()

        lootbox_system = _lootbox_system()

        class _mapbox(DynAccessor):
            __slots__ = ()
            MapBoxAwardsView = DynAccessor(348)
            MapBoxEntryPointView = DynAccessor(349)
            MapBoxIntro = DynAccessor(350)
            MapBoxProgression = DynAccessor(351)
            MapBoxRewardChoiceView = DynAccessor(352)
            MapBoxSurveyView = DynAccessor(353)

        mapbox = _mapbox()

        class _maps_training(DynAccessor):
            __slots__ = ()
            MapsTrainingPage = DynAccessor(354)
            MapsTrainingQueue = DynAccessor(355)
            MapsTrainingResult = DynAccessor(356)
            ScenarioTooltip = DynAccessor(357)

        maps_training = _maps_training()

        class _matchmaker(DynAccessor):
            __slots__ = ()
            ActiveTestConfirmView = DynAccessor(361)

        matchmaker = _matchmaker()

        class _mode_selector(DynAccessor):
            __slots__ = ()
            BattleSessionView = DynAccessor(370)
            ModeSelectorView = DynAccessor(371)

            class _popovers(DynAccessor):
                __slots__ = ()
                RandomBattlePopover = DynAccessor(372)

            popovers = _popovers()

            class _tooltips(DynAccessor):
                __slots__ = ()
                AlertTooltip = DynAccessor(373)

                class _common(DynAccessor):
                    __slots__ = ()
                    Divider = DynAccessor(374)
                    GradientDecorator = DynAccessor(375)

                common = _common()
                SimplyFormatTooltip = DynAccessor(376)

            tooltips = _tooltips()

            class _widgets(DynAccessor):
                __slots__ = ()
                BattleRoyaleProgressionWidget = DynAccessor(377)
                BattleRoyaleWidget = DynAccessor(378)
                Comp7LightProgressionWidget = DynAccessor(379)
                EpicWidget = DynAccessor(380)
                RankedWidget = DynAccessor(381)

            widgets = _widgets()

        mode_selector = _mode_selector()

        class _offers(DynAccessor):
            __slots__ = ()
            OfferBannerWindow = DynAccessor(382)
            OfferGiftsWindow = DynAccessor(383)
            OfferRewardWindow = DynAccessor(384)

        offers = _offers()

        class _personal_reserves(DynAccessor):
            __slots__ = ()
            BoosterTooltip = DynAccessor(385)
            PersonalReservesTooltip = DynAccessor(386)
            PersonalReservesWidget = DynAccessor(387)
            QuestBoosterTooltip = DynAccessor(388)
            ReserveCard = DynAccessor(389)
            ReserveCardTooltip = DynAccessor(390)
            ReserveGroup = DynAccessor(391)
            ReservesActivationView = DynAccessor(392)
            ReservesIntroView = DynAccessor(393)

        personal_reserves = _personal_reserves()

        class _platoon(DynAccessor):
            __slots__ = ()
            AlertTooltip = DynAccessor(394)
            MembersWindow = DynAccessor(395)
            PlatoonDropdown = DynAccessor(396)
            SearchingDropdown = DynAccessor(397)
            SettingsPopover = DynAccessor(398)

            class _subViews(DynAccessor):
                __slots__ = ()
                Chat = DynAccessor(399)
                SettingsContent = DynAccessor(400)
                TiersLimit = DynAccessor(401)

            subViews = _subViews()
            WTRTooltip = DynAccessor(402)

        platoon = _platoon()

        class _player_subscriptions(DynAccessor):
            __slots__ = ()
            PlayerSubscriptions = DynAccessor(403)
            SubscriptionItem = DynAccessor(404)
            SubscriptionRewardView = DynAccessor(405)

        player_subscriptions = _player_subscriptions()

        class _prestige(DynAccessor):
            __slots__ = ()

            class _sharedComponents(DynAccessor):
                __slots__ = ()
                PrestigeProgressSymbol = DynAccessor(407)
                PrestigeProgressTab = DynAccessor(408)

            sharedComponents = _sharedComponents()

            class _tooltips(DynAccessor):
                __slots__ = ()
                EliteLevelGradesTooltip = DynAccessor(409)

            tooltips = _tooltips()

            class _views(DynAccessor):
                __slots__ = ()
                GlobalOnboardingView = DynAccessor(410)
                PrestigeHangarEntryPoint = DynAccessor(411)
                PrestigeProfileTechniqueEmblemView = DynAccessor(412)
                PrestigeProfileTechniqueView = DynAccessor(413)
                PrestigeRewardView = DynAccessor(414)

            views = _views()

        prestige = _prestige()

        class _research(DynAccessor):
            __slots__ = ()
            BuyModuleDialogView = DynAccessor(420)
            InsufficientCreditsTooltip = DynAccessor(421)
            SoldModuleInfoTooltip = DynAccessor(422)

        research = _research()

        class _resource_well(DynAccessor):
            __slots__ = ()
            AwardView = DynAccessor(423)
            CompletedProgressionView = DynAccessor(424)
            EntryPoint = DynAccessor(425)
            IntroView = DynAccessor(426)
            NoSerialVehiclesConfirm = DynAccessor(427)
            NoVehiclesConfirm = DynAccessor(428)
            ProgressionView = DynAccessor(429)
            ResourcesLoadingConfirm = DynAccessor(430)
            ResourcesLoadingView = DynAccessor(431)

            class _sharedComponents(DynAccessor):
                __slots__ = ()

                class _award(DynAccessor):
                    __slots__ = ()
                    AdditionalReward = DynAccessor(432)
                    Footer = DynAccessor(433)
                    Header = DynAccessor(434)
                    Reward = DynAccessor(435)

                award = _award()
                Counter = DynAccessor(436)
                NoVehiclesState = DynAccessor(437)
                Resource = DynAccessor(438)
                VehicleCount = DynAccessor(439)
                VehicleInfo = DynAccessor(440)

            sharedComponents = _sharedComponents()

            class _tooltips(DynAccessor):
                __slots__ = ()
                EntryPointTooltip = DynAccessor(441)
                MaxProgressTooltip = DynAccessor(442)
                ProgressTooltip = DynAccessor(443)
                RefundResourcesTooltip = DynAccessor(444)
                SerialNumberTooltip = DynAccessor(445)

            tooltips = _tooltips()

        resource_well = _resource_well()

        class _seniority_awards(DynAccessor):
            __slots__ = ()
            SeniorityAwardsTooltip = DynAccessor(446)
            SeniorityAwardsView = DynAccessor(447)
            SeniorityVehiclesAwardsView = DynAccessor(448)

            class _sharedComponents(DynAccessor):
                __slots__ = ()
                FormatGradientText = DynAccessor(449)
                SeniorityAwardCoin = DynAccessor(450)
                SeniorityAwardsScroll = DynAccessor(451)
                SeniorityAwardsViewFooter = DynAccessor(452)
                SeniorityAwardsViewHeader = DynAccessor(453)

            sharedComponents = _sharedComponents()

        seniority_awards = _seniority_awards()

        class _stronghold(DynAccessor):
            __slots__ = ()
            StrongholdEntryPointView = DynAccessor(454)

        stronghold = _stronghold()

        class _subscription(DynAccessor):
            __slots__ = ()
            SubscriptionAwardView = DynAccessor(455)
            WotPlusIntroView = DynAccessor(456)
            WotPlusTooltip = DynAccessor(457)

        subscription = _subscription()

        class _tanksetup(DynAccessor):
            __slots__ = ()
            AmmunitionPanel = DynAccessor(458)

            class _common(DynAccessor):
                __slots__ = ()
                Action = DynAccessor(459)
                CtaButtons = DynAccessor(460)
                DealPanel = DynAccessor(461)
                ExtraImage = DynAccessor(462)
                FormatColorTagText = DynAccessor(463)
                MaybeWrapper = DynAccessor(464)
                Price = DynAccessor(465)
                SetupApp = DynAccessor(466)
                ShortenedText = DynAccessor(467)
                Slider = DynAccessor(468)

                class _SlotParts(DynAccessor):
                    __slots__ = ()
                    Bonus = DynAccessor(469)
                    Container = DynAccessor(470)
                    Count = DynAccessor(471)
                    Inside = DynAccessor(472)
                    Level = DynAccessor(473)

                SlotParts = _SlotParts()
                Specializations = DynAccessor(474)
                Storage = DynAccessor(475)
                SwitchButton = DynAccessor(476)
                SwitchEquipment = DynAccessor(477)

                class _Transitions(DynAccessor):
                    __slots__ = ()
                    SlotTransitions = DynAccessor(478)

                Transitions = _Transitions()
                WeaponOccupancy = DynAccessor(479)

            common = _common()
            DeconstructionDeviceView = DynAccessor(480)

            class _dialogs(DynAccessor):
                __slots__ = ()
                Confirm = DynAccessor(481)
                ConfirmActionsWithEquipmentDialog = DynAccessor(482)
                DeconstructConfirm = DynAccessor(483)
                DeviceUpgradeDialog = DynAccessor(484)
                ExchangeToBuyItems = DynAccessor(485)
                ExchangeToUpgradeItems = DynAccessor(486)
                NeedRepair = DynAccessor(487)
                RefillShells = DynAccessor(488)
                Sell = DynAccessor(489)

            dialogs = _dialogs()
            HangarAmmunitionSetup = DynAccessor(490)
            IntroScreen = DynAccessor(491)

            class _tooltips(DynAccessor):
                __slots__ = ()
                DeconstructFromInventoryTooltip = DynAccessor(492)
                DeconstructFromVehicleTooltip = DynAccessor(493)
                SetupTabTooltipView = DynAccessor(494)
                WarningTooltipView = DynAccessor(495)

            tooltips = _tooltips()
            VehicleCompareAmmunitionPanel = DynAccessor(496)
            VehicleCompareAmmunitionSetup = DynAccessor(497)

        tanksetup = _tanksetup()

        class _vehicle_compare(DynAccessor):
            __slots__ = ()
            CompareModificationsPanelView = DynAccessor(502)
            SelectSlotSpecCompareDialog = DynAccessor(503)

        vehicle_compare = _vehicle_compare()

        class _vehicle_preview(DynAccessor):
            __slots__ = ()

            class _buying_panel(DynAccessor):
                __slots__ = ()
                StyleBuyingPanel = DynAccessor(504)
                VPProgressionStylesBuyingPanel = DynAccessor(505)
                WellPanel = DynAccessor(506)

            buying_panel = _buying_panel()

            class _top_panel(DynAccessor):
                __slots__ = ()
                TopPanelTabs = DynAccessor(507)

            top_panel = _top_panel()

        vehicle_preview = _vehicle_preview()

        class _veh_post_progression(DynAccessor):
            __slots__ = ()

            class _common(DynAccessor):
                __slots__ = ()
                Bonus = DynAccessor(508)
                Description = DynAccessor(509)
                Grid = DynAccessor(510)
                PersistentBonuses = DynAccessor(511)
                Slide = DynAccessor(512)
                SlideContent = DynAccessor(513)
                Slider = DynAccessor(514)
                TextSplit = DynAccessor(515)

            common = _common()
            PostProgressionInfo = DynAccessor(516)
            PostProgressionIntro = DynAccessor(517)
            PostProgressionResearchSteps = DynAccessor(518)

            class _tooltip(DynAccessor):
                __slots__ = ()

                class _common(DynAccessor):
                    __slots__ = ()
                    DisabledBlock = DynAccessor(519)
                    FeatureLevelSubtitle = DynAccessor(520)
                    Lock = DynAccessor(521)
                    NotEnoughCredits = DynAccessor(522)
                    PriceBlock = DynAccessor(523)
                    Separator = DynAccessor(524)

                common = _common()
                PairModificationTooltipView = DynAccessor(525)
                PostProgressionLevelTooltipView = DynAccessor(526)
                RoleSlotTooltipView = DynAccessor(527)
                SetupTooltipView = DynAccessor(528)

            tooltip = _tooltip()
            VehiclePostProgressionCmpView = DynAccessor(529)
            VehiclePostProgressionView = DynAccessor(530)

        veh_post_progression = _veh_post_progression()

        class _winback(DynAccessor):
            __slots__ = ()

            class _popovers(DynAccessor):
                __slots__ = ()
                WinbackLeaveModePopoverView = DynAccessor(531)

            popovers = _popovers()

            class _tooltips(DynAccessor):
                __slots__ = ()
                MainRewardTooltip = DynAccessor(532)
                ModeInfoTooltip = DynAccessor(533)
                SelectableRewardTooltip = DynAccessor(534)
                SelectedRewardsTooltip = DynAccessor(535)

            tooltips = _tooltips()
            WinbackDailyQuestsIntroView = DynAccessor(536)
            WinbackLeaveModeDialogView = DynAccessor(537)
            WinbackRewardView = DynAccessor(538)
            WinbackSelectableRewardView = DynAccessor(539)

        winback = _winback()

        class _wot_anniversary(DynAccessor):
            __slots__ = ()
            EntryPoint = DynAccessor(540)
            IntroScreen = DynAccessor(541)
            MainView = DynAccessor(542)
            RewardScreen = DynAccessor(543)

            class _tooltips(DynAccessor):
                __slots__ = ()
                RandomRewardTooltip = DynAccessor(544)

            tooltips = _tooltips()
            WelcomeScreen = DynAccessor(545)

        wot_anniversary = _wot_anniversary()

    lobby = _lobby()

    class _test_check_box_view(DynAccessor):
        __slots__ = ()
        TestCheckBoxView = DynAccessor(57)

    test_check_box_view = _test_check_box_view()

    class _test_text_button_view(DynAccessor):
        __slots__ = ()
        TestTextButtonView = DynAccessor(58)

    test_text_button_view = _test_text_button_view()

    class _windows_layout_view(DynAccessor):
        __slots__ = ()
        WindowsLayountView = DynAccessor(59)

    windows_layout_view = _windows_layout_view()

    class _blend_mode(DynAccessor):
        __slots__ = ()

        class _blend_mode(DynAccessor):
            __slots__ = ()
            BlendMode = DynAccessor(60)

        blend_mode = _blend_mode()

    blend_mode = _blend_mode()

    class _demo_view(DynAccessor):
        __slots__ = ()

        class _views(DynAccessor):
            __slots__ = ()

            class _demo_window_content(DynAccessor):
                __slots__ = ()
                DemoWindowContent = DynAccessor(61)
                ImageProps = DynAccessor(62)

            demo_window_content = _demo_window_content()

            class _demo_window_details_panel(DynAccessor):
                __slots__ = ()
                DemoWindowDetailsPanel = DynAccessor(63)

            demo_window_details_panel = _demo_window_details_panel()

            class _demo_window_image_panel(DynAccessor):
                __slots__ = ()
                DemoWindowImagePanel = DynAccessor(64)

            demo_window_image_panel = _demo_window_image_panel()

            class _image_preview_window_content(DynAccessor):
                __slots__ = ()
                ImagePreviewWindowContent = DynAccessor(65)

            image_preview_window_content = _image_preview_window_content()

        views = _views()

    demo_view = _demo_view()

    class _examples(DynAccessor):
        __slots__ = ()

        class _views(DynAccessor):
            __slots__ = ()

            class _test_dialogs_view(DynAccessor):
                __slots__ = ()
                TestDialogsView = DynAccessor(66)

            test_dialogs_view = _test_dialogs_view()

            class _test_expr_functions_view(DynAccessor):
                __slots__ = ()
                TestExprFunctionsView = DynAccessor(67)

            test_expr_functions_view = _test_expr_functions_view()

            class _test_sub_view(DynAccessor):
                __slots__ = ()
                TestSubView = DynAccessor(68)

            test_sub_view = _test_sub_view()

            class _test_view(DynAccessor):
                __slots__ = ()
                TestView = DynAccessor(69)

            test_view = _test_view()

            class _unbound_example(DynAccessor):
                __slots__ = ()
                UnboundExample = DynAccessor(70)

            unbound_example = _unbound_example()

        views = _views()

    examples = _examples()

    class _list_examples(DynAccessor):
        __slots__ = ()

        class _views(DynAccessor):
            __slots__ = ()

            class _list_examples_empty_render_window_content(DynAccessor):
                __slots__ = ()
                ListExamplesEmptyRenderWindowContent = DynAccessor(71)

            list_examples_empty_render_window_content = _list_examples_empty_render_window_content()

            class _list_examples_window_content(DynAccessor):
                __slots__ = ()
                ListExamplesWindowContent = DynAccessor(72)

            list_examples_window_content = _list_examples_window_content()

        views = _views()

    list_examples = _list_examples()

    class _rotation_pivot_view(DynAccessor):
        __slots__ = ()

        class _views(DynAccessor):
            __slots__ = ()

            class _rotation_pivot_view(DynAccessor):
                __slots__ = ()
                RotationAndPivotTestView = DynAccessor(73)

            rotation_pivot_view = _rotation_pivot_view()

        views = _views()

    rotation_pivot_view = _rotation_pivot_view()

    class _rotation_view(DynAccessor):
        __slots__ = ()

        class _views(DynAccessor):
            __slots__ = ()

            class _rotation_view(DynAccessor):
                __slots__ = ()
                RotationTestView = DynAccessor(74)

            rotation_view = _rotation_view()

        views = _views()

    rotation_view = _rotation_view()

    class _scale_view(DynAccessor):
        __slots__ = ()

        class _views(DynAccessor):
            __slots__ = ()

            class _scale_view(DynAccessor):
                __slots__ = ()
                ScaleTestView = DynAccessor(75)

            scale_view = _scale_view()

        views = _views()

    scale_view = _scale_view()

    class _test_uikit_buttons_view(DynAccessor):
        __slots__ = ()

        class _views(DynAccessor):
            __slots__ = ()

            class _test_uikit_buttons_view(DynAccessor):
                __slots__ = ()
                TestUikitButtonsView = DynAccessor(76)

            test_uikit_buttons_view = _test_uikit_buttons_view()

        views = _views()

    test_uikit_buttons_view = _test_uikit_buttons_view()

    class _test_uikit_view(DynAccessor):
        __slots__ = ()

        class _views(DynAccessor):
            __slots__ = ()

            class _test_uikit_view(DynAccessor):
                __slots__ = ()
                TestUikitView = DynAccessor(77)

            test_uikit_view = _test_uikit_view()

        views = _views()

    test_uikit_view = _test_uikit_view()

    class _wtypes_view(DynAccessor):
        __slots__ = ()

        class _views(DynAccessor):
            __slots__ = ()

            class _wtypes_demo_window_content(DynAccessor):
                __slots__ = ()
                WtypesDemoWindowContent = DynAccessor(78)

            wtypes_demo_window_content = _wtypes_demo_window_content()

        views = _views()

    wtypes_view = _wtypes_view()

    class _dialogs(DynAccessor):
        __slots__ = ()

        class _common(DynAccessor):
            __slots__ = ()
            DialogTemplateGenericTooltip = DynAccessor(95)

        common = _common()
        DefaultDialog = DynAccessor(96)

        class _sub_views(DynAccessor):
            __slots__ = ()

            class _common(DynAccessor):
                __slots__ = ()
                SimpleText = DynAccessor(97)
                SinglePrice = DynAccessor(98)

            common = _common()

            class _content(DynAccessor):
                __slots__ = ()
                SelectOptionContent = DynAccessor(99)
                SimpleTextContent = DynAccessor(100)
                SinglePriceContent = DynAccessor(101)
                TextWithWarning = DynAccessor(102)

            content = _content()

            class _footer(DynAccessor):
                __slots__ = ()
                BRSinglePriceFooter = DynAccessor(103)
                SimpleTextFooter = DynAccessor(104)
                SinglePriceFooter = DynAccessor(105)

            footer = _footer()

            class _icon(DynAccessor):
                __slots__ = ()
                MultipleIconsSet = DynAccessor(106)

            icon = _icon()

            class _title(DynAccessor):
                __slots__ = ()
                SimpleTextTitle = DynAccessor(107)

            title = _title()

            class _topRight(DynAccessor):
                __slots__ = ()
                BRMoneyBalance = DynAccessor(108)
                MoneyBalance = DynAccessor(109)

            topRight = _topRight()

        sub_views = _sub_views()

        class _widgets(DynAccessor):
            __slots__ = ()
            IconSet = DynAccessor(110)
            MoneyBalance = DynAccessor(111)
            SinglePrice = DynAccessor(112)
            WarningText = DynAccessor(113)

        widgets = _widgets()

    dialogs = _dialogs()

    class _loading(DynAccessor):
        __slots__ = ()
        GameLoadingView = DynAccessor(114)

    loading = _loading()

    class _battle_modifiers(DynAccessor):
        __slots__ = ()

        class _lobby(DynAccessor):
            __slots__ = ()

            class _tooltips(DynAccessor):
                __slots__ = ()
                ModifiersDomainTooltipView = DynAccessor(546)

            tooltips = _tooltips()

        lobby = _lobby()

    battle_modifiers = _battle_modifiers()

    class _battle_royale(DynAccessor):
        __slots__ = ()

        class _battle(DynAccessor):
            __slots__ = ()

            class _views(DynAccessor):
                __slots__ = ()
                LeaveBattleView = DynAccessor(547)

            views = _views()

        battle = _battle()

        class _lobby(DynAccessor):
            __slots__ = ()

            class _tooltips(DynAccessor):
                __slots__ = ()
                AbilityTooltipView = DynAccessor(548)
                BrCoinTooltipView = DynAccessor(549)

                class _common(DynAccessor):
                    __slots__ = ()

                    class _LeaderBoard(DynAccessor):
                        __slots__ = ()
                        Column = DynAccessor(550)
                        Table = DynAccessor(551)

                    LeaderBoard = _LeaderBoard()

                common = _common()
                LeaderboardRewardTooltipView = DynAccessor(552)
                RespawnTooltipView = DynAccessor(553)
                RewardCurrencyTooltipView = DynAccessor(554)
                TabTooltipView = DynAccessor(555)
                TournamentBannerTooltipView = DynAccessor(556)
                VehicleTooltipView = DynAccessor(557)
                WidgetTooltipView = DynAccessor(558)

            tooltips = _tooltips()

            class _views(DynAccessor):
                __slots__ = ()
                BattleResultView = DynAccessor(559)
                BattleRoyaleEntryPoint = DynAccessor(560)
                BattleTypeSelectorView = DynAccessor(561)
                InfoPage = DynAccessor(562)
                IntroView = DynAccessor(563)
                PreBattleView = DynAccessor(564)
                ProxyCurrencyView = DynAccessor(565)
                TankSetupPanelView = DynAccessor(566)
                TournamentBannerView = DynAccessor(567)
                WidgetView = DynAccessor(568)

            views = _views()

        lobby = _lobby()

    battle_royale = _battle_royale()

    class _battle_royale_progression(DynAccessor):
        __slots__ = ()
        BattleQuestAwardsView = DynAccessor(569)
        ProgressionMainView = DynAccessor(570)

    battle_royale_progression = _battle_royale_progression()

    class _comp7_light_progression(DynAccessor):
        __slots__ = ()
        BattleQuestAwardsView = DynAccessor(571)
        LeaderboardRewardTooltipView = DynAccessor(572)
        ProgressionMainView = DynAccessor(573)

    comp7_light_progression = _comp7_light_progression()

    class _event_lootboxes(DynAccessor):
        __slots__ = ()

        class _lobby(DynAccessor):
            __slots__ = ()

            class _event_lootboxes(DynAccessor):
                __slots__ = ()
                EntryPointView = DynAccessor(574)
                OpenBoxErrorView = DynAccessor(575)
                OpenBoxScreen = DynAccessor(576)
                PopoverView = DynAccessor(577)

                class _shared(DynAccessor):
                    __slots__ = ()
                    AnimationControls = DynAccessor(578)
                    BuyBoxFooter = DynAccessor(579)
                    CloseBtn = DynAccessor(580)
                    Divider = DynAccessor(581)
                    Header = DynAccessor(582)

                shared = _shared()

                class _tooltips(DynAccessor):
                    __slots__ = ()
                    CompensationTooltip = DynAccessor(583)
                    EntryPointTooltip = DynAccessor(584)
                    LootBoxesTooltip = DynAccessor(585)

                tooltips = _tooltips()
                WelcomeScreen = DynAccessor(586)

            event_lootboxes = _event_lootboxes()

        lobby = _lobby()

    event_lootboxes = _event_lootboxes()

    class _frontline(DynAccessor):
        __slots__ = ()

        class _lobby(DynAccessor):
            __slots__ = ()
            BannerView = DynAccessor(587)

            class _dialogs(DynAccessor):
                __slots__ = ()
                ReservesConfirmDialog = DynAccessor(588)

            dialogs = _dialogs()
            FrontlineContainerView = DynAccessor(589)
            InfoView = DynAccessor(590)
            ProgressView = DynAccessor(591)
            RewardsView = DynAccessor(592)

            class _tooltips(DynAccessor):
                __slots__ = ()
                LevelReservesTooltip = DynAccessor(593)
                NotEnoughPointsTooltip = DynAccessor(594)
                SkillOrderTooltip = DynAccessor(595)

            tooltips = _tooltips()
            WelcomeView = DynAccessor(596)

        lobby = _lobby()

    frontline = _frontline()

    class _fun_random(DynAccessor):
        __slots__ = ()

        class _lobby(DynAccessor):
            __slots__ = ()

            class _feature(DynAccessor):
                __slots__ = ()
                FunRandomBattleResultsView = DynAccessor(597)
                FunRandomEntryPointView = DynAccessor(598)
                FunRandomHangarWidgetView = DynAccessor(599)
                FunRandomModeSubSelector = DynAccessor(600)
                FunRandomProgression = DynAccessor(601)
                FunRandomQuickFireGunsAmmunitionPanelView = DynAccessor(602)
                FunRandomRewardsView = DynAccessor(603)
                FunRandomStrengthsWeaknessesView = DynAccessor(604)
                FunRandomTierListView = DynAccessor(605)

            feature = _feature()

            class _tooltips(DynAccessor):
                __slots__ = ()
                FunRandomAlertTooltipView = DynAccessor(606)
                FunRandomBattleResultsEconomicTooltipView = DynAccessor(607)
                FunRandomLootBoxTooltipView = DynAccessor(608)
                FunRandomProgressionTooltipView = DynAccessor(609)
                FunRandomVehicleTooltipView = DynAccessor(610)

            tooltips = _tooltips()

        lobby = _lobby()

    fun_random = _fun_random()

    class _story_mode(DynAccessor):
        __slots__ = ()

        class _battle(DynAccessor):
            __slots__ = ()
            EpilogueWindow = DynAccessor(611)
            OnboardingBattleResultView = DynAccessor(612)
            PrebattleWindow = DynAccessor(613)

        battle = _battle()

        class _common(DynAccessor):
            __slots__ = ()
            CongratulationsWindow = DynAccessor(614)
            MedalTooltip = DynAccessor(615)
            OnboardingQueueView = DynAccessor(616)

        common = _common()

        class _lobby(DynAccessor):
            __slots__ = ()
            BattleResultStatTooltip = DynAccessor(617)
            BattleResultView = DynAccessor(618)
            DifficultyTooltip = DynAccessor(619)
            EntryPointView = DynAccessor(620)
            MissionSelectionView = DynAccessor(621)
            MissionTooltip = DynAccessor(622)
            TaskTooltip = DynAccessor(623)
            WelcomeView = DynAccessor(624)

        lobby = _lobby()

    story_mode = _story_mode()
    Anchor = DynAccessor(625)

    class _child_views_demo(DynAccessor):
        __slots__ = ()
        ChildDemoView = DynAccessor(626)
        MainView = DynAccessor(627)

    child_views_demo = _child_views_demo()
    Comp7DemoPageView = DynAccessor(628)
    ComponentsDemo = DynAccessor(629)
    DataLayerDemoView = DynAccessor(630)
    DataTrackerDemo = DynAccessor(631)
    DeathCamDemoView = DynAccessor(632)
    DemoContextMenu = DynAccessor(633)
    Easings = DynAccessor(634)
    GameLoadingDebugView = DynAccessor(635)
    GFCharset = DynAccessor(636)
    GFComponents = DynAccessor(637)
    GFDemoPopover = DynAccessor(638)
    GFDemoRichTooltipWindow = DynAccessor(639)
    GFDemoWindow = DynAccessor(640)
    GFHooksDemo = DynAccessor(641)
    GFInjectView = DynAccessor(642)
    GFInputCases = DynAccessor(643)
    GFSimpleTooltipWindow = DynAccessor(644)
    GFWebSubDemoWindow = DynAccessor(645)

    class _gf_dialogs_demo(DynAccessor):
        __slots__ = ()
        DefaultDialogProxy = DynAccessor(646)
        GFDialogsDemo = DynAccessor(647)

        class _sub_views(DynAccessor):
            __slots__ = ()
            DummyContent = DynAccessor(648)
            DummyFooter = DynAccessor(649)
            DummyIcon = DynAccessor(650)
            DummyStepper = DynAccessor(651)
            DummyTitle = DynAccessor(652)
            DummyTopRight = DynAccessor(653)

        sub_views = _sub_views()

    gf_dialogs_demo = _gf_dialogs_demo()

    class _gf_viewer(DynAccessor):
        __slots__ = ()
        GFViewerWindow = DynAccessor(654)

    gf_viewer = _gf_viewer()

    class _igb_demo(DynAccessor):
        __slots__ = ()
        BrowserFullscreenWindow = DynAccessor(655)
        BrowserWindow = DynAccessor(656)
        MainView = DynAccessor(657)

    igb_demo = _igb_demo()
    LocaleDemo = DynAccessor(658)
    MediaWrapperDemo = DynAccessor(659)
    MixBlendMode = DynAccessor(660)
    MixBlendModeAnimation = DynAccessor(661)
    ModeSelectorDemo = DynAccessor(662)
    ModeSelectorToolsetView = DynAccessor(663)
    PluralLocView = DynAccessor(664)
    PropsSupportDemo = DynAccessor(665)
    ReactSpringVizualizer = DynAccessor(666)
    SelectableRewardDemoView = DynAccessor(667)
    StructuralDataBindDemo = DynAccessor(668)

    class _sub_views_demo(DynAccessor):
        __slots__ = ()
        GFSubViewsDemo = DynAccessor(669)

        class _sub_views(DynAccessor):
            __slots__ = ()
            CustomizationCartProxy = DynAccessor(670)
            DailyProxy = DynAccessor(671)
            ProgressiveItemsViewProxy = DynAccessor(672)

        sub_views = _sub_views()

    sub_views_demo = _sub_views_demo()
    UILoggerDemo = DynAccessor(673)
    VideoSupportView = DynAccessor(674)
    W2CTestPageWindow = DynAccessor(675)
    WgcgMockView = DynAccessor(676)