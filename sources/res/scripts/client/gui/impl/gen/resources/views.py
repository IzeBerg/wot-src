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
            BattleNotifierView = DynAccessor(98)

        battle_notifier = _battle_notifier()

        class _battle_page(DynAccessor):
            __slots__ = ()
            EpicRespawnAmmunitionPanelView = DynAccessor(99)
            PrebattleAmmunitionPanelView = DynAccessor(100)

        battle_page = _battle_page()

        class _timer(DynAccessor):
            __slots__ = ()
            TimerView = DynAccessor(101)

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
        BackportContextMenu = DynAccessor(102)

    common = _common()

    class _lobby(DynAccessor):
        __slots__ = ()

        class _battleRoyale(DynAccessor):
            __slots__ = ()

            class _commander_cmp(DynAccessor):
                __slots__ = ()
                CommanderCmp = DynAccessor(32)

            commander_cmp = _commander_cmp()

            class _event_info(DynAccessor):
                __slots__ = ()
                EventInfo = DynAccessor(33)

            event_info = _event_info()

            class _hangar_bottom_panel_cmp(DynAccessor):
                __slots__ = ()
                HangarBottomPanelCmp = DynAccessor(34)

            hangar_bottom_panel_cmp = _hangar_bottom_panel_cmp()

            class _tech_parameters_cmp(DynAccessor):
                __slots__ = ()
                TechParametersCmp = DynAccessor(35)

            tech_parameters_cmp = _tech_parameters_cmp()

            class _vehicle_info_intro_overlay(DynAccessor):
                __slots__ = ()
                VehicleInfoIntroOverlay = DynAccessor(36)

            vehicle_info_intro_overlay = _vehicle_info_intro_overlay()

        battleRoyale = _battleRoyale()

        class _battle_pass(DynAccessor):
            __slots__ = ()

            class _trophy_device_confirm_dialog(DynAccessor):
                __slots__ = ()
                TrophyDeviceConfirmDialogContent = DynAccessor(37)

            trophy_device_confirm_dialog = _trophy_device_confirm_dialog()
            BattlePass3dStyleChoiceView = DynAccessor(120)
            BattlePassAwardsView = DynAccessor(121)
            BattlePassBuyView = DynAccessor(122)
            BattlePassDailyQuestsIntroView = DynAccessor(123)
            BattlePassEntryPointView = DynAccessor(124)
            BattlePassHowToEarnPointsView = DynAccessor(125)
            BattlePassProgressionsView = DynAccessor(126)
            BattlePassRewardChoiceView = DynAccessor(127)
            BattlePassVehicleAwardView = DynAccessor(128)

            class _sharedComponents(DynAccessor):
                __slots__ = ()
                Emblem = DynAccessor(129)
                Header = DynAccessor(130)
                LoupeButton = DynAccessor(131)
                Slider = DynAccessor(132)
                VehicleBonusList = DynAccessor(133)
                VehicleInfo = DynAccessor(134)

            sharedComponents = _sharedComponents()

            class _tooltips(DynAccessor):
                __slots__ = ()
                BattlePass3dStyleNotChosenTooltip = DynAccessor(135)
                BattlePassCoinTooltipView = DynAccessor(136)
                BattlePassCompletedTooltipView = DynAccessor(137)
                BattlePassInProgressTooltipView = DynAccessor(138)
                BattlePassLockIconTooltipView = DynAccessor(139)
                BattlePassNotStartedTooltipView = DynAccessor(140)
                BattlePassPointsView = DynAccessor(141)
                BattlePassStyleInfoTooltipView = DynAccessor(142)
                BattlePassUndefinedStyleView = DynAccessor(143)
                BattlePassUpgradeStyleTooltipView = DynAccessor(144)

                class _sharedComponents(DynAccessor):
                    __slots__ = ()
                    BlockCompleted = DynAccessor(145)
                    Chose = DynAccessor(146)
                    FinalLevel = DynAccessor(147)
                    IconTextBlock = DynAccessor(148)
                    PerBattlePointsTable = DynAccessor(149)
                    Point = DynAccessor(150)

                sharedComponents = _sharedComponents()
                VehiclePointsTooltipView = DynAccessor(151)

            tooltips = _tooltips()

        battle_pass = _battle_pass()

        class _blueprints(DynAccessor):
            __slots__ = ()

            class _fragments_balance_content(DynAccessor):
                __slots__ = ()
                FragmentsBalanceContent = DynAccessor(38)

            fragments_balance_content = _fragments_balance_content()

            class _blueprint_screen(DynAccessor):
                __slots__ = ()

                class _blueprint_screen(DynAccessor):
                    __slots__ = ()
                    BlueprintScreen = DynAccessor(39)

                blueprint_screen = _blueprint_screen()

            blueprint_screen = _blueprint_screen()
            Confirm = DynAccessor(155)

            class _tooltips(DynAccessor):
                __slots__ = ()
                BlueprintsAlliancesTooltipView = DynAccessor(156)

            tooltips = _tooltips()

        blueprints = _blueprints()

        class _common(DynAccessor):
            __slots__ = ()

            class _congrats(DynAccessor):
                __slots__ = ()

                class _common_congrats_view(DynAccessor):
                    __slots__ = ()
                    CommonCongratsView = DynAccessor(40)

                common_congrats_view = _common_congrats_view()

            congrats = _congrats()
            SelectSlotSpecDialog = DynAccessor(161)

        common = _common()

        class _crew_books(DynAccessor):
            __slots__ = ()

            class _crew_books_buy_dialog(DynAccessor):
                __slots__ = ()
                CrewBooksBuyDialog = DynAccessor(41)

            crew_books_buy_dialog = _crew_books_buy_dialog()

            class _crew_books_dialog_content(DynAccessor):
                __slots__ = ()
                CrewBooksDialogContent = DynAccessor(42)

            crew_books_dialog_content = _crew_books_dialog_content()

            class _crew_books_lack_view(DynAccessor):
                __slots__ = ()
                CrewBooksLackView = DynAccessor(43)

            crew_books_lack_view = _crew_books_lack_view()

            class _crew_books_view(DynAccessor):
                __slots__ = ()
                CrewBooksView = DynAccessor(44)

            crew_books_view = _crew_books_view()

            class _crew_book_item_view(DynAccessor):
                __slots__ = ()
                CrewBookItemView = DynAccessor(45)

            crew_book_item_view = _crew_book_item_view()

        crew_books = _crew_books()

        class _marathon(DynAccessor):
            __slots__ = ()

            class _marathon_reward_view(DynAccessor):
                __slots__ = ()
                MarathonRewardView = DynAccessor(46)

            marathon_reward_view = _marathon_reward_view()

        marathon = _marathon()

        class _missions(DynAccessor):
            __slots__ = ()

            class _missions_tab_bar_view(DynAccessor):
                __slots__ = ()
                MissionsTabBarView = DynAccessor(47)

            missions_tab_bar_view = _missions_tab_bar_view()

            class _common(DynAccessor):
                __slots__ = ()
                BattleConditions = DynAccessor(189)
                Countdown = DynAccessor(190)
                PendingDots = DynAccessor(191)

            common = _common()
            Daily = DynAccessor(192)
            DailyQuestsTooltip = DynAccessor(193)
            DailyQuestsWidget = DynAccessor(194)
            RerollTooltip = DynAccessor(195)
            RerollTooltipWithCountdown = DynAccessor(196)

        missions = _missions()

        class _nation_change(DynAccessor):
            __slots__ = ()

            class _nation_change_screen(DynAccessor):
                __slots__ = ()
                NationChangeScreen = DynAccessor(48)

            nation_change_screen = _nation_change_screen()

        nation_change = _nation_change()

        class _premacc(DynAccessor):
            __slots__ = ()

            class _daily_experience_view(DynAccessor):
                __slots__ = ()
                DailyExperiencePage = DynAccessor(49)

            daily_experience_view = _daily_experience_view()

            class _maps_blacklist_view(DynAccessor):
                __slots__ = ()
                MapsBlacklistView = DynAccessor(50)

            maps_blacklist_view = _maps_blacklist_view()

            class _piggybank(DynAccessor):
                __slots__ = ()
                Piggybank = DynAccessor(51)

            piggybank = _piggybank()

            class _prem_dashboard_view(DynAccessor):
                __slots__ = ()
                PremDashboardView = DynAccessor(52)

            prem_dashboard_view = _prem_dashboard_view()

            class _squad_bonus_tooltip_content(DynAccessor):
                __slots__ = ()
                SquadBonusTooltipContent = DynAccessor(53)

            squad_bonus_tooltip_content = _squad_bonus_tooltip_content()

            class _dashboard(DynAccessor):
                __slots__ = ()

                class _dashboard_premium_card(DynAccessor):
                    __slots__ = ()
                    DashboardPremiumCard = DynAccessor(54)

                dashboard_premium_card = _dashboard_premium_card()

                class _prem_dashboard_dog_tags_card(DynAccessor):
                    __slots__ = ()
                    PremDashboardDogTagsCard = DynAccessor(55)

                prem_dashboard_dog_tags_card = _prem_dashboard_dog_tags_card()

                class _prem_dashboard_double_experience_card(DynAccessor):
                    __slots__ = ()
                    PremDashboardDoubleExperienceCard = DynAccessor(56)

                prem_dashboard_double_experience_card = _prem_dashboard_double_experience_card()

                class _prem_dashboard_header(DynAccessor):
                    __slots__ = ()
                    PremDashboardHeader = DynAccessor(57)

                prem_dashboard_header = _prem_dashboard_header()

                class _prem_dashboard_maps_blacklist_card(DynAccessor):
                    __slots__ = ()
                    PremDashboardMapsBlacklistCard = DynAccessor(58)

                prem_dashboard_maps_blacklist_card = _prem_dashboard_maps_blacklist_card()

                class _prem_dashboard_piggy_bank_card(DynAccessor):
                    __slots__ = ()
                    PremDashboardPiggyBankCard = DynAccessor(59)

                prem_dashboard_piggy_bank_card = _prem_dashboard_piggy_bank_card()

                class _prem_dashboard_quests_card(DynAccessor):
                    __slots__ = ()
                    PremDashboardQuestsCard = DynAccessor(60)

                prem_dashboard_quests_card = _prem_dashboard_quests_card()

            dashboard = _dashboard()

            class _maps_blacklist(DynAccessor):
                __slots__ = ()

                class _maps_blacklist_confirm_dialog(DynAccessor):
                    __slots__ = ()
                    MapsBlacklistConfirmDialogContent = DynAccessor(61)

                maps_blacklist_confirm_dialog = _maps_blacklist_confirm_dialog()

                class _maps_blacklist_tooltips(DynAccessor):
                    __slots__ = ()
                    MapsBlacklistInfoTooltipContent = DynAccessor(62)

                maps_blacklist_tooltips = _maps_blacklist_tooltips()

            maps_blacklist = _maps_blacklist()

        premacc = _premacc()

        class _progressive_reward(DynAccessor):
            __slots__ = ()

            class _progressive_reward_award(DynAccessor):
                __slots__ = ()
                ProgressiveRewardAward = DynAccessor(63)

            progressive_reward_award = _progressive_reward_award()

            class _progressive_reward_view(DynAccessor):
                __slots__ = ()
                ProgressiveRewardView = DynAccessor(64)

            progressive_reward_view = _progressive_reward_view()

        progressive_reward = _progressive_reward()

        class _ranked(DynAccessor):
            __slots__ = ()

            class _ranked_year_award(DynAccessor):
                __slots__ = ()
                RankedYearAward = DynAccessor(65)

            ranked_year_award = _ranked_year_award()
            EntryPoint = DynAccessor(218)

            class _tooltips(DynAccessor):
                __slots__ = ()
                RankedBattlesRolesTooltipView = DynAccessor(219)

            tooltips = _tooltips()
            YearLeaderboardView = DynAccessor(220)

        ranked = _ranked()

        class _reward_window(DynAccessor):
            __slots__ = ()

            class _clan_reward_window_content(DynAccessor):
                __slots__ = ()
                ClanRewardWindowContent = DynAccessor(66)

            clan_reward_window_content = _clan_reward_window_content()

            class _piggy_bank_reward_window_content(DynAccessor):
                __slots__ = ()
                PiggyBankRewardWindowContent = DynAccessor(67)

            piggy_bank_reward_window_content = _piggy_bank_reward_window_content()

            class _reward_window_content(DynAccessor):
                __slots__ = ()
                RewardWindowContent = DynAccessor(68)

            reward_window_content = _reward_window_content()

            class _twitch_reward_window_content(DynAccessor):
                __slots__ = ()
                TwitchRewardWindowContent = DynAccessor(69)

            twitch_reward_window_content = _twitch_reward_window_content()

        reward_window = _reward_window()

        class _seniority_awards(DynAccessor):
            __slots__ = ()

            class _seniority_awards_multi_open_view(DynAccessor):
                __slots__ = ()
                SeniorityAwardsMultiOpenView = DynAccessor(70)

            seniority_awards_multi_open_view = _seniority_awards_multi_open_view()

            class _seniority_reward_view(DynAccessor):
                __slots__ = ()
                SeniorityRewardView = DynAccessor(71)

            seniority_reward_view = _seniority_reward_view()

            class _seniority_reward_award(DynAccessor):
                __slots__ = ()

                class _seniority_reward_award_view(DynAccessor):
                    __slots__ = ()
                    SeniorityRewardAwardView = DynAccessor(72)

                seniority_reward_award_view = _seniority_reward_award_view()

            seniority_reward_award = _seniority_reward_award()
            SeniorityAwardsView = DynAccessor(224)
            SeniorityInfoView = DynAccessor(225)

            class _sharedComponents(DynAccessor):
                __slots__ = ()
                RewardBox = DynAccessor(226)

            sharedComponents = _sharedComponents()

        seniority_awards = _seniority_awards()

        class _shop(DynAccessor):
            __slots__ = ()

            class _buy_vehicle_view(DynAccessor):
                __slots__ = ()
                BuyVehicleView = DynAccessor(73)

            buy_vehicle_view = _buy_vehicle_view()

        shop = _shop()

        class _tooltips(DynAccessor):
            __slots__ = ()

            class _clans(DynAccessor):
                __slots__ = ()
                ClanShortInfoTooltipContent = DynAccessor(74)

            clans = _clans()
            AdditionalRewardsTooltip = DynAccessor(259)
            VehPostProgressionEntryPointTooltip = DynAccessor(260)

        tooltips = _tooltips()

        class _video(DynAccessor):
            __slots__ = ()

            class _video_view(DynAccessor):
                __slots__ = ()
                VideoView = DynAccessor(75)

            video_view = _video_view()

        video = _video()

        class _account_completion(DynAccessor):
            __slots__ = ()
            EmailActivateCurtainView = DynAccessor(114)
            EmailConfirmationCurtainView = DynAccessor(115)

            class _tooltips(DynAccessor):
                __slots__ = ()
                HangarTooltip = DynAccessor(116)

            tooltips = _tooltips()

        account_completion = _account_completion()

        class _awards(DynAccessor):
            __slots__ = ()
            BadgeAwardView = DynAccessor(117)
            MultipleAwardsView = DynAccessor(118)

            class _tooltips(DynAccessor):
                __slots__ = ()
                VehicleForChooseTooltip = DynAccessor(119)

            tooltips = _tooltips()

        awards = _awards()

        class _battle_royale(DynAccessor):
            __slots__ = ()
            BattleResultView = DynAccessor(152)
            PreBattleView = DynAccessor(153)

            class _tooltips(DynAccessor):
                __slots__ = ()
                BattlePassPointsSourcesTooltipView = DynAccessor(154)

            tooltips = _tooltips()

        battle_royale = _battle_royale()

        class _bootcamp(DynAccessor):
            __slots__ = ()
            BootcampExitView = DynAccessor(157)
            BootcampProgressView = DynAccessor(158)
            BootcampProgressWidget = DynAccessor(159)
            BootcampQuestWidget = DynAccessor(160)

        bootcamp = _bootcamp()

        class _craft_machine(DynAccessor):
            __slots__ = ()
            CraftmachineEntryPointView = DynAccessor(162)

        craft_machine = _craft_machine()

        class _crystalsPromo(DynAccessor):
            __slots__ = ()
            CrystalsPromoView = DynAccessor(163)

        crystalsPromo = _crystalsPromo()

        class _customization(DynAccessor):
            __slots__ = ()
            CustomizationCart = DynAccessor(164)

            class _progression_styles(DynAccessor):
                __slots__ = ()
                StageSwitcher = DynAccessor(165)

            progression_styles = _progression_styles()

            class _progressive_items_reward(DynAccessor):
                __slots__ = ()
                ProgressiveItemsUpgradeView = DynAccessor(166)

            progressive_items_reward = _progressive_items_reward()

            class _progressive_items_view(DynAccessor):
                __slots__ = ()
                ProgressiveItemsView = DynAccessor(167)

            progressive_items_view = _progressive_items_view()

            class _style_unlocked_view(DynAccessor):
                __slots__ = ()
                StyleUnlockedView = DynAccessor(168)

            style_unlocked_view = _style_unlocked_view()

        customization = _customization()

        class _dedication(DynAccessor):
            __slots__ = ()
            DedicationRewardView = DynAccessor(169)

        dedication = _dedication()

        class _dog_tags(DynAccessor):
            __slots__ = ()
            DedicationTooltip = DynAccessor(170)
            DogTagsView = DynAccessor(171)
            RankedEfficiencyTooltip = DynAccessor(172)
            ThreeMonthsTooltip = DynAccessor(173)
            TriumphTooltip = DynAccessor(174)

        dog_tags = _dog_tags()

        class _elite_window(DynAccessor):
            __slots__ = ()
            EliteView = DynAccessor(175)

        elite_window = _elite_window()

        class _frontline(DynAccessor):
            __slots__ = ()
            IntroScreen = DynAccessor(176)

        frontline = _frontline()

        class _instructions(DynAccessor):
            __slots__ = ()
            BuyWindow = DynAccessor(177)
            SellWindow = DynAccessor(178)

        instructions = _instructions()

        class _mapbox(DynAccessor):
            __slots__ = ()
            MapBoxAwardsView = DynAccessor(179)
            MapBoxEntryPointView = DynAccessor(180)
            MapBoxIntro = DynAccessor(181)
            MapBoxProgression = DynAccessor(182)
            MapBoxRewardChoiceView = DynAccessor(183)

        mapbox = _mapbox()

        class _maps_training(DynAccessor):
            __slots__ = ()
            MapsTrainingPage = DynAccessor(184)
            MapsTrainingQueue = DynAccessor(185)
            MapsTrainingResult = DynAccessor(186)
            ScenarioTooltip = DynAccessor(187)

        maps_training = _maps_training()

        class _matchmaker(DynAccessor):
            __slots__ = ()
            ActiveTestConfirmView = DynAccessor(188)

        matchmaker = _matchmaker()

        class _mode_selector(DynAccessor):
            __slots__ = ()
            BattleSessionView = DynAccessor(197)
            ModeSelectorView = DynAccessor(198)

            class _popovers(DynAccessor):
                __slots__ = ()
                RandomBattlePopover = DynAccessor(199)

            popovers = _popovers()

            class _tooltips(DynAccessor):
                __slots__ = ()
                AlertTooltip = DynAccessor(200)

                class _common(DynAccessor):
                    __slots__ = ()
                    Divider = DynAccessor(201)
                    GradientDecorator = DynAccessor(202)

                common = _common()
                SimplyFormatTooltip = DynAccessor(203)

            tooltips = _tooltips()

            class _widgets(DynAccessor):
                __slots__ = ()
                RandomBattleWidget = DynAccessor(204)
                RankedWidget = DynAccessor(205)

            widgets = _widgets()

        mode_selector = _mode_selector()

        class _offers(DynAccessor):
            __slots__ = ()
            OfferBannerWindow = DynAccessor(206)
            OfferGiftsWindow = DynAccessor(207)
            OfferRewardWindow = DynAccessor(208)

        offers = _offers()

        class _platoon(DynAccessor):
            __slots__ = ()
            AlertTooltip = DynAccessor(209)
            MembersWindow = DynAccessor(210)
            PlatoonDropdown = DynAccessor(211)
            SearchingDropdown = DynAccessor(212)
            SettingsPopover = DynAccessor(213)

            class _subViews(DynAccessor):
                __slots__ = ()
                Chat = DynAccessor(214)
                SettingsContent = DynAccessor(215)
                TiersLimit = DynAccessor(216)

            subViews = _subViews()
            WTRTooltip = DynAccessor(217)

        platoon = _platoon()

        class _research(DynAccessor):
            __slots__ = ()
            BuyModuleDialogView = DynAccessor(221)
            InsufficientCreditsTooltip = DynAccessor(222)
            SoldModuleInfoTooltip = DynAccessor(223)

        research = _research()

        class _tanksetup(DynAccessor):
            __slots__ = ()
            AmmunitionPanel = DynAccessor(227)

            class _common(DynAccessor):
                __slots__ = ()
                Action = DynAccessor(228)
                CtaButtons = DynAccessor(229)
                DealPanel = DynAccessor(230)
                ExtraImage = DynAccessor(231)
                FormatColorTagText = DynAccessor(232)
                MaybeWrapper = DynAccessor(233)
                Price = DynAccessor(234)
                SetupApp = DynAccessor(235)
                ShortenedText = DynAccessor(236)
                Slider = DynAccessor(237)

                class _SlotParts(DynAccessor):
                    __slots__ = ()
                    Bonus = DynAccessor(238)
                    Container = DynAccessor(239)
                    Count = DynAccessor(240)
                    Inside = DynAccessor(241)
                    Level = DynAccessor(242)

                SlotParts = _SlotParts()
                Specializations = DynAccessor(243)
                Storage = DynAccessor(244)
                SwitchButton = DynAccessor(245)
                SwitchEquipment = DynAccessor(246)

                class _Transitions(DynAccessor):
                    __slots__ = ()
                    SlotTransitions = DynAccessor(247)

                Transitions = _Transitions()
                WeaponOccupancy = DynAccessor(248)

            common = _common()

            class _dialogs(DynAccessor):
                __slots__ = ()
                Confirm = DynAccessor(249)
                ExchangeToBuyItems = DynAccessor(250)
                ExchangeToUpgradeItems = DynAccessor(251)
                NeedRepair = DynAccessor(252)
                RefillShells = DynAccessor(253)

            dialogs = _dialogs()
            HangarAmmunitionSetup = DynAccessor(254)
            IntroScreen = DynAccessor(255)
            VehicleCompareAmmunitionPanel = DynAccessor(256)
            VehicleCompareAmmunitionSetup = DynAccessor(257)

        tanksetup = _tanksetup()

        class _techtree(DynAccessor):
            __slots__ = ()
            TechTreeIntro = DynAccessor(258)

        techtree = _techtree()

        class _vehicle_compare(DynAccessor):
            __slots__ = ()
            CompareModificationsPanelView = DynAccessor(261)
            SelectSlotSpecCompareDialog = DynAccessor(262)

        vehicle_compare = _vehicle_compare()

        class _vehicle_preview(DynAccessor):
            __slots__ = ()

            class _buying_panel(DynAccessor):
                __slots__ = ()
                VPProgressionStylesBuyingPanel = DynAccessor(263)

            buying_panel = _buying_panel()

        vehicle_preview = _vehicle_preview()

        class _veh_post_progression(DynAccessor):
            __slots__ = ()

            class _common(DynAccessor):
                __slots__ = ()
                Bonus = DynAccessor(264)
                Description = DynAccessor(265)
                Grid = DynAccessor(266)
                PersistentBonuses = DynAccessor(267)
                Slide = DynAccessor(268)
                SlideContent = DynAccessor(269)
                Slider = DynAccessor(270)
                TextSplit = DynAccessor(271)

            common = _common()
            PostProgressionInfo = DynAccessor(272)
            PostProgressionIntro = DynAccessor(273)
            PostProgressionResearchSteps = DynAccessor(274)

            class _tooltip(DynAccessor):
                __slots__ = ()

                class _common(DynAccessor):
                    __slots__ = ()
                    DisabledBlock = DynAccessor(275)
                    FeatureLevelSubtitle = DynAccessor(276)
                    Lock = DynAccessor(277)
                    NotEnoughCredits = DynAccessor(278)
                    PriceBlock = DynAccessor(279)
                    Separator = DynAccessor(280)

                common = _common()
                PairModificationTooltipView = DynAccessor(281)
                PostProgressionLevelTooltipView = DynAccessor(282)
                RoleSlotTooltipView = DynAccessor(283)
                SetupTooltipView = DynAccessor(284)

            tooltip = _tooltip()
            VehiclePostProgressionCmpView = DynAccessor(285)
            VehiclePostProgressionView = DynAccessor(286)

        veh_post_progression = _veh_post_progression()

    lobby = _lobby()

    class _test_check_box_view(DynAccessor):
        __slots__ = ()
        TestCheckBoxView = DynAccessor(76)

    test_check_box_view = _test_check_box_view()

    class _test_text_button_view(DynAccessor):
        __slots__ = ()
        TestTextButtonView = DynAccessor(77)

    test_text_button_view = _test_text_button_view()

    class _windows_layout_view(DynAccessor):
        __slots__ = ()
        WindowsLayountView = DynAccessor(78)

    windows_layout_view = _windows_layout_view()

    class _blend_mode(DynAccessor):
        __slots__ = ()

        class _blend_mode(DynAccessor):
            __slots__ = ()
            BlendMode = DynAccessor(79)

        blend_mode = _blend_mode()

    blend_mode = _blend_mode()

    class _demo_view(DynAccessor):
        __slots__ = ()

        class _views(DynAccessor):
            __slots__ = ()

            class _demo_window_content(DynAccessor):
                __slots__ = ()
                DemoWindowContent = DynAccessor(80)
                ImageProps = DynAccessor(81)

            demo_window_content = _demo_window_content()

            class _demo_window_details_panel(DynAccessor):
                __slots__ = ()
                DemoWindowDetailsPanel = DynAccessor(82)

            demo_window_details_panel = _demo_window_details_panel()

            class _demo_window_image_panel(DynAccessor):
                __slots__ = ()
                DemoWindowImagePanel = DynAccessor(83)

            demo_window_image_panel = _demo_window_image_panel()

            class _image_preview_window_content(DynAccessor):
                __slots__ = ()
                ImagePreviewWindowContent = DynAccessor(84)

            image_preview_window_content = _image_preview_window_content()

        views = _views()

    demo_view = _demo_view()

    class _examples(DynAccessor):
        __slots__ = ()

        class _views(DynAccessor):
            __slots__ = ()

            class _test_dialogs_view(DynAccessor):
                __slots__ = ()
                TestDialogsView = DynAccessor(85)

            test_dialogs_view = _test_dialogs_view()

            class _test_expr_functions_view(DynAccessor):
                __slots__ = ()
                TestExprFunctionsView = DynAccessor(86)

            test_expr_functions_view = _test_expr_functions_view()

            class _test_sub_view(DynAccessor):
                __slots__ = ()
                TestSubView = DynAccessor(87)

            test_sub_view = _test_sub_view()

            class _test_view(DynAccessor):
                __slots__ = ()
                TestView = DynAccessor(88)

            test_view = _test_view()

            class _unbound_example(DynAccessor):
                __slots__ = ()
                UnboundExample = DynAccessor(89)

            unbound_example = _unbound_example()

        views = _views()

    examples = _examples()

    class _list_examples(DynAccessor):
        __slots__ = ()

        class _views(DynAccessor):
            __slots__ = ()

            class _list_examples_empty_render_window_content(DynAccessor):
                __slots__ = ()
                ListExamplesEmptyRenderWindowContent = DynAccessor(90)

            list_examples_empty_render_window_content = _list_examples_empty_render_window_content()

            class _list_examples_window_content(DynAccessor):
                __slots__ = ()
                ListExamplesWindowContent = DynAccessor(91)

            list_examples_window_content = _list_examples_window_content()

        views = _views()

    list_examples = _list_examples()

    class _rotation_pivot_view(DynAccessor):
        __slots__ = ()

        class _views(DynAccessor):
            __slots__ = ()

            class _rotation_pivot_view(DynAccessor):
                __slots__ = ()
                RotationAndPivotTestView = DynAccessor(92)

            rotation_pivot_view = _rotation_pivot_view()

        views = _views()

    rotation_pivot_view = _rotation_pivot_view()

    class _rotation_view(DynAccessor):
        __slots__ = ()

        class _views(DynAccessor):
            __slots__ = ()

            class _rotation_view(DynAccessor):
                __slots__ = ()
                RotationTestView = DynAccessor(93)

            rotation_view = _rotation_view()

        views = _views()

    rotation_view = _rotation_view()

    class _scale_view(DynAccessor):
        __slots__ = ()

        class _views(DynAccessor):
            __slots__ = ()

            class _scale_view(DynAccessor):
                __slots__ = ()
                ScaleTestView = DynAccessor(94)

            scale_view = _scale_view()

        views = _views()

    scale_view = _scale_view()

    class _test_uikit_buttons_view(DynAccessor):
        __slots__ = ()

        class _views(DynAccessor):
            __slots__ = ()

            class _test_uikit_buttons_view(DynAccessor):
                __slots__ = ()
                TestUikitButtonsView = DynAccessor(95)

            test_uikit_buttons_view = _test_uikit_buttons_view()

        views = _views()

    test_uikit_buttons_view = _test_uikit_buttons_view()

    class _test_uikit_view(DynAccessor):
        __slots__ = ()

        class _views(DynAccessor):
            __slots__ = ()

            class _test_uikit_view(DynAccessor):
                __slots__ = ()
                TestUikitView = DynAccessor(96)

            test_uikit_view = _test_uikit_view()

        views = _views()

    test_uikit_view = _test_uikit_view()

    class _wtypes_view(DynAccessor):
        __slots__ = ()

        class _views(DynAccessor):
            __slots__ = ()

            class _wtypes_demo_window_content(DynAccessor):
                __slots__ = ()
                WtypesDemoWindowContent = DynAccessor(97)

            wtypes_demo_window_content = _wtypes_demo_window_content()

        views = _views()

    wtypes_view = _wtypes_view()

    class _dialogs(DynAccessor):
        __slots__ = ()

        class _common(DynAccessor):
            __slots__ = ()
            DialogTemplateGenericTooltip = DynAccessor(103)

        common = _common()
        DefaultDialog = DynAccessor(104)

        class _sub_views(DynAccessor):
            __slots__ = ()

            class _common(DynAccessor):
                __slots__ = ()
                SimpleText = DynAccessor(105)
                SinglePrice = DynAccessor(106)

            common = _common()

            class _content(DynAccessor):
                __slots__ = ()
                SelectOptionContent = DynAccessor(107)
                SimpleTextContent = DynAccessor(108)
                SinglePriceContent = DynAccessor(109)

            content = _content()

            class _footer(DynAccessor):
                __slots__ = ()
                SinglePriceFooter = DynAccessor(110)

            footer = _footer()

            class _icon(DynAccessor):
                __slots__ = ()
                IconSet = DynAccessor(111)

            icon = _icon()

            class _title(DynAccessor):
                __slots__ = ()
                SimpleTextTitle = DynAccessor(112)

            title = _title()

            class _topRight(DynAccessor):
                __slots__ = ()
                MoneyBalance = DynAccessor(113)

            topRight = _topRight()

        sub_views = _sub_views()

    dialogs = _dialogs()
    Anchor = DynAccessor(287)
    ComponentsDemo = DynAccessor(288)
    DataTrackerDemo = DynAccessor(289)
    DemoContextMenu = DynAccessor(290)
    Easings = DynAccessor(291)
    GFComponents = DynAccessor(292)
    GFDemoPopover = DynAccessor(293)
    GFDemoRichTooltipWindow = DynAccessor(294)
    GFDemoWindow = DynAccessor(295)
    GFHooksDemo = DynAccessor(296)
    GFInjectView = DynAccessor(297)
    GFSimpleTooltipWindow = DynAccessor(298)
    GFWebSubDemoWindow = DynAccessor(299)

    class _gf_dialogs_demo(DynAccessor):
        __slots__ = ()
        DefaultDialogProxy = DynAccessor(300)
        GFDialogsDemo = DynAccessor(301)

        class _sub_views(DynAccessor):
            __slots__ = ()
            DummyContent = DynAccessor(302)
            DummyFooter = DynAccessor(303)
            DummyIcon = DynAccessor(304)
            DummyStepper = DynAccessor(305)
            DummyTitle = DynAccessor(306)
            DummyTopRight = DynAccessor(307)

        sub_views = _sub_views()

    gf_dialogs_demo = _gf_dialogs_demo()
    LocaleDemo = DynAccessor(308)
    MixBlendMode = DynAccessor(309)
    MixBlendModeAnimation = DynAccessor(310)
    ModeSelectorDemo = DynAccessor(311)
    ModeSelectorToolsetView = DynAccessor(312)
    NewYearLevelUp = DynAccessor(313)
    PropsSupportDemo = DynAccessor(314)
    StructuralDataBindDemo = DynAccessor(315)

    class _sub_views_demo(DynAccessor):
        __slots__ = ()
        GFSubViewsDemo = DynAccessor(316)

        class _sub_views(DynAccessor):
            __slots__ = ()
            CustomizationCartProxy = DynAccessor(317)
            DailyProxy = DynAccessor(318)
            ProgressiveItemsViewProxy = DynAccessor(319)

        sub_views = _sub_views()

    sub_views_demo = _sub_views_demo()
    UILoggerDemo = DynAccessor(320)
    VideoSupportView = DynAccessor(321)