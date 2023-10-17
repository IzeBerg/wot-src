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
            BattleNotifierView = DynAccessor(82)

        battle_notifier = _battle_notifier()

        class _battle_page(DynAccessor):
            __slots__ = ()
            EpicRespawnAmmunitionPanelView = DynAccessor(83)
            PersonalReservesTabView = DynAccessor(84)
            PrebattleAmmunitionPanelView = DynAccessor(85)

        battle_page = _battle_page()

        class _timer(DynAccessor):
            __slots__ = ()
            TimerView = DynAccessor(86)

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
        BackportContextMenu = DynAccessor(87)
        Browser = DynAccessor(88)
        FadingCoverView = DynAccessor(89)

        class _personal_reserves(DynAccessor):
            __slots__ = ()
            ReservesDisabledTooltip = DynAccessor(90)

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

            class _hangar_bottom_panel_cmp(DynAccessor):
                __slots__ = ()
                HangarBottomPanelCmp = DynAccessor(33)

            hangar_bottom_panel_cmp = _hangar_bottom_panel_cmp()

        battleRoyale = _battleRoyale()

        class _battle_pass(DynAccessor):
            __slots__ = ()

            class _trophy_device_confirm_dialog(DynAccessor):
                __slots__ = ()
                TrophyDeviceConfirmDialogContent = DynAccessor(34)

            trophy_device_confirm_dialog = _trophy_device_confirm_dialog()
            BattlePassAwardsView = DynAccessor(146)
            BattlePassBuyLevelView = DynAccessor(147)
            BattlePassBuyView = DynAccessor(148)
            BattlePassDailyQuestsIntroView = DynAccessor(149)
            BattlePassEntryPointView = DynAccessor(150)
            BattlePassHowToEarnPointsView = DynAccessor(151)
            BattlePassIntroView = DynAccessor(152)
            BattlePassProgressionsView = DynAccessor(153)
            BattlePassVehicleAwardView = DynAccessor(154)
            ChapterChoiceView = DynAccessor(155)

            class _dialogs(DynAccessor):
                __slots__ = ()
                ChapterConfirm = DynAccessor(156)

            dialogs = _dialogs()
            ExtraIntroView = DynAccessor(157)
            FullscreenVideoView = DynAccessor(158)
            RewardsSelectionView = DynAccessor(159)

            class _sharedComponents(DynAccessor):
                __slots__ = ()
                AnimatedReward = DynAccessor(160)
                AwardsWidget = DynAccessor(161)
                BuyButtons = DynAccessor(162)
                ChapterBackground = DynAccessor(163)
                CurrencyReward = DynAccessor(164)
                Emblem = DynAccessor(165)
                FormatRemainingDate = DynAccessor(166)
                Header = DynAccessor(167)
                LoupeButton = DynAccessor(168)
                RewardsBlock = DynAccessor(169)
                ScrollWithLips = DynAccessor(170)
                Slider = DynAccessor(171)
                Title = DynAccessor(172)
                VehicleBonusList = DynAccessor(173)
                VehicleInfo = DynAccessor(174)
                VehicleList = DynAccessor(175)

            sharedComponents = _sharedComponents()
            TankmenVoiceoverView = DynAccessor(176)

            class _tooltips(DynAccessor):
                __slots__ = ()
                BattlePassCoinTooltipView = DynAccessor(177)
                BattlePassCompletedTooltipView = DynAccessor(178)
                BattlePassGoldMissionTooltipView = DynAccessor(179)
                BattlePassInProgressTooltipView = DynAccessor(180)
                BattlePassLockIconTooltipView = DynAccessor(181)
                BattlePassNoChapterTooltipView = DynAccessor(182)
                BattlePassNotStartedTooltipView = DynAccessor(183)
                BattlePassOnPauseTooltipView = DynAccessor(184)
                BattlePassPointsView = DynAccessor(185)
                BattlePassQuestsChainTooltipView = DynAccessor(186)
                BattlePassUpgradeStyleTooltipView = DynAccessor(187)
                RandomQuestTooltip = DynAccessor(188)

                class _sharedComponents(DynAccessor):
                    __slots__ = ()
                    BlockCompleted = DynAccessor(189)
                    Chose = DynAccessor(190)
                    FinalLevel = DynAccessor(191)
                    IconTextBlock = DynAccessor(192)
                    PerBattlePointsTable = DynAccessor(193)
                    Point = DynAccessor(194)

                sharedComponents = _sharedComponents()
                VehiclePointsTooltipView = DynAccessor(195)

            tooltips = _tooltips()

        battle_pass = _battle_pass()

        class _blueprints(DynAccessor):
            __slots__ = ()

            class _fragments_balance_content(DynAccessor):
                __slots__ = ()
                FragmentsBalanceContent = DynAccessor(35)

            fragments_balance_content = _fragments_balance_content()

            class _blueprint_screen(DynAccessor):
                __slots__ = ()

                class _blueprint_screen(DynAccessor):
                    __slots__ = ()
                    BlueprintScreen = DynAccessor(36)

                blueprint_screen = _blueprint_screen()

            blueprint_screen = _blueprint_screen()
            Confirm = DynAccessor(201)

            class _tooltips(DynAccessor):
                __slots__ = ()
                BlueprintsAlliancesTooltipView = DynAccessor(202)

            tooltips = _tooltips()

        blueprints = _blueprints()

        class _common(DynAccessor):
            __slots__ = ()

            class _congrats(DynAccessor):
                __slots__ = ()

                class _common_congrats_view(DynAccessor):
                    __slots__ = ()
                    CommonCongratsView = DynAccessor(37)

                common_congrats_view = _common_congrats_view()

            congrats = _congrats()
            AwardsView = DynAccessor(216)
            BrowserView = DynAccessor(217)
            SelectableRewardBase = DynAccessor(218)
            SelectSlotSpecDialog = DynAccessor(219)

            class _tooltips(DynAccessor):
                __slots__ = ()
                ExtendedTextTooltip = DynAccessor(220)
                SelectedRewardsTooltipView = DynAccessor(221)

            tooltips = _tooltips()

        common = _common()

        class _marathon(DynAccessor):
            __slots__ = ()

            class _marathon_reward_view(DynAccessor):
                __slots__ = ()
                MarathonRewardView = DynAccessor(38)

            marathon_reward_view = _marathon_reward_view()
            EntryPoint = DynAccessor(318)
            RewardWindow = DynAccessor(319)

            class _tooltips(DynAccessor):
                __slots__ = ()
                RestRewardTooltip = DynAccessor(320)

            tooltips = _tooltips()

        marathon = _marathon()

        class _missions(DynAccessor):
            __slots__ = ()

            class _missions_tab_bar_view(DynAccessor):
                __slots__ = ()
                MissionsTabBarView = DynAccessor(39)

            missions_tab_bar_view = _missions_tab_bar_view()

            class _common(DynAccessor):
                __slots__ = ()
                BattleConditions = DynAccessor(322)
                Countdown = DynAccessor(323)
                PendingDots = DynAccessor(324)

            common = _common()
            Daily = DynAccessor(325)
            DailyQuestsTooltip = DynAccessor(326)
            DailyQuestsWidget = DynAccessor(327)
            RerollTooltip = DynAccessor(328)
            RerollTooltipWithCountdown = DynAccessor(329)

        missions = _missions()

        class _nation_change(DynAccessor):
            __slots__ = ()

            class _nation_change_screen(DynAccessor):
                __slots__ = ()
                NationChangeScreen = DynAccessor(40)

            nation_change_screen = _nation_change_screen()

        nation_change = _nation_change()

        class _premacc(DynAccessor):
            __slots__ = ()

            class _daily_experience_view(DynAccessor):
                __slots__ = ()
                DailyExperiencePage = DynAccessor(41)

            daily_experience_view = _daily_experience_view()

            class _maps_blacklist_view(DynAccessor):
                __slots__ = ()
                MapsBlacklistView = DynAccessor(42)

            maps_blacklist_view = _maps_blacklist_view()

            class _piggybank(DynAccessor):
                __slots__ = ()
                Piggybank = DynAccessor(43)

            piggybank = _piggybank()

            class _squad_bonus_tooltip_content(DynAccessor):
                __slots__ = ()
                SquadBonusTooltipContent = DynAccessor(44)

            squad_bonus_tooltip_content = _squad_bonus_tooltip_content()

            class _dashboard(DynAccessor):
                __slots__ = ()

                class _prem_dashboard_parent_control_info(DynAccessor):
                    __slots__ = ()
                    PremDashboardParentControlInfoContent = DynAccessor(45)

                prem_dashboard_parent_control_info = _prem_dashboard_parent_control_info()

                class _piggy_bank_cards(DynAccessor):
                    __slots__ = ()

                    class _prem_piggy_bank(DynAccessor):
                        __slots__ = ()
                        PremPiggyBankCard = DynAccessor(46)

                    prem_piggy_bank = _prem_piggy_bank()

                    class _wot_plus_piggy_bank(DynAccessor):
                        __slots__ = ()
                        WotPlusPiggyBankCard = DynAccessor(47)

                    wot_plus_piggy_bank = _wot_plus_piggy_bank()

                piggy_bank_cards = _piggy_bank_cards()

            dashboard = _dashboard()

            class _maps_blacklist(DynAccessor):
                __slots__ = ()

                class _maps_blacklist_confirm_dialog(DynAccessor):
                    __slots__ = ()
                    MapsBlacklistConfirmDialogContent = DynAccessor(48)

                maps_blacklist_confirm_dialog = _maps_blacklist_confirm_dialog()

                class _maps_blacklist_tooltips(DynAccessor):
                    __slots__ = ()
                    MapsBlacklistInfoTooltipContent = DynAccessor(49)

                maps_blacklist_tooltips = _maps_blacklist_tooltips()

            maps_blacklist = _maps_blacklist()

        premacc = _premacc()

        class _progressive_reward(DynAccessor):
            __slots__ = ()

            class _progressive_reward_award(DynAccessor):
                __slots__ = ()
                ProgressiveRewardAward = DynAccessor(50)

            progressive_reward_award = _progressive_reward_award()

            class _progressive_reward_view(DynAccessor):
                __slots__ = ()
                ProgressiveRewardView = DynAccessor(51)

            progressive_reward_view = _progressive_reward_view()

        progressive_reward = _progressive_reward()

        class _ranked(DynAccessor):
            __slots__ = ()

            class _ranked_year_award(DynAccessor):
                __slots__ = ()
                RankedYearAward = DynAccessor(52)

            ranked_year_award = _ranked_year_award()
            EntryPoint = DynAccessor(372)
            QualificationRewardsView = DynAccessor(373)
            RankedSelectableRewardView = DynAccessor(374)

            class _tooltips(DynAccessor):
                __slots__ = ()
                RankedBattlesRolesTooltipView = DynAccessor(375)

            tooltips = _tooltips()
            YearLeaderboardView = DynAccessor(376)

        ranked = _ranked()

        class _reward_window(DynAccessor):
            __slots__ = ()

            class _clan_reward_window_content(DynAccessor):
                __slots__ = ()
                ClanRewardWindowContent = DynAccessor(53)

            clan_reward_window_content = _clan_reward_window_content()

            class _piggy_bank_reward_window_content(DynAccessor):
                __slots__ = ()
                PiggyBankRewardWindowContent = DynAccessor(54)

            piggy_bank_reward_window_content = _piggy_bank_reward_window_content()

            class _reward_window_content(DynAccessor):
                __slots__ = ()
                RewardWindowContent = DynAccessor(55)

            reward_window_content = _reward_window_content()

            class _twitch_reward_window_content(DynAccessor):
                __slots__ = ()
                TwitchRewardWindowContent = DynAccessor(56)

            twitch_reward_window_content = _twitch_reward_window_content()

        reward_window = _reward_window()

        class _shop(DynAccessor):
            __slots__ = ()

            class _buy_vehicle_view(DynAccessor):
                __slots__ = ()
                BuyVehicleView = DynAccessor(57)

            buy_vehicle_view = _buy_vehicle_view()

        shop = _shop()

        class _tooltips(DynAccessor):
            __slots__ = ()

            class _clans(DynAccessor):
                __slots__ = ()
                ClanShortInfoTooltipContent = DynAccessor(58)

            clans = _clans()
            AdditionalRewardsTooltip = DynAccessor(454)
            TankmanTooltipView = DynAccessor(455)
            VehPostProgressionEntryPointTooltip = DynAccessor(456)

        tooltips = _tooltips()

        class _video(DynAccessor):
            __slots__ = ()

            class _video_view(DynAccessor):
                __slots__ = ()
                VideoView = DynAccessor(59)

            video_view = _video_view()

        video = _video()

        class _account_completion(DynAccessor):
            __slots__ = ()
            AddCredentialsView = DynAccessor(110)
            CompleteView = DynAccessor(111)
            ConfirmCredentialsView = DynAccessor(112)
            ContactSupportView = DynAccessor(113)
            CurtainView = DynAccessor(114)
            EmptyView = DynAccessor(115)
            ErrorView = DynAccessor(116)
            RenamingCompleteView = DynAccessor(117)
            RenamingView = DynAccessor(118)
            SteamEmailConfirmRewardsView = DynAccessor(119)

            class _tooltips(DynAccessor):
                __slots__ = ()
                HangarTooltip = DynAccessor(120)
                RenamingHangarTooltip = DynAccessor(121)

            tooltips = _tooltips()

        account_completion = _account_completion()

        class _account_dashboard(DynAccessor):
            __slots__ = ()
            AccountDashboard = DynAccessor(122)

        account_dashboard = _account_dashboard()

        class _achievements(DynAccessor):
            __slots__ = ()
            AchievementsMainView = DynAccessor(123)

            class _dialogs(DynAccessor):
                __slots__ = ()
                EditConfirm = DynAccessor(124)

            dialogs = _dialogs()
            EditView = DynAccessor(125)

            class _tooltips(DynAccessor):
                __slots__ = ()
                AutoSettingTooltip = DynAccessor(126)
                BattlesKPITooltip = DynAccessor(127)
                EditingTooltip = DynAccessor(128)
                KPITooltip = DynAccessor(129)
                WOTPRMainTooltip = DynAccessor(130)
                WTRInfoTooltip = DynAccessor(131)
                WTRMainTooltip = DynAccessor(132)

            tooltips = _tooltips()

        achievements = _achievements()

        class _awards(DynAccessor):
            __slots__ = ()
            BadgeAwardView = DynAccessor(133)
            MultipleAwardsView = DynAccessor(134)

            class _tooltips(DynAccessor):
                __slots__ = ()
                VehicleForChooseTooltip = DynAccessor(135)

            tooltips = _tooltips()

        awards = _awards()

        class _battle_matters(DynAccessor):
            __slots__ = ()
            BattleMattersEntryPointView = DynAccessor(136)
            BattleMattersExchangeRewards = DynAccessor(137)
            BattleMattersMainRewardView = DynAccessor(138)
            BattleMattersMainView = DynAccessor(139)
            BattleMattersPausedView = DynAccessor(140)
            BattleMattersRewardsView = DynAccessor(141)
            BattleMattersVehicleSelectionView = DynAccessor(142)

            class _popovers(DynAccessor):
                __slots__ = ()
                BattleMattersFilterPopoverView = DynAccessor(143)

            popovers = _popovers()

            class _tooltips(DynAccessor):
                __slots__ = ()
                BattleMattersEntryTooltipView = DynAccessor(144)
                BattleMattersTokenTooltipView = DynAccessor(145)

            tooltips = _tooltips()

        battle_matters = _battle_matters()

        class _battle_royale(DynAccessor):
            __slots__ = ()
            BattleResultView = DynAccessor(196)
            CommanderView = DynAccessor(197)

            class _sharedComponents(DynAccessor):
                __slots__ = ()
                CurrencyResolver = DynAccessor(198)
                PriceResolver = DynAccessor(199)

            sharedComponents = _sharedComponents()
            TechParametersVIew = DynAccessor(200)

        battle_royale = _battle_royale()

        class _bootcamp(DynAccessor):
            __slots__ = ()
            BootcampExitView = DynAccessor(203)
            BootcampFinalRewardView = DynAccessor(204)
            BootcampNationView = DynAccessor(205)
            BootcampProgressView = DynAccessor(206)
            BootcampProgressWidget = DynAccessor(207)
            BootcampQuestWidget = DynAccessor(208)
            RewardsTooltip = DynAccessor(209)

        bootcamp = _bootcamp()

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
            Banner = DynAccessor(222)
            IntroScreen = DynAccessor(223)
            MainWidget = DynAccessor(224)
            MetaRootView = DynAccessor(225)
            NoVehiclesScreen = DynAccessor(226)
            RewardsScreen = DynAccessor(227)
            SeasonModifier = DynAccessor(228)
            SeasonStatistics = DynAccessor(229)

            class _tooltips(DynAccessor):
                __slots__ = ()
                DivisionTooltip = DynAccessor(230)
                FifthRankTooltip = DynAccessor(231)
                GeneralRankTooltip = DynAccessor(232)
                LastUpdateTooltip = DynAccessor(233)
                MainWidgetTooltip = DynAccessor(234)
                RankInactivityTooltip = DynAccessor(235)
                SeasonPointTooltip = DynAccessor(236)
                SixthRankTooltip = DynAccessor(237)

            tooltips = _tooltips()
            WhatsNewView = DynAccessor(238)

        comp7 = _comp7()

        class _craft_machine(DynAccessor):
            __slots__ = ()
            CraftmachineEntryPointView = DynAccessor(239)

        craft_machine = _craft_machine()

        class _crew(DynAccessor):
            __slots__ = ()
            BarracksView = DynAccessor(240)
            CrewHeaderTooltipView = DynAccessor(241)
            CrewIntroView = DynAccessor(242)

            class _dialogs(DynAccessor):
                __slots__ = ()
                CrewBooksPurchaseDialog = DynAccessor(243)
                DismissTankmanDialog = DynAccessor(244)
                DocumentChangeDialog = DynAccessor(245)
                EnlargeBarracksDialog = DynAccessor(246)
                PerksResetContent = DynAccessor(247)
                RecruitDialog = DynAccessor(248)
                RecruitNewTankmanDialog = DynAccessor(249)
                RestoreTankmanDialog = DynAccessor(250)
                RetrainDialog = DynAccessor(251)
                RoleChangeDialog = DynAccessor(252)
                SkinApplyDialog = DynAccessor(253)

            dialogs = _dialogs()
            HangarCrewWidget = DynAccessor(254)
            HelpView = DynAccessor(255)
            MemberChangeView = DynAccessor(256)

            class _personal_case(DynAccessor):
                __slots__ = ()

                class _component(DynAccessor):
                    __slots__ = ()
                    ScrollWithLips = DynAccessor(257)
                    TankmanInfoWrapper = DynAccessor(258)

                component = _component()
                PersonalDataView = DynAccessor(259)
                PersonalFileView = DynAccessor(260)
                ServiceRecordView = DynAccessor(261)

            personal_case = _personal_case()

            class _popovers(DynAccessor):
                __slots__ = ()
                FilterPopoverView = DynAccessor(262)

            popovers = _popovers()
            QuickTrainingView = DynAccessor(263)
            TankChangeView = DynAccessor(264)
            TankmanContainerView = DynAccessor(265)

            class _tooltips(DynAccessor):
                __slots__ = ()
                AdvancedTooltipView = DynAccessor(266)
                BunksConfirmDiscountTooltip = DynAccessor(267)
                CrewPerksAdditionalTooltip = DynAccessor(268)
                CrewPerksTooltip = DynAccessor(269)
                DismissedToggleTooltip = DynAccessor(270)
                ExperienceStepperTooltip = DynAccessor(271)
                PerkAvailableTooltip = DynAccessor(272)
                PremiumVehicleTooltip = DynAccessor(273)
                QuickTrainingDiscountTooltip = DynAccessor(274)
                TankmanTooltip = DynAccessor(275)
                TrainingLevelTooltip = DynAccessor(276)
                VehCmpSkillsTooltip = DynAccessor(277)
                VehicleParamsTooltipView = DynAccessor(278)

            tooltips = _tooltips()

            class _widgets(DynAccessor):
                __slots__ = ()
                CrewWidget = DynAccessor(279)
                FilterPanelWidget = DynAccessor(280)
                PriceList = DynAccessor(281)
                TankmanInfo = DynAccessor(282)

            widgets = _widgets()

        crew = _crew()

        class _crystalsPromo(DynAccessor):
            __slots__ = ()
            CrystalsPromoView = DynAccessor(283)

        crystalsPromo = _crystalsPromo()

        class _currency_reserves(DynAccessor):
            __slots__ = ()
            CurrencyReserves = DynAccessor(284)
            ReservesAwardView = DynAccessor(285)

        currency_reserves = _currency_reserves()

        class _customization(DynAccessor):
            __slots__ = ()
            CustomizationCart = DynAccessor(286)

            class _progression_styles(DynAccessor):
                __slots__ = ()
                OnboardingView = DynAccessor(287)
                StageSwitcher = DynAccessor(288)

            progression_styles = _progression_styles()

            class _progressive_items_reward(DynAccessor):
                __slots__ = ()
                ProgressiveItemsUpgradeView = DynAccessor(289)

            progressive_items_reward = _progressive_items_reward()

            class _progressive_items_view(DynAccessor):
                __slots__ = ()
                ProgressiveItemsView = DynAccessor(290)

            progressive_items_view = _progressive_items_view()

            class _style_unlocked_view(DynAccessor):
                __slots__ = ()
                StyleUnlockedView = DynAccessor(291)

            style_unlocked_view = _style_unlocked_view()

        customization = _customization()

        class _dedication(DynAccessor):
            __slots__ = ()
            DedicationRewardView = DynAccessor(292)

        dedication = _dedication()

        class _dog_tags(DynAccessor):
            __slots__ = ()
            DedicationTooltip = DynAccessor(293)
            DogTagsView = DynAccessor(294)
            RankedEfficiencyTooltip = DynAccessor(295)
            ThreeMonthsTooltip = DynAccessor(296)
            TriumphTooltip = DynAccessor(297)

        dog_tags = _dog_tags()

        class _elite_window(DynAccessor):
            __slots__ = ()
            EliteView = DynAccessor(298)

        elite_window = _elite_window()

        class _excluded_maps(DynAccessor):
            __slots__ = ()
            ExcludedMapsView = DynAccessor(299)

        excluded_maps = _excluded_maps()

        class _frontline(DynAccessor):
            __slots__ = ()
            AwardsView = DynAccessor(300)

            class _dialogs(DynAccessor):
                __slots__ = ()
                BlankPrice = DynAccessor(301)

            dialogs = _dialogs()
            IntroScreen = DynAccessor(302)
            RewardsSelectionView = DynAccessor(303)

        frontline = _frontline()

        class _hangar(DynAccessor):
            __slots__ = ()

            class _subViews(DynAccessor):
                __slots__ = ()
                VehicleParams = DynAccessor(304)

            subViews = _subViews()
            VehicleParamsWidget = DynAccessor(305)

        hangar = _hangar()

        class _instructions(DynAccessor):
            __slots__ = ()
            BuyWindow = DynAccessor(306)
            SellWindow = DynAccessor(307)

        instructions = _instructions()

        class _mapbox(DynAccessor):
            __slots__ = ()
            MapBoxAwardsView = DynAccessor(308)
            MapBoxEntryPointView = DynAccessor(309)
            MapBoxIntro = DynAccessor(310)
            MapBoxProgression = DynAccessor(311)
            MapBoxRewardChoiceView = DynAccessor(312)
            MapBoxSurveyView = DynAccessor(313)

        mapbox = _mapbox()

        class _maps_training(DynAccessor):
            __slots__ = ()
            MapsTrainingPage = DynAccessor(314)
            MapsTrainingQueue = DynAccessor(315)
            MapsTrainingResult = DynAccessor(316)
            ScenarioTooltip = DynAccessor(317)

        maps_training = _maps_training()

        class _matchmaker(DynAccessor):
            __slots__ = ()
            ActiveTestConfirmView = DynAccessor(321)

        matchmaker = _matchmaker()

        class _mode_selector(DynAccessor):
            __slots__ = ()
            BattleSessionView = DynAccessor(330)
            ModeSelectorView = DynAccessor(331)

            class _popovers(DynAccessor):
                __slots__ = ()
                RandomBattlePopover = DynAccessor(332)

            popovers = _popovers()

            class _tooltips(DynAccessor):
                __slots__ = ()
                AlertTooltip = DynAccessor(333)

                class _common(DynAccessor):
                    __slots__ = ()
                    Divider = DynAccessor(334)
                    GradientDecorator = DynAccessor(335)

                common = _common()
                SimplyFormatTooltip = DynAccessor(336)

            tooltips = _tooltips()

            class _widgets(DynAccessor):
                __slots__ = ()
                BattleRoyaleProgressionWidget = DynAccessor(337)
                BattleRoyaleWidget = DynAccessor(338)
                EpicWidget = DynAccessor(339)
                RankedWidget = DynAccessor(340)

            widgets = _widgets()

        mode_selector = _mode_selector()

        class _offers(DynAccessor):
            __slots__ = ()
            OfferBannerWindow = DynAccessor(341)
            OfferGiftsWindow = DynAccessor(342)
            OfferRewardWindow = DynAccessor(343)

        offers = _offers()

        class _personal_reserves(DynAccessor):
            __slots__ = ()
            PersonalReservesTooltip = DynAccessor(344)
            PersonalReservesWidget = DynAccessor(345)
            ReserveCard = DynAccessor(346)
            ReserveCardTooltip = DynAccessor(347)
            ReserveGroup = DynAccessor(348)
            ReservesActivationView = DynAccessor(349)
            ReservesConversionView = DynAccessor(350)
            ReservesIntroView = DynAccessor(351)

        personal_reserves = _personal_reserves()

        class _platoon(DynAccessor):
            __slots__ = ()
            AlertTooltip = DynAccessor(352)
            MembersWindow = DynAccessor(353)
            PlatoonDropdown = DynAccessor(354)
            SearchingDropdown = DynAccessor(355)
            SettingsPopover = DynAccessor(356)

            class _subViews(DynAccessor):
                __slots__ = ()
                Chat = DynAccessor(357)
                SettingsContent = DynAccessor(358)
                TiersLimit = DynAccessor(359)

            subViews = _subViews()
            WTRTooltip = DynAccessor(360)

        platoon = _platoon()

        class _player_subscriptions(DynAccessor):
            __slots__ = ()
            PlayerSubscriptions = DynAccessor(361)
            SubscriptionItem = DynAccessor(362)
            SubscriptionRewardView = DynAccessor(363)

        player_subscriptions = _player_subscriptions()

        class _prestige(DynAccessor):
            __slots__ = ()

            class _sharedComponents(DynAccessor):
                __slots__ = ()
                PrestigeProgressSymbol = DynAccessor(364)
                PrestigeProgressTab = DynAccessor(365)

            sharedComponents = _sharedComponents()

            class _tooltips(DynAccessor):
                __slots__ = ()
                EliteLevelGradesTooltip = DynAccessor(366)

            tooltips = _tooltips()

            class _views(DynAccessor):
                __slots__ = ()
                GlobalOnboardingView = DynAccessor(367)
                PrestigeHangarEntryPoint = DynAccessor(368)
                PrestigeProfileTechniqueEmblemView = DynAccessor(369)
                PrestigeProfileTechniqueView = DynAccessor(370)
                PrestigeRewardView = DynAccessor(371)

            views = _views()

        prestige = _prestige()

        class _research(DynAccessor):
            __slots__ = ()
            BuyModuleDialogView = DynAccessor(377)
            InsufficientCreditsTooltip = DynAccessor(378)
            SoldModuleInfoTooltip = DynAccessor(379)

        research = _research()

        class _resource_well(DynAccessor):
            __slots__ = ()
            AwardView = DynAccessor(380)
            CompletedProgressionView = DynAccessor(381)
            EntryPoint = DynAccessor(382)
            IntroView = DynAccessor(383)
            NoSerialVehiclesConfirm = DynAccessor(384)
            NoVehiclesConfirm = DynAccessor(385)
            ProgressionView = DynAccessor(386)
            ResourcesLoadingConfirm = DynAccessor(387)
            ResourcesLoadingView = DynAccessor(388)

            class _sharedComponents(DynAccessor):
                __slots__ = ()

                class _award(DynAccessor):
                    __slots__ = ()
                    AdditionalReward = DynAccessor(389)
                    Footer = DynAccessor(390)
                    Header = DynAccessor(391)
                    Reward = DynAccessor(392)

                award = _award()
                Counter = DynAccessor(393)
                NoVehiclesState = DynAccessor(394)
                Resource = DynAccessor(395)
                VehicleCount = DynAccessor(396)
                VehicleInfo = DynAccessor(397)

            sharedComponents = _sharedComponents()

            class _tooltips(DynAccessor):
                __slots__ = ()
                EntryPointTooltip = DynAccessor(398)
                MaxProgressTooltip = DynAccessor(399)
                ProgressTooltip = DynAccessor(400)
                RefundResourcesTooltip = DynAccessor(401)
                SerialNumberTooltip = DynAccessor(402)

            tooltips = _tooltips()

        resource_well = _resource_well()

        class _seniority_awards(DynAccessor):
            __slots__ = ()
            SeniorityAwardsView = DynAccessor(403)

            class _sharedComponents(DynAccessor):
                __slots__ = ()
                SeniorityAwardCoin = DynAccessor(404)

            sharedComponents = _sharedComponents()

        seniority_awards = _seniority_awards()

        class _stronghold(DynAccessor):
            __slots__ = ()
            StrongholdEntryPointView = DynAccessor(405)

        stronghold = _stronghold()

        class _subscription(DynAccessor):
            __slots__ = ()
            SubscriptionAwardView = DynAccessor(406)
            WotPlusIntroView = DynAccessor(407)
            WotPlusTooltip = DynAccessor(408)

        subscription = _subscription()

        class _tanksetup(DynAccessor):
            __slots__ = ()
            AmmunitionPanel = DynAccessor(409)

            class _common(DynAccessor):
                __slots__ = ()
                Action = DynAccessor(410)
                CtaButtons = DynAccessor(411)
                DealPanel = DynAccessor(412)
                ExtraImage = DynAccessor(413)
                FormatColorTagText = DynAccessor(414)
                MaybeWrapper = DynAccessor(415)
                Price = DynAccessor(416)
                SetupApp = DynAccessor(417)
                ShortenedText = DynAccessor(418)
                Slider = DynAccessor(419)

                class _SlotParts(DynAccessor):
                    __slots__ = ()
                    Bonus = DynAccessor(420)
                    Container = DynAccessor(421)
                    Count = DynAccessor(422)
                    Inside = DynAccessor(423)
                    Level = DynAccessor(424)

                SlotParts = _SlotParts()
                Specializations = DynAccessor(425)
                Storage = DynAccessor(426)
                SwitchButton = DynAccessor(427)
                SwitchEquipment = DynAccessor(428)

                class _Transitions(DynAccessor):
                    __slots__ = ()
                    SlotTransitions = DynAccessor(429)

                Transitions = _Transitions()
                WeaponOccupancy = DynAccessor(430)

            common = _common()
            DeconstructionDeviceView = DynAccessor(431)

            class _dialogs(DynAccessor):
                __slots__ = ()
                Confirm = DynAccessor(432)
                ConfirmActionsWithEquipmentDialog = DynAccessor(433)
                DeconstructConfirm = DynAccessor(434)
                DeviceUpgradeDialog = DynAccessor(435)
                ExchangeToBuyItems = DynAccessor(436)
                ExchangeToUpgradeItems = DynAccessor(437)
                NeedRepair = DynAccessor(438)
                RefillShells = DynAccessor(439)
                Sell = DynAccessor(440)

                class _sub_views(DynAccessor):
                    __slots__ = ()
                    FrontlineConfirmFooterMoney = DynAccessor(441)
                    FrontlineConfirmIcons = DynAccessor(442)
                    FrontlineConfirmInfo = DynAccessor(443)
                    FrontlineConfirmMultipleNames = DynAccessor(444)
                    FrontlineConfirmTitle = DynAccessor(445)

                sub_views = _sub_views()

            dialogs = _dialogs()
            HangarAmmunitionSetup = DynAccessor(446)
            IntroScreen = DynAccessor(447)

            class _tooltips(DynAccessor):
                __slots__ = ()
                DeconstructFromInventoryTooltip = DynAccessor(448)
                DeconstructFromVehicleTooltip = DynAccessor(449)
                SetupTabTooltipView = DynAccessor(450)
                WarningTooltipView = DynAccessor(451)

            tooltips = _tooltips()
            VehicleCompareAmmunitionPanel = DynAccessor(452)
            VehicleCompareAmmunitionSetup = DynAccessor(453)

        tanksetup = _tanksetup()

        class _vehicle_compare(DynAccessor):
            __slots__ = ()
            CompareModificationsPanelView = DynAccessor(457)
            SelectSlotSpecCompareDialog = DynAccessor(458)

        vehicle_compare = _vehicle_compare()

        class _vehicle_preview(DynAccessor):
            __slots__ = ()

            class _buying_panel(DynAccessor):
                __slots__ = ()
                StyleBuyingPanel = DynAccessor(459)
                VPProgressionStylesBuyingPanel = DynAccessor(460)
                WellPanel = DynAccessor(461)

            buying_panel = _buying_panel()

            class _top_panel(DynAccessor):
                __slots__ = ()
                TopPanelTabs = DynAccessor(462)

            top_panel = _top_panel()

        vehicle_preview = _vehicle_preview()

        class _veh_post_progression(DynAccessor):
            __slots__ = ()

            class _common(DynAccessor):
                __slots__ = ()
                Bonus = DynAccessor(463)
                Description = DynAccessor(464)
                Grid = DynAccessor(465)
                PersistentBonuses = DynAccessor(466)
                Slide = DynAccessor(467)
                SlideContent = DynAccessor(468)
                Slider = DynAccessor(469)
                TextSplit = DynAccessor(470)

            common = _common()
            PostProgressionInfo = DynAccessor(471)
            PostProgressionIntro = DynAccessor(472)
            PostProgressionResearchSteps = DynAccessor(473)

            class _tooltip(DynAccessor):
                __slots__ = ()

                class _common(DynAccessor):
                    __slots__ = ()
                    DisabledBlock = DynAccessor(474)
                    FeatureLevelSubtitle = DynAccessor(475)
                    Lock = DynAccessor(476)
                    NotEnoughCredits = DynAccessor(477)
                    PriceBlock = DynAccessor(478)
                    Separator = DynAccessor(479)

                common = _common()
                PairModificationTooltipView = DynAccessor(480)
                PostProgressionLevelTooltipView = DynAccessor(481)
                RoleSlotTooltipView = DynAccessor(482)
                SetupTooltipView = DynAccessor(483)

            tooltip = _tooltip()
            VehiclePostProgressionCmpView = DynAccessor(484)
            VehiclePostProgressionView = DynAccessor(485)

        veh_post_progression = _veh_post_progression()

        class _winback(DynAccessor):
            __slots__ = ()

            class _popovers(DynAccessor):
                __slots__ = ()
                WinbackLeaveModePopoverView = DynAccessor(486)

            popovers = _popovers()

            class _tooltips(DynAccessor):
                __slots__ = ()
                MainRewardTooltip = DynAccessor(487)
                ModeInfoTooltip = DynAccessor(488)
                SelectableRewardTooltip = DynAccessor(489)
                SelectedRewardsTooltip = DynAccessor(490)

            tooltips = _tooltips()
            WinbackDailyQuestsIntroView = DynAccessor(491)
            WinbackLeaveModeDialogView = DynAccessor(492)
            WinbackRewardView = DynAccessor(493)
            WinbackSelectableRewardView = DynAccessor(494)

        winback = _winback()

        class _winback_call(DynAccessor):
            __slots__ = ()
            WinbackCallErrorView = DynAccessor(495)
            WinbackCallIntroView = DynAccessor(496)
            WinbackCallInvitationView = DynAccessor(497)
            WinbackCallMainView = DynAccessor(498)
            WinbackCallRewardsView = DynAccessor(499)

        winback_call = _winback_call()

    lobby = _lobby()

    class _test_check_box_view(DynAccessor):
        __slots__ = ()
        TestCheckBoxView = DynAccessor(60)

    test_check_box_view = _test_check_box_view()

    class _test_text_button_view(DynAccessor):
        __slots__ = ()
        TestTextButtonView = DynAccessor(61)

    test_text_button_view = _test_text_button_view()

    class _windows_layout_view(DynAccessor):
        __slots__ = ()
        WindowsLayountView = DynAccessor(62)

    windows_layout_view = _windows_layout_view()

    class _blend_mode(DynAccessor):
        __slots__ = ()

        class _blend_mode(DynAccessor):
            __slots__ = ()
            BlendMode = DynAccessor(63)

        blend_mode = _blend_mode()

    blend_mode = _blend_mode()

    class _demo_view(DynAccessor):
        __slots__ = ()

        class _views(DynAccessor):
            __slots__ = ()

            class _demo_window_content(DynAccessor):
                __slots__ = ()
                DemoWindowContent = DynAccessor(64)
                ImageProps = DynAccessor(65)

            demo_window_content = _demo_window_content()

            class _demo_window_details_panel(DynAccessor):
                __slots__ = ()
                DemoWindowDetailsPanel = DynAccessor(66)

            demo_window_details_panel = _demo_window_details_panel()

            class _demo_window_image_panel(DynAccessor):
                __slots__ = ()
                DemoWindowImagePanel = DynAccessor(67)

            demo_window_image_panel = _demo_window_image_panel()

            class _image_preview_window_content(DynAccessor):
                __slots__ = ()
                ImagePreviewWindowContent = DynAccessor(68)

            image_preview_window_content = _image_preview_window_content()

        views = _views()

    demo_view = _demo_view()

    class _examples(DynAccessor):
        __slots__ = ()

        class _views(DynAccessor):
            __slots__ = ()

            class _test_dialogs_view(DynAccessor):
                __slots__ = ()
                TestDialogsView = DynAccessor(69)

            test_dialogs_view = _test_dialogs_view()

            class _test_expr_functions_view(DynAccessor):
                __slots__ = ()
                TestExprFunctionsView = DynAccessor(70)

            test_expr_functions_view = _test_expr_functions_view()

            class _test_sub_view(DynAccessor):
                __slots__ = ()
                TestSubView = DynAccessor(71)

            test_sub_view = _test_sub_view()

            class _test_view(DynAccessor):
                __slots__ = ()
                TestView = DynAccessor(72)

            test_view = _test_view()

            class _unbound_example(DynAccessor):
                __slots__ = ()
                UnboundExample = DynAccessor(73)

            unbound_example = _unbound_example()

        views = _views()

    examples = _examples()

    class _list_examples(DynAccessor):
        __slots__ = ()

        class _views(DynAccessor):
            __slots__ = ()

            class _list_examples_empty_render_window_content(DynAccessor):
                __slots__ = ()
                ListExamplesEmptyRenderWindowContent = DynAccessor(74)

            list_examples_empty_render_window_content = _list_examples_empty_render_window_content()

            class _list_examples_window_content(DynAccessor):
                __slots__ = ()
                ListExamplesWindowContent = DynAccessor(75)

            list_examples_window_content = _list_examples_window_content()

        views = _views()

    list_examples = _list_examples()

    class _rotation_pivot_view(DynAccessor):
        __slots__ = ()

        class _views(DynAccessor):
            __slots__ = ()

            class _rotation_pivot_view(DynAccessor):
                __slots__ = ()
                RotationAndPivotTestView = DynAccessor(76)

            rotation_pivot_view = _rotation_pivot_view()

        views = _views()

    rotation_pivot_view = _rotation_pivot_view()

    class _rotation_view(DynAccessor):
        __slots__ = ()

        class _views(DynAccessor):
            __slots__ = ()

            class _rotation_view(DynAccessor):
                __slots__ = ()
                RotationTestView = DynAccessor(77)

            rotation_view = _rotation_view()

        views = _views()

    rotation_view = _rotation_view()

    class _scale_view(DynAccessor):
        __slots__ = ()

        class _views(DynAccessor):
            __slots__ = ()

            class _scale_view(DynAccessor):
                __slots__ = ()
                ScaleTestView = DynAccessor(78)

            scale_view = _scale_view()

        views = _views()

    scale_view = _scale_view()

    class _test_uikit_buttons_view(DynAccessor):
        __slots__ = ()

        class _views(DynAccessor):
            __slots__ = ()

            class _test_uikit_buttons_view(DynAccessor):
                __slots__ = ()
                TestUikitButtonsView = DynAccessor(79)

            test_uikit_buttons_view = _test_uikit_buttons_view()

        views = _views()

    test_uikit_buttons_view = _test_uikit_buttons_view()

    class _test_uikit_view(DynAccessor):
        __slots__ = ()

        class _views(DynAccessor):
            __slots__ = ()

            class _test_uikit_view(DynAccessor):
                __slots__ = ()
                TestUikitView = DynAccessor(80)

            test_uikit_view = _test_uikit_view()

        views = _views()

    test_uikit_view = _test_uikit_view()

    class _wtypes_view(DynAccessor):
        __slots__ = ()

        class _views(DynAccessor):
            __slots__ = ()

            class _wtypes_demo_window_content(DynAccessor):
                __slots__ = ()
                WtypesDemoWindowContent = DynAccessor(81)

            wtypes_demo_window_content = _wtypes_demo_window_content()

        views = _views()

    wtypes_view = _wtypes_view()

    class _dialogs(DynAccessor):
        __slots__ = ()

        class _common(DynAccessor):
            __slots__ = ()
            DialogTemplateGenericTooltip = DynAccessor(91)

        common = _common()
        DefaultDialog = DynAccessor(92)

        class _sub_views(DynAccessor):
            __slots__ = ()

            class _common(DynAccessor):
                __slots__ = ()
                SimpleText = DynAccessor(93)
                SinglePrice = DynAccessor(94)

            common = _common()

            class _content(DynAccessor):
                __slots__ = ()
                SelectOptionContent = DynAccessor(95)
                SimpleTextContent = DynAccessor(96)
                SinglePriceContent = DynAccessor(97)
                TextWithWarning = DynAccessor(98)

            content = _content()

            class _footer(DynAccessor):
                __slots__ = ()
                BRSinglePriceFooter = DynAccessor(99)
                HWSinglePrice = DynAccessor(100)
                SimpleTextFooter = DynAccessor(101)
                SinglePriceFooter = DynAccessor(102)

            footer = _footer()

            class _icon(DynAccessor):
                __slots__ = ()
                IconSet = DynAccessor(103)
                RewardList = DynAccessor(104)

            icon = _icon()

            class _title(DynAccessor):
                __slots__ = ()
                SimpleTextTitle = DynAccessor(105)

            title = _title()

            class _topRight(DynAccessor):
                __slots__ = ()
                BRMoneyBalance = DynAccessor(106)
                MoneyBalance = DynAccessor(107)

            topRight = _topRight()

        sub_views = _sub_views()

        class _widgets(DynAccessor):
            __slots__ = ()
            SinglePrice = DynAccessor(108)

        widgets = _widgets()

    dialogs = _dialogs()

    class _loading(DynAccessor):
        __slots__ = ()
        GameLoadingView = DynAccessor(109)

    loading = _loading()

    class _battle_modifiers(DynAccessor):
        __slots__ = ()

        class _lobby(DynAccessor):
            __slots__ = ()

            class _tooltips(DynAccessor):
                __slots__ = ()
                ModifiersDomainTooltipView = DynAccessor(500)

            tooltips = _tooltips()

        lobby = _lobby()

    battle_modifiers = _battle_modifiers()

    class _battle_royale(DynAccessor):
        __slots__ = ()

        class _battle(DynAccessor):
            __slots__ = ()

            class _views(DynAccessor):
                __slots__ = ()
                LeaveBattleView = DynAccessor(501)

            views = _views()

        battle = _battle()

        class _lobby(DynAccessor):
            __slots__ = ()

            class _tooltips(DynAccessor):
                __slots__ = ()
                BrCoinTooltipView = DynAccessor(502)

                class _common(DynAccessor):
                    __slots__ = ()

                    class _LeaderBoard(DynAccessor):
                        __slots__ = ()
                        Column = DynAccessor(503)
                        Table = DynAccessor(504)

                    LeaderBoard = _LeaderBoard()
                    PriceBlock = DynAccessor(505)
                    RentPrice = DynAccessor(506)

                common = _common()
                LeaderboardRewardTooltipView = DynAccessor(507)
                RentIconTooltipView = DynAccessor(508)
                RespawnInfoTooltipView = DynAccessor(509)
                RewardCurrencyTooltipView = DynAccessor(510)
                TestDriveInfoTooltipView = DynAccessor(511)
                VehicleTooltipView = DynAccessor(512)
                WidgetTooltipView = DynAccessor(513)

            tooltips = _tooltips()

            class _views(DynAccessor):
                __slots__ = ()
                BattleRoyaleEntryPoint = DynAccessor(514)
                IntroView = DynAccessor(515)
                PreBattleView = DynAccessor(516)
                ProxyCurrencyView = DynAccessor(517)
                WidgetView = DynAccessor(518)

            views = _views()

        lobby = _lobby()

    battle_royale = _battle_royale()

    class _battle_royale_progression(DynAccessor):
        __slots__ = ()
        BattleQuestAwardsView = DynAccessor(519)
        ProgressionMainView = DynAccessor(520)

    battle_royale_progression = _battle_royale_progression()

    class _event_lootboxes(DynAccessor):
        __slots__ = ()

        class _lobby(DynAccessor):
            __slots__ = ()

            class _event_lootboxes(DynAccessor):
                __slots__ = ()
                EntryPointView = DynAccessor(521)
                OpenBoxErrorView = DynAccessor(522)
                OpenBoxScreen = DynAccessor(523)
                PopoverView = DynAccessor(524)

                class _shared(DynAccessor):
                    __slots__ = ()
                    AnimationControls = DynAccessor(525)
                    BuyBoxFooter = DynAccessor(526)
                    CloseBtn = DynAccessor(527)
                    Divider = DynAccessor(528)
                    Header = DynAccessor(529)

                shared = _shared()

                class _tooltips(DynAccessor):
                    __slots__ = ()
                    CompensationTooltip = DynAccessor(530)
                    EntryPointTooltip = DynAccessor(531)
                    LootBoxesTooltip = DynAccessor(532)

                tooltips = _tooltips()
                WelcomeScreen = DynAccessor(533)

            event_lootboxes = _event_lootboxes()

        lobby = _lobby()

    event_lootboxes = _event_lootboxes()

    class _frontline(DynAccessor):
        __slots__ = ()

        class _lobby(DynAccessor):
            __slots__ = ()
            BannerView = DynAccessor(534)
            FrontlineContainerView = DynAccessor(535)
            InfoView = DynAccessor(536)
            ProgressView = DynAccessor(537)
            RewardsView = DynAccessor(538)

            class _tooltips(DynAccessor):
                __slots__ = ()
                LevelReservesTooltip = DynAccessor(539)
                NotEnoughPointsTooltip = DynAccessor(540)
                SkillOrderTooltip = DynAccessor(541)

            tooltips = _tooltips()
            WelcomeView = DynAccessor(542)

        lobby = _lobby()

    frontline = _frontline()

    class _fun_random(DynAccessor):
        __slots__ = ()

        class _lobby(DynAccessor):
            __slots__ = ()

            class _feature(DynAccessor):
                __slots__ = ()
                FunRandomEntryPointView = DynAccessor(543)
                FunRandomHangarWidgetView = DynAccessor(544)
                FunRandomModeSubSelector = DynAccessor(545)
                FunRandomProgression = DynAccessor(546)

            feature = _feature()

            class _tooltips(DynAccessor):
                __slots__ = ()
                FunRandomProgressionTooltipView = DynAccessor(547)

            tooltips = _tooltips()

        lobby = _lobby()

    fun_random = _fun_random()

    class _halloween(DynAccessor):
        __slots__ = ()

        class _battle(DynAccessor):
            __slots__ = ()
            EventBattleLoading = DynAccessor(548)
            FullStats = DynAccessor(549)
            HelpView = DynAccessor(550)

        battle = _battle()

        class _lobby(DynAccessor):
            __slots__ = ()
            BattleResultView = DynAccessor(551)
            BundleView = DynAccessor(552)
            ComparisonWindowView = DynAccessor(553)
            DifficultyWindowView = DynAccessor(554)
            EventBannerView = DynAccessor(555)
            HangarAmmunitionSetupView = DynAccessor(556)
            HangarView = DynAccessor(557)
            KingRewardCongratsView = DynAccessor(558)
            MembersWindow = DynAccessor(559)
            MetaIntroView = DynAccessor(560)
            MetaView = DynAccessor(561)
            PreBattleQueueView = DynAccessor(562)
            RewardWindowView = DynAccessor(563)
            StylePreview = DynAccessor(564)

            class _tooltips(DynAccessor):
                __slots__ = ()
                AbilityTooltip = DynAccessor(565)
                DifficultyTooltip = DynAccessor(566)
                EventBannerTooltip = DynAccessor(567)
                KeyTooltip = DynAccessor(568)
                NotEnoughKeyTooltip = DynAccessor(569)
                RewardsTooltip = DynAccessor(570)
                SimpleFormatTooltip = DynAccessor(571)
                VideoTooltip = DynAccessor(572)

            tooltips = _tooltips()

            class _widgets(DynAccessor):
                __slots__ = ()
                CarouselView = DynAccessor(573)
                DifficultyView = DynAccessor(574)
                KeysView = DynAccessor(575)
                MoneyBalance = DynAccessor(576)
                TankSetupView = DynAccessor(577)

            widgets = _widgets()

        lobby = _lobby()

        class _sub_views(DynAccessor):
            __slots__ = ()
            EventStats = DynAccessor(578)

        sub_views = _sub_views()

    halloween = _halloween()

    class _story_mode(DynAccessor):
        __slots__ = ()

        class _battle(DynAccessor):
            __slots__ = ()
            EpilogueWindow = DynAccessor(579)
            OnboardingBattleResultView = DynAccessor(580)
            PrebattleWindow = DynAccessor(581)

        battle = _battle()

        class _common(DynAccessor):
            __slots__ = ()
            CongratulationsWindow = DynAccessor(582)
            MedalTooltip = DynAccessor(583)
            OnboardingQueueView = DynAccessor(584)

        common = _common()

        class _lobby(DynAccessor):
            __slots__ = ()
            BattleResultView = DynAccessor(585)
            MissionSelectionView = DynAccessor(586)
            MissionTooltip = DynAccessor(587)

        lobby = _lobby()

    story_mode = _story_mode()
    Anchor = DynAccessor(588)

    class _child_views_demo(DynAccessor):
        __slots__ = ()
        ChildDemoView = DynAccessor(589)
        MainView = DynAccessor(590)

    child_views_demo = _child_views_demo()
    Comp7DemoPageView = DynAccessor(591)
    ComponentsDemo = DynAccessor(592)
    DataLayerDemoView = DynAccessor(593)
    DataTrackerDemo = DynAccessor(594)
    DemoContextMenu = DynAccessor(595)
    Easings = DynAccessor(596)
    GameLoadingDebugView = DynAccessor(597)
    GFCharset = DynAccessor(598)
    GFComponents = DynAccessor(599)
    GFDemoPopover = DynAccessor(600)
    GFDemoRichTooltipWindow = DynAccessor(601)
    GFDemoWindow = DynAccessor(602)
    GFHooksDemo = DynAccessor(603)
    GFInjectView = DynAccessor(604)
    GFInputCases = DynAccessor(605)
    GFSimpleTooltipWindow = DynAccessor(606)
    GFWebSubDemoWindow = DynAccessor(607)

    class _gf_dialogs_demo(DynAccessor):
        __slots__ = ()
        DefaultDialogProxy = DynAccessor(608)
        GFDialogsDemo = DynAccessor(609)

        class _sub_views(DynAccessor):
            __slots__ = ()
            DummyContent = DynAccessor(610)
            DummyFooter = DynAccessor(611)
            DummyIcon = DynAccessor(612)
            DummyStepper = DynAccessor(613)
            DummyTitle = DynAccessor(614)
            DummyTopRight = DynAccessor(615)

        sub_views = _sub_views()

    gf_dialogs_demo = _gf_dialogs_demo()

    class _gf_viewer(DynAccessor):
        __slots__ = ()
        GFViewerWindow = DynAccessor(616)

    gf_viewer = _gf_viewer()

    class _igb_demo(DynAccessor):
        __slots__ = ()
        BrowserFullscreenWindow = DynAccessor(617)
        BrowserWindow = DynAccessor(618)
        MainView = DynAccessor(619)

    igb_demo = _igb_demo()
    LocaleDemo = DynAccessor(620)
    MediaWrapperDemo = DynAccessor(621)
    MixBlendMode = DynAccessor(622)
    MixBlendModeAnimation = DynAccessor(623)
    ModeSelectorDemo = DynAccessor(624)
    ModeSelectorToolsetView = DynAccessor(625)
    NewYearLevelUp = DynAccessor(626)
    PluralLocView = DynAccessor(627)
    PropsSupportDemo = DynAccessor(628)
    ReactSpringVizualizer = DynAccessor(629)
    SelectableRewardDemoView = DynAccessor(630)
    StructuralDataBindDemo = DynAccessor(631)

    class _sub_views_demo(DynAccessor):
        __slots__ = ()
        GFSubViewsDemo = DynAccessor(632)

        class _sub_views(DynAccessor):
            __slots__ = ()
            CustomizationCartProxy = DynAccessor(633)
            DailyProxy = DynAccessor(634)
            ProgressiveItemsViewProxy = DynAccessor(635)

        sub_views = _sub_views()

    sub_views_demo = _sub_views_demo()
    UILoggerDemo = DynAccessor(636)
    VideoSupportView = DynAccessor(637)
    W2CTestPageWindow = DynAccessor(638)
    WgcgMockView = DynAccessor(639)