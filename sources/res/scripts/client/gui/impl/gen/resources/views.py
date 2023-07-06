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
            BattleNotifierView = DynAccessor(87)

        battle_notifier = _battle_notifier()

        class _battle_page(DynAccessor):
            __slots__ = ()
            EpicRespawnAmmunitionPanelView = DynAccessor(88)
            PersonalReservesTabView = DynAccessor(89)
            PrebattleAmmunitionPanelView = DynAccessor(90)

        battle_page = _battle_page()

        class _timer(DynAccessor):
            __slots__ = ()
            TimerView = DynAccessor(91)

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
        BackportContextMenu = DynAccessor(92)
        Browser = DynAccessor(93)

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
            RewardsSelectionView = DynAccessor(158)

            class _sharedComponents(DynAccessor):
                __slots__ = ()
                AnimatedReward = DynAccessor(159)
                AwardsWidget = DynAccessor(160)
                BuyButtons = DynAccessor(161)
                ChapterBackground = DynAccessor(162)
                CurrencyReward = DynAccessor(163)
                Emblem = DynAccessor(164)
                FormatRemainingDate = DynAccessor(165)
                Header = DynAccessor(166)
                LoupeButton = DynAccessor(167)
                RewardsBlock = DynAccessor(168)
                ScrollWithLips = DynAccessor(169)
                Slider = DynAccessor(170)
                Title = DynAccessor(171)
                VehicleBonusList = DynAccessor(172)
                VehicleInfo = DynAccessor(173)
                VehicleList = DynAccessor(174)

            sharedComponents = _sharedComponents()

            class _tooltips(DynAccessor):
                __slots__ = ()
                BattlePassCoinTooltipView = DynAccessor(175)
                BattlePassCompletedTooltipView = DynAccessor(176)
                BattlePassGoldMissionTooltipView = DynAccessor(177)
                BattlePassInProgressTooltipView = DynAccessor(178)
                BattlePassLockIconTooltipView = DynAccessor(179)
                BattlePassNoChapterTooltipView = DynAccessor(180)
                BattlePassNotStartedTooltipView = DynAccessor(181)
                BattlePassOnPauseTooltipView = DynAccessor(182)
                BattlePassPointsView = DynAccessor(183)
                BattlePassQuestsChainTooltipView = DynAccessor(184)
                BattlePassUndefinedStyleView = DynAccessor(185)
                BattlePassUpgradeStyleTooltipView = DynAccessor(186)
                RandomQuestTooltip = DynAccessor(187)

                class _sharedComponents(DynAccessor):
                    __slots__ = ()
                    BlockCompleted = DynAccessor(188)
                    Chose = DynAccessor(189)
                    FinalLevel = DynAccessor(190)
                    IconTextBlock = DynAccessor(191)
                    PerBattlePointsTable = DynAccessor(192)
                    Point = DynAccessor(193)

                sharedComponents = _sharedComponents()
                VehiclePointsTooltipView = DynAccessor(194)

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
            Confirm = DynAccessor(200)

            class _tooltips(DynAccessor):
                __slots__ = ()
                BlueprintsAlliancesTooltipView = DynAccessor(201)

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
            AwardsView = DynAccessor(215)
            BrowserView = DynAccessor(216)
            SelectableRewardBase = DynAccessor(217)
            SelectSlotSpecDialog = DynAccessor(218)

            class _tooltips(DynAccessor):
                __slots__ = ()
                SelectedRewardsTooltipView = DynAccessor(219)

            tooltips = _tooltips()

        common = _common()

        class _crew_books(DynAccessor):
            __slots__ = ()

            class _crew_books_buy_dialog(DynAccessor):
                __slots__ = ()
                CrewBooksBuyDialog = DynAccessor(38)

            crew_books_buy_dialog = _crew_books_buy_dialog()

            class _crew_books_dialog_content(DynAccessor):
                __slots__ = ()
                CrewBooksDialogContent = DynAccessor(39)

            crew_books_dialog_content = _crew_books_dialog_content()

            class _crew_books_lack_view(DynAccessor):
                __slots__ = ()
                CrewBooksLackView = DynAccessor(40)

            crew_books_lack_view = _crew_books_lack_view()

            class _crew_books_view(DynAccessor):
                __slots__ = ()
                CrewBooksView = DynAccessor(41)

            crew_books_view = _crew_books_view()

            class _crew_book_item_view(DynAccessor):
                __slots__ = ()
                CrewBookItemView = DynAccessor(42)

            crew_book_item_view = _crew_book_item_view()

        crew_books = _crew_books()

        class _marathon(DynAccessor):
            __slots__ = ()

            class _marathon_reward_view(DynAccessor):
                __slots__ = ()
                MarathonRewardView = DynAccessor(43)

            marathon_reward_view = _marathon_reward_view()
            EntryPoint = DynAccessor(294)
            RewardWindow = DynAccessor(295)

            class _tooltips(DynAccessor):
                __slots__ = ()
                RestRewardTooltip = DynAccessor(296)

            tooltips = _tooltips()

        marathon = _marathon()

        class _missions(DynAccessor):
            __slots__ = ()

            class _missions_tab_bar_view(DynAccessor):
                __slots__ = ()
                MissionsTabBarView = DynAccessor(44)

            missions_tab_bar_view = _missions_tab_bar_view()

            class _common(DynAccessor):
                __slots__ = ()
                BattleConditions = DynAccessor(298)
                Countdown = DynAccessor(299)
                PendingDots = DynAccessor(300)

            common = _common()
            Daily = DynAccessor(301)
            DailyQuestsTooltip = DynAccessor(302)
            DailyQuestsWidget = DynAccessor(303)
            RerollTooltip = DynAccessor(304)
            RerollTooltipWithCountdown = DynAccessor(305)

        missions = _missions()

        class _nation_change(DynAccessor):
            __slots__ = ()

            class _nation_change_screen(DynAccessor):
                __slots__ = ()
                NationChangeScreen = DynAccessor(45)

            nation_change_screen = _nation_change_screen()

        nation_change = _nation_change()

        class _premacc(DynAccessor):
            __slots__ = ()

            class _daily_experience_view(DynAccessor):
                __slots__ = ()
                DailyExperiencePage = DynAccessor(46)

            daily_experience_view = _daily_experience_view()

            class _maps_blacklist_view(DynAccessor):
                __slots__ = ()
                MapsBlacklistView = DynAccessor(47)

            maps_blacklist_view = _maps_blacklist_view()

            class _piggybank(DynAccessor):
                __slots__ = ()
                Piggybank = DynAccessor(48)

            piggybank = _piggybank()

            class _squad_bonus_tooltip_content(DynAccessor):
                __slots__ = ()
                SquadBonusTooltipContent = DynAccessor(49)

            squad_bonus_tooltip_content = _squad_bonus_tooltip_content()

            class _dashboard(DynAccessor):
                __slots__ = ()

                class _prem_dashboard_parent_control_info(DynAccessor):
                    __slots__ = ()
                    PremDashboardParentControlInfoContent = DynAccessor(50)

                prem_dashboard_parent_control_info = _prem_dashboard_parent_control_info()

                class _piggy_bank_cards(DynAccessor):
                    __slots__ = ()

                    class _prem_piggy_bank(DynAccessor):
                        __slots__ = ()
                        PremPiggyBankCard = DynAccessor(51)

                    prem_piggy_bank = _prem_piggy_bank()

                    class _wot_plus_piggy_bank(DynAccessor):
                        __slots__ = ()
                        WotPlusPiggyBankCard = DynAccessor(52)

                    wot_plus_piggy_bank = _wot_plus_piggy_bank()

                piggy_bank_cards = _piggy_bank_cards()

            dashboard = _dashboard()

            class _maps_blacklist(DynAccessor):
                __slots__ = ()

                class _maps_blacklist_confirm_dialog(DynAccessor):
                    __slots__ = ()
                    MapsBlacklistConfirmDialogContent = DynAccessor(53)

                maps_blacklist_confirm_dialog = _maps_blacklist_confirm_dialog()

                class _maps_blacklist_tooltips(DynAccessor):
                    __slots__ = ()
                    MapsBlacklistInfoTooltipContent = DynAccessor(54)

                maps_blacklist_tooltips = _maps_blacklist_tooltips()

            maps_blacklist = _maps_blacklist()

        premacc = _premacc()

        class _progressive_reward(DynAccessor):
            __slots__ = ()

            class _progressive_reward_award(DynAccessor):
                __slots__ = ()
                ProgressiveRewardAward = DynAccessor(55)

            progressive_reward_award = _progressive_reward_award()

            class _progressive_reward_view(DynAccessor):
                __slots__ = ()
                ProgressiveRewardView = DynAccessor(56)

            progressive_reward_view = _progressive_reward_view()

        progressive_reward = _progressive_reward()

        class _ranked(DynAccessor):
            __slots__ = ()

            class _ranked_year_award(DynAccessor):
                __slots__ = ()
                RankedYearAward = DynAccessor(57)

            ranked_year_award = _ranked_year_award()
            EntryPoint = DynAccessor(339)
            QualificationRewardsView = DynAccessor(340)
            RankedSelectableRewardView = DynAccessor(341)

            class _tooltips(DynAccessor):
                __slots__ = ()
                RankedBattlesRolesTooltipView = DynAccessor(342)

            tooltips = _tooltips()
            YearLeaderboardView = DynAccessor(343)

        ranked = _ranked()

        class _reward_window(DynAccessor):
            __slots__ = ()

            class _clan_reward_window_content(DynAccessor):
                __slots__ = ()
                ClanRewardWindowContent = DynAccessor(58)

            clan_reward_window_content = _clan_reward_window_content()

            class _piggy_bank_reward_window_content(DynAccessor):
                __slots__ = ()
                PiggyBankRewardWindowContent = DynAccessor(59)

            piggy_bank_reward_window_content = _piggy_bank_reward_window_content()

            class _reward_window_content(DynAccessor):
                __slots__ = ()
                RewardWindowContent = DynAccessor(60)

            reward_window_content = _reward_window_content()

            class _twitch_reward_window_content(DynAccessor):
                __slots__ = ()
                TwitchRewardWindowContent = DynAccessor(61)

            twitch_reward_window_content = _twitch_reward_window_content()

        reward_window = _reward_window()

        class _shop(DynAccessor):
            __slots__ = ()

            class _buy_vehicle_view(DynAccessor):
                __slots__ = ()
                BuyVehicleView = DynAccessor(62)

            buy_vehicle_view = _buy_vehicle_view()

        shop = _shop()

        class _tooltips(DynAccessor):
            __slots__ = ()

            class _clans(DynAccessor):
                __slots__ = ()
                ClanShortInfoTooltipContent = DynAccessor(63)

            clans = _clans()
            AdditionalRewardsTooltip = DynAccessor(419)
            TankmanTooltipView = DynAccessor(420)
            VehPostProgressionEntryPointTooltip = DynAccessor(421)

        tooltips = _tooltips()

        class _video(DynAccessor):
            __slots__ = ()

            class _video_view(DynAccessor):
                __slots__ = ()
                VideoView = DynAccessor(64)

            video_view = _video_view()

        video = _video()

        class _account_completion(DynAccessor):
            __slots__ = ()
            AddCredentialsView = DynAccessor(111)
            CompleteView = DynAccessor(112)
            ConfirmCredentialsView = DynAccessor(113)
            ContactSupportView = DynAccessor(114)
            CurtainView = DynAccessor(115)
            EmptyView = DynAccessor(116)
            ErrorView = DynAccessor(117)
            RenamingCompleteView = DynAccessor(118)
            RenamingView = DynAccessor(119)

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
            BattleResultView = DynAccessor(195)
            CommanderView = DynAccessor(196)

            class _sharedComponents(DynAccessor):
                __slots__ = ()
                CurrencyResolver = DynAccessor(197)
                PriceResolver = DynAccessor(198)

            sharedComponents = _sharedComponents()
            TechParametersVIew = DynAccessor(199)

        battle_royale = _battle_royale()

        class _bootcamp(DynAccessor):
            __slots__ = ()
            BootcampExitView = DynAccessor(202)
            BootcampFinalRewardView = DynAccessor(203)
            BootcampNationView = DynAccessor(204)
            BootcampProgressView = DynAccessor(205)
            BootcampProgressWidget = DynAccessor(206)
            BootcampQuestWidget = DynAccessor(207)
            RewardsTooltip = DynAccessor(208)

        bootcamp = _bootcamp()

        class _collection(DynAccessor):
            __slots__ = ()
            AwardsView = DynAccessor(209)
            CollectionItemPreview = DynAccessor(210)
            CollectionView = DynAccessor(211)

            class _tooltips(DynAccessor):
                __slots__ = ()
                CollectionItemTooltipView = DynAccessor(212)

            tooltips = _tooltips()

        collection = _collection()

        class _collective_goal(DynAccessor):
            __slots__ = ()
            CollectiveGoalEntryPointView = DynAccessor(213)

            class _tooltips(DynAccessor):
                __slots__ = ()
                EntryPointTooltip = DynAccessor(214)

            tooltips = _tooltips()

        collective_goal = _collective_goal()

        class _comp7(DynAccessor):
            __slots__ = ()
            MetaRootView = DynAccessor(220)

            class _sharedComponents(DynAccessor):
                __slots__ = ()
                ActiveSeasonState = DynAccessor(221)
                CloseButton = DynAccessor(222)
                DivisionTooltip = DynAccessor(223)
                Heading = DynAccessor(224)
                HighlightedRankEmblem = DynAccessor(225)
                LastUpdate = DynAccessor(226)
                LastUpdateNote = DynAccessor(227)
                LobbyTopSubViewWrapper = DynAccessor(228)
                ProgressionScroll = DynAccessor(229)
                RankEmblem = DynAccessor(230)
                RankTooltip = DynAccessor(231)
                ScheduleSubheading = DynAccessor(232)

            sharedComponents = _sharedComponents()

            class _tooltips(DynAccessor):
                __slots__ = ()
                DivisionTooltip = DynAccessor(233)
                GeneralRankTooltip = DynAccessor(234)
                LastUpdateTooltip = DynAccessor(235)
                MainWidgetTooltip = DynAccessor(236)
                RankInactivityTooltip = DynAccessor(237)
                SeventhRankTooltip = DynAccessor(238)
                SixthRankTooltip = DynAccessor(239)

            tooltips = _tooltips()

            class _views(DynAccessor):
                __slots__ = ()
                Banner = DynAccessor(240)
                IntroScreen = DynAccessor(241)
                LeaderboardPage = DynAccessor(242)
                MainWidget = DynAccessor(243)
                NoVehiclesScreen = DynAccessor(244)
                ProgressionPage = DynAccessor(245)
                RankRewardsPage = DynAccessor(246)
                RewardsScreen = DynAccessor(247)
                SeasonModifier = DynAccessor(248)
                WeeklyQuestsPage = DynAccessor(249)

            views = _views()

        comp7 = _comp7()

        class _craft_machine(DynAccessor):
            __slots__ = ()
            CraftmachineEntryPointView = DynAccessor(250)

        craft_machine = _craft_machine()

        class _crew(DynAccessor):
            __slots__ = ()
            AccelerateTrainingTooltipView = DynAccessor(251)

            class _common(DynAccessor):
                __slots__ = ()
                TooltipAdvancedFooter = DynAccessor(252)

            common = _common()
            ConfirmLearnSkillsContent = DynAccessor(253)
            CrewHeader = DynAccessor(254)
            CrewHeaderTooltipView = DynAccessor(255)
            CrewIntroView = DynAccessor(256)

            class _tooltips(DynAccessor):
                __slots__ = ()
                AdvancedTooltipView = DynAccessor(257)
                CrewPerksAdditionalTooltip = DynAccessor(258)
                CrewPerksTooltip = DynAccessor(259)
                VehicleParamsTooltipView = DynAccessor(260)

            tooltips = _tooltips()

        crew = _crew()

        class _crystalsPromo(DynAccessor):
            __slots__ = ()
            CrystalsPromoView = DynAccessor(261)

        crystalsPromo = _crystalsPromo()

        class _currency_reserves(DynAccessor):
            __slots__ = ()
            CurrencyReserves = DynAccessor(262)
            ReservesAwardView = DynAccessor(263)

        currency_reserves = _currency_reserves()

        class _customization(DynAccessor):
            __slots__ = ()
            CustomizationCart = DynAccessor(264)

            class _progression_styles(DynAccessor):
                __slots__ = ()
                OnboardingView = DynAccessor(265)
                StageSwitcher = DynAccessor(266)

            progression_styles = _progression_styles()

            class _progressive_items_reward(DynAccessor):
                __slots__ = ()
                ProgressiveItemsUpgradeView = DynAccessor(267)

            progressive_items_reward = _progressive_items_reward()

            class _progressive_items_view(DynAccessor):
                __slots__ = ()
                ProgressiveItemsView = DynAccessor(268)

            progressive_items_view = _progressive_items_view()

            class _style_unlocked_view(DynAccessor):
                __slots__ = ()
                StyleUnlockedView = DynAccessor(269)

            style_unlocked_view = _style_unlocked_view()

        customization = _customization()

        class _dedication(DynAccessor):
            __slots__ = ()
            DedicationRewardView = DynAccessor(270)

        dedication = _dedication()

        class _dog_tags(DynAccessor):
            __slots__ = ()
            DedicationTooltip = DynAccessor(271)
            DogTagsView = DynAccessor(272)
            RankedEfficiencyTooltip = DynAccessor(273)
            ThreeMonthsTooltip = DynAccessor(274)
            TriumphTooltip = DynAccessor(275)

        dog_tags = _dog_tags()

        class _elite_window(DynAccessor):
            __slots__ = ()
            EliteView = DynAccessor(276)

        elite_window = _elite_window()

        class _excluded_maps(DynAccessor):
            __slots__ = ()
            ExcludedMapsView = DynAccessor(277)

        excluded_maps = _excluded_maps()

        class _frontline(DynAccessor):
            __slots__ = ()
            AwardsView = DynAccessor(278)

            class _dialogs(DynAccessor):
                __slots__ = ()
                BlankPrice = DynAccessor(279)

            dialogs = _dialogs()
            IntroScreen = DynAccessor(280)
            RewardsSelectionView = DynAccessor(281)

        frontline = _frontline()

        class _instructions(DynAccessor):
            __slots__ = ()
            BuyWindow = DynAccessor(282)
            SellWindow = DynAccessor(283)

        instructions = _instructions()

        class _mapbox(DynAccessor):
            __slots__ = ()
            MapBoxAwardsView = DynAccessor(284)
            MapBoxEntryPointView = DynAccessor(285)
            MapBoxIntro = DynAccessor(286)
            MapBoxProgression = DynAccessor(287)
            MapBoxRewardChoiceView = DynAccessor(288)
            MapBoxSurveyView = DynAccessor(289)

        mapbox = _mapbox()

        class _maps_training(DynAccessor):
            __slots__ = ()
            MapsTrainingPage = DynAccessor(290)
            MapsTrainingQueue = DynAccessor(291)
            MapsTrainingResult = DynAccessor(292)
            ScenarioTooltip = DynAccessor(293)

        maps_training = _maps_training()

        class _matchmaker(DynAccessor):
            __slots__ = ()
            ActiveTestConfirmView = DynAccessor(297)

        matchmaker = _matchmaker()

        class _mode_selector(DynAccessor):
            __slots__ = ()
            BattleSessionView = DynAccessor(306)
            ModeSelectorView = DynAccessor(307)

            class _popovers(DynAccessor):
                __slots__ = ()
                RandomBattlePopover = DynAccessor(308)

            popovers = _popovers()

            class _tooltips(DynAccessor):
                __slots__ = ()
                AlertTooltip = DynAccessor(309)

                class _common(DynAccessor):
                    __slots__ = ()
                    Divider = DynAccessor(310)
                    GradientDecorator = DynAccessor(311)

                common = _common()
                SimplyFormatTooltip = DynAccessor(312)

            tooltips = _tooltips()

            class _widgets(DynAccessor):
                __slots__ = ()
                BattleRoyaleProgressionWidget = DynAccessor(313)
                EpicWidget = DynAccessor(314)
                RankedWidget = DynAccessor(315)

            widgets = _widgets()

        mode_selector = _mode_selector()

        class _offers(DynAccessor):
            __slots__ = ()
            OfferBannerWindow = DynAccessor(316)
            OfferGiftsWindow = DynAccessor(317)
            OfferRewardWindow = DynAccessor(318)

        offers = _offers()

        class _personal_reserves(DynAccessor):
            __slots__ = ()
            PersonalReservesTooltip = DynAccessor(319)
            PersonalReservesWidget = DynAccessor(320)
            ReserveCard = DynAccessor(321)
            ReserveCardTooltip = DynAccessor(322)
            ReserveGroup = DynAccessor(323)
            ReservesActivationView = DynAccessor(324)
            ReservesConversionView = DynAccessor(325)
            ReservesIntroView = DynAccessor(326)

        personal_reserves = _personal_reserves()

        class _platoon(DynAccessor):
            __slots__ = ()
            AlertTooltip = DynAccessor(327)
            MembersWindow = DynAccessor(328)
            PlatoonDropdown = DynAccessor(329)
            SearchingDropdown = DynAccessor(330)
            SettingsPopover = DynAccessor(331)

            class _subViews(DynAccessor):
                __slots__ = ()
                Chat = DynAccessor(332)
                SettingsContent = DynAccessor(333)
                TiersLimit = DynAccessor(334)

            subViews = _subViews()
            WTRTooltip = DynAccessor(335)

        platoon = _platoon()

        class _player_subscriptions(DynAccessor):
            __slots__ = ()
            PlayerSubscriptions = DynAccessor(336)
            SubscriptionItem = DynAccessor(337)
            SubscriptionRewardView = DynAccessor(338)

        player_subscriptions = _player_subscriptions()

        class _recruit_window(DynAccessor):
            __slots__ = ()
            RecruitDialog = DynAccessor(344)

        recruit_window = _recruit_window()

        class _research(DynAccessor):
            __slots__ = ()
            BuyModuleDialogView = DynAccessor(345)
            InsufficientCreditsTooltip = DynAccessor(346)
            SoldModuleInfoTooltip = DynAccessor(347)

        research = _research()

        class _resource_well(DynAccessor):
            __slots__ = ()
            AwardView = DynAccessor(348)
            CompletedProgressionView = DynAccessor(349)
            EntryPoint = DynAccessor(350)
            IntroView = DynAccessor(351)
            NoSerialVehiclesConfirm = DynAccessor(352)
            NoVehiclesConfirm = DynAccessor(353)
            ProgressionView = DynAccessor(354)
            ResourcesLoadingConfirm = DynAccessor(355)
            ResourcesLoadingView = DynAccessor(356)

            class _sharedComponents(DynAccessor):
                __slots__ = ()

                class _award(DynAccessor):
                    __slots__ = ()
                    AdditionalReward = DynAccessor(357)
                    Footer = DynAccessor(358)
                    Header = DynAccessor(359)
                    Reward = DynAccessor(360)

                award = _award()
                Counter = DynAccessor(361)
                NoVehiclesState = DynAccessor(362)
                Resource = DynAccessor(363)
                VehicleCount = DynAccessor(364)
                VehicleInfo = DynAccessor(365)

            sharedComponents = _sharedComponents()

            class _tooltips(DynAccessor):
                __slots__ = ()
                EntryPointTooltip = DynAccessor(366)
                MaxProgressTooltip = DynAccessor(367)
                ProgressTooltip = DynAccessor(368)
                RefundResourcesTooltip = DynAccessor(369)
                SerialNumberTooltip = DynAccessor(370)

            tooltips = _tooltips()

        resource_well = _resource_well()

        class _seniority_awards(DynAccessor):
            __slots__ = ()
            SeniorityAwardsView = DynAccessor(371)

            class _sharedComponents(DynAccessor):
                __slots__ = ()
                SeniorityAwardCoin = DynAccessor(372)

            sharedComponents = _sharedComponents()

        seniority_awards = _seniority_awards()

        class _stronghold(DynAccessor):
            __slots__ = ()
            StrongholdEntryPointView = DynAccessor(373)

        stronghold = _stronghold()

        class _subscription(DynAccessor):
            __slots__ = ()
            SubscriptionAwardView = DynAccessor(374)
            WotPlusTooltip = DynAccessor(375)

        subscription = _subscription()

        class _tanksetup(DynAccessor):
            __slots__ = ()
            AmmunitionPanel = DynAccessor(376)

            class _common(DynAccessor):
                __slots__ = ()
                Action = DynAccessor(377)
                CtaButtons = DynAccessor(378)
                DealPanel = DynAccessor(379)
                ExtraImage = DynAccessor(380)
                FormatColorTagText = DynAccessor(381)
                MaybeWrapper = DynAccessor(382)
                Price = DynAccessor(383)
                SetupApp = DynAccessor(384)
                ShortenedText = DynAccessor(385)
                Slider = DynAccessor(386)

                class _SlotParts(DynAccessor):
                    __slots__ = ()
                    Bonus = DynAccessor(387)
                    Container = DynAccessor(388)
                    Count = DynAccessor(389)
                    Inside = DynAccessor(390)
                    Level = DynAccessor(391)

                SlotParts = _SlotParts()
                Specializations = DynAccessor(392)
                Storage = DynAccessor(393)
                SwitchButton = DynAccessor(394)
                SwitchEquipment = DynAccessor(395)

                class _Transitions(DynAccessor):
                    __slots__ = ()
                    SlotTransitions = DynAccessor(396)

                Transitions = _Transitions()
                WeaponOccupancy = DynAccessor(397)

            common = _common()
            DeconstructionDeviceView = DynAccessor(398)

            class _dialogs(DynAccessor):
                __slots__ = ()
                Confirm = DynAccessor(399)
                ConfirmActionsWithEquipmentDialog = DynAccessor(400)
                DeconstructConfirm = DynAccessor(401)
                DeviceUpgradeDialog = DynAccessor(402)
                ExchangeToBuyItems = DynAccessor(403)
                ExchangeToUpgradeItems = DynAccessor(404)
                NeedRepair = DynAccessor(405)
                RefillShells = DynAccessor(406)

                class _sub_views(DynAccessor):
                    __slots__ = ()
                    FrontlineConfirmFooterMoney = DynAccessor(407)
                    FrontlineConfirmIcons = DynAccessor(408)
                    FrontlineConfirmMultipleNames = DynAccessor(409)
                    FrontlineConfirmTitle = DynAccessor(410)

                sub_views = _sub_views()

            dialogs = _dialogs()
            HangarAmmunitionSetup = DynAccessor(411)
            IntroScreen = DynAccessor(412)

            class _tooltips(DynAccessor):
                __slots__ = ()
                DeconstructFromInventoryTooltip = DynAccessor(413)
                DeconstructFromVehicleTooltip = DynAccessor(414)
                SetupTabTooltipView = DynAccessor(415)
                WarningTooltipView = DynAccessor(416)

            tooltips = _tooltips()
            VehicleCompareAmmunitionPanel = DynAccessor(417)
            VehicleCompareAmmunitionSetup = DynAccessor(418)

        tanksetup = _tanksetup()

        class _vehicle_compare(DynAccessor):
            __slots__ = ()
            CompareModificationsPanelView = DynAccessor(422)
            SelectSlotSpecCompareDialog = DynAccessor(423)

        vehicle_compare = _vehicle_compare()

        class _vehicle_preview(DynAccessor):
            __slots__ = ()

            class _buying_panel(DynAccessor):
                __slots__ = ()
                StyleBuyingPanel = DynAccessor(424)
                VPProgressionStylesBuyingPanel = DynAccessor(425)
                WellPanel = DynAccessor(426)

            buying_panel = _buying_panel()

            class _top_panel(DynAccessor):
                __slots__ = ()
                TopPanelTabs = DynAccessor(427)

            top_panel = _top_panel()

        vehicle_preview = _vehicle_preview()

        class _veh_post_progression(DynAccessor):
            __slots__ = ()

            class _common(DynAccessor):
                __slots__ = ()
                Bonus = DynAccessor(428)
                Description = DynAccessor(429)
                Grid = DynAccessor(430)
                PersistentBonuses = DynAccessor(431)
                Slide = DynAccessor(432)
                SlideContent = DynAccessor(433)
                Slider = DynAccessor(434)
                TextSplit = DynAccessor(435)

            common = _common()
            PostProgressionInfo = DynAccessor(436)
            PostProgressionIntro = DynAccessor(437)
            PostProgressionResearchSteps = DynAccessor(438)

            class _tooltip(DynAccessor):
                __slots__ = ()

                class _common(DynAccessor):
                    __slots__ = ()
                    DisabledBlock = DynAccessor(439)
                    FeatureLevelSubtitle = DynAccessor(440)
                    Lock = DynAccessor(441)
                    NotEnoughCredits = DynAccessor(442)
                    PriceBlock = DynAccessor(443)
                    Separator = DynAccessor(444)

                common = _common()
                PairModificationTooltipView = DynAccessor(445)
                PostProgressionLevelTooltipView = DynAccessor(446)
                RoleSlotTooltipView = DynAccessor(447)
                SetupTooltipView = DynAccessor(448)

            tooltip = _tooltip()
            VehiclePostProgressionCmpView = DynAccessor(449)
            VehiclePostProgressionView = DynAccessor(450)

        veh_post_progression = _veh_post_progression()

        class _winback(DynAccessor):
            __slots__ = ()

            class _popovers(DynAccessor):
                __slots__ = ()
                WinbackLeaveModePopoverView = DynAccessor(451)

            popovers = _popovers()

            class _tooltips(DynAccessor):
                __slots__ = ()
                MainRewardTooltip = DynAccessor(452)
                ModeInfoTooltip = DynAccessor(453)
                SelectableRewardTooltip = DynAccessor(454)
                SelectedRewardsTooltip = DynAccessor(455)

            tooltips = _tooltips()
            WinbackDailyQuestsIntroView = DynAccessor(456)
            WinbackLeaveModeDialogView = DynAccessor(457)
            WinbackRewardView = DynAccessor(458)
            WinbackSelectableRewardView = DynAccessor(459)

        winback = _winback()

    lobby = _lobby()

    class _test_check_box_view(DynAccessor):
        __slots__ = ()
        TestCheckBoxView = DynAccessor(65)

    test_check_box_view = _test_check_box_view()

    class _test_text_button_view(DynAccessor):
        __slots__ = ()
        TestTextButtonView = DynAccessor(66)

    test_text_button_view = _test_text_button_view()

    class _windows_layout_view(DynAccessor):
        __slots__ = ()
        WindowsLayountView = DynAccessor(67)

    windows_layout_view = _windows_layout_view()

    class _blend_mode(DynAccessor):
        __slots__ = ()

        class _blend_mode(DynAccessor):
            __slots__ = ()
            BlendMode = DynAccessor(68)

        blend_mode = _blend_mode()

    blend_mode = _blend_mode()

    class _demo_view(DynAccessor):
        __slots__ = ()

        class _views(DynAccessor):
            __slots__ = ()

            class _demo_window_content(DynAccessor):
                __slots__ = ()
                DemoWindowContent = DynAccessor(69)
                ImageProps = DynAccessor(70)

            demo_window_content = _demo_window_content()

            class _demo_window_details_panel(DynAccessor):
                __slots__ = ()
                DemoWindowDetailsPanel = DynAccessor(71)

            demo_window_details_panel = _demo_window_details_panel()

            class _demo_window_image_panel(DynAccessor):
                __slots__ = ()
                DemoWindowImagePanel = DynAccessor(72)

            demo_window_image_panel = _demo_window_image_panel()

            class _image_preview_window_content(DynAccessor):
                __slots__ = ()
                ImagePreviewWindowContent = DynAccessor(73)

            image_preview_window_content = _image_preview_window_content()

        views = _views()

    demo_view = _demo_view()

    class _examples(DynAccessor):
        __slots__ = ()

        class _views(DynAccessor):
            __slots__ = ()

            class _test_dialogs_view(DynAccessor):
                __slots__ = ()
                TestDialogsView = DynAccessor(74)

            test_dialogs_view = _test_dialogs_view()

            class _test_expr_functions_view(DynAccessor):
                __slots__ = ()
                TestExprFunctionsView = DynAccessor(75)

            test_expr_functions_view = _test_expr_functions_view()

            class _test_sub_view(DynAccessor):
                __slots__ = ()
                TestSubView = DynAccessor(76)

            test_sub_view = _test_sub_view()

            class _test_view(DynAccessor):
                __slots__ = ()
                TestView = DynAccessor(77)

            test_view = _test_view()

            class _unbound_example(DynAccessor):
                __slots__ = ()
                UnboundExample = DynAccessor(78)

            unbound_example = _unbound_example()

        views = _views()

    examples = _examples()

    class _list_examples(DynAccessor):
        __slots__ = ()

        class _views(DynAccessor):
            __slots__ = ()

            class _list_examples_empty_render_window_content(DynAccessor):
                __slots__ = ()
                ListExamplesEmptyRenderWindowContent = DynAccessor(79)

            list_examples_empty_render_window_content = _list_examples_empty_render_window_content()

            class _list_examples_window_content(DynAccessor):
                __slots__ = ()
                ListExamplesWindowContent = DynAccessor(80)

            list_examples_window_content = _list_examples_window_content()

        views = _views()

    list_examples = _list_examples()

    class _rotation_pivot_view(DynAccessor):
        __slots__ = ()

        class _views(DynAccessor):
            __slots__ = ()

            class _rotation_pivot_view(DynAccessor):
                __slots__ = ()
                RotationAndPivotTestView = DynAccessor(81)

            rotation_pivot_view = _rotation_pivot_view()

        views = _views()

    rotation_pivot_view = _rotation_pivot_view()

    class _rotation_view(DynAccessor):
        __slots__ = ()

        class _views(DynAccessor):
            __slots__ = ()

            class _rotation_view(DynAccessor):
                __slots__ = ()
                RotationTestView = DynAccessor(82)

            rotation_view = _rotation_view()

        views = _views()

    rotation_view = _rotation_view()

    class _scale_view(DynAccessor):
        __slots__ = ()

        class _views(DynAccessor):
            __slots__ = ()

            class _scale_view(DynAccessor):
                __slots__ = ()
                ScaleTestView = DynAccessor(83)

            scale_view = _scale_view()

        views = _views()

    scale_view = _scale_view()

    class _test_uikit_buttons_view(DynAccessor):
        __slots__ = ()

        class _views(DynAccessor):
            __slots__ = ()

            class _test_uikit_buttons_view(DynAccessor):
                __slots__ = ()
                TestUikitButtonsView = DynAccessor(84)

            test_uikit_buttons_view = _test_uikit_buttons_view()

        views = _views()

    test_uikit_buttons_view = _test_uikit_buttons_view()

    class _test_uikit_view(DynAccessor):
        __slots__ = ()

        class _views(DynAccessor):
            __slots__ = ()

            class _test_uikit_view(DynAccessor):
                __slots__ = ()
                TestUikitView = DynAccessor(85)

            test_uikit_view = _test_uikit_view()

        views = _views()

    test_uikit_view = _test_uikit_view()

    class _wtypes_view(DynAccessor):
        __slots__ = ()

        class _views(DynAccessor):
            __slots__ = ()

            class _wtypes_demo_window_content(DynAccessor):
                __slots__ = ()
                WtypesDemoWindowContent = DynAccessor(86)

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
                IconSet = DynAccessor(106)

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

    dialogs = _dialogs()

    class _loading(DynAccessor):
        __slots__ = ()
        GameLoadingView = DynAccessor(110)

    loading = _loading()

    class _armory_yard(DynAccessor):
        __slots__ = ()

        class _lobby(DynAccessor):
            __slots__ = ()

            class _feature(DynAccessor):
                __slots__ = ()
                ArmoryYardBuyView = DynAccessor(460)
                ArmoryYardEntryPointView = DynAccessor(461)
                ArmoryYardIntroView = DynAccessor(462)
                ArmoryYardMainView = DynAccessor(463)
                ArmoryYardRewardsView = DynAccessor(464)
                ArmoryYardVideoRewardView = DynAccessor(465)
                ArmoryYardWidgetView = DynAccessor(466)

                class _tooltips(DynAccessor):
                    __slots__ = ()
                    ArmoryYardCurrencyTooltipView = DynAccessor(467)
                    ArmoryYardSimpleTooltipView = DynAccessor(468)
                    EntryPointActiveTooltipView = DynAccessor(469)
                    EntryPointBeforeProgressionTooltipView = DynAccessor(470)
                    RestRewardTooltipView = DynAccessor(471)

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
                ModifiersDomainTooltipView = DynAccessor(472)

            tooltips = _tooltips()

        lobby = _lobby()

    battle_modifiers = _battle_modifiers()

    class _battle_royale(DynAccessor):
        __slots__ = ()

        class _lobby(DynAccessor):
            __slots__ = ()

            class _tooltips(DynAccessor):
                __slots__ = ()
                BrCoinTooltipView = DynAccessor(473)

                class _common(DynAccessor):
                    __slots__ = ()
                    PriceBlock = DynAccessor(474)
                    RentPrice = DynAccessor(475)

                common = _common()
                RentIconTooltipView = DynAccessor(476)
                RewardCurrencyTooltipView = DynAccessor(477)
                TestDriveInfoTooltipView = DynAccessor(478)
                VehicleTooltipView = DynAccessor(479)

            tooltips = _tooltips()

            class _views(DynAccessor):
                __slots__ = ()
                BattleRoyaleEntryPoint = DynAccessor(480)
                IntroView = DynAccessor(481)
                PreBattleView = DynAccessor(482)
                ProxyCurrencyView = DynAccessor(483)
                WidgetView = DynAccessor(484)

            views = _views()

        lobby = _lobby()

    battle_royale = _battle_royale()

    class _battle_royale_progression(DynAccessor):
        __slots__ = ()
        BattleQuestAwardsView = DynAccessor(485)
        ProgressionMainView = DynAccessor(486)

    battle_royale_progression = _battle_royale_progression()

    class _event_lootboxes(DynAccessor):
        __slots__ = ()

        class _lobby(DynAccessor):
            __slots__ = ()

            class _event_lootboxes(DynAccessor):
                __slots__ = ()
                EntryPointView = DynAccessor(487)
                OpenBoxErrorView = DynAccessor(488)
                OpenBoxScreen = DynAccessor(489)
                PopoverView = DynAccessor(490)

                class _shared(DynAccessor):
                    __slots__ = ()
                    AnimationControls = DynAccessor(491)
                    BuyBoxFooter = DynAccessor(492)
                    CloseBtn = DynAccessor(493)
                    Divider = DynAccessor(494)
                    Header = DynAccessor(495)

                shared = _shared()

                class _tooltips(DynAccessor):
                    __slots__ = ()
                    CompensationTooltip = DynAccessor(496)
                    EntryPointTooltip = DynAccessor(497)
                    LootBoxesTooltip = DynAccessor(498)

                tooltips = _tooltips()
                WelcomeScreen = DynAccessor(499)

            event_lootboxes = _event_lootboxes()

        lobby = _lobby()

    event_lootboxes = _event_lootboxes()

    class _frontline(DynAccessor):
        __slots__ = ()

        class _lobby(DynAccessor):
            __slots__ = ()
            BannerView = DynAccessor(500)
            FrontlineContainerView = DynAccessor(501)
            InfoView = DynAccessor(502)
            ProgressView = DynAccessor(503)
            RewardsView = DynAccessor(504)

            class _tooltips(DynAccessor):
                __slots__ = ()
                LevelReservesTooltip = DynAccessor(505)
                NotEnoughPointsTooltip = DynAccessor(506)
                SkillOrderTooltip = DynAccessor(507)

            tooltips = _tooltips()
            WelcomeView = DynAccessor(508)

        lobby = _lobby()

    frontline = _frontline()

    class _fun_random(DynAccessor):
        __slots__ = ()

        class _lobby(DynAccessor):
            __slots__ = ()

            class _feature(DynAccessor):
                __slots__ = ()
                FunRandomEntryPointView = DynAccessor(509)
                FunRandomHangarWidgetView = DynAccessor(510)
                FunRandomModeSubSelector = DynAccessor(511)
                FunRandomProgression = DynAccessor(512)
                FunRandomQuickFireGunsAmmunitionPanelView = DynAccessor(513)
                FunRandomStrengthsWeaknessesView = DynAccessor(514)

            feature = _feature()

            class _tooltips(DynAccessor):
                __slots__ = ()
                FunRandomAlertTooltipView = DynAccessor(515)
                FunRandomProgressionTooltipView = DynAccessor(516)
                FunRandomVehicleTooltipView = DynAccessor(517)

            tooltips = _tooltips()

        lobby = _lobby()

    fun_random = _fun_random()

    class _survey(DynAccessor):
        __slots__ = ()

        class _lobby(DynAccessor):
            __slots__ = ()

            class _survey(DynAccessor):
                __slots__ = ()
                SurveyView = DynAccessor(518)

            survey = _survey()

        lobby = _lobby()

    survey = _survey()
    Anchor = DynAccessor(519)
    ArmoryYardDemoView = DynAccessor(520)
    Comp7DemoPageView = DynAccessor(521)
    ComponentsDemo = DynAccessor(522)
    DataLayerDemoView = DynAccessor(523)
    DataTrackerDemo = DynAccessor(524)
    DemoContextMenu = DynAccessor(525)
    Easings = DynAccessor(526)
    GameLoadingDebugView = DynAccessor(527)
    GFCharset = DynAccessor(528)
    GFComponents = DynAccessor(529)
    GFDemoPopover = DynAccessor(530)
    GFDemoRichTooltipWindow = DynAccessor(531)
    GFDemoWindow = DynAccessor(532)
    GFHooksDemo = DynAccessor(533)
    GFInjectView = DynAccessor(534)
    GFSimpleTooltipWindow = DynAccessor(535)
    GFWebSubDemoWindow = DynAccessor(536)

    class _gf_dialogs_demo(DynAccessor):
        __slots__ = ()
        DefaultDialogProxy = DynAccessor(537)
        GFDialogsDemo = DynAccessor(538)

        class _sub_views(DynAccessor):
            __slots__ = ()
            DummyContent = DynAccessor(539)
            DummyFooter = DynAccessor(540)
            DummyIcon = DynAccessor(541)
            DummyStepper = DynAccessor(542)
            DummyTitle = DynAccessor(543)
            DummyTopRight = DynAccessor(544)

        sub_views = _sub_views()

    gf_dialogs_demo = _gf_dialogs_demo()

    class _gf_viewer(DynAccessor):
        __slots__ = ()
        GFViewerWindow = DynAccessor(545)

    gf_viewer = _gf_viewer()

    class _igb_demo(DynAccessor):
        __slots__ = ()
        BrowserFullscreenWindow = DynAccessor(546)
        BrowserWindow = DynAccessor(547)
        MainView = DynAccessor(548)

    igb_demo = _igb_demo()
    LocaleDemo = DynAccessor(549)
    MediaWrapperDemo = DynAccessor(550)
    MixBlendMode = DynAccessor(551)
    MixBlendModeAnimation = DynAccessor(552)
    ModeSelectorDemo = DynAccessor(553)
    ModeSelectorToolsetView = DynAccessor(554)
    NewYearLevelUp = DynAccessor(555)
    PluralLocView = DynAccessor(556)
    PropsSupportDemo = DynAccessor(557)
    ReactSpringVizualizer = DynAccessor(558)
    StructuralDataBindDemo = DynAccessor(559)

    class _sub_views_demo(DynAccessor):
        __slots__ = ()
        GFSubViewsDemo = DynAccessor(560)

        class _sub_views(DynAccessor):
            __slots__ = ()
            CustomizationCartProxy = DynAccessor(561)
            DailyProxy = DynAccessor(562)
            ProgressiveItemsViewProxy = DynAccessor(563)

        sub_views = _sub_views()

    sub_views_demo = _sub_views_demo()
    UILoggerDemo = DynAccessor(564)
    VideoSupportView = DynAccessor(565)
    W2CTestPageWindow = DynAccessor(566)
    WgcgMockView = DynAccessor(567)