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
            BattlePassAwardsView = DynAccessor(143)
            BattlePassBuyLevelView = DynAccessor(144)
            BattlePassBuyView = DynAccessor(145)
            BattlePassDailyQuestsIntroView = DynAccessor(146)
            BattlePassEntryPointView = DynAccessor(147)
            BattlePassHowToEarnPointsView = DynAccessor(148)
            BattlePassIntroView = DynAccessor(149)
            BattlePassProgressionsView = DynAccessor(150)
            BattlePassVehicleAwardView = DynAccessor(151)
            ChapterChoiceView = DynAccessor(152)

            class _dialogs(DynAccessor):
                __slots__ = ()
                ChapterConfirm = DynAccessor(153)

            dialogs = _dialogs()
            ExtraIntroView = DynAccessor(154)
            RewardsSelectionView = DynAccessor(155)

            class _sharedComponents(DynAccessor):
                __slots__ = ()
                AnimatedReward = DynAccessor(156)
                AwardsWidget = DynAccessor(157)
                BuyButtons = DynAccessor(158)
                ChapterBackground = DynAccessor(159)
                CurrencyReward = DynAccessor(160)
                Emblem = DynAccessor(161)
                FormatRemainingDate = DynAccessor(162)
                Header = DynAccessor(163)
                LoupeButton = DynAccessor(164)
                RewardsBlock = DynAccessor(165)
                ScrollWithLips = DynAccessor(166)
                Slider = DynAccessor(167)
                Title = DynAccessor(168)
                VehicleBonusList = DynAccessor(169)
                VehicleInfo = DynAccessor(170)
                VehicleList = DynAccessor(171)

            sharedComponents = _sharedComponents()
            StyleVideoView = DynAccessor(172)

            class _tooltips(DynAccessor):
                __slots__ = ()
                BattlePassCoinTooltipView = DynAccessor(173)
                BattlePassCompletedTooltipView = DynAccessor(174)
                BattlePassGoldMissionTooltipView = DynAccessor(175)
                BattlePassInProgressTooltipView = DynAccessor(176)
                BattlePassLockIconTooltipView = DynAccessor(177)
                BattlePassNoChapterTooltipView = DynAccessor(178)
                BattlePassNotStartedTooltipView = DynAccessor(179)
                BattlePassOnPauseTooltipView = DynAccessor(180)
                BattlePassPointsView = DynAccessor(181)
                BattlePassQuestsChainTooltipView = DynAccessor(182)
                BattlePassUpgradeStyleTooltipView = DynAccessor(183)
                RandomQuestTooltip = DynAccessor(184)

                class _sharedComponents(DynAccessor):
                    __slots__ = ()
                    BlockCompleted = DynAccessor(185)
                    Chose = DynAccessor(186)
                    FinalLevel = DynAccessor(187)
                    IconTextBlock = DynAccessor(188)
                    PerBattlePointsTable = DynAccessor(189)
                    Point = DynAccessor(190)

                sharedComponents = _sharedComponents()
                VehiclePointsTooltipView = DynAccessor(191)

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
            Confirm = DynAccessor(198)

            class _tooltips(DynAccessor):
                __slots__ = ()
                BlueprintsAlliancesTooltipView = DynAccessor(199)

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
            AwardsView = DynAccessor(217)
            BrowserView = DynAccessor(218)
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
                MarathonRewardView = DynAccessor(38)

            marathon_reward_view = _marathon_reward_view()
            EntryPoint = DynAccessor(334)
            RewardWindow = DynAccessor(335)

            class _tooltips(DynAccessor):
                __slots__ = ()
                RestRewardTooltip = DynAccessor(336)

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
                BattleConditions = DynAccessor(338)
                Countdown = DynAccessor(339)
                PendingDots = DynAccessor(340)

            common = _common()
            Daily = DynAccessor(341)
            DailyQuestsTooltip = DynAccessor(342)
            DailyQuestsWidget = DynAccessor(343)
            LockedSubscriptionBonusTooltip = DynAccessor(344)
            RerollTooltip = DynAccessor(345)
            RerollTooltipWithCountdown = DynAccessor(346)

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
            EntryPoint = DynAccessor(385)
            QualificationRewardsView = DynAccessor(386)
            RankedProgressionView = DynAccessor(387)
            RankedSelectableRewardView = DynAccessor(388)

            class _tooltips(DynAccessor):
                __slots__ = ()
                RankedBattlesRolesTooltipView = DynAccessor(389)

            tooltips = _tooltips()
            YearLeaderboardView = DynAccessor(390)

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
            AdditionalRewardsTooltip = DynAccessor(473)
            TankmanTooltipView = DynAccessor(474)
            VehPostProgressionEntryPointTooltip = DynAccessor(475)

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
            AddCredentialsView = DynAccessor(108)
            CompleteView = DynAccessor(109)
            ConfirmCredentialsView = DynAccessor(110)
            ContactSupportView = DynAccessor(111)
            CurtainView = DynAccessor(112)
            EmptyView = DynAccessor(113)
            ErrorView = DynAccessor(114)
            RenamingCompleteView = DynAccessor(115)
            RenamingView = DynAccessor(116)

            class _tooltips(DynAccessor):
                __slots__ = ()
                HangarTooltip = DynAccessor(117)
                RenamingHangarTooltip = DynAccessor(118)

            tooltips = _tooltips()

        account_completion = _account_completion()

        class _account_dashboard(DynAccessor):
            __slots__ = ()
            AccountDashboard = DynAccessor(119)

        account_dashboard = _account_dashboard()

        class _achievements(DynAccessor):
            __slots__ = ()
            AchievementsMainView = DynAccessor(120)

            class _dialogs(DynAccessor):
                __slots__ = ()
                EditConfirm = DynAccessor(121)

            dialogs = _dialogs()
            EditView = DynAccessor(122)

            class _tooltips(DynAccessor):
                __slots__ = ()
                AutoSettingTooltip = DynAccessor(123)
                BattlesKPITooltip = DynAccessor(124)
                EditingTooltip = DynAccessor(125)
                KPITooltip = DynAccessor(126)
                WOTPRMainTooltip = DynAccessor(127)
                WTRInfoTooltip = DynAccessor(128)
                WTRMainTooltip = DynAccessor(129)

            tooltips = _tooltips()

        achievements = _achievements()

        class _awards(DynAccessor):
            __slots__ = ()
            BadgeAwardView = DynAccessor(130)
            MultipleAwardsView = DynAccessor(131)

            class _tooltips(DynAccessor):
                __slots__ = ()
                VehicleForChooseTooltip = DynAccessor(132)

            tooltips = _tooltips()

        awards = _awards()

        class _battle_matters(DynAccessor):
            __slots__ = ()
            BattleMattersEntryPointView = DynAccessor(133)
            BattleMattersExchangeRewards = DynAccessor(134)
            BattleMattersMainRewardView = DynAccessor(135)
            BattleMattersMainView = DynAccessor(136)
            BattleMattersPausedView = DynAccessor(137)
            BattleMattersRewardsView = DynAccessor(138)
            BattleMattersVehicleSelectionView = DynAccessor(139)

            class _popovers(DynAccessor):
                __slots__ = ()
                BattleMattersFilterPopoverView = DynAccessor(140)

            popovers = _popovers()

            class _tooltips(DynAccessor):
                __slots__ = ()
                BattleMattersEntryTooltipView = DynAccessor(141)
                BattleMattersTokenTooltipView = DynAccessor(142)

            tooltips = _tooltips()

        battle_matters = _battle_matters()

        class _battle_royale(DynAccessor):
            __slots__ = ()
            BattleResultView = DynAccessor(192)
            CommanderView = DynAccessor(193)

            class _sharedComponents(DynAccessor):
                __slots__ = ()
                CurrencyResolver = DynAccessor(194)
                PriceResolver = DynAccessor(195)

            sharedComponents = _sharedComponents()
            TechParametersVIew = DynAccessor(196)

        battle_royale = _battle_royale()

        class _birthday2023(DynAccessor):
            __slots__ = ()
            BirthdayIntroScreen = DynAccessor(197)

        birthday2023 = _birthday2023()

        class _bootcamp(DynAccessor):
            __slots__ = ()
            BootcampExitView = DynAccessor(200)
            BootcampFinalRewardView = DynAccessor(201)
            BootcampNationView = DynAccessor(202)
            BootcampProgressView = DynAccessor(203)
            BootcampProgressWidget = DynAccessor(204)
            BootcampQuestWidget = DynAccessor(205)
            RewardsTooltip = DynAccessor(206)

        bootcamp = _bootcamp()

        class _collection(DynAccessor):
            __slots__ = ()
            AwardsView = DynAccessor(207)
            CollectionEntryPointView = DynAccessor(208)
            CollectionItemPreview = DynAccessor(209)
            CollectionsMainView = DynAccessor(210)
            CollectionView = DynAccessor(211)
            IntroView = DynAccessor(212)

            class _tooltips(DynAccessor):
                __slots__ = ()
                CollectionItemTooltipView = DynAccessor(213)
                RewardTooltipView = DynAccessor(214)

            tooltips = _tooltips()

        collection = _collection()

        class _collective_goal(DynAccessor):
            __slots__ = ()
            CollectiveGoalEntryPointView = DynAccessor(215)

            class _tooltips(DynAccessor):
                __slots__ = ()
                EntryPointTooltip = DynAccessor(216)

            tooltips = _tooltips()

        collective_goal = _collective_goal()

        class _comp7(DynAccessor):
            __slots__ = ()
            Banner = DynAccessor(223)
            MainWidget = DynAccessor(224)
            MetaRootView = DynAccessor(225)
            NoVehiclesScreen = DynAccessor(226)
            RewardsScreen = DynAccessor(227)
            SeasonModifier = DynAccessor(228)

            class _tooltips(DynAccessor):
                __slots__ = ()
                DivisionTooltip = DynAccessor(229)
                FifthRankTooltip = DynAccessor(230)
                GeneralRankTooltip = DynAccessor(231)
                LastUpdateTooltip = DynAccessor(232)
                MainWidgetTooltip = DynAccessor(233)
                RankInactivityTooltip = DynAccessor(234)
                SeasonPointTooltip = DynAccessor(235)
                SixthRankTooltip = DynAccessor(236)

            tooltips = _tooltips()
            WhatsNewView = DynAccessor(237)

        comp7 = _comp7()

        class _craft_machine(DynAccessor):
            __slots__ = ()
            CraftmachineEntryPointView = DynAccessor(238)

        craft_machine = _craft_machine()

        class _crew(DynAccessor):
            __slots__ = ()
            BarracksView = DynAccessor(239)
            CrewHeaderTooltipView = DynAccessor(240)
            CrewIntroView = DynAccessor(241)

            class _dialogs(DynAccessor):
                __slots__ = ()
                CrewBooksPurchaseDialog = DynAccessor(242)
                DismissTankmanDialog = DynAccessor(243)
                DocumentChangeDialog = DynAccessor(244)
                EnlargeBarracksDialog = DynAccessor(245)
                PerksResetContent = DynAccessor(246)
                RecruitDialog = DynAccessor(247)
                RecruitNewTankmanDialog = DynAccessor(248)
                RestoreTankmanDialog = DynAccessor(249)
                RetrainDialog = DynAccessor(250)
                RoleChangeDialog = DynAccessor(251)
                SkinApplyDialog = DynAccessor(252)

            dialogs = _dialogs()
            HangarCrewWidget = DynAccessor(253)
            HelpView = DynAccessor(254)
            MemberChangeView = DynAccessor(255)

            class _personal_case(DynAccessor):
                __slots__ = ()

                class _component(DynAccessor):
                    __slots__ = ()
                    ScrollWithLips = DynAccessor(256)
                    TankmanInfoWrapper = DynAccessor(257)

                component = _component()
                PersonalDataView = DynAccessor(258)
                PersonalFileView = DynAccessor(259)
                ServiceRecordView = DynAccessor(260)

            personal_case = _personal_case()

            class _popovers(DynAccessor):
                __slots__ = ()
                FilterPopoverView = DynAccessor(261)

            popovers = _popovers()
            QuickTrainingView = DynAccessor(262)
            TankChangeView = DynAccessor(263)
            TankmanContainerView = DynAccessor(264)

            class _tooltips(DynAccessor):
                __slots__ = ()
                AdvancedTooltipView = DynAccessor(265)
                BunksConfirmDiscountTooltip = DynAccessor(266)
                CrewPerksAdditionalTooltip = DynAccessor(267)
                CrewPerksTooltip = DynAccessor(268)
                DismissedToggleTooltip = DynAccessor(269)
                ExperienceStepperTooltip = DynAccessor(270)
                PerkAvailableTooltip = DynAccessor(271)
                PremiumVehicleTooltip = DynAccessor(272)
                QuickTrainingDiscountTooltip = DynAccessor(273)
                TankmanTooltip = DynAccessor(274)
                TrainingLevelTooltip = DynAccessor(275)
                VehCmpSkillsTooltip = DynAccessor(276)
                VehicleParamsTooltipView = DynAccessor(277)

            tooltips = _tooltips()

            class _widgets(DynAccessor):
                __slots__ = ()
                CrewWidget = DynAccessor(278)
                FilterPanelWidget = DynAccessor(279)
                PriceList = DynAccessor(280)
                TankmanInfo = DynAccessor(281)

            widgets = _widgets()

        crew = _crew()

        class _crystalsPromo(DynAccessor):
            __slots__ = ()
            CrystalsPromoView = DynAccessor(282)

        crystalsPromo = _crystalsPromo()

        class _currency_reserves(DynAccessor):
            __slots__ = ()
            CurrencyReserves = DynAccessor(283)
            ReservesAwardView = DynAccessor(284)

        currency_reserves = _currency_reserves()

        class _customization(DynAccessor):
            __slots__ = ()
            CustomizationCart = DynAccessor(285)

            class _progression_styles(DynAccessor):
                __slots__ = ()
                OnboardingView = DynAccessor(286)
                StageSwitcher = DynAccessor(287)

            progression_styles = _progression_styles()

            class _progressive_items_reward(DynAccessor):
                __slots__ = ()
                ProgressiveItemsUpgradeView = DynAccessor(288)

            progressive_items_reward = _progressive_items_reward()

            class _progressive_items_view(DynAccessor):
                __slots__ = ()
                ProgressiveItemsView = DynAccessor(289)

            progressive_items_view = _progressive_items_view()

            class _style_unlocked_view(DynAccessor):
                __slots__ = ()
                StyleUnlockedView = DynAccessor(290)

            style_unlocked_view = _style_unlocked_view()

        customization = _customization()

        class _debutBoxes(DynAccessor):
            __slots__ = ()
            DebutBoxesBadgeTooltipView = DynAccessor(291)

        debutBoxes = _debutBoxes()

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

        class _early_access(DynAccessor):
            __slots__ = ()
            EarlyAccessBuyView = DynAccessor(298)
            EarlyAccessEntryPointView = DynAccessor(299)
            EarlyAccessIntroView = DynAccessor(300)
            EarlyAccessQuestsView = DynAccessor(301)
            EarlyAccessRewardsView = DynAccessor(302)
            EarlyAccessVehicleView = DynAccessor(303)

            class _tooltips(DynAccessor):
                __slots__ = ()
                EarlyAccessCommonDescriptionTooltip = DynAccessor(304)
                EarlyAccessCompensationTooltip = DynAccessor(305)
                EarlyAccessCurrencyTooltipView = DynAccessor(306)
                EarlyAccessEntryPointPausedTooltip = DynAccessor(307)
                EarlyAccessEntryPointTooltipView = DynAccessor(308)
                EarlyAccessSimpleTooltipView = DynAccessor(309)
                EarlyAccessTokensStepperTooltip = DynAccessor(310)
                EarlyAccessVehicleCarouselPausedTooltip = DynAccessor(311)
                EarlyAccessVehicleLockedTooltip = DynAccessor(312)

            tooltips = _tooltips()

        early_access = _early_access()

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
            AwardsView = DynAccessor(315)

            class _dialogs(DynAccessor):
                __slots__ = ()
                BlankPrice = DynAccessor(316)

            dialogs = _dialogs()
            IntroScreen = DynAccessor(317)
            RewardsSelectionView = DynAccessor(318)

        frontline = _frontline()

        class _hangar(DynAccessor):
            __slots__ = ()

            class _subViews(DynAccessor):
                __slots__ = ()
                VehicleParams = DynAccessor(319)

            subViews = _subViews()
            VehicleParamsWidget = DynAccessor(320)

        hangar = _hangar()

        class _instructions(DynAccessor):
            __slots__ = ()
            BuyWindow = DynAccessor(321)
            SellWindow = DynAccessor(322)

        instructions = _instructions()

        class _mapbox(DynAccessor):
            __slots__ = ()
            MapBoxAwardsView = DynAccessor(323)
            MapBoxEntryPointView = DynAccessor(324)
            MapBoxIntro = DynAccessor(325)
            MapBoxProgression = DynAccessor(326)
            MapBoxRewardChoiceView = DynAccessor(327)
            MapBoxSurveyView = DynAccessor(328)

        mapbox = _mapbox()

        class _maps_training(DynAccessor):
            __slots__ = ()
            MapPointDescriptionTooltip = DynAccessor(329)
            MapsTrainingPage = DynAccessor(330)
            MapsTrainingQueue = DynAccessor(331)
            MapsTrainingResult = DynAccessor(332)
            ScenarioTooltip = DynAccessor(333)

        maps_training = _maps_training()

        class _matchmaker(DynAccessor):
            __slots__ = ()
            ActiveTestConfirmView = DynAccessor(337)

        matchmaker = _matchmaker()

        class _mode_selector(DynAccessor):
            __slots__ = ()
            BattleSessionView = DynAccessor(347)
            ModeSelectorView = DynAccessor(348)

            class _popovers(DynAccessor):
                __slots__ = ()
                RandomBattlePopover = DynAccessor(349)

            popovers = _popovers()

            class _tooltips(DynAccessor):
                __slots__ = ()
                AlertTooltip = DynAccessor(350)

                class _common(DynAccessor):
                    __slots__ = ()
                    Divider = DynAccessor(351)
                    GradientDecorator = DynAccessor(352)

                common = _common()
                SimplyFormatTooltip = DynAccessor(353)

            tooltips = _tooltips()

            class _widgets(DynAccessor):
                __slots__ = ()
                BattleRoyaleProgressionWidget = DynAccessor(354)
                BattleRoyaleWidget = DynAccessor(355)
                EpicWidget = DynAccessor(356)
                RankedWidget = DynAccessor(357)
                WTWidget = DynAccessor(358)

            widgets = _widgets()

        mode_selector = _mode_selector()

        class _offers(DynAccessor):
            __slots__ = ()
            OfferBannerWindow = DynAccessor(359)
            OfferGiftsWindow = DynAccessor(360)
            OfferRewardWindow = DynAccessor(361)

        offers = _offers()

        class _personal_reserves(DynAccessor):
            __slots__ = ()
            PersonalReservesTooltip = DynAccessor(362)
            PersonalReservesWidget = DynAccessor(363)
            ReserveCard = DynAccessor(364)
            ReserveCardTooltip = DynAccessor(365)
            ReserveGroup = DynAccessor(366)
            ReservesActivationView = DynAccessor(367)
            ReservesConversionView = DynAccessor(368)
            ReservesIntroView = DynAccessor(369)

        personal_reserves = _personal_reserves()

        class _platoon(DynAccessor):
            __slots__ = ()
            AlertTooltip = DynAccessor(370)
            MembersWindow = DynAccessor(371)
            PlatoonDropdown = DynAccessor(372)
            SearchingDropdown = DynAccessor(373)
            SettingsPopover = DynAccessor(374)

            class _subViews(DynAccessor):
                __slots__ = ()
                Chat = DynAccessor(375)
                SettingsContent = DynAccessor(376)
                TiersLimit = DynAccessor(377)

            subViews = _subViews()
            WTRTooltip = DynAccessor(378)

        platoon = _platoon()

        class _player_subscriptions(DynAccessor):
            __slots__ = ()
            PlayerSubscriptions = DynAccessor(379)
            SubscriptionItem = DynAccessor(380)
            SubscriptionRewardView = DynAccessor(381)

        player_subscriptions = _player_subscriptions()

        class _pm_announce(DynAccessor):
            __slots__ = ()

            class _tooltips(DynAccessor):
                __slots__ = ()
                PersonalMissionsNewCampaignTooltipView = DynAccessor(382)
                PersonalMissionsOldCampaignTooltipView = DynAccessor(383)

            tooltips = _tooltips()

        pm_announce = _pm_announce()

        class _poll(DynAccessor):
            __slots__ = ()
            PollView = DynAccessor(384)

        poll = _poll()

        class _research(DynAccessor):
            __slots__ = ()
            BuyModuleDialogView = DynAccessor(391)
            InsufficientCreditsTooltip = DynAccessor(392)
            SoldModuleInfoTooltip = DynAccessor(393)

        research = _research()

        class _resource_well(DynAccessor):
            __slots__ = ()
            AwardView = DynAccessor(394)
            CompletedProgressionView = DynAccessor(395)
            EntryPoint = DynAccessor(396)
            IntroView = DynAccessor(397)
            NoSerialVehiclesConfirm = DynAccessor(398)
            NoVehiclesConfirm = DynAccessor(399)
            ProgressionView = DynAccessor(400)
            ResourcesLoadingConfirm = DynAccessor(401)
            ResourcesLoadingView = DynAccessor(402)

            class _sharedComponents(DynAccessor):
                __slots__ = ()

                class _award(DynAccessor):
                    __slots__ = ()
                    AdditionalReward = DynAccessor(403)
                    Footer = DynAccessor(404)
                    Header = DynAccessor(405)
                    Reward = DynAccessor(406)

                award = _award()
                Counter = DynAccessor(407)
                NoVehiclesState = DynAccessor(408)
                Resource = DynAccessor(409)
                VehicleCount = DynAccessor(410)
                VehicleInfo = DynAccessor(411)

            sharedComponents = _sharedComponents()

            class _tooltips(DynAccessor):
                __slots__ = ()
                EntryPointTooltip = DynAccessor(412)
                MaxProgressTooltip = DynAccessor(413)
                ProgressTooltip = DynAccessor(414)
                RefundResourcesTooltip = DynAccessor(415)
                SerialNumberTooltip = DynAccessor(416)

            tooltips = _tooltips()

        resource_well = _resource_well()

        class _seniority_awards(DynAccessor):
            __slots__ = ()
            SeniorityAwardsView = DynAccessor(417)

            class _sharedComponents(DynAccessor):
                __slots__ = ()
                SeniorityAwardCoin = DynAccessor(418)

            sharedComponents = _sharedComponents()

        seniority_awards = _seniority_awards()

        class _shop_sales(DynAccessor):
            __slots__ = ()
            ShopSalesEntryPointView = DynAccessor(419)

        shop_sales = _shop_sales()

        class _stronghold(DynAccessor):
            __slots__ = ()
            StrongholdEntryPointView = DynAccessor(420)

        stronghold = _stronghold()

        class _subscription(DynAccessor):
            __slots__ = ()
            SubscriptionAwardView = DynAccessor(421)
            SubscriptionDailyQuestsIntro = DynAccessor(422)
            WotPlusIntroView = DynAccessor(423)
            WotPlusTooltip = DynAccessor(424)

        subscription = _subscription()

        class _tanksetup(DynAccessor):
            __slots__ = ()
            AmmunitionPanel = DynAccessor(425)

            class _common(DynAccessor):
                __slots__ = ()
                Action = DynAccessor(426)
                CtaButtons = DynAccessor(427)
                DealPanel = DynAccessor(428)
                ExtraImage = DynAccessor(429)
                FormatColorTagText = DynAccessor(430)
                MaybeWrapper = DynAccessor(431)
                Price = DynAccessor(432)
                SetupApp = DynAccessor(433)
                ShortenedText = DynAccessor(434)
                Slider = DynAccessor(435)

                class _SlotParts(DynAccessor):
                    __slots__ = ()
                    Bonus = DynAccessor(436)
                    Container = DynAccessor(437)
                    Count = DynAccessor(438)
                    Inside = DynAccessor(439)
                    Level = DynAccessor(440)

                SlotParts = _SlotParts()
                Specializations = DynAccessor(441)
                Storage = DynAccessor(442)
                SwitchButton = DynAccessor(443)
                SwitchEquipment = DynAccessor(444)

                class _Transitions(DynAccessor):
                    __slots__ = ()
                    SlotTransitions = DynAccessor(445)

                Transitions = _Transitions()
                WeaponOccupancy = DynAccessor(446)

            common = _common()
            DeconstructionDeviceView = DynAccessor(447)

            class _dialogs(DynAccessor):
                __slots__ = ()
                Confirm = DynAccessor(448)
                ConfirmActionsWithEquipmentDialog = DynAccessor(449)
                DeconstructConfirm = DynAccessor(450)
                DeviceUpgradeDialog = DynAccessor(451)
                ExchangeToBuyItems = DynAccessor(452)
                ExchangeToUpgradeItems = DynAccessor(453)
                NeedRepair = DynAccessor(454)
                RefillShells = DynAccessor(455)
                Sell = DynAccessor(456)

                class _sub_views(DynAccessor):
                    __slots__ = ()
                    FrontlineConfirmFooterMoney = DynAccessor(457)
                    FrontlineConfirmIcons = DynAccessor(458)
                    FrontlineConfirmMultipleNames = DynAccessor(459)
                    FrontlineConfirmTitle = DynAccessor(460)

                sub_views = _sub_views()

            dialogs = _dialogs()
            HangarAmmunitionSetup = DynAccessor(461)
            IntroScreen = DynAccessor(462)

            class _tooltips(DynAccessor):
                __slots__ = ()
                AbilitySkillAdditionalTooltip = DynAccessor(463)
                AbilitySkillTooltip = DynAccessor(464)
                DeconstructFromInventoryTooltip = DynAccessor(465)
                DeconstructFromVehicleTooltip = DynAccessor(466)
                SetupTabTooltipView = DynAccessor(467)
                WarningTooltipView = DynAccessor(468)

            tooltips = _tooltips()
            VehicleCompareAmmunitionPanel = DynAccessor(469)
            VehicleCompareAmmunitionSetup = DynAccessor(470)

        tanksetup = _tanksetup()

        class _techtree(DynAccessor):
            __slots__ = ()

            class _tooltips(DynAccessor):
                __slots__ = ()
                ParagonsEntryPointTooltip = DynAccessor(471)

            tooltips = _tooltips()
            VehicleTechTree = DynAccessor(472)

        techtree = _techtree()

        class _vehicle_compare(DynAccessor):
            __slots__ = ()
            CompareModificationsPanelView = DynAccessor(476)
            SelectSlotSpecCompareDialog = DynAccessor(477)

        vehicle_compare = _vehicle_compare()

        class _vehicle_preview(DynAccessor):
            __slots__ = ()

            class _buying_panel(DynAccessor):
                __slots__ = ()
                EarlyAccessPanel = DynAccessor(478)
                StyleBuyingPanel = DynAccessor(479)
                VPProgressionStylesBuyingPanel = DynAccessor(480)
                WellPanel = DynAccessor(481)

            buying_panel = _buying_panel()

            class _top_panel(DynAccessor):
                __slots__ = ()
                TopPanelTabs = DynAccessor(482)

            top_panel = _top_panel()

        vehicle_preview = _vehicle_preview()

        class _veh_post_progression(DynAccessor):
            __slots__ = ()

            class _common(DynAccessor):
                __slots__ = ()
                Bonus = DynAccessor(483)
                Description = DynAccessor(484)
                Grid = DynAccessor(485)
                PersistentBonuses = DynAccessor(486)
                Slide = DynAccessor(487)
                SlideContent = DynAccessor(488)
                Slider = DynAccessor(489)
                TextSplit = DynAccessor(490)

            common = _common()
            PostProgressionInfo = DynAccessor(491)
            PostProgressionIntro = DynAccessor(492)
            PostProgressionResearchSteps = DynAccessor(493)

            class _tooltip(DynAccessor):
                __slots__ = ()

                class _common(DynAccessor):
                    __slots__ = ()
                    DisabledBlock = DynAccessor(494)
                    FeatureLevelSubtitle = DynAccessor(495)
                    Lock = DynAccessor(496)
                    NotEnoughCredits = DynAccessor(497)
                    PriceBlock = DynAccessor(498)
                    Separator = DynAccessor(499)

                common = _common()
                PairModificationTooltipView = DynAccessor(500)
                PostProgressionLevelTooltipView = DynAccessor(501)
                RoleSlotTooltipView = DynAccessor(502)
                SetupTooltipView = DynAccessor(503)

            tooltip = _tooltip()
            VehiclePostProgressionCmpView = DynAccessor(504)
            VehiclePostProgressionView = DynAccessor(505)

        veh_post_progression = _veh_post_progression()

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
                SimpleTextFooter = DynAccessor(100)
                SinglePriceFooter = DynAccessor(101)

            footer = _footer()

            class _icon(DynAccessor):
                __slots__ = ()
                IconSet = DynAccessor(102)

            icon = _icon()

            class _title(DynAccessor):
                __slots__ = ()
                SimpleTextTitle = DynAccessor(103)

            title = _title()

            class _topRight(DynAccessor):
                __slots__ = ()
                BRMoneyBalance = DynAccessor(104)
                MoneyBalance = DynAccessor(105)

            topRight = _topRight()

        sub_views = _sub_views()

        class _widgets(DynAccessor):
            __slots__ = ()
            SinglePrice = DynAccessor(106)

        widgets = _widgets()

    dialogs = _dialogs()

    class _loading(DynAccessor):
        __slots__ = ()
        GameLoadingView = DynAccessor(107)

    loading = _loading()

    class _armory_yard(DynAccessor):
        __slots__ = ()

        class _lobby(DynAccessor):
            __slots__ = ()

            class _feature(DynAccessor):
                __slots__ = ()
                ArmoryYardBundlesView = DynAccessor(506)
                ArmoryYardBuyBundleView = DynAccessor(507)
                ArmoryYardBuyView = DynAccessor(508)
                ArmoryYardEntryPointView = DynAccessor(509)
                ArmoryYardIntroView = DynAccessor(510)
                ArmoryYardMainView = DynAccessor(511)
                ArmoryYardPostProgressionBuyView = DynAccessor(512)
                ArmoryYardRewardsView = DynAccessor(513)
                ArmoryYardShopBuyView = DynAccessor(514)
                ArmoryYardShopRewardsView = DynAccessor(515)
                ArmoryYardShopView = DynAccessor(516)
                ArmoryYardVideoRewardView = DynAccessor(517)
                ArmoryYardWidgetView = DynAccessor(518)

                class _tooltips(DynAccessor):
                    __slots__ = ()
                    ArmoryYardCurrencyTooltipView = DynAccessor(519)
                    ArmoryYardSimpleTooltipView = DynAccessor(520)
                    ArmoryYardWalletNotAvailableTooltipView = DynAccessor(521)
                    EntryPointActiveTooltipView = DynAccessor(522)
                    EntryPointBeforeProgressionTooltipView = DynAccessor(523)
                    EntryPointNotActiveTooltipView = DynAccessor(524)
                    RestRewardTooltipView = DynAccessor(525)
                    ShopCurrencyTooltipView = DynAccessor(526)

                tooltips = _tooltips()

            feature = _feature()

        lobby = _lobby()

    armory_yard = _armory_yard()

    class _battle_modifiers(DynAccessor):
        __slots__ = ()

        class _lobby(DynAccessor):
            __slots__ = ()

            class _tooltips(DynAccessor):
                __slots__ = ()
                ModifiersDomainTooltipView = DynAccessor(527)

            tooltips = _tooltips()

        lobby = _lobby()

    battle_modifiers = _battle_modifiers()

    class _battle_royale(DynAccessor):
        __slots__ = ()

        class _battle(DynAccessor):
            __slots__ = ()

            class _views(DynAccessor):
                __slots__ = ()
                LeaveBattleView = DynAccessor(528)

            views = _views()

        battle = _battle()

        class _lobby(DynAccessor):
            __slots__ = ()

            class _tooltips(DynAccessor):
                __slots__ = ()
                BrCoinTooltipView = DynAccessor(529)

                class _common(DynAccessor):
                    __slots__ = ()

                    class _LeaderBoard(DynAccessor):
                        __slots__ = ()
                        Column = DynAccessor(530)
                        Table = DynAccessor(531)

                    LeaderBoard = _LeaderBoard()
                    PriceBlock = DynAccessor(532)
                    RentPrice = DynAccessor(533)

                common = _common()
                LeaderboardRewardTooltipView = DynAccessor(534)
                RentIconTooltipView = DynAccessor(535)
                RespawnInfoTooltipView = DynAccessor(536)
                RewardCurrencyTooltipView = DynAccessor(537)
                TestDriveInfoTooltipView = DynAccessor(538)
                VehicleTooltipView = DynAccessor(539)
                WidgetTooltipView = DynAccessor(540)

            tooltips = _tooltips()

            class _views(DynAccessor):
                __slots__ = ()
                BattleRoyaleEntryPoint = DynAccessor(541)
                IntroView = DynAccessor(542)
                PreBattleView = DynAccessor(543)
                ProxyCurrencyView = DynAccessor(544)
                WidgetView = DynAccessor(545)

            views = _views()

        lobby = _lobby()

    battle_royale = _battle_royale()

    class _battle_royale_progression(DynAccessor):
        __slots__ = ()
        BattleQuestAwardsView = DynAccessor(546)
        ProgressionMainView = DynAccessor(547)

    battle_royale_progression = _battle_royale_progression()

    class _cosmic_event(DynAccessor):
        __slots__ = ()

        class _battle(DynAccessor):
            __slots__ = ()

            class _cosmic_hud(DynAccessor):
                __slots__ = ()
                CosmicBattleHelpView = DynAccessor(548)
                CosmicReactHudView = DynAccessor(549)

                class _tooltips(DynAccessor):
                    __slots__ = ()
                    AbilityTooltip = DynAccessor(550)

                tooltips = _tooltips()

            cosmic_hud = _cosmic_hud()

        battle = _battle()

        class _lobby(DynAccessor):
            __slots__ = ()

            class _banner_entry_point(DynAccessor):
                __slots__ = ()
                CosmicBannerEntryPoint = DynAccessor(551)

            banner_entry_point = _banner_entry_point()

            class _cosmic_lobby_view(DynAccessor):
                __slots__ = ()
                CosmicLobbyView = DynAccessor(552)

            cosmic_lobby_view = _cosmic_lobby_view()

            class _cosmic_post_battle(DynAccessor):
                __slots__ = ()
                CosmicPostBattleView = DynAccessor(553)

            cosmic_post_battle = _cosmic_post_battle()

            class _queue_view(DynAccessor):
                __slots__ = ()
                QueueView = DynAccessor(554)

            queue_view = _queue_view()

            class _rewards_view(DynAccessor):
                __slots__ = ()
                RewardsView = DynAccessor(555)

            rewards_view = _rewards_view()

        lobby = _lobby()

    cosmic_event = _cosmic_event()

    class _frontline(DynAccessor):
        __slots__ = ()

        class _lobby(DynAccessor):
            __slots__ = ()
            BannerView = DynAccessor(556)
            FrontlineContainerView = DynAccessor(557)
            InfoView = DynAccessor(558)
            ProgressView = DynAccessor(559)
            RewardsView = DynAccessor(560)
            SkillsView = DynAccessor(561)

            class _tooltips(DynAccessor):
                __slots__ = ()
                LevelReservesTooltip = DynAccessor(562)
                NotEnoughPointsTooltip = DynAccessor(563)
                SkillOrderTooltip = DynAccessor(564)

            tooltips = _tooltips()
            WelcomeView = DynAccessor(565)

        lobby = _lobby()

    frontline = _frontline()

    class _fun_random(DynAccessor):
        __slots__ = ()

        class _lobby(DynAccessor):
            __slots__ = ()

            class _feature(DynAccessor):
                __slots__ = ()
                FunRandomEntryPointView = DynAccessor(566)
                FunRandomHangarWidgetView = DynAccessor(567)
                FunRandomModeSubSelector = DynAccessor(568)
                FunRandomProgression = DynAccessor(569)

            feature = _feature()

            class _tooltips(DynAccessor):
                __slots__ = ()
                FunRandomProgressionTooltipView = DynAccessor(570)

            tooltips = _tooltips()

        lobby = _lobby()

    fun_random = _fun_random()

    class _gui_lootboxes(DynAccessor):
        __slots__ = ()

        class _lobby(DynAccessor):
            __slots__ = ()

            class _gui_lootboxes(DynAccessor):
                __slots__ = ()
                BonusProbabilitiesView = DynAccessor(571)
                EntryPointView = DynAccessor(572)
                KeysWelcomeScreen = DynAccessor(573)
                LootBoxesLoseRewardScreen = DynAccessor(574)
                LootboxRewardsView = DynAccessor(575)
                LootboxVideoRewardView = DynAccessor(576)
                OpenBoxErrorView = DynAccessor(577)

                class _shared(DynAccessor):
                    __slots__ = ()
                    AnimationControls = DynAccessor(578)
                    BacklitTransparentButton = DynAccessor(579)
                    BuyBoxFooter = DynAccessor(580)
                    CanvasSequence = DynAccessor(581)
                    CloseBtn = DynAccessor(582)
                    Compensation = DynAccessor(583)
                    CurrencyKey = DynAccessor(584)
                    Divider = DynAccessor(585)
                    Header = DynAccessor(586)
                    RotationVehicle = DynAccessor(587)
                    Video = DynAccessor(588)
                    VideoComponent = DynAccessor(589)

                shared = _shared()
                StorageView = DynAccessor(590)

                class _tooltips(DynAccessor):
                    __slots__ = ()
                    BonusGroupTooltip = DynAccessor(591)
                    CompensationTooltip = DynAccessor(592)
                    GuaranteedRewardTooltip = DynAccessor(593)
                    LootboxKeyTooltip = DynAccessor(594)
                    LootboxRotationTooltip = DynAccessor(595)
                    LootboxTooltip = DynAccessor(596)
                    ProbabilityButtonTooltip = DynAccessor(597)

                tooltips = _tooltips()
                WelcomeScreen = DynAccessor(598)

            gui_lootboxes = _gui_lootboxes()

        lobby = _lobby()

    gui_lootboxes = _gui_lootboxes()

    class _story_mode(DynAccessor):
        __slots__ = ()

        class _battle(DynAccessor):
            __slots__ = ()
            EpilogueWindow = DynAccessor(599)
            OnboardingBattleResultView = DynAccessor(600)
            PrebattleWindow = DynAccessor(601)

        battle = _battle()

        class _common(DynAccessor):
            __slots__ = ()
            CongratulationsWindow = DynAccessor(602)
            MedalTooltip = DynAccessor(603)
            OnboardingQueueView = DynAccessor(604)

        common = _common()

        class _lobby(DynAccessor):
            __slots__ = ()
            BattleResultView = DynAccessor(605)
            MissionSelectionView = DynAccessor(606)
            MissionTooltip = DynAccessor(607)

        lobby = _lobby()

    story_mode = _story_mode()

    class _survey(DynAccessor):
        __slots__ = ()

        class _lobby(DynAccessor):
            __slots__ = ()

            class _survey(DynAccessor):
                __slots__ = ()
                SurveyView = DynAccessor(608)

            survey = _survey()

        lobby = _lobby()

    survey = _survey()

    class _white_tiger(DynAccessor):
        __slots__ = ()

        class _lobby(DynAccessor):
            __slots__ = ()
            AwardsView = DynAccessor(609)
            CarouselView = DynAccessor(610)
            CharacteristicsPanel = DynAccessor(611)
            CrewWidget = DynAccessor(612)
            EntryPoint = DynAccessor(613)
            InsidePortalView = DynAccessor(614)
            LootBoxesEntryPoint = DynAccessor(615)
            PortalAwardsView = DynAccessor(616)
            PortalVehicleAwardView = DynAccessor(617)
            PortalView = DynAccessor(618)

            class _postbattle(DynAccessor):
                __slots__ = ()

                class _common(DynAccessor):
                    __slots__ = ()
                    Reveal = DynAccessor(619)

                common = _common()
                PostbattleScreen = DynAccessor(620)

                class _tooltips(DynAccessor):
                    __slots__ = ()
                    ExpBonus = DynAccessor(621)
                    FinanceDetails = DynAccessor(622)
                    PersonalEfficiency = DynAccessor(623)
                    PremiumPlus = DynAccessor(624)
                    ProgressiveReward = DynAccessor(625)

                tooltips = _tooltips()

            postbattle = _postbattle()
            ProgressionEntryPoint = DynAccessor(626)
            ProgressionView = DynAccessor(627)

            class _tooltips(DynAccessor):
                __slots__ = ()
                AmmunitionTooltipView = DynAccessor(628)
                BattlesEndTooltipView = DynAccessor(629)
                BuyLootBoxesTooltipView = DynAccessor(630)
                CarouselVehicleTooltipView = DynAccessor(631)
                GuaranteedRewardTooltipView = DynAccessor(632)
                InfoTooltipView = DynAccessor(633)
                LootBoxesTooltipView = DynAccessor(634)
                LootBoxTooltipView = DynAccessor(635)
                MainPrizeDiscountTooltipView = DynAccessor(636)
                ProgressionEntryPointTooltip = DynAccessor(637)
                StampTooltipView = DynAccessor(638)
                TicketTooltipView = DynAccessor(639)
                VehicleParamsTooltipView = DynAccessor(640)

            tooltips = _tooltips()
            VideoView = DynAccessor(641)
            WelcomeView = DynAccessor(642)

        lobby = _lobby()

    white_tiger = _white_tiger()

    class _winback(DynAccessor):
        __slots__ = ()
        BattleQuestAwardsView = DynAccessor(643)

        class _lobby(DynAccessor):
            __slots__ = ()

            class _popovers(DynAccessor):
                __slots__ = ()
                WinbackLeaveModePopoverView = DynAccessor(644)

            popovers = _popovers()

            class _tooltips(DynAccessor):
                __slots__ = ()
                CompensationTooltip = DynAccessor(645)
                ModeInfoTooltip = DynAccessor(646)
                SelectableRewardTooltip = DynAccessor(647)
                SelectedRewardsTooltip = DynAccessor(648)
                WidgetTooltipView = DynAccessor(649)

            tooltips = _tooltips()
            WinbackDailyQuestsIntroView = DynAccessor(650)
            WinbackIntroView = DynAccessor(651)
            WinbackLeaveModeDialogView = DynAccessor(652)
            WinbackRewardView = DynAccessor(653)
            WinbackSelectableRewardView = DynAccessor(654)
            WinbackWidgetView = DynAccessor(655)

        lobby = _lobby()
        ProgressionMainView = DynAccessor(656)

    winback = _winback()
    Anchor = DynAccessor(657)
    ArmoryYardDemoView = DynAccessor(658)

    class _child_views_demo(DynAccessor):
        __slots__ = ()
        ChildDemoView = DynAccessor(659)
        MainView = DynAccessor(660)

    child_views_demo = _child_views_demo()
    Comp7DemoPageView = DynAccessor(661)
    ComponentsDemo = DynAccessor(662)
    DataLayerDemoView = DynAccessor(663)
    DataTrackerDemo = DynAccessor(664)
    DemoContextMenu = DynAccessor(665)
    Easings = DynAccessor(666)
    GameLoadingDebugView = DynAccessor(667)
    GFCharset = DynAccessor(668)
    GFComponents = DynAccessor(669)
    GFDemoPopover = DynAccessor(670)
    GFDemoRichTooltipWindow = DynAccessor(671)
    GFDemoWindow = DynAccessor(672)
    GFHooksDemo = DynAccessor(673)
    GFInjectView = DynAccessor(674)
    GFInputCases = DynAccessor(675)
    GFSimpleTooltipWindow = DynAccessor(676)
    GFWebSubDemoWindow = DynAccessor(677)

    class _gf_dialogs_demo(DynAccessor):
        __slots__ = ()
        DefaultDialogProxy = DynAccessor(678)
        GFDialogsDemo = DynAccessor(679)

        class _sub_views(DynAccessor):
            __slots__ = ()
            DummyContent = DynAccessor(680)
            DummyFooter = DynAccessor(681)
            DummyIcon = DynAccessor(682)
            DummyStepper = DynAccessor(683)
            DummyTitle = DynAccessor(684)
            DummyTopRight = DynAccessor(685)

        sub_views = _sub_views()

    gf_dialogs_demo = _gf_dialogs_demo()

    class _gf_viewer(DynAccessor):
        __slots__ = ()
        GFViewerWindow = DynAccessor(686)

    gf_viewer = _gf_viewer()

    class _igb_demo(DynAccessor):
        __slots__ = ()
        BrowserFullscreenWindow = DynAccessor(687)
        BrowserWindow = DynAccessor(688)
        MainView = DynAccessor(689)

    igb_demo = _igb_demo()
    LocaleDemo = DynAccessor(690)
    MediaWrapperDemo = DynAccessor(691)
    MixBlendMode = DynAccessor(692)
    MixBlendModeAnimation = DynAccessor(693)
    ModeSelectorDemo = DynAccessor(694)
    ModeSelectorToolsetView = DynAccessor(695)
    NewYearLevelUp = DynAccessor(696)
    PluralLocView = DynAccessor(697)
    PropsSupportDemo = DynAccessor(698)
    ReactSpringVizualizer = DynAccessor(699)
    SelectableRewardDemoView = DynAccessor(700)
    StructuralDataBindDemo = DynAccessor(701)

    class _sub_views_demo(DynAccessor):
        __slots__ = ()
        GFSubViewsDemo = DynAccessor(702)

        class _sub_views(DynAccessor):
            __slots__ = ()
            CustomizationCartProxy = DynAccessor(703)
            DailyProxy = DynAccessor(704)
            ProgressiveItemsViewProxy = DynAccessor(705)

        sub_views = _sub_views()

    sub_views_demo = _sub_views_demo()
    SurfaceView = DynAccessor(706)
    UILoggerDemo = DynAccessor(707)
    VideoSupportView = DynAccessor(708)
    W2CTestPageWindow = DynAccessor(709)
    WgcgMockView = DynAccessor(710)

    class _wgtv(DynAccessor):
        __slots__ = ()
        WgtvEntityView = DynAccessor(711)
        WgtvKeyframeInfoView = DynAccessor(712)
        WgtvKeyframeView = DynAccessor(713)
        WgtvTimelineView = DynAccessor(714)
        WgtvToolsView = DynAccessor(715)

    wgtv = _wgtv()