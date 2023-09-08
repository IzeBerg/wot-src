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
        FadingCoverView = DynAccessor(94)

        class _personal_reserves(DynAccessor):
            __slots__ = ()
            ReservesDisabledTooltip = DynAccessor(95)

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
            BattlePassAwardsView = DynAccessor(147)
            BattlePassBuyLevelView = DynAccessor(148)
            BattlePassBuyView = DynAccessor(149)
            BattlePassDailyQuestsIntroView = DynAccessor(150)
            BattlePassEntryPointView = DynAccessor(151)
            BattlePassHowToEarnPointsView = DynAccessor(152)
            BattlePassIntroView = DynAccessor(153)
            BattlePassProgressionsView = DynAccessor(154)
            BattlePassVehicleAwardView = DynAccessor(155)
            ChapterChoiceView = DynAccessor(156)

            class _dialogs(DynAccessor):
                __slots__ = ()
                ChapterConfirm = DynAccessor(157)

            dialogs = _dialogs()
            ExtraIntroView = DynAccessor(158)
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
            StyleVideoView = DynAccessor(176)

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
                SelectedRewardsTooltipView = DynAccessor(220)

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
            EntryPoint = DynAccessor(281)
            RewardWindow = DynAccessor(282)

            class _tooltips(DynAccessor):
                __slots__ = ()
                RestRewardTooltip = DynAccessor(283)

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
                BattleConditions = DynAccessor(285)
                Countdown = DynAccessor(286)
                PendingDots = DynAccessor(287)

            common = _common()
            Daily = DynAccessor(288)
            DailyQuestsTooltip = DynAccessor(289)
            DailyQuestsWidget = DynAccessor(290)
            RerollTooltip = DynAccessor(291)
            RerollTooltipWithCountdown = DynAccessor(292)

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
            EntryPoint = DynAccessor(326)
            QualificationRewardsView = DynAccessor(327)
            RankedSelectableRewardView = DynAccessor(328)

            class _tooltips(DynAccessor):
                __slots__ = ()
                RankedBattlesRolesTooltipView = DynAccessor(329)

            tooltips = _tooltips()
            YearLeaderboardView = DynAccessor(330)

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
            AdditionalRewardsTooltip = DynAccessor(408)
            TankmanTooltipView = DynAccessor(409)
            VehPostProgressionEntryPointTooltip = DynAccessor(410)

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
            AddCredentialsView = DynAccessor(112)
            CompleteView = DynAccessor(113)
            ConfirmCredentialsView = DynAccessor(114)
            ContactSupportView = DynAccessor(115)
            CurtainView = DynAccessor(116)
            EmptyView = DynAccessor(117)
            ErrorView = DynAccessor(118)
            RenamingCompleteView = DynAccessor(119)
            RenamingView = DynAccessor(120)

            class _tooltips(DynAccessor):
                __slots__ = ()
                HangarTooltip = DynAccessor(121)
                RenamingHangarTooltip = DynAccessor(122)

            tooltips = _tooltips()

        account_completion = _account_completion()

        class _account_dashboard(DynAccessor):
            __slots__ = ()
            AccountDashboard = DynAccessor(123)

        account_dashboard = _account_dashboard()

        class _achievements(DynAccessor):
            __slots__ = ()
            AchievementsMainView = DynAccessor(124)

            class _dialogs(DynAccessor):
                __slots__ = ()
                EditConfirm = DynAccessor(125)

            dialogs = _dialogs()
            EditView = DynAccessor(126)

            class _tooltips(DynAccessor):
                __slots__ = ()
                AutoSettingTooltip = DynAccessor(127)
                BattlesKPITooltip = DynAccessor(128)
                EditingTooltip = DynAccessor(129)
                KPITooltip = DynAccessor(130)
                WOTPRMainTooltip = DynAccessor(131)
                WTRInfoTooltip = DynAccessor(132)
                WTRMainTooltip = DynAccessor(133)

            tooltips = _tooltips()

        achievements = _achievements()

        class _awards(DynAccessor):
            __slots__ = ()
            BadgeAwardView = DynAccessor(134)
            MultipleAwardsView = DynAccessor(135)

            class _tooltips(DynAccessor):
                __slots__ = ()
                VehicleForChooseTooltip = DynAccessor(136)

            tooltips = _tooltips()

        awards = _awards()

        class _battle_matters(DynAccessor):
            __slots__ = ()
            BattleMattersEntryPointView = DynAccessor(137)
            BattleMattersExchangeRewards = DynAccessor(138)
            BattleMattersMainRewardView = DynAccessor(139)
            BattleMattersMainView = DynAccessor(140)
            BattleMattersPausedView = DynAccessor(141)
            BattleMattersRewardsView = DynAccessor(142)
            BattleMattersVehicleSelectionView = DynAccessor(143)

            class _popovers(DynAccessor):
                __slots__ = ()
                BattleMattersFilterPopoverView = DynAccessor(144)

            popovers = _popovers()

            class _tooltips(DynAccessor):
                __slots__ = ()
                BattleMattersEntryTooltipView = DynAccessor(145)
                BattleMattersTokenTooltipView = DynAccessor(146)

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
            Banner = DynAccessor(221)
            IntroScreen = DynAccessor(222)
            MainWidget = DynAccessor(223)
            MetaRootView = DynAccessor(224)
            NoVehiclesScreen = DynAccessor(225)
            RewardsScreen = DynAccessor(226)
            SeasonModifier = DynAccessor(227)

            class _tooltips(DynAccessor):
                __slots__ = ()
                DivisionTooltip = DynAccessor(228)
                FifthRankTooltip = DynAccessor(229)
                GeneralRankTooltip = DynAccessor(230)
                LastUpdateTooltip = DynAccessor(231)
                MainWidgetTooltip = DynAccessor(232)
                RankInactivityTooltip = DynAccessor(233)
                SeasonPointTooltip = DynAccessor(234)
                SixthRankTooltip = DynAccessor(235)

            tooltips = _tooltips()
            WhatsNewView = DynAccessor(236)

        comp7 = _comp7()

        class _craft_machine(DynAccessor):
            __slots__ = ()
            CraftmachineEntryPointView = DynAccessor(237)

        craft_machine = _craft_machine()

        class _crew(DynAccessor):
            __slots__ = ()
            AccelerateTrainingTooltipView = DynAccessor(238)

            class _common(DynAccessor):
                __slots__ = ()
                TooltipAdvancedFooter = DynAccessor(239)

            common = _common()
            ConfirmLearnSkillsContent = DynAccessor(240)
            CrewHeader = DynAccessor(241)
            CrewHeaderTooltipView = DynAccessor(242)
            CrewIntroView = DynAccessor(243)

            class _tooltips(DynAccessor):
                __slots__ = ()
                AdvancedTooltipView = DynAccessor(244)
                CrewPerksAdditionalTooltip = DynAccessor(245)
                CrewPerksTooltip = DynAccessor(246)
                VehicleParamsTooltipView = DynAccessor(247)

            tooltips = _tooltips()

        crew = _crew()

        class _crystalsPromo(DynAccessor):
            __slots__ = ()
            CrystalsPromoView = DynAccessor(248)

        crystalsPromo = _crystalsPromo()

        class _currency_reserves(DynAccessor):
            __slots__ = ()
            CurrencyReserves = DynAccessor(249)
            ReservesAwardView = DynAccessor(250)

        currency_reserves = _currency_reserves()

        class _customization(DynAccessor):
            __slots__ = ()
            CustomizationCart = DynAccessor(251)

            class _progression_styles(DynAccessor):
                __slots__ = ()
                OnboardingView = DynAccessor(252)
                StageSwitcher = DynAccessor(253)

            progression_styles = _progression_styles()

            class _progressive_items_reward(DynAccessor):
                __slots__ = ()
                ProgressiveItemsUpgradeView = DynAccessor(254)

            progressive_items_reward = _progressive_items_reward()

            class _progressive_items_view(DynAccessor):
                __slots__ = ()
                ProgressiveItemsView = DynAccessor(255)

            progressive_items_view = _progressive_items_view()

            class _style_unlocked_view(DynAccessor):
                __slots__ = ()
                StyleUnlockedView = DynAccessor(256)

            style_unlocked_view = _style_unlocked_view()

        customization = _customization()

        class _dedication(DynAccessor):
            __slots__ = ()
            DedicationRewardView = DynAccessor(257)

        dedication = _dedication()

        class _dog_tags(DynAccessor):
            __slots__ = ()
            DedicationTooltip = DynAccessor(258)
            DogTagsView = DynAccessor(259)
            RankedEfficiencyTooltip = DynAccessor(260)
            ThreeMonthsTooltip = DynAccessor(261)
            TriumphTooltip = DynAccessor(262)

        dog_tags = _dog_tags()

        class _elite_window(DynAccessor):
            __slots__ = ()
            EliteView = DynAccessor(263)

        elite_window = _elite_window()

        class _excluded_maps(DynAccessor):
            __slots__ = ()
            ExcludedMapsView = DynAccessor(264)

        excluded_maps = _excluded_maps()

        class _frontline(DynAccessor):
            __slots__ = ()
            AwardsView = DynAccessor(265)

            class _dialogs(DynAccessor):
                __slots__ = ()
                BlankPrice = DynAccessor(266)

            dialogs = _dialogs()
            IntroScreen = DynAccessor(267)
            RewardsSelectionView = DynAccessor(268)

        frontline = _frontline()

        class _instructions(DynAccessor):
            __slots__ = ()
            BuyWindow = DynAccessor(269)
            SellWindow = DynAccessor(270)

        instructions = _instructions()

        class _mapbox(DynAccessor):
            __slots__ = ()
            MapBoxAwardsView = DynAccessor(271)
            MapBoxEntryPointView = DynAccessor(272)
            MapBoxIntro = DynAccessor(273)
            MapBoxProgression = DynAccessor(274)
            MapBoxRewardChoiceView = DynAccessor(275)
            MapBoxSurveyView = DynAccessor(276)

        mapbox = _mapbox()

        class _maps_training(DynAccessor):
            __slots__ = ()
            MapsTrainingPage = DynAccessor(277)
            MapsTrainingQueue = DynAccessor(278)
            MapsTrainingResult = DynAccessor(279)
            ScenarioTooltip = DynAccessor(280)

        maps_training = _maps_training()

        class _matchmaker(DynAccessor):
            __slots__ = ()
            ActiveTestConfirmView = DynAccessor(284)

        matchmaker = _matchmaker()

        class _mode_selector(DynAccessor):
            __slots__ = ()
            BattleSessionView = DynAccessor(293)
            ModeSelectorView = DynAccessor(294)

            class _popovers(DynAccessor):
                __slots__ = ()
                RandomBattlePopover = DynAccessor(295)

            popovers = _popovers()

            class _tooltips(DynAccessor):
                __slots__ = ()
                AlertTooltip = DynAccessor(296)

                class _common(DynAccessor):
                    __slots__ = ()
                    Divider = DynAccessor(297)
                    GradientDecorator = DynAccessor(298)

                common = _common()
                SimplyFormatTooltip = DynAccessor(299)

            tooltips = _tooltips()

            class _widgets(DynAccessor):
                __slots__ = ()
                BattleRoyaleProgressionWidget = DynAccessor(300)
                EpicWidget = DynAccessor(301)
                RankedWidget = DynAccessor(302)

            widgets = _widgets()

        mode_selector = _mode_selector()

        class _offers(DynAccessor):
            __slots__ = ()
            OfferBannerWindow = DynAccessor(303)
            OfferGiftsWindow = DynAccessor(304)
            OfferRewardWindow = DynAccessor(305)

        offers = _offers()

        class _personal_reserves(DynAccessor):
            __slots__ = ()
            PersonalReservesTooltip = DynAccessor(306)
            PersonalReservesWidget = DynAccessor(307)
            ReserveCard = DynAccessor(308)
            ReserveCardTooltip = DynAccessor(309)
            ReserveGroup = DynAccessor(310)
            ReservesActivationView = DynAccessor(311)
            ReservesConversionView = DynAccessor(312)
            ReservesIntroView = DynAccessor(313)

        personal_reserves = _personal_reserves()

        class _platoon(DynAccessor):
            __slots__ = ()
            AlertTooltip = DynAccessor(314)
            MembersWindow = DynAccessor(315)
            PlatoonDropdown = DynAccessor(316)
            SearchingDropdown = DynAccessor(317)
            SettingsPopover = DynAccessor(318)

            class _subViews(DynAccessor):
                __slots__ = ()
                Chat = DynAccessor(319)
                SettingsContent = DynAccessor(320)
                TiersLimit = DynAccessor(321)

            subViews = _subViews()
            WTRTooltip = DynAccessor(322)

        platoon = _platoon()

        class _player_subscriptions(DynAccessor):
            __slots__ = ()
            PlayerSubscriptions = DynAccessor(323)
            SubscriptionItem = DynAccessor(324)
            SubscriptionRewardView = DynAccessor(325)

        player_subscriptions = _player_subscriptions()

        class _recruit_window(DynAccessor):
            __slots__ = ()
            RecruitDialog = DynAccessor(331)

        recruit_window = _recruit_window()

        class _research(DynAccessor):
            __slots__ = ()
            BuyModuleDialogView = DynAccessor(332)
            InsufficientCreditsTooltip = DynAccessor(333)
            SoldModuleInfoTooltip = DynAccessor(334)

        research = _research()

        class _resource_well(DynAccessor):
            __slots__ = ()
            AwardView = DynAccessor(335)
            CompletedProgressionView = DynAccessor(336)
            EntryPoint = DynAccessor(337)
            IntroView = DynAccessor(338)
            NoSerialVehiclesConfirm = DynAccessor(339)
            NoVehiclesConfirm = DynAccessor(340)
            ProgressionView = DynAccessor(341)
            ResourcesLoadingConfirm = DynAccessor(342)
            ResourcesLoadingView = DynAccessor(343)

            class _sharedComponents(DynAccessor):
                __slots__ = ()

                class _award(DynAccessor):
                    __slots__ = ()
                    AdditionalReward = DynAccessor(344)
                    Footer = DynAccessor(345)
                    Header = DynAccessor(346)
                    Reward = DynAccessor(347)

                award = _award()
                Counter = DynAccessor(348)
                NoVehiclesState = DynAccessor(349)
                Resource = DynAccessor(350)
                VehicleCount = DynAccessor(351)
                VehicleInfo = DynAccessor(352)

            sharedComponents = _sharedComponents()

            class _tooltips(DynAccessor):
                __slots__ = ()
                EntryPointTooltip = DynAccessor(353)
                MaxProgressTooltip = DynAccessor(354)
                ProgressTooltip = DynAccessor(355)
                RefundResourcesTooltip = DynAccessor(356)
                SerialNumberTooltip = DynAccessor(357)

            tooltips = _tooltips()

        resource_well = _resource_well()

        class _seniority_awards(DynAccessor):
            __slots__ = ()
            SeniorityAwardsView = DynAccessor(358)

            class _sharedComponents(DynAccessor):
                __slots__ = ()
                SeniorityAwardCoin = DynAccessor(359)

            sharedComponents = _sharedComponents()

        seniority_awards = _seniority_awards()

        class _stronghold(DynAccessor):
            __slots__ = ()
            StrongholdEntryPointView = DynAccessor(360)

        stronghold = _stronghold()

        class _subscription(DynAccessor):
            __slots__ = ()
            SubscriptionAwardView = DynAccessor(361)
            WotPlusIntroView = DynAccessor(362)
            WotPlusTooltip = DynAccessor(363)

        subscription = _subscription()

        class _tanksetup(DynAccessor):
            __slots__ = ()
            AmmunitionPanel = DynAccessor(364)

            class _common(DynAccessor):
                __slots__ = ()
                Action = DynAccessor(365)
                CtaButtons = DynAccessor(366)
                DealPanel = DynAccessor(367)
                ExtraImage = DynAccessor(368)
                FormatColorTagText = DynAccessor(369)
                MaybeWrapper = DynAccessor(370)
                Price = DynAccessor(371)
                SetupApp = DynAccessor(372)
                ShortenedText = DynAccessor(373)
                Slider = DynAccessor(374)

                class _SlotParts(DynAccessor):
                    __slots__ = ()
                    Bonus = DynAccessor(375)
                    Container = DynAccessor(376)
                    Count = DynAccessor(377)
                    Inside = DynAccessor(378)
                    Level = DynAccessor(379)

                SlotParts = _SlotParts()
                Specializations = DynAccessor(380)
                Storage = DynAccessor(381)
                SwitchButton = DynAccessor(382)
                SwitchEquipment = DynAccessor(383)

                class _Transitions(DynAccessor):
                    __slots__ = ()
                    SlotTransitions = DynAccessor(384)

                Transitions = _Transitions()
                WeaponOccupancy = DynAccessor(385)

            common = _common()
            DeconstructionDeviceView = DynAccessor(386)

            class _dialogs(DynAccessor):
                __slots__ = ()
                Confirm = DynAccessor(387)
                ConfirmActionsWithEquipmentDialog = DynAccessor(388)
                DeconstructConfirm = DynAccessor(389)
                DeviceUpgradeDialog = DynAccessor(390)
                ExchangeToBuyItems = DynAccessor(391)
                ExchangeToUpgradeItems = DynAccessor(392)
                NeedRepair = DynAccessor(393)
                RefillShells = DynAccessor(394)

                class _sub_views(DynAccessor):
                    __slots__ = ()
                    FrontlineConfirmFooterMoney = DynAccessor(395)
                    FrontlineConfirmIcons = DynAccessor(396)
                    FrontlineConfirmInfo = DynAccessor(397)
                    FrontlineConfirmMultipleNames = DynAccessor(398)
                    FrontlineConfirmTitle = DynAccessor(399)

                sub_views = _sub_views()

            dialogs = _dialogs()
            HangarAmmunitionSetup = DynAccessor(400)
            IntroScreen = DynAccessor(401)

            class _tooltips(DynAccessor):
                __slots__ = ()
                DeconstructFromInventoryTooltip = DynAccessor(402)
                DeconstructFromVehicleTooltip = DynAccessor(403)
                SetupTabTooltipView = DynAccessor(404)
                WarningTooltipView = DynAccessor(405)

            tooltips = _tooltips()
            VehicleCompareAmmunitionPanel = DynAccessor(406)
            VehicleCompareAmmunitionSetup = DynAccessor(407)

        tanksetup = _tanksetup()

        class _vehicle_compare(DynAccessor):
            __slots__ = ()
            CompareModificationsPanelView = DynAccessor(411)
            SelectSlotSpecCompareDialog = DynAccessor(412)

        vehicle_compare = _vehicle_compare()

        class _vehicle_preview(DynAccessor):
            __slots__ = ()

            class _buying_panel(DynAccessor):
                __slots__ = ()
                StyleBuyingPanel = DynAccessor(413)
                VPProgressionStylesBuyingPanel = DynAccessor(414)
                WellPanel = DynAccessor(415)

            buying_panel = _buying_panel()

            class _top_panel(DynAccessor):
                __slots__ = ()
                TopPanelTabs = DynAccessor(416)

            top_panel = _top_panel()

        vehicle_preview = _vehicle_preview()

        class _veh_post_progression(DynAccessor):
            __slots__ = ()

            class _common(DynAccessor):
                __slots__ = ()
                Bonus = DynAccessor(417)
                Description = DynAccessor(418)
                Grid = DynAccessor(419)
                PersistentBonuses = DynAccessor(420)
                Slide = DynAccessor(421)
                SlideContent = DynAccessor(422)
                Slider = DynAccessor(423)
                TextSplit = DynAccessor(424)

            common = _common()
            PostProgressionInfo = DynAccessor(425)
            PostProgressionIntro = DynAccessor(426)
            PostProgressionResearchSteps = DynAccessor(427)

            class _tooltip(DynAccessor):
                __slots__ = ()

                class _common(DynAccessor):
                    __slots__ = ()
                    DisabledBlock = DynAccessor(428)
                    FeatureLevelSubtitle = DynAccessor(429)
                    Lock = DynAccessor(430)
                    NotEnoughCredits = DynAccessor(431)
                    PriceBlock = DynAccessor(432)
                    Separator = DynAccessor(433)

                common = _common()
                PairModificationTooltipView = DynAccessor(434)
                PostProgressionLevelTooltipView = DynAccessor(435)
                RoleSlotTooltipView = DynAccessor(436)
                SetupTooltipView = DynAccessor(437)

            tooltip = _tooltip()
            VehiclePostProgressionCmpView = DynAccessor(438)
            VehiclePostProgressionView = DynAccessor(439)

        veh_post_progression = _veh_post_progression()

        class _winback(DynAccessor):
            __slots__ = ()

            class _popovers(DynAccessor):
                __slots__ = ()
                WinbackLeaveModePopoverView = DynAccessor(440)

            popovers = _popovers()

            class _tooltips(DynAccessor):
                __slots__ = ()
                MainRewardTooltip = DynAccessor(441)
                ModeInfoTooltip = DynAccessor(442)
                SelectableRewardTooltip = DynAccessor(443)
                SelectedRewardsTooltip = DynAccessor(444)

            tooltips = _tooltips()
            WinbackDailyQuestsIntroView = DynAccessor(445)
            WinbackLeaveModeDialogView = DynAccessor(446)
            WinbackRewardView = DynAccessor(447)
            WinbackSelectableRewardView = DynAccessor(448)

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
            DialogTemplateGenericTooltip = DynAccessor(96)

        common = _common()
        DefaultDialog = DynAccessor(97)

        class _sub_views(DynAccessor):
            __slots__ = ()

            class _common(DynAccessor):
                __slots__ = ()
                SimpleText = DynAccessor(98)
                SinglePrice = DynAccessor(99)

            common = _common()

            class _content(DynAccessor):
                __slots__ = ()
                SelectOptionContent = DynAccessor(100)
                SimpleTextContent = DynAccessor(101)
                SinglePriceContent = DynAccessor(102)
                TextWithWarning = DynAccessor(103)

            content = _content()

            class _footer(DynAccessor):
                __slots__ = ()
                BRSinglePriceFooter = DynAccessor(104)
                SimpleTextFooter = DynAccessor(105)
                SinglePriceFooter = DynAccessor(106)

            footer = _footer()

            class _icon(DynAccessor):
                __slots__ = ()
                IconSet = DynAccessor(107)

            icon = _icon()

            class _title(DynAccessor):
                __slots__ = ()
                SimpleTextTitle = DynAccessor(108)

            title = _title()

            class _topRight(DynAccessor):
                __slots__ = ()
                BRMoneyBalance = DynAccessor(109)
                MoneyBalance = DynAccessor(110)

            topRight = _topRight()

        sub_views = _sub_views()

    dialogs = _dialogs()

    class _loading(DynAccessor):
        __slots__ = ()
        GameLoadingView = DynAccessor(111)

    loading = _loading()

    class _battle_modifiers(DynAccessor):
        __slots__ = ()

        class _lobby(DynAccessor):
            __slots__ = ()

            class _tooltips(DynAccessor):
                __slots__ = ()
                ModifiersDomainTooltipView = DynAccessor(449)

            tooltips = _tooltips()

        lobby = _lobby()

    battle_modifiers = _battle_modifiers()

    class _battle_royale(DynAccessor):
        __slots__ = ()

        class _lobby(DynAccessor):
            __slots__ = ()

            class _tooltips(DynAccessor):
                __slots__ = ()
                BrCoinTooltipView = DynAccessor(450)

                class _common(DynAccessor):
                    __slots__ = ()
                    PriceBlock = DynAccessor(451)
                    RentPrice = DynAccessor(452)

                common = _common()
                RentIconTooltipView = DynAccessor(453)
                RewardCurrencyTooltipView = DynAccessor(454)
                TestDriveInfoTooltipView = DynAccessor(455)
                VehicleTooltipView = DynAccessor(456)

            tooltips = _tooltips()

            class _views(DynAccessor):
                __slots__ = ()
                BattleRoyaleEntryPoint = DynAccessor(457)
                IntroView = DynAccessor(458)
                PreBattleView = DynAccessor(459)
                ProxyCurrencyView = DynAccessor(460)
                WidgetView = DynAccessor(461)

            views = _views()

        lobby = _lobby()

    battle_royale = _battle_royale()

    class _battle_royale_progression(DynAccessor):
        __slots__ = ()
        BattleQuestAwardsView = DynAccessor(462)
        ProgressionMainView = DynAccessor(463)

    battle_royale_progression = _battle_royale_progression()

    class _event_lootboxes(DynAccessor):
        __slots__ = ()

        class _lobby(DynAccessor):
            __slots__ = ()

            class _event_lootboxes(DynAccessor):
                __slots__ = ()
                EntryPointView = DynAccessor(464)
                OpenBoxErrorView = DynAccessor(465)
                OpenBoxScreen = DynAccessor(466)
                PopoverView = DynAccessor(467)

                class _shared(DynAccessor):
                    __slots__ = ()
                    AnimationControls = DynAccessor(468)
                    BuyBoxFooter = DynAccessor(469)
                    CloseBtn = DynAccessor(470)
                    Divider = DynAccessor(471)
                    Header = DynAccessor(472)

                shared = _shared()

                class _tooltips(DynAccessor):
                    __slots__ = ()
                    CompensationTooltip = DynAccessor(473)
                    EntryPointTooltip = DynAccessor(474)
                    LootBoxesTooltip = DynAccessor(475)

                tooltips = _tooltips()
                WelcomeScreen = DynAccessor(476)

            event_lootboxes = _event_lootboxes()

        lobby = _lobby()

    event_lootboxes = _event_lootboxes()

    class _frontline(DynAccessor):
        __slots__ = ()

        class _lobby(DynAccessor):
            __slots__ = ()
            BannerView = DynAccessor(477)
            FrontlineContainerView = DynAccessor(478)
            InfoView = DynAccessor(479)
            ProgressView = DynAccessor(480)
            RewardsView = DynAccessor(481)

            class _tooltips(DynAccessor):
                __slots__ = ()
                LevelReservesTooltip = DynAccessor(482)
                NotEnoughPointsTooltip = DynAccessor(483)
                SkillOrderTooltip = DynAccessor(484)

            tooltips = _tooltips()
            WelcomeView = DynAccessor(485)

        lobby = _lobby()

    frontline = _frontline()

    class _fun_random(DynAccessor):
        __slots__ = ()

        class _lobby(DynAccessor):
            __slots__ = ()

            class _feature(DynAccessor):
                __slots__ = ()
                FunRandomEntryPointView = DynAccessor(486)
                FunRandomHangarWidgetView = DynAccessor(487)
                FunRandomModeSubSelector = DynAccessor(488)
                FunRandomProgression = DynAccessor(489)

            feature = _feature()

            class _tooltips(DynAccessor):
                __slots__ = ()
                FunRandomProgressionTooltipView = DynAccessor(490)

            tooltips = _tooltips()

        lobby = _lobby()

    fun_random = _fun_random()

    class _story_mode(DynAccessor):
        __slots__ = ()

        class _battle(DynAccessor):
            __slots__ = ()
            EpilogueWindow = DynAccessor(491)
            OnboardingBattleResultView = DynAccessor(492)
            PrebattleWindow = DynAccessor(493)

        battle = _battle()

        class _common(DynAccessor):
            __slots__ = ()
            CongratulationsWindow = DynAccessor(494)
            MedalTooltip = DynAccessor(495)
            OnboardingQueueView = DynAccessor(496)

        common = _common()

        class _lobby(DynAccessor):
            __slots__ = ()
            BattleResultView = DynAccessor(497)
            MissionSelectionView = DynAccessor(498)
            MissionTooltip = DynAccessor(499)

        lobby = _lobby()

    story_mode = _story_mode()
    Anchor = DynAccessor(500)
    Comp7DemoPageView = DynAccessor(501)
    ComponentsDemo = DynAccessor(502)
    DataLayerDemoView = DynAccessor(503)
    DataTrackerDemo = DynAccessor(504)
    DemoContextMenu = DynAccessor(505)
    Easings = DynAccessor(506)
    GameLoadingDebugView = DynAccessor(507)
    GFCharset = DynAccessor(508)
    GFComponents = DynAccessor(509)
    GFDemoPopover = DynAccessor(510)
    GFDemoRichTooltipWindow = DynAccessor(511)
    GFDemoWindow = DynAccessor(512)
    GFHooksDemo = DynAccessor(513)
    GFInjectView = DynAccessor(514)
    GFSimpleTooltipWindow = DynAccessor(515)
    GFWebSubDemoWindow = DynAccessor(516)

    class _gf_dialogs_demo(DynAccessor):
        __slots__ = ()
        DefaultDialogProxy = DynAccessor(517)
        GFDialogsDemo = DynAccessor(518)

        class _sub_views(DynAccessor):
            __slots__ = ()
            DummyContent = DynAccessor(519)
            DummyFooter = DynAccessor(520)
            DummyIcon = DynAccessor(521)
            DummyStepper = DynAccessor(522)
            DummyTitle = DynAccessor(523)
            DummyTopRight = DynAccessor(524)

        sub_views = _sub_views()

    gf_dialogs_demo = _gf_dialogs_demo()

    class _gf_viewer(DynAccessor):
        __slots__ = ()
        GFViewerWindow = DynAccessor(525)

    gf_viewer = _gf_viewer()

    class _igb_demo(DynAccessor):
        __slots__ = ()
        BrowserFullscreenWindow = DynAccessor(526)
        BrowserWindow = DynAccessor(527)
        MainView = DynAccessor(528)

    igb_demo = _igb_demo()
    LocaleDemo = DynAccessor(529)
    MediaWrapperDemo = DynAccessor(530)
    MixBlendMode = DynAccessor(531)
    MixBlendModeAnimation = DynAccessor(532)
    ModeSelectorDemo = DynAccessor(533)
    ModeSelectorToolsetView = DynAccessor(534)
    NewYearLevelUp = DynAccessor(535)
    PluralLocView = DynAccessor(536)
    PropsSupportDemo = DynAccessor(537)
    ReactSpringVizualizer = DynAccessor(538)
    SelectableRewardDemoView = DynAccessor(539)
    StructuralDataBindDemo = DynAccessor(540)

    class _sub_views_demo(DynAccessor):
        __slots__ = ()
        GFSubViewsDemo = DynAccessor(541)

        class _sub_views(DynAccessor):
            __slots__ = ()
            CustomizationCartProxy = DynAccessor(542)
            DailyProxy = DynAccessor(543)
            ProgressiveItemsViewProxy = DynAccessor(544)

        sub_views = _sub_views()

    sub_views_demo = _sub_views_demo()
    UILoggerDemo = DynAccessor(545)
    VideoSupportView = DynAccessor(546)
    W2CTestPageWindow = DynAccessor(547)
    WgcgMockView = DynAccessor(548)