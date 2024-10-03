package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.VO.VehicleStatusLightVO;
   import net.wg.data.VO.daapi.DAAPIArenaHeaderInfoVO;
   import net.wg.data.VO.daapi.DAAPIArenaInfoVO;
   import net.wg.data.VO.daapi.DAAPIInvitationStatusVO;
   import net.wg.data.VO.daapi.DAAPIPlayerStatusVO;
   import net.wg.data.VO.daapi.DAAPIQuestStatusVO;
   import net.wg.data.VO.daapi.DAAPITotalStatsVO;
   import net.wg.data.VO.daapi.DAAPITriggeredCommandVO;
   import net.wg.data.VO.daapi.DAAPITriggeredCommandsVO;
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.VO.daapi.DAAPIVehicleStatsVO;
   import net.wg.data.VO.daapi.DAAPIVehicleStatusVO;
   import net.wg.data.VO.daapi.DAAPIVehicleUserTagsVO;
   import net.wg.data.VO.daapi.DAAPIVehiclesDataVO;
   import net.wg.data.VO.daapi.DAAPIVehiclesInvitationStatusVO;
   import net.wg.data.VO.daapi.DAAPIVehiclesStatsVO;
   import net.wg.data.VO.daapi.DAAPIVehiclesUserTagsVO;
   import net.wg.data.constants.BattleStatisticsModelStatus;
   import net.wg.data.constants.FragCorrelationBarStatus;
   import net.wg.data.constants.InteractiveStates;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.InvitationStatus;
   import net.wg.data.constants.PersonalStatus;
   import net.wg.data.constants.PlayerStatus;
   import net.wg.data.constants.StatisticDataFacadeName;
   import net.wg.data.constants.VehicleStatus;
   import net.wg.data.constants.generated.ANIMATION_TYPES;
   import net.wg.data.constants.generated.BATTLE_CONSUMABLES_PANEL_TAGS;
   import net.wg.data.constants.generated.BATTLE_CONTEXT_MENU_HANDLER_TYPE;
   import net.wg.data.constants.generated.BATTLE_DEVICES_REPAIR_MODES;
   import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
   import net.wg.data.constants.generated.BATTLE_MARKERS_CONSTS;
   import net.wg.data.constants.generated.BATTLE_MARKER_ABILITIES_CONSTS;
   import net.wg.data.constants.generated.BATTLE_MARKER_STATES;
   import net.wg.data.constants.generated.BATTLE_MESSAGES_CONSTS;
   import net.wg.data.constants.generated.BATTLE_MINIMAP_CONSTS;
   import net.wg.data.constants.generated.BATTLE_NOTIFICATIONS_TIMER_COLORS;
   import net.wg.data.constants.generated.BATTLE_NOTIFICATIONS_TIMER_LINKAGES;
   import net.wg.data.constants.generated.BATTLE_NOTIFICATIONS_TIMER_TYPES;
   import net.wg.data.constants.generated.BATTLE_ROYAL_CONSTS;
   import net.wg.data.constants.generated.BATTLE_SOUND;
   import net.wg.data.constants.generated.BATTLE_TOP_HINT_CONSTS;
   import net.wg.data.constants.generated.BATTLE_TYPES;
   import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
   import net.wg.data.constants.generated.COMP7_CONSTS;
   import net.wg.data.constants.generated.CONSUMABLES_PANEL_SETTINGS;
   import net.wg.data.constants.generated.CROSSHAIR_VIEW_ID;
   import net.wg.data.constants.generated.DAMAGE_INFO_PANEL_CONSTS;
   import net.wg.data.constants.generated.EPIC_CONSTS;
   import net.wg.data.constants.generated.GAME_MESSAGES_CONSTS;
   import net.wg.data.constants.generated.INTERFACE_STATES;
   import net.wg.data.constants.generated.KEYBOARD_KEYS;
   import net.wg.data.constants.generated.PLAYERS_PANEL_STATE;
   import net.wg.data.constants.generated.POI_CONSTS;
   import net.wg.data.constants.generated.PREBATTLE_TIMER;
   import net.wg.data.constants.generated.QUEST_PROGRESS_BATTLE;
   import net.wg.data.constants.generated.RADIAL_MENU_CONSTS;
   import net.wg.data.constants.generated.ROCKET_ACCELERATOR_INDICATOR;
   import net.wg.data.constants.generated.SIEGE_MODE_CONSTS;
   import net.wg.gui.battle.ClassicFullStats;
   import net.wg.gui.battle.StatsBase;
   import net.wg.gui.battle.TabbedFullStats;
   import net.wg.gui.battle.battleRoyale.BattleRoyalePage;
   import net.wg.gui.battle.battleRoyale.RadarButton;
   import net.wg.gui.battle.battleRoyale.data.BattleRoyaleEventHeaderVO;
   import net.wg.gui.battle.battleRoyale.data.BattleRoyaleFullStatsVO;
   import net.wg.gui.battle.battleRoyale.data.DescriptionBlockWithIconVO;
   import net.wg.gui.battle.battleRoyale.data.RespawnMessageVO;
   import net.wg.gui.battle.battleRoyale.data.VehicleCounterVO;
   import net.wg.gui.battle.battleRoyale.ub.UnboundContainer;
   import net.wg.gui.battle.battleRoyale.views.BattleRoyaleLoading;
   import net.wg.gui.battle.battleRoyale.views.BattleRoyalePostmortemPanel;
   import net.wg.gui.battle.battleRoyale.views.BattleRoyaleScoreBar;
   import net.wg.gui.battle.battleRoyale.views.BattleRoyaleTeamPanel;
   import net.wg.gui.battle.battleRoyale.views.BattleRoyaleTeamPanelListItem;
   import net.wg.gui.battle.battleRoyale.views.BattleRoyaleWinnerCongrats;
   import net.wg.gui.battle.battleRoyale.views.components.BRZoneDamageIconContent;
   import net.wg.gui.battle.battleRoyale.views.components.BattleRoyaleConsumableButton;
   import net.wg.gui.battle.battleRoyale.views.components.BattleRoyaleCounterTimer;
   import net.wg.gui.battle.battleRoyale.views.components.BattleRoyaleCounterTimerAnimation;
   import net.wg.gui.battle.battleRoyale.views.components.BattleRoyaleCounterTimerContainer;
   import net.wg.gui.battle.battleRoyale.views.components.BattleRoyaleIconContent;
   import net.wg.gui.battle.battleRoyale.views.components.BattleRoyaleTimer;
   import net.wg.gui.battle.battleRoyale.views.components.BattleRoyaleTimerContainer;
   import net.wg.gui.battle.battleRoyale.views.components.BattleRoyaleTimerCounterContainer;
   import net.wg.gui.battle.battleRoyale.views.components.BattleRoyaleWinnerCongratsAnimation;
   import net.wg.gui.battle.battleRoyale.views.components.CorrodingShotIndicator;
   import net.wg.gui.battle.battleRoyale.views.components.DamageScreen;
   import net.wg.gui.battle.battleRoyale.views.components.EventViewHeader;
   import net.wg.gui.battle.battleRoyale.views.components.RespawnButton.BattleRoyaleRespawnButton;
   import net.wg.gui.battle.battleRoyale.views.components.RespawnButton.RespawnIcon;
   import net.wg.gui.battle.battleRoyale.views.components.fullStats.BattleRoyaleFullStats;
   import net.wg.gui.battle.battleRoyale.views.components.fullStats.DescriptionWithIconRenderer;
   import net.wg.gui.battle.battleRoyale.views.components.fullStats.DescriptionWithIconRendererSmall;
   import net.wg.gui.battle.battleRoyale.views.components.fullStats.MinimapItemsInfo;
   import net.wg.gui.battle.battleRoyale.views.components.fullStats.ScoreBlock;
   import net.wg.gui.battle.battleRoyale.views.components.fullStats.VehicleCounter;
   import net.wg.gui.battle.battleRoyale.views.components.fullStats.nationsVehiclesCounter.BattleRoyaleNationsVehiclesCounter;
   import net.wg.gui.battle.battleRoyale.views.components.fullStats.nationsVehiclesCounter.BattleRoyaleNationsVehiclesRenderer;
   import net.wg.gui.battle.battleRoyale.views.components.fullStats.nationsVehiclesCounter.BattleRoyalePlatoonRenderer;
   import net.wg.gui.battle.battleRoyale.views.components.fullStats.nationsVehiclesCounter.data.BattleRoyaleNationsVehiclesCounterVO;
   import net.wg.gui.battle.battleRoyale.views.components.fullStats.nationsVehiclesCounter.data.BattleRoyaleNationsVehiclesVO;
   import net.wg.gui.battle.battleRoyale.views.components.fullStats.nationsVehiclesCounter.data.BattleRoyalePlatoonVO;
   import net.wg.gui.battle.battleRoyale.views.components.respawnMessages.BaseRespawnMessage;
   import net.wg.gui.battle.battleRoyale.views.components.respawnMessages.IRespawnMessage;
   import net.wg.gui.battle.battleRoyale.views.components.respawnMessages.RespawnMessagePanel;
   import net.wg.gui.battle.battleRoyale.views.components.respawnMessages.RespawnMessageTimer;
   import net.wg.gui.battle.battleRoyale.views.components.respawnMessages.RespawnMessageWithDescription;
   import net.wg.gui.battle.battleRoyale.views.components.timersPanel.AirDropTimer;
   import net.wg.gui.battle.battleRoyale.views.components.timersPanel.BattleRoyaleTimersPanel;
   import net.wg.gui.battle.battleRoyale.views.components.timersPanel.RespawnTimer;
   import net.wg.gui.battle.battleRoyale.views.components.timersPanel.TimerTextField;
   import net.wg.gui.battle.battleRoyale.views.configurator.BattleVehicleConfigurator;
   import net.wg.gui.battle.battleRoyale.views.configurator.ChoiceInfoPanel;
   import net.wg.gui.battle.battleRoyale.views.configurator.ConfiguratorRenderer;
   import net.wg.gui.battle.battleRoyale.views.configurator.ModuleInfo;
   import net.wg.gui.battle.battleRoyale.views.configurator.ModuleInfoPanel;
   import net.wg.gui.battle.battleRoyale.views.configurator.data.BattleVehicleConfiguratorVO;
   import net.wg.gui.battle.battleRoyale.views.configurator.data.ChoiceInfoPanelVO;
   import net.wg.gui.battle.battleRoyale.views.configurator.data.ModuleInfoVO;
   import net.wg.gui.battle.battleRoyale.views.configurator.data.ModuleParameterVO;
   import net.wg.gui.battle.battleRoyale.views.playerStats.BattleRoyalePlayerStatRenderer;
   import net.wg.gui.battle.battleRoyale.views.playerStats.BattleRoyalePlayerStatVO;
   import net.wg.gui.battle.battleRoyale.views.playerStats.BattleRoyalePlayerStats;
   import net.wg.gui.battle.battleRoyale.views.playersPanel.BattleRoyalePlayersPanel;
   import net.wg.gui.battle.battleRoyale.views.playersPanel.PlayerDataVO;
   import net.wg.gui.battle.battleRoyale.views.playersPanel.PlayersPanelItemRenderer;
   import net.wg.gui.battle.battleloading.BaseBattleLoading;
   import net.wg.gui.battle.battleloading.BaseLoadingForm;
   import net.wg.gui.battle.battleloading.BattleLoading;
   import net.wg.gui.battle.battleloading.BattleLoadingForm;
   import net.wg.gui.battle.battleloading.BattleLoadingHelper;
   import net.wg.gui.battle.battleloading.constants.PlayerStatus;
   import net.wg.gui.battle.battleloading.constants.VehicleStatus;
   import net.wg.gui.battle.battleloading.constants.VehicleStatusSchemes;
   import net.wg.gui.battle.battleloading.data.VehiclesDataProvider;
   import net.wg.gui.battle.battleloading.interfaces.IVehiclesDataProvider;
   import net.wg.gui.battle.battleloading.renderers.BasePlayerItemRenderer;
   import net.wg.gui.battle.battleloading.renderers.BaseRendererContainer;
   import net.wg.gui.battle.battleloading.renderers.IBattleLoadingRenderer;
   import net.wg.gui.battle.battleloading.renderers.TablePlayerItemRenderer;
   import net.wg.gui.battle.battleloading.renderers.TipPlayerItemRenderer;
   import net.wg.gui.battle.battleloading.util.BattleLoadingUtil;
   import net.wg.gui.battle.battleloading.vo.LoadingFormDisplayDataVO;
   import net.wg.gui.battle.battleloading.vo.VehInfoWithSortedIDTeamVO;
   import net.wg.gui.battle.battleloading.vo.VehInfoWithSortedIDVO;
   import net.wg.gui.battle.battleloading.vo.VehStatusTeamVO;
   import net.wg.gui.battle.battleloading.vo.VehStatusVO;
   import net.wg.gui.battle.battleloading.vo.VehicleDataTeamVO;
   import net.wg.gui.battle.battleloading.vo.VehicleDataVO;
   import net.wg.gui.battle.battleloading.vo.VehicleInfoVO;
   import net.wg.gui.battle.battleloading.vo.VisualTipInfoVO;
   import net.wg.gui.battle.comp7.Comp7BattlePage;
   import net.wg.gui.battle.comp7.Comp7HelpCtrl;
   import net.wg.gui.battle.comp7.VO.daapi.Comp7DAAPIVehicleInfoVO;
   import net.wg.gui.battle.comp7.VO.daapi.Comp7DAAPIVehicleStatsVO;
   import net.wg.gui.battle.comp7.VO.daapi.Comp7DAAPIVehiclesDataVO;
   import net.wg.gui.battle.comp7.VO.daapi.Comp7DAAPIVehiclesStatsVO;
   import net.wg.gui.battle.comp7.VO.daapi.Comp7InterestPointVO;
   import net.wg.gui.battle.comp7.battleloading.Comp7BattleLoading;
   import net.wg.gui.battle.comp7.battleloading.Comp7BattleLoadingForm;
   import net.wg.gui.battle.comp7.battleloading.renderers.Comp7RendererContainer;
   import net.wg.gui.battle.comp7.battleloading.renderers.Comp7TipPlayerItemRenderer;
   import net.wg.gui.battle.comp7.infrastructure.Comp7StatisticsDataController;
   import net.wg.gui.battle.comp7.infrastructure.interfaces.IFullStatsPoiHolder;
   import net.wg.gui.battle.comp7.infrastructure.interfaces.IPoiContainer;
   import net.wg.gui.battle.comp7.stats.PoiContainer;
   import net.wg.gui.battle.comp7.stats.components.RoleSkillLevel;
   import net.wg.gui.battle.comp7.stats.components.VoiceChatActivation;
   import net.wg.gui.battle.comp7.stats.components.data.VoiceChatActivationVO;
   import net.wg.gui.battle.comp7.stats.components.events.VoiceChatActivationEvent;
   import net.wg.gui.battle.comp7.stats.components.playersPanel.Comp7PlayersPanel;
   import net.wg.gui.battle.comp7.stats.components.playersPanel.interfaces.IComp7PlayersPanelList;
   import net.wg.gui.battle.comp7.stats.components.playersPanel.interfaces.IComp7PlayersPanelListItem;
   import net.wg.gui.battle.comp7.stats.components.playersPanel.interfaces.IComp7PlayersPanelListLeft;
   import net.wg.gui.battle.comp7.stats.components.playersPanel.list.Comp7PlayersPanelList;
   import net.wg.gui.battle.comp7.stats.components.playersPanel.list.Comp7PlayersPanelListItem;
   import net.wg.gui.battle.comp7.stats.components.playersPanel.list.Comp7PlayersPanelListItemHolder;
   import net.wg.gui.battle.comp7.stats.components.playersPanel.list.Comp7PlayersPanelListLeft;
   import net.wg.gui.battle.comp7.stats.components.playersPanel.list.Comp7PlayersPanelListRight;
   import net.wg.gui.battle.comp7.stats.fullStats.FullStats;
   import net.wg.gui.battle.comp7.stats.fullStats.FullStatsTable;
   import net.wg.gui.battle.comp7.stats.fullStats.FullStatsTableCtrl;
   import net.wg.gui.battle.comp7.stats.fullStats.tableItem.AnonymizerCtrl;
   import net.wg.gui.battle.comp7.stats.fullStats.tableItem.StatsTableItem;
   import net.wg.gui.battle.comp7.stats.fullStats.tableItem.StatsTableItemHolder;
   import net.wg.gui.battle.comp7.views.battleTankCarousel.BattleCarouselEnvironment;
   import net.wg.gui.battle.comp7.views.battleTankCarousel.BattleTankCarousel;
   import net.wg.gui.battle.comp7.views.battleTankCarousel.BattleTankCarouselFilters;
   import net.wg.gui.battle.comp7.views.battleTankCarousel.data.BattleVehicleCarouselVO;
   import net.wg.gui.battle.comp7.views.battleTankCarousel.renderers.BaseBattleTankIcon;
   import net.wg.gui.battle.comp7.views.battleTankCarousel.renderers.BattleTankCarouselItemRenderer;
   import net.wg.gui.battle.comp7.views.battleTankCarousel.renderers.SmallBattleTankCarouselItemRenderer;
   import net.wg.gui.battle.comp7.views.battleTankCarousel.renderers.SmallBattleTankIcon;
   import net.wg.gui.battle.comp7.views.consumablesPanel.Comp7ConsumableButton;
   import net.wg.gui.battle.comp7.views.consumablesPanel.Comp7ConsumableButtonGlow;
   import net.wg.gui.battle.comp7.views.consumablesPanel.Comp7Counter;
   import net.wg.gui.battle.comp7.views.consumablesPanel.Comp7ProgressBar;
   import net.wg.gui.battle.comp7.views.consumablesPanel.Comp7ProgressContainer;
   import net.wg.gui.battle.comp7.views.consumablesPanel.events.ConsumablesPanelEvent;
   import net.wg.gui.battle.comp7.views.prebattleTimer.Comp7PrebattleInfoContainer;
   import net.wg.gui.battle.comp7.views.prebattleTimer.Comp7PrebattleInfoView;
   import net.wg.gui.battle.comp7.views.prebattleTimer.Comp7PrebattleInfoViewVO;
   import net.wg.gui.battle.comp7.views.prebattleTimer.Comp7PrebattleTimer;
   import net.wg.gui.battle.comp7.views.prebattleTimer.events.Comp7PrebattleInfoViewEvent;
   import net.wg.gui.battle.comp7.views.teamBasesPanel.Comp7TeamBasesPanel;
   import net.wg.gui.battle.components.BaseProgressCircle;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.components.BattleDAAPIComponent;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.gui.battle.components.BattleIconHolder;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.components.BattleUIComponentsHolder;
   import net.wg.gui.battle.components.BattleUIDisplayable;
   import net.wg.gui.battle.components.CoolDownTimer;
   import net.wg.gui.battle.components.EpicProgressCircle;
   import net.wg.gui.battle.components.FrameAnimationTimer;
   import net.wg.gui.battle.components.FullStatsHeader;
   import net.wg.gui.battle.components.FullStatsTitle;
   import net.wg.gui.battle.components.HpProgressCircle;
   import net.wg.gui.battle.components.PlayerStatusView;
   import net.wg.gui.battle.components.PlayersPanelBase;
   import net.wg.gui.battle.components.PlayersPanelSwitchBase;
   import net.wg.gui.battle.components.StatusNotificationsPanel;
   import net.wg.gui.battle.components.TimersPanel;
   import net.wg.gui.battle.components.animatedBattleHint.AnimatedBattleHint;
   import net.wg.gui.battle.components.animatedBattleHint.constants.HINT_LABELS;
   import net.wg.gui.battle.components.animatedBattleHint.containers.HintAnimationBlind;
   import net.wg.gui.battle.components.animatedBattleHint.containers.HintAnimationContainer;
   import net.wg.gui.battle.components.animatedBattleHint.containers.HintBackground;
   import net.wg.gui.battle.components.animatedBattleHint.containers.HintBlindContainer;
   import net.wg.gui.battle.components.animatedBattleHint.containers.HintContainer;
   import net.wg.gui.battle.components.animatedBattleHint.containers.HintInfoContainer;
   import net.wg.gui.battle.components.animatedBattleHint.containers.HintPenetrationAnimation;
   import net.wg.gui.battle.components.buttons.BattleButton;
   import net.wg.gui.battle.components.buttons.BattleStateButton;
   import net.wg.gui.battle.components.buttons.BattleToolTipButton;
   import net.wg.gui.battle.components.buttons.btnConfig.BattleStateBtnSettings;
   import net.wg.gui.battle.components.buttons.interfaces.IBattleButton;
   import net.wg.gui.battle.components.buttons.interfaces.IBattleToolTipButton;
   import net.wg.gui.battle.components.buttons.interfaces.IClickButtonHandler;
   import net.wg.gui.battle.components.buttons.interfaces.IDragOutButtonHandler;
   import net.wg.gui.battle.components.buttons.interfaces.IDragOverButtonHandler;
   import net.wg.gui.battle.components.buttons.interfaces.IPressButtonHandler;
   import net.wg.gui.battle.components.buttons.interfaces.IReleaseOutSideButtonHandler;
   import net.wg.gui.battle.components.buttons.interfaces.IRollOutButtonHandler;
   import net.wg.gui.battle.components.buttons.interfaces.IRollOverButtonHandler;
   import net.wg.gui.battle.components.buttons.interfaces.IStateChangedButtonHandler;
   import net.wg.gui.battle.components.buttons.interfaces.ITooltipTarget;
   import net.wg.gui.battle.components.events.PlayersPanelListEvent;
   import net.wg.gui.battle.components.interestPointTimersPanel.InterestPointDestroyTimer;
   import net.wg.gui.battle.components.interestPointTimersPanel.InterestPointDestroyTimerBase;
   import net.wg.gui.battle.components.interestPointTimersPanel.InterestPointSecondaryTimer;
   import net.wg.gui.battle.components.interfaces.IBattleUIComponent;
   import net.wg.gui.battle.components.interfaces.ICoolDownCompleteHandler;
   import net.wg.gui.battle.components.interfaces.IStatusNotification;
   import net.wg.gui.battle.components.interfaces.IStatusNotificationCallback;
   import net.wg.gui.battle.components.poi.components.PoiProgressCircle;
   import net.wg.gui.battle.components.poi.components.PoiProgressCircleWrapper;
   import net.wg.gui.battle.components.poi.components.PoiWithProgressStateCircle;
   import net.wg.gui.battle.components.pointsOfInterestNotificationPanel.PoiProgressCircle;
   import net.wg.gui.battle.components.pointsOfInterestNotificationPanel.PoiStatusIndicator;
   import net.wg.gui.battle.components.pointsOfInterestNotificationPanel.PointsOfInterestNotificationPanel;
   import net.wg.gui.battle.components.pointsOfInterestNotificationPanel.data.PointsOfInterestNotificationVO;
   import net.wg.gui.battle.components.preBattleTimer.DigitAnim;
   import net.wg.gui.battle.components.preBattleTimer.DigitsChain;
   import net.wg.gui.battle.components.preBattleTimer.PreBattleTimerEvent;
   import net.wg.gui.battle.components.preBattleTimer.TimerAnim;
   import net.wg.gui.battle.components.stats.playersPanel.ChatCommandItemComponent;
   import net.wg.gui.battle.components.stats.playersPanel.SpottedIndicator;
   import net.wg.gui.battle.components.stats.playersPanel.events.ChatCommandItemEvent;
   import net.wg.gui.battle.components.stats.playersPanel.events.PlayersPanelItemEvent;
   import net.wg.gui.battle.components.stats.playersPanel.interfaces.IPlayersPanelListItem;
   import net.wg.gui.battle.components.stats.playersPanel.interfaces.IRandomPlayersPanelListItem;
   import net.wg.gui.battle.components.stats.playersPanel.interfaces.IRankedPlayersPanelListItem;
   import net.wg.gui.battle.components.stats.playersPanel.list.BasePlayersListItemHolder;
   import net.wg.gui.battle.components.stats.playersPanel.list.BasePlayersPanelList;
   import net.wg.gui.battle.components.stats.playersPanel.list.BasePlayersPanelListItem;
   import net.wg.gui.battle.components.stats.playersPanel.list.HPBarPlayersPanelListItem;
   import net.wg.gui.battle.cosmic.CosmicBattlePage;
   import net.wg.gui.battle.cosmic.battleloading.CosmicBattleLoading;
   import net.wg.gui.battle.epicBattle.VO.daapi.EpicPlayerStatsVO;
   import net.wg.gui.battle.epicBattle.VO.daapi.EpicVehicleStatsVO;
   import net.wg.gui.battle.epicBattle.VO.daapi.EpicVehiclesStatsVO;
   import net.wg.gui.battle.epicBattle.battleloading.EpicBattleLoading;
   import net.wg.gui.battle.epicBattle.battleloading.EpicBattleLoadingForm;
   import net.wg.gui.battle.epicBattle.battleloading.components.EpicBattleLoadingTankBalance;
   import net.wg.gui.battle.epicBattle.battleloading.components.EpicBattleLoadingTankTypeComponent;
   import net.wg.gui.battle.epicBattle.battleloading.components.EpicBattleScrollingList;
   import net.wg.gui.battle.epicBattle.battleloading.components.EpicBattleStatsTable;
   import net.wg.gui.battle.epicBattle.battleloading.components.EpicBattleStatsTableCtrl;
   import net.wg.gui.battle.epicBattle.battleloading.events.EpicBattleLoadingEvent;
   import net.wg.gui.battle.epicBattle.battleloading.renderers.EpicBattleLoadingPlayerItemRenderer;
   import net.wg.gui.battle.epicBattle.views.EpicBattlePage;
   import net.wg.gui.battle.epicBattle.views.EpicCarouselFilterPopoverView;
   import net.wg.gui.battle.epicBattle.views.components.EpicBattleConsumableButton;
   import net.wg.gui.battle.epicBattle.views.components.EpicBattleEquipmentButtonGlow;
   import net.wg.gui.battle.epicBattle.views.data.EpicStatsDataProviderBaseCtrl;
   import net.wg.gui.battle.epicBattle.views.data.EpicVehicleDataProvider;
   import net.wg.gui.battle.epicBattle.views.stats.EpicFullStats;
   import net.wg.gui.battle.epicBattle.views.stats.components.EpicFullStatsTable;
   import net.wg.gui.battle.epicBattle.views.stats.components.EpicFullStatsTableCtrl;
   import net.wg.gui.battle.epicBattle.views.stats.components.EpicStatsGeneralBonus;
   import net.wg.gui.battle.epicBattle.views.stats.components.EpicStatsHeader;
   import net.wg.gui.battle.epicBattle.views.stats.components.EpicStatsTableFilterGroup;
   import net.wg.gui.battle.epicBattle.views.stats.components.EpicStatsTableTabButton;
   import net.wg.gui.battle.epicBattle.views.stats.components.PlayerScrollingList;
   import net.wg.gui.battle.epicBattle.views.stats.events.EpicFullStatsEvent;
   import net.wg.gui.battle.epicBattle.views.stats.events.EpicFullStatsRendererEvent;
   import net.wg.gui.battle.epicBattle.views.stats.renderers.EpicStatsPlayerRenderer;
   import net.wg.gui.battle.epicRandom.VO.daapi.EpicRandomDAAPIVehicleInfoVO;
   import net.wg.gui.battle.epicRandom.VO.daapi.EpicRandomDAAPIVehiclesDataVO;
   import net.wg.gui.battle.epicRandom.battleloading.EpicRandomBattleLoading;
   import net.wg.gui.battle.epicRandom.battleloading.EpicRandomBattleLoadingForm;
   import net.wg.gui.battle.epicRandom.battleloading.components.EpicRandomStatsTable;
   import net.wg.gui.battle.epicRandom.battleloading.components.EpicRandomStatsTableCtrl;
   import net.wg.gui.battle.epicRandom.battleloading.renderers.EpicRandomBasePlayerItemRenderer;
   import net.wg.gui.battle.epicRandom.battleloading.renderers.IEpicRandomBattleLoadingRenderer;
   import net.wg.gui.battle.epicRandom.battleloading.renderers.TableEpicRandomPlayerItemRenderer;
   import net.wg.gui.battle.epicRandom.battleloading.renderers.TipEpicRandomPlayerItemRenderer;
   import net.wg.gui.battle.epicRandom.infrastructure.EpicRandomStatisticsDataController;
   import net.wg.gui.battle.epicRandom.views.EpicRandomPage;
   import net.wg.gui.battle.epicRandom.views.stats.components.fullStats.EpicRandomFullStats;
   import net.wg.gui.battle.epicRandom.views.stats.components.fullStats.EpicRandomFullStatsListItemRenderer;
   import net.wg.gui.battle.epicRandom.views.stats.components.fullStats.EpicRandomFullStatsTable;
   import net.wg.gui.battle.epicRandom.views.stats.components.fullStats.EpicRandomFullStatsTableCtrl;
   import net.wg.gui.battle.epicRandom.views.stats.components.playersPanel.PlayersPanel;
   import net.wg.gui.battle.epicRandom.views.stats.components.playersPanel.events.PlayersPanelItemEvent;
   import net.wg.gui.battle.epicRandom.views.stats.components.playersPanel.list.ListRowBackgroundContainer;
   import net.wg.gui.battle.epicRandom.views.stats.components.playersPanel.list.ListRowBackgroundItem;
   import net.wg.gui.battle.epicRandom.views.stats.components.playersPanel.list.PlayersPanelDeploymentGroupIcon;
   import net.wg.gui.battle.epicRandom.views.stats.components.playersPanel.list.PlayersPanelList;
   import net.wg.gui.battle.epicRandom.views.stats.components.playersPanel.list.PlayersPanelListItem;
   import net.wg.gui.battle.epicRandom.views.stats.components.playersPanel.list.PlayersPanelListItemHolder;
   import net.wg.gui.battle.epicRandom.views.stats.components.playersPanel.list.PlayersPanelListItemSettings;
   import net.wg.gui.battle.epicRandom.views.stats.components.playersPanel.list.PlayersPanelListItemState;
   import net.wg.gui.battle.epicRandom.views.stats.components.playersPanel.list.PlayersPanelListLeft;
   import net.wg.gui.battle.epicRandom.views.stats.components.playersPanel.list.PlayersPanelListRight;
   import net.wg.gui.battle.epicRandom.views.stats.components.playersPanel.panelSwitch.PlayersPanelSwitch;
   import net.wg.gui.battle.epicRandom.views.stats.components.playersPanel.panelSwitch.PlayersPanelSwitchButtonEx;
   import net.wg.gui.battle.epicRandom.views.stats.events.EpicRandomFullStatsListItemRendererEvent;
   import net.wg.gui.battle.eventBattle.VO.DAAPIHunterVehicleInfoVO;
   import net.wg.gui.battle.eventBattle.VO.DAAPIHunterVehiclesDataVO;
   import net.wg.gui.battle.eventBattle.views.EventBattleLoading;
   import net.wg.gui.battle.eventBattle.views.EventBattlePage;
   import net.wg.gui.battle.eventBattle.views.battleHints.EventBattleHint;
   import net.wg.gui.battle.eventBattle.views.battleHints.EventObjectives;
   import net.wg.gui.battle.eventBattle.views.battleHints.InfoContainer;
   import net.wg.gui.battle.eventBattle.views.battleHints.TextContainer;
   import net.wg.gui.battle.eventBattle.views.battleHints.data.HintInfoVO;
   import net.wg.gui.battle.eventBattle.views.buffsPanel.BuffsPanel;
   import net.wg.gui.battle.eventBattle.views.buffsPanel.EventBuffButton;
   import net.wg.gui.battle.eventBattle.views.consumablesPanel.EventBattleEquipmentButton;
   import net.wg.gui.battle.eventBattle.views.consumablesPanel.EventBattleShellButton;
   import net.wg.gui.battle.eventBattle.views.consumablesPanel.EventConsumablesPanel;
   import net.wg.gui.battle.eventBattle.views.eventPlayersPanel.EventHealthBar;
   import net.wg.gui.battle.eventBattle.views.eventPlayersPanel.EventPlayersInfo;
   import net.wg.gui.battle.eventBattle.views.eventPlayersPanel.EventPlayersPanel;
   import net.wg.gui.battle.eventBattle.views.eventPlayersPanel.EventPlayersPanelListItem;
   import net.wg.gui.battle.eventBattle.views.eventPlayersPanel.VO.DAAPIPlayerPanelInfoVO;
   import net.wg.gui.battle.eventBattle.views.eventPointCounter.EventPointCounter;
   import net.wg.gui.battle.eventBattle.views.eventStats.EventStats;
   import net.wg.gui.battle.eventBattle.views.eventStats.VO.EventStatsPlayerVO;
   import net.wg.gui.battle.eventBattle.views.eventStats.renderers.StatsPlayerRenderer;
   import net.wg.gui.battle.eventBattle.views.eventTimer.EventCaptureTimer;
   import net.wg.gui.battle.eventBattle.views.eventTimer.EventTimer;
   import net.wg.gui.battle.eventBattle.views.eventTimer.TimerMovie;
   import net.wg.gui.battle.eventBattle.views.introVideoPage.EventIntroLogoContainer;
   import net.wg.gui.battle.eventBattle.views.minimap.entries.CustomDeathZoneMinimapEntry;
   import net.wg.gui.battle.eventBattle.views.minimap.entries.EventDeathZoneMinimapEntry;
   import net.wg.gui.battle.eventBattle.views.prebattleTimer.EventPrebattleTimerBg;
   import net.wg.gui.battle.eventBattle.views.radialMenu.EventRadialButton;
   import net.wg.gui.battle.eventBattle.views.radialMenu.EventRadialMenu;
   import net.wg.gui.battle.eventBattle.views.radialMenu.components.ChatContainer;
   import net.wg.gui.battle.eventBattle.views.radialMenu.components.CommandContainer;
   import net.wg.gui.battle.eventBattle.views.radialMenu.components.EventBackGround;
   import net.wg.gui.battle.eventBattle.views.radialMenu.components.EventContent;
   import net.wg.gui.battle.eventBattle.views.radialMenu.components.EventSectorHoveredWrapper;
   import net.wg.gui.battle.eventBattle.views.radialMenu.components.IconRotationContainer;
   import net.wg.gui.battle.eventBattle.views.radialMenu.components.RadialPaging;
   import net.wg.gui.battle.eventBattle.views.timersPanel.ITimerIconContent;
   import net.wg.gui.battle.eventBattle.views.timersPanel.WtBombCarryIconContent;
   import net.wg.gui.battle.eventBattle.views.timersPanel.WtTimer;
   import net.wg.gui.battle.eventInfoPanel.EventInfoPanel;
   import net.wg.gui.battle.eventInfoPanel.data.EventInfoPanelItemVO;
   import net.wg.gui.battle.eventInfoPanel.data.EventInfoPanelVO;
   import net.wg.gui.battle.eventInfoPanel.interfaces.IEventInfoPanel;
   import net.wg.gui.battle.events.BattleSoundEvent;
   import net.wg.gui.battle.events.RepairAnimEvent;
   import net.wg.gui.battle.interfaces.IBattleInfo;
   import net.wg.gui.battle.interfaces.IFullStats;
   import net.wg.gui.battle.interfaces.IPrebattleTimerBase;
   import net.wg.gui.battle.interfaces.IQuestProgressStats;
   import net.wg.gui.battle.interfaces.IReservesStats;
   import net.wg.gui.battle.interfaces.IStatsTableController;
   import net.wg.gui.battle.interfaces.ITabbedFullStatsTableController;
   import net.wg.gui.battle.mapsTraining.views.MapsTrainingBattleLoading;
   import net.wg.gui.battle.mapsTraining.views.MapsTrainingBattlePage;
   import net.wg.gui.battle.mapsTraining.views.consumablesPanel.MapsTrainingBattleShellButton;
   import net.wg.gui.battle.mapsTraining.views.data.MapsTrainingBattleLoadingVO;
   import net.wg.gui.battle.mapsTraining.views.goals.MapsTrainingGoals;
   import net.wg.gui.battle.mapsTraining.views.goals.data.MapsTrainingGoalVO;
   import net.wg.gui.battle.mapsTraining.views.goals.hint.MapsTrainingGoal;
   import net.wg.gui.battle.mapsTraining.views.goals.hint.MapsTrainingGoalItem;
   import net.wg.gui.battle.mapsTraining.views.goals.hint.MapsTrainingTimerAnim;
   import net.wg.gui.battle.mapsTraining.views.goals.hint.MapsTrainingTimerHint;
   import net.wg.gui.battle.mapsTraining.views.listTargets.ListTargets;
   import net.wg.gui.battle.mapsTraining.views.mapsTrainingMessagesPanel.MapsTrainingMessagesPanel;
   import net.wg.gui.battle.mapsTraining.views.minimap.MapsTrainingVehicleMinimapEntry;
   import net.wg.gui.battle.mapsTraining.views.minimap.ShootingPointMinimapEntry;
   import net.wg.gui.battle.mapsTraining.views.prebattleTimer.MapsTrainingPrebattleTimer;
   import net.wg.gui.battle.mapsTraining.views.prebattleTimer.MapsTrainingPrebattleTimerBg;
   import net.wg.gui.battle.mapsTraining.views.prebattleTimer.MapsTrainingTextFieldContainer;
   import net.wg.gui.battle.random.battleloading.renderers.RandomPlayerItemRenderer;
   import net.wg.gui.battle.random.battleloading.renderers.RandomRendererContainer;
   import net.wg.gui.battle.random.views.BattlePage;
   import net.wg.gui.battle.random.views.fragCorrelationBar.FragCorrelationBar;
   import net.wg.gui.battle.random.views.fragCorrelationBar.FragsAndEnemiesBar;
   import net.wg.gui.battle.random.views.fragCorrelationBar.components.AllyTeamHealthBar;
   import net.wg.gui.battle.random.views.fragCorrelationBar.components.BaseTeamHealthBar;
   import net.wg.gui.battle.random.views.fragCorrelationBar.components.FCVehicleMarker;
   import net.wg.gui.battle.random.views.fragCorrelationBar.components.IVehicleMarkerAnimFinishedHandler;
   import net.wg.gui.battle.random.views.fragCorrelationBar.components.ScoreHealthBarElement;
   import net.wg.gui.battle.random.views.fragCorrelationBar.components.TierGroupingElement;
   import net.wg.gui.battle.random.views.fragCorrelationBar.components.VehicleMarkersList;
   import net.wg.gui.battle.random.views.stats.components.fullStats.FullStats;
   import net.wg.gui.battle.random.views.stats.components.fullStats.FullStatsTable;
   import net.wg.gui.battle.random.views.stats.components.fullStats.FullStatsTableCtrl;
   import net.wg.gui.battle.random.views.stats.components.fullStats.constants.RandomFullStatsValidationType;
   import net.wg.gui.battle.random.views.stats.components.fullStats.interfaces.IDynamicSquadCtrl;
   import net.wg.gui.battle.random.views.stats.components.fullStats.interfaces.ISquadHandler;
   import net.wg.gui.battle.random.views.stats.components.fullStats.tableItem.DynamicSquadCtrl;
   import net.wg.gui.battle.random.views.stats.components.fullStats.tableItem.StatsTableItem;
   import net.wg.gui.battle.random.views.stats.components.fullStats.tableItem.StatsTableItemHolder;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.PlayersPanel;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.VO.PlayersPanelContextMenuSentData;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.constants.PlayersPanelInvalidationType;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.events.PlayersPanelEvent;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.events.PlayersPanelSwitchEvent;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.interfaces.IEpicPlayersPanelList;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.interfaces.IPlayersPanelList;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.interfaces.IPlayersPanelListItemHolder;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.list.InviteReceivedIndicator;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.list.PlayersPanelDynamicSquad;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.list.PlayersPanelList;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.list.PlayersPanelListItem;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.list.PlayersPanelListItemHolder;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.list.PlayersPanelListLeft;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.list.PlayersPanelListRight;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.panelSwitch.PlayersPanelSwitch;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.panelSwitch.PlayersPanelSwitchButton;
   import net.wg.gui.battle.random.views.stats.constants.VehicleActions;
   import net.wg.gui.battle.random.views.stats.events.DynamicSquadEvent;
   import net.wg.gui.battle.random.views.teamBasesPanel.TeamBasesPanel;
   import net.wg.gui.battle.random.views.teamBasesPanel.TeamCaptureBar;
   import net.wg.gui.battle.random.views.teamBasesPanel.TeamCaptureBarBg;
   import net.wg.gui.battle.random.views.teamBasesPanel.TeamCaptureFeel;
   import net.wg.gui.battle.random.views.teamBasesPanel.TeamCaptureProgress;
   import net.wg.gui.battle.random.views.teamBasesPanel.TeamCaptureProgressReset;
   import net.wg.gui.battle.ranked.RankedBattlePage;
   import net.wg.gui.battle.ranked.VO.daapi.RankedDAAPIVehicleInfoVO;
   import net.wg.gui.battle.ranked.VO.daapi.RankedDAAPIVehiclesDataVO;
   import net.wg.gui.battle.ranked.battleloading.BattleLoading;
   import net.wg.gui.battle.ranked.battleloading.BattleLoadingForm;
   import net.wg.gui.battle.ranked.battleloading.renderers.RankedPlayerItemRenderer;
   import net.wg.gui.battle.ranked.battleloading.renderers.RankedRendererContainer;
   import net.wg.gui.battle.ranked.battleloading.renderers.TablePlayerItemRenderer;
   import net.wg.gui.battle.ranked.battleloading.renderers.TipPlayerItemRenderer;
   import net.wg.gui.battle.ranked.infrastructure.RankedStatisticsDataController;
   import net.wg.gui.battle.ranked.stats.components.fullStats.FullStats;
   import net.wg.gui.battle.ranked.stats.components.fullStats.FullStatsTable;
   import net.wg.gui.battle.ranked.stats.components.fullStats.FullStatsTableCtrl;
   import net.wg.gui.battle.ranked.stats.components.fullStats.tableItem.StatsTableItem;
   import net.wg.gui.battle.ranked.stats.components.fullStats.tableItem.StatsTableItemHolder;
   import net.wg.gui.battle.ranked.stats.components.playersPanel.list.PlayersPanelList;
   import net.wg.gui.battle.ranked.stats.components.playersPanel.list.PlayersPanelListItem;
   import net.wg.gui.battle.ranked.stats.components.playersPanel.list.PlayersPanelListItemHolder;
   import net.wg.gui.battle.ranked.stats.components.playersPanel.list.PlayersPanelListLeft;
   import net.wg.gui.battle.ranked.stats.components.playersPanel.list.PlayersPanelListRight;
   import net.wg.gui.battle.views.BaseBattlePage;
   import net.wg.gui.battle.views.BattlePageQuestsProgress;
   import net.wg.gui.battle.views.actionMarkers.ActionMarkerStates;
   import net.wg.gui.battle.views.actionMarkers.BaseActionMarker;
   import net.wg.gui.battle.views.actionMarkers.RepliedMarker;
   import net.wg.gui.battle.views.actionMarkers.RepliedMarkerIcon;
   import net.wg.gui.battle.views.actionMarkers.StickyMarker;
   import net.wg.gui.battle.views.ammunitionPanel.EpicRespawnAmmunitionPanelView;
   import net.wg.gui.battle.views.ammunitionPanel.PrbAmmunitionPanelEvent;
   import net.wg.gui.battle.views.ammunitionPanel.PrebattleAmmunitionPanelView;
   import net.wg.gui.battle.views.battleEndWarning.BattleEndWarningPanel;
   import net.wg.gui.battle.views.battleEndWarning.EndWarningPanelEvent;
   import net.wg.gui.battle.views.battleEndWarning.containers.Timer;
   import net.wg.gui.battle.views.battleLevelPanel.BattleLevelPanel;
   import net.wg.gui.battle.views.battleLevelPanel.BattleLevelPanelData;
   import net.wg.gui.battle.views.battleLevelPanel.ExperienceDiffAnimation;
   import net.wg.gui.battle.views.battleLevelPanel.ProgressDeltaAnimation;
   import net.wg.gui.battle.views.battleLevelPanel.ProgressIndicator;
   import net.wg.gui.battle.views.battleLevelPanel.TextAnimation;
   import net.wg.gui.battle.views.battleMessenger.BattleImageSubstitution;
   import net.wg.gui.battle.views.battleMessenger.BattleMessage;
   import net.wg.gui.battle.views.battleMessenger.BattleMessenger;
   import net.wg.gui.battle.views.battleMessenger.BattleMessengerPool;
   import net.wg.gui.battle.views.battleMessenger.BattleSmileyMap;
   import net.wg.gui.battle.views.battleMessenger.VO.BattleMessengerReceiverVO;
   import net.wg.gui.battle.views.battleMessenger.VO.BattleMessengerSettingsVO;
   import net.wg.gui.battle.views.battleMessenger.VO.BattleMessengerToxicVO;
   import net.wg.gui.battle.views.battleMessenger.VO.ButtonToxicStatusVO;
   import net.wg.gui.battle.views.battleMessenger.actionPanel.BattleMessengerActionContainer;
   import net.wg.gui.battle.views.battleMessenger.interfaces.IBattleMessenger;
   import net.wg.gui.battle.views.battleNotifier.BattleNotifier;
   import net.wg.gui.battle.views.battleTankCarousel.BattleCarouselEnvironment;
   import net.wg.gui.battle.views.battleTankCarousel.BattleTankCarousel;
   import net.wg.gui.battle.views.battleTankCarousel.BattleTankCarouselFilters;
   import net.wg.gui.battle.views.battleTankCarousel.data.BattleVehicleCarouselVO;
   import net.wg.gui.battle.views.battleTankCarousel.renderers.BaseBattleTankIcon;
   import net.wg.gui.battle.views.battleTankCarousel.renderers.BattleTankCarouselItemRenderer;
   import net.wg.gui.battle.views.battleTimer.BaseBattleTimer;
   import net.wg.gui.battle.views.battleTimer.BattleAnimationTimer;
   import net.wg.gui.battle.views.battleTimer.BattleTimer;
   import net.wg.gui.battle.views.battleTimer.EpicBattleTimer;
   import net.wg.gui.battle.views.battleTimer.TimerDisplay;
   import net.wg.gui.battle.views.calloutPanel.CalloutPanel;
   import net.wg.gui.battle.views.calloutPanel.components.InteractionDynamicTextLabel;
   import net.wg.gui.battle.views.calloutPanel.components.VehicleInfoLabel;
   import net.wg.gui.battle.views.consumablesPanel.BattleAbilityEquipmentButton;
   import net.wg.gui.battle.views.consumablesPanel.BattleAbilityEquipmentButtonGlow;
   import net.wg.gui.battle.views.consumablesPanel.BattleEquipmentButton;
   import net.wg.gui.battle.views.consumablesPanel.BattleEquipmentButtonGlow;
   import net.wg.gui.battle.views.consumablesPanel.BattleOptionalDeviceButton;
   import net.wg.gui.battle.views.consumablesPanel.BattleShellButton;
   import net.wg.gui.battle.views.consumablesPanel.ConsumablesPanel;
   import net.wg.gui.battle.views.consumablesPanel.EntitiesStatePopup;
   import net.wg.gui.battle.views.consumablesPanel.EntityStateButton;
   import net.wg.gui.battle.views.consumablesPanel.VO.ConsumablesVO;
   import net.wg.gui.battle.views.consumablesPanel.constants.COLOR_STATES;
   import net.wg.gui.battle.views.consumablesPanel.events.ConsumablesButtonEvent;
   import net.wg.gui.battle.views.consumablesPanel.events.ConsumablesPanelEvent;
   import net.wg.gui.battle.views.consumablesPanel.interfaces.IBattleEquipmentButtonGlow;
   import net.wg.gui.battle.views.consumablesPanel.interfaces.IBattleOptionalDeviceButton;
   import net.wg.gui.battle.views.consumablesPanel.interfaces.IBattleShellButton;
   import net.wg.gui.battle.views.consumablesPanel.interfaces.IConsumablesButton;
   import net.wg.gui.battle.views.consumablesPanel.interfaces.IConsumablesPanel;
   import net.wg.gui.battle.views.consumablesPanel.interfaces.IEntityStateButton;
   import net.wg.gui.battle.views.cosmicHud.CosmicHud;
   import net.wg.gui.battle.views.damageIndicator.DamageIndicator;
   import net.wg.gui.battle.views.damageInfoPanel.DamageInfoPanel;
   import net.wg.gui.battle.views.damageInfoPanel.components.DamageItem;
   import net.wg.gui.battle.views.damageInfoPanel.components.Fire;
   import net.wg.gui.battle.views.damageInfoPanel.components.TrackDamageItem;
   import net.wg.gui.battle.views.damagePanel.DamagePanel;
   import net.wg.gui.battle.views.damagePanel.VO.DamagePanelTooltipVO;
   import net.wg.gui.battle.views.damagePanel.VO.ItemStates;
   import net.wg.gui.battle.views.damagePanel.VO.TankIndicatorItem;
   import net.wg.gui.battle.views.damagePanel.VO.TooltipStringByItemStateVO;
   import net.wg.gui.battle.views.damagePanel.components.DamagePanelItemClickArea;
   import net.wg.gui.battle.views.damagePanel.components.DamagePanelItemFrameStates;
   import net.wg.gui.battle.views.damagePanel.components.FireIndicator;
   import net.wg.gui.battle.views.damagePanel.components.HealthBar;
   import net.wg.gui.battle.views.damagePanel.components.modules.ModuleAssets;
   import net.wg.gui.battle.views.damagePanel.components.modules.ModuleRepairAnim;
   import net.wg.gui.battle.views.damagePanel.components.modules.ModuleWarningAnim;
   import net.wg.gui.battle.views.damagePanel.components.modules.ModulesCtrl;
   import net.wg.gui.battle.views.damagePanel.components.modules.chassis.MultitrackChassisState;
   import net.wg.gui.battle.views.damagePanel.components.modules.chassis.PartState;
   import net.wg.gui.battle.views.damagePanel.components.modules.chassis.YohChassisState;
   import net.wg.gui.battle.views.damagePanel.components.statusIndicator.StatusArrow;
   import net.wg.gui.battle.views.damagePanel.components.stunIndicator.StunArrow;
   import net.wg.gui.battle.views.damagePanel.components.stunIndicator.StunCounter;
   import net.wg.gui.battle.views.damagePanel.components.tankIndicator.ItemWithModules;
   import net.wg.gui.battle.views.damagePanel.components.tankIndicator.SPGRotator;
   import net.wg.gui.battle.views.damagePanel.components.tankIndicator.TankIndicator;
   import net.wg.gui.battle.views.damagePanel.components.tankIndicator.TankRotator;
   import net.wg.gui.battle.views.damagePanel.components.tankIndicator.VehicleTurret;
   import net.wg.gui.battle.views.damagePanel.components.tankIndicator.Wheel;
   import net.wg.gui.battle.views.damagePanel.components.tankIndicator.WheelRotator;
   import net.wg.gui.battle.views.damagePanel.components.tankIndicator.WheelTurret;
   import net.wg.gui.battle.views.damagePanel.components.tankman.TankmanAssets;
   import net.wg.gui.battle.views.damagePanel.components.tankman.TankmanDumper;
   import net.wg.gui.battle.views.damagePanel.components.tankman.TankmanIdentifiers;
   import net.wg.gui.battle.views.damagePanel.components.tankman.TankmenCtrl;
   import net.wg.gui.battle.views.damagePanel.interfaces.IAssetCreator;
   import net.wg.gui.battle.views.damagePanel.interfaces.IDamagePanelClickableItem;
   import net.wg.gui.battle.views.damagePanel.interfaces.IDamagePanelItemsCtrl;
   import net.wg.gui.battle.views.debugPanel.DebugPanel;
   import net.wg.gui.battle.views.destroyTimers.DestroyTimer;
   import net.wg.gui.battle.views.destroyTimers.EpicDestroyTimersPanel;
   import net.wg.gui.battle.views.destroyTimers.EventDestroyTimersPanel;
   import net.wg.gui.battle.views.destroyTimers.PoiMainTimer;
   import net.wg.gui.battle.views.destroyTimers.PoiSecondaryTimer;
   import net.wg.gui.battle.views.destroyTimers.PoiTimer;
   import net.wg.gui.battle.views.destroyTimers.ResupplyTimer;
   import net.wg.gui.battle.views.destroyTimers.SecondaryTimer;
   import net.wg.gui.battle.views.destroyTimers.SecondaryTimerBase;
   import net.wg.gui.battle.views.destroyTimers.StatusNotificationTimer;
   import net.wg.gui.battle.views.destroyTimers.components.CircleProgressBar;
   import net.wg.gui.battle.views.destroyTimers.components.SecondaryTimerContainer;
   import net.wg.gui.battle.views.destroyTimers.components.SecondaryTimerSetting;
   import net.wg.gui.battle.views.destroyTimers.components.TimerContainer;
   import net.wg.gui.battle.views.destroyTimers.components.secondaryTimerFx.ISecondaryTimerFX;
   import net.wg.gui.battle.views.destroyTimers.components.secondaryTimerFx.MultipleHitFXAnimation;
   import net.wg.gui.battle.views.destroyTimers.components.secondaryTimerFx.SecondaryTimerFXAnimation;
   import net.wg.gui.battle.views.destroyTimers.components.secondaryTimerFx.SecondaryTimerFXContainer;
   import net.wg.gui.battle.views.destroyTimers.components.secondaryTimerFx.StunTimerFX;
   import net.wg.gui.battle.views.destroyTimers.data.NotificationTimerSettingVO;
   import net.wg.gui.battle.views.destroyTimers.data.StatusNotificationVO;
   import net.wg.gui.battle.views.destroyTimers.data.StatusNotificationsPanelInitVO;
   import net.wg.gui.battle.views.destroyTimers.data.TimersPanelInitVO;
   import net.wg.gui.battle.views.destroyTimers.events.DestroyTimerEvent;
   import net.wg.gui.battle.views.directionIndicator.ArtyDirectionIndicator;
   import net.wg.gui.battle.views.directionIndicator.BaseValueIndicator;
   import net.wg.gui.battle.views.directionIndicator.DirectionIndicator;
   import net.wg.gui.battle.views.directionIndicator.DirectionIndicatorImage;
   import net.wg.gui.battle.views.directionIndicator.DirectionIndicatorShape;
   import net.wg.gui.battle.views.directionIndicator.DirnIndicatorDistance;
   import net.wg.gui.battle.views.dualGunPanel.DualGunBulletState;
   import net.wg.gui.battle.views.dualGunPanel.DualGunChangingProgressIndicator;
   import net.wg.gui.battle.views.dualGunPanel.DualGunPanel;
   import net.wg.gui.battle.views.dualGunPanel.DualGunPanelGunIndicator;
   import net.wg.gui.battle.views.dualGunPanel.DualGunPanelState;
   import net.wg.gui.battle.views.dualGunPanel.DualGunPanelTimer;
   import net.wg.gui.battle.views.epicDamagePanel.EpicDamagePanel;
   import net.wg.gui.battle.views.epicDamagePanel.components.GeneralBonus;
   import net.wg.gui.battle.views.epicDeploymentMap.EpicDeploymentMap;
   import net.wg.gui.battle.views.epicDeploymentMap.components.EpicDeploymentMapEntriesContainer;
   import net.wg.gui.battle.views.epicDeploymentMap.components.EpicMapContainer;
   import net.wg.gui.battle.views.epicDeploymentMap.constants.DeploymentMapConstants;
   import net.wg.gui.battle.views.epicDeploymentMap.events.EpicDeploymentMapEvent;
   import net.wg.gui.battle.views.epicInGameRank.EpicInGameRankAnimatedProgress;
   import net.wg.gui.battle.views.epicInGameRank.EpicInGameRankIcon;
   import net.wg.gui.battle.views.epicInGameRank.EpicInGameRankPanel;
   import net.wg.gui.battle.views.epicInGameRank.data.EpicInGameRankVO;
   import net.wg.gui.battle.views.epicInGameRank.events.EpicInGameRankEvent;
   import net.wg.gui.battle.views.epicMessagesPanel.EpicMessagesPanel;
   import net.wg.gui.battle.views.epicMessagesPanel.components.BaseCaptureMessage;
   import net.wg.gui.battle.views.epicMessagesPanel.components.BaseContestedMessage;
   import net.wg.gui.battle.views.epicMessagesPanel.components.FirstGeneralRankReachedMessage;
   import net.wg.gui.battle.views.epicMessagesPanel.components.HeadquarterAttackedMessage;
   import net.wg.gui.battle.views.epicMessagesPanel.components.HeadquarterDestroyedMessage;
   import net.wg.gui.battle.views.epicMessagesPanel.components.MessageBaseMarker;
   import net.wg.gui.battle.views.epicMessagesPanel.components.MessageHQMarker;
   import net.wg.gui.battle.views.epicMessagesPanel.components.OverTimeMessage;
   import net.wg.gui.battle.views.epicMessagesPanel.components.RankUpMessage;
   import net.wg.gui.battle.views.epicMessagesPanel.components.RankUpSubElement;
   import net.wg.gui.battle.views.epicMessagesPanel.components.RetreatMessage;
   import net.wg.gui.battle.views.epicMessagesPanel.components.TimeRemainingMessage;
   import net.wg.gui.battle.views.epicMessagesPanel.components.UnlockTankLevelMessage;
   import net.wg.gui.battle.views.epicMessagesPanel.data.FirstGeneralRankReachedMessageVO;
   import net.wg.gui.battle.views.epicMessagesPanel.data.HeadquarterAttackedMessageVO;
   import net.wg.gui.battle.views.epicMessagesPanel.data.HeadquarterDestroyedMessageVO;
   import net.wg.gui.battle.views.epicMessagesPanel.data.MissionChangeMessageVO;
   import net.wg.gui.battle.views.epicMessagesPanel.data.OverTimeMessageVO;
   import net.wg.gui.battle.views.epicMessagesPanel.data.RankUpMessageVO;
   import net.wg.gui.battle.views.epicMessagesPanel.data.SectorBaseContestedMessageVO;
   import net.wg.gui.battle.views.epicMessagesPanel.data.SectorBaseMessageVO;
   import net.wg.gui.battle.views.epicMissionsPanel.EpicMissionsPanel;
   import net.wg.gui.battle.views.epicMissionsPanel.components.EpicMissionsAnimatedMarker;
   import net.wg.gui.battle.views.epicMissionsPanel.data.EpicMissionVO;
   import net.wg.gui.battle.views.epicOverviewMapScreen.EpicOverviewMapScreen;
   import net.wg.gui.battle.views.epicOverviewMapScreen.data.EpicOverviewMapScreenVO;
   import net.wg.gui.battle.views.epicReinforcementPanel.EpicReinforcementPanel;
   import net.wg.gui.battle.views.epicRespawnView.EpicRespawnView;
   import net.wg.gui.battle.views.epicRespawnView.components.EpicRespawnDeployButtonGroup;
   import net.wg.gui.battle.views.epicRespawnView.components.EpicRespawnMapEntriesContainer;
   import net.wg.gui.battle.views.epicRespawnView.components.EpicRespawnPoint;
   import net.wg.gui.battle.views.epicRespawnView.data.RespawnPointVO;
   import net.wg.gui.battle.views.epicRespawnView.events.EpicRespawnEvent;
   import net.wg.gui.battle.views.epicScorePanel.EpicScorePanel;
   import net.wg.gui.battle.views.epicScorePanel.components.HeadquarterEntryAnimated;
   import net.wg.gui.battle.views.epicScorePanel.components.HeadquarterScoreEntry;
   import net.wg.gui.battle.views.epicScorePanel.components.SectorBaseEntryAnimated;
   import net.wg.gui.battle.views.epicScorePanel.components.SectorBaseScoreEntry;
   import net.wg.gui.battle.views.epicScorePanel.events.EpicScorePanelEvent;
   import net.wg.gui.battle.views.epicSpectatorView.EpicSpectatorView;
   import net.wg.gui.battle.views.gameMessagesPanel.GameMessagesPanel;
   import net.wg.gui.battle.views.gameMessagesPanel.components.EndGameMessage;
   import net.wg.gui.battle.views.gameMessagesPanel.components.EndGameMessageTextfields;
   import net.wg.gui.battle.views.gameMessagesPanel.components.MessageContainerBase;
   import net.wg.gui.battle.views.gameMessagesPanel.data.BaseGameMessageVO;
   import net.wg.gui.battle.views.gameMessagesPanel.data.EndGameMessageVO;
   import net.wg.gui.battle.views.gameMessagesPanel.data.GameMessageVO;
   import net.wg.gui.battle.views.gameMessagesPanel.events.GameMessagesPanelEvent;
   import net.wg.gui.battle.views.mapInfoTip.MapInfoTip;
   import net.wg.gui.battle.views.messages.FadedMessagesPool;
   import net.wg.gui.battle.views.messages.FadedTextMessage;
   import net.wg.gui.battle.views.messages.IMessage;
   import net.wg.gui.battle.views.messages.MessageList;
   import net.wg.gui.battle.views.messages.MessageListDAAPI;
   import net.wg.gui.battle.views.messages.VO.FadingMessageListSettingsVO;
   import net.wg.gui.battle.views.messages.VO.MessageListSettingsVO;
   import net.wg.gui.battle.views.messages.VO.PoolSettingsVO;
   import net.wg.gui.battle.views.messages.components.TextMessageRenderer;
   import net.wg.gui.battle.views.messages.events.MessageEvent;
   import net.wg.gui.battle.views.messages.interfaces.IMessageList;
   import net.wg.gui.battle.views.minimap.BaseMinimap;
   import net.wg.gui.battle.views.minimap.EpicMinimap;
   import net.wg.gui.battle.views.minimap.Minimap;
   import net.wg.gui.battle.views.minimap.MinimapEntryController;
   import net.wg.gui.battle.views.minimap.MinimapHint;
   import net.wg.gui.battle.views.minimap.MinimapHintIconInfo;
   import net.wg.gui.battle.views.minimap.MinimapIconCollection;
   import net.wg.gui.battle.views.minimap.ScenarioLayer;
   import net.wg.gui.battle.views.minimap.components.entries.arty.ArtyHitDotMarker;
   import net.wg.gui.battle.views.minimap.components.entries.arty.ArtyMarkerMinimapEntry;
   import net.wg.gui.battle.views.minimap.components.entries.background.BootcampTargetMinimapEntry;
   import net.wg.gui.battle.views.minimap.components.entries.battleRoyale.BRMarker;
   import net.wg.gui.battle.views.minimap.components.entries.battleRoyale.DeathZoneMinimapEntry;
   import net.wg.gui.battle.views.minimap.components.entries.battleRoyale.DiscoveredItemMarker;
   import net.wg.gui.battle.views.minimap.components.entries.battleRoyale.RadarAnimation;
   import net.wg.gui.battle.views.minimap.components.entries.comp7.Comp7PointReconMinimapEntry;
   import net.wg.gui.battle.views.minimap.components.entries.constants.AbsorptionFlagEntryConst;
   import net.wg.gui.battle.views.minimap.components.entries.constants.BackgroundMinimapEntryConst;
   import net.wg.gui.battle.views.minimap.components.entries.constants.EpicMinimapEntryConst;
   import net.wg.gui.battle.views.minimap.components.entries.constants.FlagMinimapEntryConst;
   import net.wg.gui.battle.views.minimap.components.entries.constants.FortConsumablesMinimapEntryConst;
   import net.wg.gui.battle.views.minimap.components.entries.constants.PersonalMinimapEntryConst;
   import net.wg.gui.battle.views.minimap.components.entries.constants.PointsOfInterestMinimapEntryConst;
   import net.wg.gui.battle.views.minimap.components.entries.constants.RepairMinimapEntryConst;
   import net.wg.gui.battle.views.minimap.components.entries.constants.ScenarioMinimapEntryConst;
   import net.wg.gui.battle.views.minimap.components.entries.constants.TeamBaseMinimapEntryConst;
   import net.wg.gui.battle.views.minimap.components.entries.constants.VehicleMinimapEntryConst;
   import net.wg.gui.battle.views.minimap.components.entries.epic.FrontLinePointEntry;
   import net.wg.gui.battle.views.minimap.components.entries.epic.HeadquarterMinimapEntry;
   import net.wg.gui.battle.views.minimap.components.entries.epic.LandingZoneMinimapEntry;
   import net.wg.gui.battle.views.minimap.components.entries.epic.ReconMinimapEntry;
   import net.wg.gui.battle.views.minimap.components.entries.epic.ResupplyMinimapEntry;
   import net.wg.gui.battle.views.minimap.components.entries.epic.SectorBaseMinimapEntry;
   import net.wg.gui.battle.views.minimap.components.entries.epic.SectorMinimapEntry;
   import net.wg.gui.battle.views.minimap.components.entries.epic.SectorOverlayMinimapEntry;
   import net.wg.gui.battle.views.minimap.components.entries.fortconsumables.AOEArtilleryMinimapEntry;
   import net.wg.gui.battle.views.minimap.components.entries.fortconsumables.ArtilleryMinimapEntry;
   import net.wg.gui.battle.views.minimap.components.entries.fortconsumables.ArtilleryYellowMinimapEntry;
   import net.wg.gui.battle.views.minimap.components.entries.fortconsumables.BomberMinimapEntry;
   import net.wg.gui.battle.views.minimap.components.entries.fortconsumables.SmokeMinimapEntry;
   import net.wg.gui.battle.views.minimap.components.entries.interfaces.IHighlightableMinimapEntry;
   import net.wg.gui.battle.views.minimap.components.entries.interfaces.IMinimapEntryWithNonScaleContent;
   import net.wg.gui.battle.views.minimap.components.entries.interfaces.IVehicleMinimapEntry;
   import net.wg.gui.battle.views.minimap.components.entries.personal.AnimationMinimapEntry;
   import net.wg.gui.battle.views.minimap.components.entries.personal.DeadPointMinimapEntry;
   import net.wg.gui.battle.views.minimap.components.entries.personal.DirectionMinimapEntry;
   import net.wg.gui.battle.views.minimap.components.entries.personal.DistanceDrawer;
   import net.wg.gui.battle.views.minimap.components.entries.personal.PingFlashMinimapEntry;
   import net.wg.gui.battle.views.minimap.components.entries.personal.RectangleAreaMinimapEntry;
   import net.wg.gui.battle.views.minimap.components.entries.personal.SimpleAttentionToFlashMinimapEntry;
   import net.wg.gui.battle.views.minimap.components.entries.personal.VideoCameraMinimapEntry;
   import net.wg.gui.battle.views.minimap.components.entries.personal.ViewPointMinimapEntry;
   import net.wg.gui.battle.views.minimap.components.entries.personal.ViewRangeCirclesMinimapEntry;
   import net.wg.gui.battle.views.minimap.components.entries.personal.ViewRangeSectorMinimapEntry;
   import net.wg.gui.battle.views.minimap.components.entries.pointsOfInterest.MinimapPoiProgressCircle;
   import net.wg.gui.battle.views.minimap.components.entries.pointsOfInterest.PoiMinimapEntry;
   import net.wg.gui.battle.views.minimap.components.entries.scenario.ScenarioMinimapEntry;
   import net.wg.gui.battle.views.minimap.components.entries.scenario.ScenarioMinimapProgressCircle;
   import net.wg.gui.battle.views.minimap.components.entries.teambase.AllyTeamBaseMinimapEntry;
   import net.wg.gui.battle.views.minimap.components.entries.teambase.AllyTeamSpawnMinimapEntry;
   import net.wg.gui.battle.views.minimap.components.entries.teambase.ControlPointMinimapEntry;
   import net.wg.gui.battle.views.minimap.components.entries.teambase.EnemyTeamBaseMinimapEntry;
   import net.wg.gui.battle.views.minimap.components.entries.teambase.EnemyTeamSpawnMinimapEntry;
   import net.wg.gui.battle.views.minimap.components.entries.teambase.MinimapProgressCircle;
   import net.wg.gui.battle.views.minimap.components.entries.vehicle.MarkerTopAnimation;
   import net.wg.gui.battle.views.minimap.components.entries.vehicle.MinimapEntryLabelHelper;
   import net.wg.gui.battle.views.minimap.components.entries.vehicle.VehicleAnimationMinimapEntry;
   import net.wg.gui.battle.views.minimap.components.entries.vehicle.VehicleMinimapEntry;
   import net.wg.gui.battle.views.minimap.constants.MinimapColorConst;
   import net.wg.gui.battle.views.minimap.constants.MinimapSizeConst;
   import net.wg.gui.battle.views.minimap.containers.EpicMinimapEntriesContainer;
   import net.wg.gui.battle.views.minimap.containers.MinimapEntriesContainer;
   import net.wg.gui.battle.views.minimap.events.MinimapEvent;
   import net.wg.gui.battle.views.perksPanel.PerksPanel;
   import net.wg.gui.battle.views.perksPanel.components.PerkItem;
   import net.wg.gui.battle.views.perksPanel.data.PerkItemVO;
   import net.wg.gui.battle.views.perksPanel.events.PerkItemEvent;
   import net.wg.gui.battle.views.personalReservesTab.PersonalReservesTab;
   import net.wg.gui.battle.views.piercingDebugPanel.PiercingDebugPanel;
   import net.wg.gui.battle.views.piercingDebugPanel.PiercingDebugRenderer;
   import net.wg.gui.battle.views.piercingDebugPanel.data.DebugPanelVO;
   import net.wg.gui.battle.views.piercingDebugPanel.data.PiercingItemVO;
   import net.wg.gui.battle.views.postMortemTips.PostmortemTips;
   import net.wg.gui.battle.views.postmortemPanel.BasePostmortemPanel;
   import net.wg.gui.battle.views.postmortemPanel.IVehiclePanel;
   import net.wg.gui.battle.views.postmortemPanel.PostmortemPanel;
   import net.wg.gui.battle.views.postmortemPanel.VehiclePanel;
   import net.wg.gui.battle.views.prebattleInfo.PrebattleInfoContainer;
   import net.wg.gui.battle.views.prebattleInfo.PrebattleInfoViewBase;
   import net.wg.gui.battle.views.prebattleInfo.questInfo.QuestInfoFlag;
   import net.wg.gui.battle.views.prebattleInfo.questInfo.QuestInfoFlagBg;
   import net.wg.gui.battle.views.prebattleInfo.questInfo.QuestInfoFlagTaskIcoContainer;
   import net.wg.gui.battle.views.prebattleInfo.questInfo.QuestInfoFlagVO;
   import net.wg.gui.battle.views.prebattleTimer.PrebattleTimer;
   import net.wg.gui.battle.views.prebattleTimer.PrebattleTimerBase;
   import net.wg.gui.battle.views.prebattleTimer.PrebattleTimerBg;
   import net.wg.gui.battle.views.prebattleTimer.PrebattleTimerEvent;
   import net.wg.gui.battle.views.questProgress.QuestProgressAnimatedWrapper;
   import net.wg.gui.battle.views.questProgress.QuestProgressTabView;
   import net.wg.gui.battle.views.questProgress.QuestProgressTopView;
   import net.wg.gui.battle.views.questProgress.QuestProgressView;
   import net.wg.gui.battle.views.questProgress.animated.AnimIconContainer;
   import net.wg.gui.battle.views.questProgress.animated.AnimStepProgress;
   import net.wg.gui.battle.views.questProgress.animated.AnimValueContainer;
   import net.wg.gui.battle.views.questProgress.animated.AnimationItem;
   import net.wg.gui.battle.views.questProgress.animated.AnimationItemCompleted;
   import net.wg.gui.battle.views.questProgress.animated.AnimationItemFailed;
   import net.wg.gui.battle.views.questProgress.animated.AnimationItemProgress;
   import net.wg.gui.battle.views.questProgress.animated.AnimationRing;
   import net.wg.gui.battle.views.questProgress.animated.AnimationTopContainer;
   import net.wg.gui.battle.views.questProgress.animated.IAnimationTopContainer;
   import net.wg.gui.battle.views.questProgress.animated.IQueueAnimControllerItem;
   import net.wg.gui.battle.views.questProgress.animated.IQueueAnimProgressState;
   import net.wg.gui.battle.views.questProgress.animated.IQueueItem;
   import net.wg.gui.battle.views.questProgress.animated.QuestProgressQueueAnimAbstract;
   import net.wg.gui.battle.views.questProgress.animated.QuestProgressQueueStateAnim;
   import net.wg.gui.battle.views.questProgress.animated.UpdateViewDataQueueItem;
   import net.wg.gui.battle.views.questProgress.components.QPFlag;
   import net.wg.gui.battle.views.questProgress.components.QPLock;
   import net.wg.gui.battle.views.questProgress.components.QPLockLineAnimation;
   import net.wg.gui.battle.views.questProgress.components.QuestProgressTracking;
   import net.wg.gui.battle.views.questProgress.components.QuestTrackingButton;
   import net.wg.gui.battle.views.questProgress.components.QuestTrackingOnPause;
   import net.wg.gui.battle.views.questProgress.data.QPProgressTrackingVO;
   import net.wg.gui.battle.views.questProgress.data.QPTrackingDataItemVO;
   import net.wg.gui.battle.views.questProgress.data.QuestProgressPerformVO;
   import net.wg.gui.battle.views.questProgress.events.QuestProgressAnimatedWrapperEvent;
   import net.wg.gui.battle.views.questProgress.events.QuestProgressTabEvent;
   import net.wg.gui.battle.views.questProgress.helper.BattleQuestProgressConsts;
   import net.wg.gui.battle.views.questProgress.helper.QuestProgressTopViewItemsPos;
   import net.wg.gui.battle.views.questProgress.interfaces.IQuestProgressDataHub;
   import net.wg.gui.battle.views.questProgress.interfaces.IQuestProgressView;
   import net.wg.gui.battle.views.questProgress.interfaces.IQuestProgressViewOperationSelector;
   import net.wg.gui.battle.views.questProgress.interfaces.IQuestProgressViewUpdatable;
   import net.wg.gui.battle.views.radialMenu.RadialButton;
   import net.wg.gui.battle.views.radialMenu.RadialMenu;
   import net.wg.gui.battle.views.radialMenu.components.BackGround;
   import net.wg.gui.battle.views.radialMenu.components.Content;
   import net.wg.gui.battle.views.radialMenu.components.Icons;
   import net.wg.gui.battle.views.radialMenu.components.SectorHoveredWrapper;
   import net.wg.gui.battle.views.radialMenu.components.SectorWrapper;
   import net.wg.gui.battle.views.recoveryPanel.RecoveryHint;
   import net.wg.gui.battle.views.recoveryPanel.RecoveryPanel;
   import net.wg.gui.battle.views.ribbonsPanel.AnimationSet;
   import net.wg.gui.battle.views.ribbonsPanel.EfficiencyBonusAnimation;
   import net.wg.gui.battle.views.ribbonsPanel.RibbonCtrl;
   import net.wg.gui.battle.views.ribbonsPanel.RibbonQueue;
   import net.wg.gui.battle.views.ribbonsPanel.RibbonsPanel;
   import net.wg.gui.battle.views.ribbonsPanel.RibbonsPool;
   import net.wg.gui.battle.views.ribbonsPanel.data.RibbonAnimationStates;
   import net.wg.gui.battle.views.ribbonsPanel.data.RibbonQueueItem;
   import net.wg.gui.battle.views.rocketAcceleratorPanel.RocketAcceleratorPanel;
   import net.wg.gui.battle.views.roleDescription.RoleAction;
   import net.wg.gui.battle.views.roleDescription.RoleDescription;
   import net.wg.gui.battle.views.roleDescription.data.RoleActionVO;
   import net.wg.gui.battle.views.roleDescription.data.RoleDescriptionVO;
   import net.wg.gui.battle.views.siegeModePanel.SiegeModeAnimation;
   import net.wg.gui.battle.views.siegeModePanel.SiegeModePanel;
   import net.wg.gui.battle.views.siegeModePanel.TurboSiegeModeAnimation;
   import net.wg.gui.battle.views.siegeModePanel.YohChassisModeAnimation;
   import net.wg.gui.battle.views.sixthSense.SixthSense;
   import net.wg.gui.battle.views.staticMarkers.epic.ObjectiveIdReplyState;
   import net.wg.gui.battle.views.staticMarkers.epic.headquarter.HeadquarterActionMarker;
   import net.wg.gui.battle.views.staticMarkers.epic.headquarter.HeadquarterAnimation;
   import net.wg.gui.battle.views.staticMarkers.epic.headquarter.HeadquarterIcon;
   import net.wg.gui.battle.views.staticMarkers.epic.headquarter.HeadquarterLifeStates;
   import net.wg.gui.battle.views.staticMarkers.epic.headquarter.HeadquarterMarker;
   import net.wg.gui.battle.views.staticMarkers.epic.resupplyPoint.ResupplyIcon;
   import net.wg.gui.battle.views.staticMarkers.epic.resupplyPoint.ResupplyMarker;
   import net.wg.gui.battle.views.staticMarkers.epic.sectorWarning.SectorWarningMarker;
   import net.wg.gui.battle.views.staticMarkers.epic.sectorWaypoint.SectorWaypointIcon;
   import net.wg.gui.battle.views.staticMarkers.epic.sectorWaypoint.SectorWaypointMarker;
   import net.wg.gui.battle.views.staticMarkers.epic.sectorbase.SectorBaseActions;
   import net.wg.gui.battle.views.staticMarkers.epic.sectorbase.SectorBaseIcon;
   import net.wg.gui.battle.views.staticMarkers.epic.sectorbase.SectorBaseMarker;
   import net.wg.gui.battle.views.staticMarkers.flag.FlagIcon;
   import net.wg.gui.battle.views.staticMarkers.flag.FlagMarker;
   import net.wg.gui.battle.views.staticMarkers.flag.constant.FlagMarkerState;
   import net.wg.gui.battle.views.staticMarkers.interestPoint.InterestPointMarker;
   import net.wg.gui.battle.views.staticMarkers.interestPoint.MarkerPoiProgressCircle;
   import net.wg.gui.battle.views.staticMarkers.location.FlagLocationActionMarker;
   import net.wg.gui.battle.views.staticMarkers.location.LocationActionMarker;
   import net.wg.gui.battle.views.staticMarkers.location.LocationMarker;
   import net.wg.gui.battle.views.staticMarkers.repairPoint.RepairPointIcon;
   import net.wg.gui.battle.views.staticMarkers.repairPoint.RepairPointMarker;
   import net.wg.gui.battle.views.staticMarkers.safeZone.SafeZoneMarker;
   import net.wg.gui.battle.views.staticMarkers.scenario.ScenarioMarker;
   import net.wg.gui.battle.views.staticMarkers.scenario.ScenarioMarkerProgressCircle;
   import net.wg.gui.battle.views.stats.SpeakAnimation;
   import net.wg.gui.battle.views.stats.SquadTooltip;
   import net.wg.gui.battle.views.stats.StatsUserProps;
   import net.wg.gui.battle.views.stats.constants.DynamicSquadState;
   import net.wg.gui.battle.views.stats.constants.FullStatsValidationType;
   import net.wg.gui.battle.views.stats.constants.PlayerStatusSchemeName;
   import net.wg.gui.battle.views.stats.constants.SquadInvalidationType;
   import net.wg.gui.battle.views.stats.fullStats.DogTagCtrl;
   import net.wg.gui.battle.views.stats.fullStats.FullStatsTableBase;
   import net.wg.gui.battle.views.stats.fullStats.SquadInviteStatusView;
   import net.wg.gui.battle.views.stats.fullStats.StatsTableControllerBase;
   import net.wg.gui.battle.views.stats.fullStats.StatsTableItemBase;
   import net.wg.gui.battle.views.stats.fullStats.StatsTableItemCommon;
   import net.wg.gui.battle.views.stats.fullStats.StatsTableItemHolderBase;
   import net.wg.gui.battle.views.stats.fullStats.StatsTableItemHolderCommon;
   import net.wg.gui.battle.views.stats.fullStats.StatsTableItemPositionController;
   import net.wg.gui.battle.views.stats.fullStats.interfaces.IStatsTableItemHandler;
   import net.wg.gui.battle.views.stats.fullStats.interfaces.IStatsTableItemHolderBase;
   import net.wg.gui.battle.views.statsHint.StatsHint;
   import net.wg.gui.battle.views.superPlatoonPanel.SuperPlatoonPanel;
   import net.wg.gui.battle.views.superPlatoonPanel.components.PlatoonInvitePanel;
   import net.wg.gui.battle.views.superPlatoonPanel.components.PlatoonMembersPanel;
   import net.wg.gui.battle.views.superPlatoonPanel.list.PlatoonMemberListItemHolder;
   import net.wg.gui.battle.views.superPlatoonPanel.list.PlatoonPanelList;
   import net.wg.gui.battle.views.superPlatoonPanel.renderers.PlatoonInviteRenderer;
   import net.wg.gui.battle.views.superPlatoonPanel.renderers.PlatoonMemberListItemRenderer;
   import net.wg.gui.battle.views.superPlatoonPanel.renderers.PlayerInfoContainer;
   import net.wg.gui.battle.views.upgradePanel.BattleUpgradePanel;
   import net.wg.gui.battle.views.upgradePanel.NotificationBorderAnimation;
   import net.wg.gui.battle.views.upgradePanel.NotificationBorderContainer;
   import net.wg.gui.battle.views.upgradePanel.data.UpgradePanelVO;
   import net.wg.gui.battle.views.vehicleMarkers.ActionIconStateMarker;
   import net.wg.gui.battle.views.vehicleMarkers.AnimateExplosion;
   import net.wg.gui.battle.views.vehicleMarkers.BranderVehicle2dMarker;
   import net.wg.gui.battle.views.vehicleMarkers.Comp7VehicleMarker;
   import net.wg.gui.battle.views.vehicleMarkers.DamageLabel;
   import net.wg.gui.battle.views.vehicleMarkers.FlagContainer;
   import net.wg.gui.battle.views.vehicleMarkers.FortConsumablesMarker;
   import net.wg.gui.battle.views.vehicleMarkers.HPFieldContainer;
   import net.wg.gui.battle.views.vehicleMarkers.HealthBar;
   import net.wg.gui.battle.views.vehicleMarkers.HealthBarAnimatedLabel;
   import net.wg.gui.battle.views.vehicleMarkers.HealthBarAnimatedPart;
   import net.wg.gui.battle.views.vehicleMarkers.IMarkerManagerHandler;
   import net.wg.gui.battle.views.vehicleMarkers.IVehicleMarkerInvokable;
   import net.wg.gui.battle.views.vehicleMarkers.IVehicleMarkersManager;
   import net.wg.gui.battle.views.vehicleMarkers.StaticArtyMarker;
   import net.wg.gui.battle.views.vehicleMarkers.StaticObjectMarker;
   import net.wg.gui.battle.views.vehicleMarkers.TargetMarker;
   import net.wg.gui.battle.views.vehicleMarkers.VMAtlasItemName;
   import net.wg.gui.battle.views.vehicleMarkers.VO.CrossOffset;
   import net.wg.gui.battle.views.vehicleMarkers.VO.HPDisplayMode;
   import net.wg.gui.battle.views.vehicleMarkers.VO.VehicleMarkerFlags;
   import net.wg.gui.battle.views.vehicleMarkers.VO.VehicleMarkerPart;
   import net.wg.gui.battle.views.vehicleMarkers.VO.VehicleMarkerSettings;
   import net.wg.gui.battle.views.vehicleMarkers.VO.VehicleMarkerVO;
   import net.wg.gui.battle.views.vehicleMarkers.VehicleActionMarker;
   import net.wg.gui.battle.views.vehicleMarkers.VehicleDistance;
   import net.wg.gui.battle.views.vehicleMarkers.VehicleIconAnimation;
   import net.wg.gui.battle.views.vehicleMarkers.VehicleMarker;
   import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersConstants;
   import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersLinkages;
   import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersManager;
   import net.wg.gui.battle.views.vehicleMarkers.VehicleStatusContainerMarker;
   import net.wg.gui.battle.views.vehicleMarkers.events.StatusAnimationEvent;
   import net.wg.gui.battle.views.vehicleMarkers.events.TimelineEvent;
   import net.wg.gui.battle.views.vehicleMarkers.events.VehicleMarkersManagerEvent;
   import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.MarkerAssetContainer;
   import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.MarkerTimer;
   import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleAnimatedStatusBaseMarker;
   import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleBerserkerMarker;
   import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleEngineerEffectMarker;
   import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleFLBasicMarker;
   import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleInspireMarker;
   import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleInspireTargetMarker;
   import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleSpecialAbilityMarker;
   import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleStatusIconMarker;
   import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleStatusMarker;
   import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleStunMarker;
   import net.wg.gui.battle.views.vehicleMessages.VehicleMessage;
   import net.wg.gui.battle.views.vehicleMessages.VehicleMessages;
   import net.wg.gui.battle.views.vehicleMessages.VehicleMessagesPool;
   import net.wg.gui.battle.views.vehicleMessages.VehicleMessagesVoQueue;
   import net.wg.gui.battle.views.vehicleMessages.vo.VehicleMessageVO;
   import net.wg.gui.battle.windows.IngameDetailsHelpWindow;
   import net.wg.gui.battle.windows.IngameHelpWindow;
   import net.wg.gui.battle.windows.IngameMenu;
   import net.wg.gui.battle.windows.MapsTrainingIngameHelpWindow;
   import net.wg.gui.battle.windows.components.IngameDetailsRoleAction;
   import net.wg.gui.battle.windows.components.IngameDetailsRoleActionContainer;
   import net.wg.gui.battle.windows.vo.IngameDetailsPageVO;
   import net.wg.gui.battle.windows.vo.IngameDetailsRoleActionVO;
   import net.wg.gui.bootcamp.BCBattleEquipmentButton;
   import net.wg.gui.bootcamp.BCBattlePage;
   import net.wg.gui.bootcamp.BCFCVehicleMarker;
   import net.wg.gui.bootcamp.BCFragCorrelationBar;
   import net.wg.gui.bootcamp.BCHighlightsOverlay;
   import net.wg.gui.bootcamp.BCIntroFadeOut;
   import net.wg.gui.bootcamp.BCPrebattleTimer;
   import net.wg.gui.bootcamp.BCSecondaryHint;
   import net.wg.gui.bootcamp.BCVehicleMarkersList;
   import net.wg.gui.bootcamp.prebattleHints.BCPrebattleHints;
   import net.wg.gui.bootcamp.prebattleHints.controls.CrosshairContainer;
   import net.wg.gui.components.controls.ReadOnlyScrollingList;
   import net.wg.gui.components.hintPanel.HintPanel;
   import net.wg.gui.components.hintPanel.KeyViewer;
   import net.wg.gui.components.hintPanel.KeyViewerContainer;
   import net.wg.gui.components.hintPanel.KeyViewerContainerAnim;
   import net.wg.gui.components.hintPanel.KeyViewersList;
   import net.wg.gui.components.hintPanel.MessageAnim;
   import net.wg.gui.components.tooltips.inblocks.blocks.TextParameterWithIconBlock;
   import net.wg.gui.components.tooltips.inblocks.data.TextParameterWithIconVO;
   import net.wg.infrastructure.base.BaseBattleDAAPIComponent;
   import net.wg.infrastructure.helpers.statisticsDataController.BattleStatisticDataController;
   import net.wg.infrastructure.helpers.statisticsDataController.EpicBattleStatisticDataController;
   import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IBattleComponentDataController;
   import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IEpicBattleStatisticDataController;
   
   public class ClassManagerMeta
   {
      
      public static const NET_WG_DATA_CONSTANTS_BATTLESTATISTICSMODELSTATUS:Class = BattleStatisticsModelStatus;
      
      public static const NET_WG_DATA_CONSTANTS_FRAGCORRELATIONBARSTATUS:Class = FragCorrelationBarStatus;
      
      public static const NET_WG_DATA_CONSTANTS_INTERACTIVESTATES:Class = InteractiveStates;
      
      public static const NET_WG_DATA_CONSTANTS_INVALIDATIONTYPE:Class = InvalidationType;
      
      public static const NET_WG_DATA_CONSTANTS_INVITATIONSTATUS:Class = InvitationStatus;
      
      public static const NET_WG_DATA_CONSTANTS_PERSONALSTATUS:Class = PersonalStatus;
      
      public static const NET_WG_DATA_CONSTANTS_PLAYERSTATUS:Class = PlayerStatus;
      
      public static const NET_WG_DATA_CONSTANTS_STATISTICDATAFACADENAME:Class = StatisticDataFacadeName;
      
      public static const NET_WG_DATA_CONSTANTS_VEHICLESTATUS:Class = VehicleStatus;
      
      public static const NET_WG_DATA_CONSTANTS_GENERATED_ANIMATION_TYPES:Class = ANIMATION_TYPES;
      
      public static const NET_WG_DATA_CONSTANTS_GENERATED_BATTLE_CONSUMABLES_PANEL_TAGS:Class = BATTLE_CONSUMABLES_PANEL_TAGS;
      
      public static const NET_WG_DATA_CONSTANTS_GENERATED_BATTLE_CONTEXT_MENU_HANDLER_TYPE:Class = BATTLE_CONTEXT_MENU_HANDLER_TYPE;
      
      public static const NET_WG_DATA_CONSTANTS_GENERATED_BATTLE_DEVICES_REPAIR_MODES:Class = BATTLE_DEVICES_REPAIR_MODES;
      
      public static const NET_WG_DATA_CONSTANTS_GENERATED_BATTLE_ITEM_STATES:Class = BATTLE_ITEM_STATES;
      
      public static const NET_WG_DATA_CONSTANTS_GENERATED_BATTLE_MARKERS_CONSTS:Class = BATTLE_MARKERS_CONSTS;
      
      public static const NET_WG_DATA_CONSTANTS_GENERATED_BATTLE_MARKER_ABILITIES_CONSTS:Class = BATTLE_MARKER_ABILITIES_CONSTS;
      
      public static const NET_WG_DATA_CONSTANTS_GENERATED_BATTLE_MARKER_STATES:Class = BATTLE_MARKER_STATES;
      
      public static const NET_WG_DATA_CONSTANTS_GENERATED_BATTLE_MESSAGES_CONSTS:Class = BATTLE_MESSAGES_CONSTS;
      
      public static const NET_WG_DATA_CONSTANTS_GENERATED_BATTLE_MINIMAP_CONSTS:Class = BATTLE_MINIMAP_CONSTS;
      
      public static const NET_WG_DATA_CONSTANTS_GENERATED_BATTLE_NOTIFICATIONS_TIMER_COLORS:Class = BATTLE_NOTIFICATIONS_TIMER_COLORS;
      
      public static const NET_WG_DATA_CONSTANTS_GENERATED_BATTLE_NOTIFICATIONS_TIMER_LINKAGES:Class = BATTLE_NOTIFICATIONS_TIMER_LINKAGES;
      
      public static const NET_WG_DATA_CONSTANTS_GENERATED_BATTLE_NOTIFICATIONS_TIMER_TYPES:Class = BATTLE_NOTIFICATIONS_TIMER_TYPES;
      
      public static const NET_WG_DATA_CONSTANTS_GENERATED_BATTLE_ROYAL_CONSTS:Class = BATTLE_ROYAL_CONSTS;
      
      public static const NET_WG_DATA_CONSTANTS_GENERATED_BATTLE_SOUND:Class = BATTLE_SOUND;
      
      public static const NET_WG_DATA_CONSTANTS_GENERATED_BATTLE_TOP_HINT_CONSTS:Class = BATTLE_TOP_HINT_CONSTS;
      
      public static const NET_WG_DATA_CONSTANTS_GENERATED_BATTLE_TYPES:Class = BATTLE_TYPES;
      
      public static const NET_WG_DATA_CONSTANTS_GENERATED_BATTLE_VIEW_ALIASES:Class = BATTLE_VIEW_ALIASES;
      
      public static const NET_WG_DATA_CONSTANTS_GENERATED_COMP7_CONSTS:Class = COMP7_CONSTS;
      
      public static const NET_WG_DATA_CONSTANTS_GENERATED_CONSUMABLES_PANEL_SETTINGS:Class = CONSUMABLES_PANEL_SETTINGS;
      
      public static const NET_WG_DATA_CONSTANTS_GENERATED_CROSSHAIR_VIEW_ID:Class = CROSSHAIR_VIEW_ID;
      
      public static const NET_WG_DATA_CONSTANTS_GENERATED_DAMAGE_INFO_PANEL_CONSTS:Class = DAMAGE_INFO_PANEL_CONSTS;
      
      public static const NET_WG_DATA_CONSTANTS_GENERATED_EPIC_CONSTS:Class = EPIC_CONSTS;
      
      public static const NET_WG_DATA_CONSTANTS_GENERATED_GAME_MESSAGES_CONSTS:Class = GAME_MESSAGES_CONSTS;
      
      public static const NET_WG_DATA_CONSTANTS_GENERATED_INTERFACE_STATES:Class = INTERFACE_STATES;
      
      public static const NET_WG_DATA_CONSTANTS_GENERATED_KEYBOARD_KEYS:Class = KEYBOARD_KEYS;
      
      public static const NET_WG_DATA_CONSTANTS_GENERATED_PLAYERS_PANEL_STATE:Class = PLAYERS_PANEL_STATE;
      
      public static const NET_WG_DATA_CONSTANTS_GENERATED_POI_CONSTS:Class = POI_CONSTS;
      
      public static const NET_WG_DATA_CONSTANTS_GENERATED_PREBATTLE_TIMER:Class = PREBATTLE_TIMER;
      
      public static const NET_WG_DATA_CONSTANTS_GENERATED_QUEST_PROGRESS_BATTLE:Class = QUEST_PROGRESS_BATTLE;
      
      public static const NET_WG_DATA_CONSTANTS_GENERATED_RADIAL_MENU_CONSTS:Class = RADIAL_MENU_CONSTS;
      
      public static const NET_WG_DATA_CONSTANTS_GENERATED_ROCKET_ACCELERATOR_INDICATOR:Class = ROCKET_ACCELERATOR_INDICATOR;
      
      public static const NET_WG_DATA_CONSTANTS_GENERATED_SIEGE_MODE_CONSTS:Class = SIEGE_MODE_CONSTS;
      
      public static const NET_WG_DATA_VO_VEHICLESTATUSLIGHTVO:Class = VehicleStatusLightVO;
      
      public static const NET_WG_DATA_VO_DAAPI_DAAPIARENAHEADERINFOVO:Class = DAAPIArenaHeaderInfoVO;
      
      public static const NET_WG_DATA_VO_DAAPI_DAAPIARENAINFOVO:Class = DAAPIArenaInfoVO;
      
      public static const NET_WG_DATA_VO_DAAPI_DAAPIINVITATIONSTATUSVO:Class = DAAPIInvitationStatusVO;
      
      public static const NET_WG_DATA_VO_DAAPI_DAAPIPLAYERSTATUSVO:Class = DAAPIPlayerStatusVO;
      
      public static const NET_WG_DATA_VO_DAAPI_DAAPIQUESTSTATUSVO:Class = DAAPIQuestStatusVO;
      
      public static const NET_WG_DATA_VO_DAAPI_DAAPITOTALSTATSVO:Class = DAAPITotalStatsVO;
      
      public static const NET_WG_DATA_VO_DAAPI_DAAPITRIGGEREDCOMMANDSVO:Class = DAAPITriggeredCommandsVO;
      
      public static const NET_WG_DATA_VO_DAAPI_DAAPITRIGGEREDCOMMANDVO:Class = DAAPITriggeredCommandVO;
      
      public static const NET_WG_DATA_VO_DAAPI_DAAPIVEHICLEINFOVO:Class = DAAPIVehicleInfoVO;
      
      public static const NET_WG_DATA_VO_DAAPI_DAAPIVEHICLESDATAVO:Class = DAAPIVehiclesDataVO;
      
      public static const NET_WG_DATA_VO_DAAPI_DAAPIVEHICLESINVITATIONSTATUSVO:Class = DAAPIVehiclesInvitationStatusVO;
      
      public static const NET_WG_DATA_VO_DAAPI_DAAPIVEHICLESSTATSVO:Class = DAAPIVehiclesStatsVO;
      
      public static const NET_WG_DATA_VO_DAAPI_DAAPIVEHICLESTATSVO:Class = DAAPIVehicleStatsVO;
      
      public static const NET_WG_DATA_VO_DAAPI_DAAPIVEHICLESTATUSVO:Class = DAAPIVehicleStatusVO;
      
      public static const NET_WG_DATA_VO_DAAPI_DAAPIVEHICLESUSERTAGSVO:Class = DAAPIVehiclesUserTagsVO;
      
      public static const NET_WG_DATA_VO_DAAPI_DAAPIVEHICLEUSERTAGSVO:Class = DAAPIVehicleUserTagsVO;
      
      public static const NET_WG_GUI_BATTLE_CLASSICFULLSTATS:Class = ClassicFullStats;
      
      public static const NET_WG_GUI_BATTLE_STATSBASE:Class = StatsBase;
      
      public static const NET_WG_GUI_BATTLE_TABBEDFULLSTATS:Class = TabbedFullStats;
      
      public static const NET_WG_GUI_BATTLE_BATTLELOADING_BASEBATTLELOADING:Class = BaseBattleLoading;
      
      public static const NET_WG_GUI_BATTLE_BATTLELOADING_BASELOADINGFORM:Class = BaseLoadingForm;
      
      public static const NET_WG_GUI_BATTLE_BATTLELOADING_BATTLELOADING:Class = BattleLoading;
      
      public static const NET_WG_GUI_BATTLE_BATTLELOADING_BATTLELOADINGFORM:Class = BattleLoadingForm;
      
      public static const NET_WG_GUI_BATTLE_BATTLELOADING_BATTLELOADINGHELPER:Class = BattleLoadingHelper;
      
      public static const NET_WG_GUI_BATTLE_BATTLELOADING_CONSTANTS_PLAYERSTATUS:Class = PlayerStatus;
      
      public static const NET_WG_GUI_BATTLE_BATTLELOADING_CONSTANTS_VEHICLESTATUS:Class = VehicleStatus;
      
      public static const NET_WG_GUI_BATTLE_BATTLELOADING_CONSTANTS_VEHICLESTATUSSCHEMES:Class = VehicleStatusSchemes;
      
      public static const NET_WG_GUI_BATTLE_BATTLELOADING_DATA_VEHICLESDATAPROVIDER:Class = VehiclesDataProvider;
      
      public static const NET_WG_GUI_BATTLE_BATTLELOADING_INTERFACES_IVEHICLESDATAPROVIDER:Class = IVehiclesDataProvider;
      
      public static const NET_WG_GUI_BATTLE_BATTLELOADING_RENDERERS_BASEPLAYERITEMRENDERER:Class = BasePlayerItemRenderer;
      
      public static const NET_WG_GUI_BATTLE_BATTLELOADING_RENDERERS_BASERENDERERCONTAINER:Class = BaseRendererContainer;
      
      public static const NET_WG_GUI_BATTLE_BATTLELOADING_RENDERERS_IBATTLELOADINGRENDERER:Class = IBattleLoadingRenderer;
      
      public static const NET_WG_GUI_BATTLE_BATTLELOADING_RENDERERS_TABLEPLAYERITEMRENDERER:Class = TablePlayerItemRenderer;
      
      public static const NET_WG_GUI_BATTLE_BATTLELOADING_RENDERERS_TIPPLAYERITEMRENDERER:Class = TipPlayerItemRenderer;
      
      public static const NET_WG_GUI_BATTLE_BATTLELOADING_UTIL_BATTLELOADINGUTIL:Class = BattleLoadingUtil;
      
      public static const NET_WG_GUI_BATTLE_BATTLELOADING_VO_LOADINGFORMDISPLAYDATAVO:Class = LoadingFormDisplayDataVO;
      
      public static const NET_WG_GUI_BATTLE_BATTLELOADING_VO_VEHICLEDATATEAMVO:Class = VehicleDataTeamVO;
      
      public static const NET_WG_GUI_BATTLE_BATTLELOADING_VO_VEHICLEDATAVO:Class = VehicleDataVO;
      
      public static const NET_WG_GUI_BATTLE_BATTLELOADING_VO_VEHICLEINFOVO:Class = VehicleInfoVO;
      
      public static const NET_WG_GUI_BATTLE_BATTLELOADING_VO_VEHINFOWITHSORTEDIDTEAMVO:Class = VehInfoWithSortedIDTeamVO;
      
      public static const NET_WG_GUI_BATTLE_BATTLELOADING_VO_VEHINFOWITHSORTEDIDVO:Class = VehInfoWithSortedIDVO;
      
      public static const NET_WG_GUI_BATTLE_BATTLELOADING_VO_VEHSTATUSTEAMVO:Class = VehStatusTeamVO;
      
      public static const NET_WG_GUI_BATTLE_BATTLELOADING_VO_VEHSTATUSVO:Class = VehStatusVO;
      
      public static const NET_WG_GUI_BATTLE_BATTLELOADING_VO_VISUALTIPINFOVO:Class = VisualTipInfoVO;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_BATTLEROYALEPAGE:Class = BattleRoyalePage;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_RADARBUTTON:Class = RadarButton;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_DATA_BATTLEROYALEEVENTHEADERVO:Class = BattleRoyaleEventHeaderVO;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_DATA_BATTLEROYALEFULLSTATSVO:Class = BattleRoyaleFullStatsVO;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_DATA_DESCRIPTIONBLOCKWITHICONVO:Class = DescriptionBlockWithIconVO;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_DATA_RESPAWNMESSAGEVO:Class = RespawnMessageVO;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_DATA_VEHICLECOUNTERVO:Class = VehicleCounterVO;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_UB_UNBOUNDCONTAINER:Class = UnboundContainer;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_BATTLEROYALELOADING:Class = BattleRoyaleLoading;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_BATTLEROYALEPOSTMORTEMPANEL:Class = BattleRoyalePostmortemPanel;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_BATTLEROYALESCOREBAR:Class = BattleRoyaleScoreBar;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_BATTLEROYALETEAMPANEL:Class = BattleRoyaleTeamPanel;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_BATTLEROYALETEAMPANELLISTITEM:Class = BattleRoyaleTeamPanelListItem;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_BATTLEROYALEWINNERCONGRATS:Class = BattleRoyaleWinnerCongrats;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_COMPONENTS_BATTLEROYALECONSUMABLEBUTTON:Class = BattleRoyaleConsumableButton;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_COMPONENTS_BATTLEROYALECOUNTERTIMER:Class = BattleRoyaleCounterTimer;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_COMPONENTS_BATTLEROYALECOUNTERTIMERANIMATION:Class = BattleRoyaleCounterTimerAnimation;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_COMPONENTS_BATTLEROYALECOUNTERTIMERCONTAINER:Class = BattleRoyaleCounterTimerContainer;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_COMPONENTS_BATTLEROYALEICONCONTENT:Class = BattleRoyaleIconContent;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_COMPONENTS_BATTLEROYALETIMER:Class = BattleRoyaleTimer;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_COMPONENTS_BATTLEROYALETIMERCONTAINER:Class = BattleRoyaleTimerContainer;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_COMPONENTS_BATTLEROYALETIMERCOUNTERCONTAINER:Class = BattleRoyaleTimerCounterContainer;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_COMPONENTS_BATTLEROYALEWINNERCONGRATSANIMATION:Class = BattleRoyaleWinnerCongratsAnimation;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_COMPONENTS_BRZONEDAMAGEICONCONTENT:Class = BRZoneDamageIconContent;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_COMPONENTS_CORRODINGSHOTINDICATOR:Class = CorrodingShotIndicator;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_COMPONENTS_DAMAGESCREEN:Class = DamageScreen;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_COMPONENTS_EVENTVIEWHEADER:Class = EventViewHeader;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_COMPONENTS_FULLSTATS_BATTLEROYALEFULLSTATS:Class = BattleRoyaleFullStats;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_COMPONENTS_FULLSTATS_DESCRIPTIONWITHICONRENDERER:Class = DescriptionWithIconRenderer;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_COMPONENTS_FULLSTATS_DESCRIPTIONWITHICONRENDERERSMALL:Class = DescriptionWithIconRendererSmall;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_COMPONENTS_FULLSTATS_MINIMAPITEMSINFO:Class = MinimapItemsInfo;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_COMPONENTS_FULLSTATS_SCOREBLOCK:Class = ScoreBlock;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_COMPONENTS_FULLSTATS_VEHICLECOUNTER:Class = VehicleCounter;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_COMPONENTS_FULLSTATS_NATIONSVEHICLESCOUNTER_BATTLEROYALENATIONSVEHICLESCOUNTER:Class = BattleRoyaleNationsVehiclesCounter;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_COMPONENTS_FULLSTATS_NATIONSVEHICLESCOUNTER_BATTLEROYALENATIONSVEHICLESRENDERER:Class = BattleRoyaleNationsVehiclesRenderer;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_COMPONENTS_FULLSTATS_NATIONSVEHICLESCOUNTER_BATTLEROYALEPLATOONRENDERER:Class = BattleRoyalePlatoonRenderer;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_COMPONENTS_FULLSTATS_NATIONSVEHICLESCOUNTER_DATA_BATTLEROYALENATIONSVEHICLESCOUNTERVO:Class = BattleRoyaleNationsVehiclesCounterVO;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_COMPONENTS_FULLSTATS_NATIONSVEHICLESCOUNTER_DATA_BATTLEROYALENATIONSVEHICLESVO:Class = BattleRoyaleNationsVehiclesVO;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_COMPONENTS_FULLSTATS_NATIONSVEHICLESCOUNTER_DATA_BATTLEROYALEPLATOONVO:Class = BattleRoyalePlatoonVO;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_COMPONENTS_RESPAWNBUTTON_BATTLEROYALERESPAWNBUTTON:Class = BattleRoyaleRespawnButton;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_COMPONENTS_RESPAWNBUTTON_RESPAWNICON:Class = RespawnIcon;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_COMPONENTS_RESPAWNMESSAGES_BASERESPAWNMESSAGE:Class = BaseRespawnMessage;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_COMPONENTS_RESPAWNMESSAGES_IRESPAWNMESSAGE:Class = IRespawnMessage;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_COMPONENTS_RESPAWNMESSAGES_RESPAWNMESSAGEPANEL:Class = RespawnMessagePanel;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_COMPONENTS_RESPAWNMESSAGES_RESPAWNMESSAGETIMER:Class = RespawnMessageTimer;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_COMPONENTS_RESPAWNMESSAGES_RESPAWNMESSAGEWITHDESCRIPTION:Class = RespawnMessageWithDescription;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_COMPONENTS_TIMERSPANEL_AIRDROPTIMER:Class = AirDropTimer;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_COMPONENTS_TIMERSPANEL_BATTLEROYALETIMERSPANEL:Class = BattleRoyaleTimersPanel;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_COMPONENTS_TIMERSPANEL_RESPAWNTIMER:Class = RespawnTimer;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_COMPONENTS_TIMERSPANEL_TIMERTEXTFIELD:Class = TimerTextField;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_CONFIGURATOR_BATTLEVEHICLECONFIGURATOR:Class = BattleVehicleConfigurator;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_CONFIGURATOR_CHOICEINFOPANEL:Class = ChoiceInfoPanel;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_CONFIGURATOR_CONFIGURATORRENDERER:Class = ConfiguratorRenderer;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_CONFIGURATOR_MODULEINFO:Class = ModuleInfo;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_CONFIGURATOR_MODULEINFOPANEL:Class = ModuleInfoPanel;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_CONFIGURATOR_DATA_BATTLEVEHICLECONFIGURATORVO:Class = BattleVehicleConfiguratorVO;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_CONFIGURATOR_DATA_CHOICEINFOPANELVO:Class = ChoiceInfoPanelVO;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_CONFIGURATOR_DATA_MODULEINFOVO:Class = ModuleInfoVO;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_CONFIGURATOR_DATA_MODULEPARAMETERVO:Class = ModuleParameterVO;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_PLAYERSPANEL_BATTLEROYALEPLAYERSPANEL:Class = BattleRoyalePlayersPanel;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_PLAYERSPANEL_PLAYERDATAVO:Class = PlayerDataVO;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_PLAYERSPANEL_PLAYERSPANELITEMRENDERER:Class = PlayersPanelItemRenderer;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_PLAYERSTATS_BATTLEROYALEPLAYERSTATRENDERER:Class = BattleRoyalePlayerStatRenderer;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_PLAYERSTATS_BATTLEROYALEPLAYERSTATS:Class = BattleRoyalePlayerStats;
      
      public static const NET_WG_GUI_BATTLE_BATTLEROYALE_VIEWS_PLAYERSTATS_BATTLEROYALEPLAYERSTATVO:Class = BattleRoyalePlayerStatVO;
      
      public static const NET_WG_GUI_BATTLE_COMP7_COMP7BATTLEPAGE:Class = Comp7BattlePage;
      
      public static const NET_WG_GUI_BATTLE_COMP7_COMP7HELPCTRL:Class = Comp7HelpCtrl;
      
      public static const NET_WG_GUI_BATTLE_COMP7_BATTLELOADING_COMP7BATTLELOADING:Class = Comp7BattleLoading;
      
      public static const NET_WG_GUI_BATTLE_COMP7_BATTLELOADING_COMP7BATTLELOADINGFORM:Class = Comp7BattleLoadingForm;
      
      public static const NET_WG_GUI_BATTLE_COMP7_BATTLELOADING_RENDERERS_COMP7RENDERERCONTAINER:Class = Comp7RendererContainer;
      
      public static const NET_WG_GUI_BATTLE_COMP7_BATTLELOADING_RENDERERS_COMP7TIPPLAYERITEMRENDERER:Class = Comp7TipPlayerItemRenderer;
      
      public static const NET_WG_GUI_BATTLE_COMP7_INFRASTRUCTURE_COMP7STATISTICSDATACONTROLLER:Class = Comp7StatisticsDataController;
      
      public static const NET_WG_GUI_BATTLE_COMP7_INFRASTRUCTURE_INTERFACES_IFULLSTATSPOIHOLDER:Class = IFullStatsPoiHolder;
      
      public static const NET_WG_GUI_BATTLE_COMP7_INFRASTRUCTURE_INTERFACES_IPOICONTAINER:Class = IPoiContainer;
      
      public static const NET_WG_GUI_BATTLE_COMP7_STATS_POICONTAINER:Class = PoiContainer;
      
      public static const NET_WG_GUI_BATTLE_COMP7_STATS_COMPONENTS_ROLESKILLLEVEL:Class = RoleSkillLevel;
      
      public static const NET_WG_GUI_BATTLE_COMP7_STATS_COMPONENTS_VOICECHATACTIVATION:Class = VoiceChatActivation;
      
      public static const NET_WG_GUI_BATTLE_COMP7_STATS_COMPONENTS_DATA_VOICECHATACTIVATIONVO:Class = VoiceChatActivationVO;
      
      public static const NET_WG_GUI_BATTLE_COMP7_STATS_COMPONENTS_EVENTS_VOICECHATACTIVATIONEVENT:Class = VoiceChatActivationEvent;
      
      public static const NET_WG_GUI_BATTLE_COMP7_STATS_COMPONENTS_PLAYERSPANEL_COMP7PLAYERSPANEL:Class = Comp7PlayersPanel;
      
      public static const NET_WG_GUI_BATTLE_COMP7_STATS_COMPONENTS_PLAYERSPANEL_INTERFACES_ICOMP7PLAYERSPANELLIST:Class = IComp7PlayersPanelList;
      
      public static const NET_WG_GUI_BATTLE_COMP7_STATS_COMPONENTS_PLAYERSPANEL_INTERFACES_ICOMP7PLAYERSPANELLISTITEM:Class = IComp7PlayersPanelListItem;
      
      public static const NET_WG_GUI_BATTLE_COMP7_STATS_COMPONENTS_PLAYERSPANEL_INTERFACES_ICOMP7PLAYERSPANELLISTLEFT:Class = IComp7PlayersPanelListLeft;
      
      public static const NET_WG_GUI_BATTLE_COMP7_STATS_COMPONENTS_PLAYERSPANEL_LIST_COMP7PLAYERSPANELLIST:Class = Comp7PlayersPanelList;
      
      public static const NET_WG_GUI_BATTLE_COMP7_STATS_COMPONENTS_PLAYERSPANEL_LIST_COMP7PLAYERSPANELLISTITEM:Class = Comp7PlayersPanelListItem;
      
      public static const NET_WG_GUI_BATTLE_COMP7_STATS_COMPONENTS_PLAYERSPANEL_LIST_COMP7PLAYERSPANELLISTITEMHOLDER:Class = Comp7PlayersPanelListItemHolder;
      
      public static const NET_WG_GUI_BATTLE_COMP7_STATS_COMPONENTS_PLAYERSPANEL_LIST_COMP7PLAYERSPANELLISTLEFT:Class = Comp7PlayersPanelListLeft;
      
      public static const NET_WG_GUI_BATTLE_COMP7_STATS_COMPONENTS_PLAYERSPANEL_LIST_COMP7PLAYERSPANELLISTRIGHT:Class = Comp7PlayersPanelListRight;
      
      public static const NET_WG_GUI_BATTLE_COMP7_STATS_FULLSTATS_FULLSTATS:Class = FullStats;
      
      public static const NET_WG_GUI_BATTLE_COMP7_STATS_FULLSTATS_FULLSTATSTABLE:Class = FullStatsTable;
      
      public static const NET_WG_GUI_BATTLE_COMP7_STATS_FULLSTATS_FULLSTATSTABLECTRL:Class = FullStatsTableCtrl;
      
      public static const NET_WG_GUI_BATTLE_COMP7_STATS_FULLSTATS_TABLEITEM_ANONYMIZERCTRL:Class = AnonymizerCtrl;
      
      public static const NET_WG_GUI_BATTLE_COMP7_STATS_FULLSTATS_TABLEITEM_STATSTABLEITEM:Class = StatsTableItem;
      
      public static const NET_WG_GUI_BATTLE_COMP7_STATS_FULLSTATS_TABLEITEM_STATSTABLEITEMHOLDER:Class = StatsTableItemHolder;
      
      public static const NET_WG_GUI_BATTLE_COMP7_VIEWS_BATTLETANKCAROUSEL_BATTLECAROUSELENVIRONMENT:Class = BattleCarouselEnvironment;
      
      public static const NET_WG_GUI_BATTLE_COMP7_VIEWS_BATTLETANKCAROUSEL_BATTLETANKCAROUSEL:Class = BattleTankCarousel;
      
      public static const NET_WG_GUI_BATTLE_COMP7_VIEWS_BATTLETANKCAROUSEL_BATTLETANKCAROUSELFILTERS:Class = BattleTankCarouselFilters;
      
      public static const NET_WG_GUI_BATTLE_COMP7_VIEWS_BATTLETANKCAROUSEL_DATA_BATTLEVEHICLECAROUSELVO:Class = BattleVehicleCarouselVO;
      
      public static const NET_WG_GUI_BATTLE_COMP7_VIEWS_BATTLETANKCAROUSEL_RENDERERS_BASEBATTLETANKICON:Class = BaseBattleTankIcon;
      
      public static const NET_WG_GUI_BATTLE_COMP7_VIEWS_BATTLETANKCAROUSEL_RENDERERS_BATTLETANKCAROUSELITEMRENDERER:Class = BattleTankCarouselItemRenderer;
      
      public static const NET_WG_GUI_BATTLE_COMP7_VIEWS_BATTLETANKCAROUSEL_RENDERERS_SMALLBATTLETANKCAROUSELITEMRENDERER:Class = SmallBattleTankCarouselItemRenderer;
      
      public static const NET_WG_GUI_BATTLE_COMP7_VIEWS_BATTLETANKCAROUSEL_RENDERERS_SMALLBATTLETANKICON:Class = SmallBattleTankIcon;
      
      public static const NET_WG_GUI_BATTLE_COMP7_VIEWS_CONSUMABLESPANEL_COMP7CONSUMABLEBUTTON:Class = Comp7ConsumableButton;
      
      public static const NET_WG_GUI_BATTLE_COMP7_VIEWS_CONSUMABLESPANEL_COMP7CONSUMABLEBUTTONGLOW:Class = Comp7ConsumableButtonGlow;
      
      public static const NET_WG_GUI_BATTLE_COMP7_VIEWS_CONSUMABLESPANEL_COMP7COUNTER:Class = Comp7Counter;
      
      public static const NET_WG_GUI_BATTLE_COMP7_VIEWS_CONSUMABLESPANEL_COMP7PROGRESSBAR:Class = Comp7ProgressBar;
      
      public static const NET_WG_GUI_BATTLE_COMP7_VIEWS_CONSUMABLESPANEL_COMP7PROGRESSCONTAINER:Class = Comp7ProgressContainer;
      
      public static const NET_WG_GUI_BATTLE_COMP7_VIEWS_CONSUMABLESPANEL_EVENTS_CONSUMABLESPANELEVENT:Class = ConsumablesPanelEvent;
      
      public static const NET_WG_GUI_BATTLE_COMP7_VIEWS_PREBATTLETIMER_COMP7PREBATTLEINFOCONTAINER:Class = Comp7PrebattleInfoContainer;
      
      public static const NET_WG_GUI_BATTLE_COMP7_VIEWS_PREBATTLETIMER_COMP7PREBATTLEINFOVIEW:Class = Comp7PrebattleInfoView;
      
      public static const NET_WG_GUI_BATTLE_COMP7_VIEWS_PREBATTLETIMER_COMP7PREBATTLEINFOVIEWVO:Class = Comp7PrebattleInfoViewVO;
      
      public static const NET_WG_GUI_BATTLE_COMP7_VIEWS_PREBATTLETIMER_COMP7PREBATTLETIMER:Class = Comp7PrebattleTimer;
      
      public static const NET_WG_GUI_BATTLE_COMP7_VIEWS_PREBATTLETIMER_EVENTS_COMP7PREBATTLEINFOVIEWEVENT:Class = Comp7PrebattleInfoViewEvent;
      
      public static const NET_WG_GUI_BATTLE_COMP7_VIEWS_TEAMBASESPANEL_COMP7TEAMBASESPANEL:Class = Comp7TeamBasesPanel;
      
      public static const NET_WG_GUI_BATTLE_COMP7_VO_DAAPI_COMP7DAAPIVEHICLEINFOVO:Class = Comp7DAAPIVehicleInfoVO;
      
      public static const NET_WG_GUI_BATTLE_COMP7_VO_DAAPI_COMP7DAAPIVEHICLESDATAVO:Class = Comp7DAAPIVehiclesDataVO;
      
      public static const NET_WG_GUI_BATTLE_COMP7_VO_DAAPI_COMP7DAAPIVEHICLESSTATSVO:Class = Comp7DAAPIVehiclesStatsVO;
      
      public static const NET_WG_GUI_BATTLE_COMP7_VO_DAAPI_COMP7DAAPIVEHICLESTATSVO:Class = Comp7DAAPIVehicleStatsVO;
      
      public static const NET_WG_GUI_BATTLE_COMP7_VO_DAAPI_COMP7INTERESTPOINTVO:Class = Comp7InterestPointVO;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_BASEPROGRESSCIRCLE:Class = BaseProgressCircle;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_BATTLEATLASSPRITE:Class = BattleAtlasSprite;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_BATTLEDAAPICOMPONENT:Class = BattleDAAPIComponent;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_BATTLEDISPLAYABLE:Class = BattleDisplayable;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_BATTLEICONHOLDER:Class = BattleIconHolder;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_BATTLEUICOMPONENT:Class = BattleUIComponent;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_BATTLEUICOMPONENTSHOLDER:Class = BattleUIComponentsHolder;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_BATTLEUIDISPLAYABLE:Class = BattleUIDisplayable;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_COOLDOWNTIMER:Class = CoolDownTimer;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_EPICPROGRESSCIRCLE:Class = EpicProgressCircle;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_FRAMEANIMATIONTIMER:Class = FrameAnimationTimer;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_FULLSTATSHEADER:Class = FullStatsHeader;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_FULLSTATSTITLE:Class = FullStatsTitle;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_HPPROGRESSCIRCLE:Class = HpProgressCircle;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_PLAYERSPANELBASE:Class = PlayersPanelBase;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_PLAYERSPANELSWITCHBASE:Class = PlayersPanelSwitchBase;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_PLAYERSTATUSVIEW:Class = PlayerStatusView;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_STATUSNOTIFICATIONSPANEL:Class = StatusNotificationsPanel;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_TIMERSPANEL:Class = TimersPanel;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_ANIMATEDBATTLEHINT_ANIMATEDBATTLEHINT:Class = AnimatedBattleHint;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_ANIMATEDBATTLEHINT_CONSTANTS_HINT_LABELS:Class = HINT_LABELS;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_ANIMATEDBATTLEHINT_CONTAINERS_HINTANIMATIONBLIND:Class = HintAnimationBlind;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_ANIMATEDBATTLEHINT_CONTAINERS_HINTANIMATIONCONTAINER:Class = HintAnimationContainer;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_ANIMATEDBATTLEHINT_CONTAINERS_HINTBACKGROUND:Class = HintBackground;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_ANIMATEDBATTLEHINT_CONTAINERS_HINTBLINDCONTAINER:Class = HintBlindContainer;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_ANIMATEDBATTLEHINT_CONTAINERS_HINTCONTAINER:Class = HintContainer;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_ANIMATEDBATTLEHINT_CONTAINERS_HINTINFOCONTAINER:Class = HintInfoContainer;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_ANIMATEDBATTLEHINT_CONTAINERS_HINTPENETRATIONANIMATION:Class = HintPenetrationAnimation;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_BUTTONS_BATTLEBUTTON:Class = BattleButton;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_BUTTONS_BATTLESTATEBUTTON:Class = BattleStateButton;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_BUTTONS_BATTLETOOLTIPBUTTON:Class = BattleToolTipButton;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_BUTTONS_BTNCONFIG_BATTLESTATEBTNSETTINGS:Class = BattleStateBtnSettings;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_BUTTONS_INTERFACES_IBATTLEBUTTON:Class = IBattleButton;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_BUTTONS_INTERFACES_IBATTLETOOLTIPBUTTON:Class = IBattleToolTipButton;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_BUTTONS_INTERFACES_ICLICKBUTTONHANDLER:Class = IClickButtonHandler;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_BUTTONS_INTERFACES_IDRAGOUTBUTTONHANDLER:Class = IDragOutButtonHandler;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_BUTTONS_INTERFACES_IDRAGOVERBUTTONHANDLER:Class = IDragOverButtonHandler;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_BUTTONS_INTERFACES_IPRESSBUTTONHANDLER:Class = IPressButtonHandler;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_BUTTONS_INTERFACES_IRELEASEOUTSIDEBUTTONHANDLER:Class = IReleaseOutSideButtonHandler;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_BUTTONS_INTERFACES_IROLLOUTBUTTONHANDLER:Class = IRollOutButtonHandler;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_BUTTONS_INTERFACES_IROLLOVERBUTTONHANDLER:Class = IRollOverButtonHandler;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_BUTTONS_INTERFACES_ISTATECHANGEDBUTTONHANDLER:Class = IStateChangedButtonHandler;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_BUTTONS_INTERFACES_ITOOLTIPTARGET:Class = ITooltipTarget;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_EVENTS_PLAYERSPANELLISTEVENT:Class = PlayersPanelListEvent;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_INTERESTPOINTTIMERSPANEL_INTERESTPOINTDESTROYTIMER:Class = InterestPointDestroyTimer;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_INTERESTPOINTTIMERSPANEL_INTERESTPOINTDESTROYTIMERBASE:Class = InterestPointDestroyTimerBase;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_INTERESTPOINTTIMERSPANEL_INTERESTPOINTSECONDARYTIMER:Class = InterestPointSecondaryTimer;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_INTERFACES_IBATTLEUICOMPONENT:Class = IBattleUIComponent;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_INTERFACES_ICOOLDOWNCOMPLETEHANDLER:Class = ICoolDownCompleteHandler;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_INTERFACES_ISTATUSNOTIFICATION:Class = IStatusNotification;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_INTERFACES_ISTATUSNOTIFICATIONCALLBACK:Class = IStatusNotificationCallback;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_POI_COMPONENTS_POIPROGRESSCIRCLE:Class = PoiProgressCircle;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_POI_COMPONENTS_POIPROGRESSCIRCLEWRAPPER:Class = PoiProgressCircleWrapper;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_POI_COMPONENTS_POIWITHPROGRESSSTATECIRCLE:Class = PoiWithProgressStateCircle;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_POINTSOFINTERESTNOTIFICATIONPANEL_POINTSOFINTERESTNOTIFICATIONPANEL:Class = PointsOfInterestNotificationPanel;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_POINTSOFINTERESTNOTIFICATIONPANEL_POIPROGRESSCIRCLE:Class = PoiProgressCircle;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_POINTSOFINTERESTNOTIFICATIONPANEL_POISTATUSINDICATOR:Class = PoiStatusIndicator;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_POINTSOFINTERESTNOTIFICATIONPANEL_DATA_POINTSOFINTERESTNOTIFICATIONVO:Class = PointsOfInterestNotificationVO;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_PREBATTLETIMER_DIGITANIM:Class = DigitAnim;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_PREBATTLETIMER_DIGITSCHAIN:Class = DigitsChain;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_PREBATTLETIMER_PREBATTLETIMEREVENT:Class = PreBattleTimerEvent;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_PREBATTLETIMER_TIMERANIM:Class = TimerAnim;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_STATS_PLAYERSPANEL_CHATCOMMANDITEMCOMPONENT:Class = ChatCommandItemComponent;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_STATS_PLAYERSPANEL_SPOTTEDINDICATOR:Class = SpottedIndicator;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_STATS_PLAYERSPANEL_EVENTS_CHATCOMMANDITEMEVENT:Class = ChatCommandItemEvent;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_STATS_PLAYERSPANEL_EVENTS_PLAYERSPANELITEMEVENT:Class = PlayersPanelItemEvent;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_STATS_PLAYERSPANEL_INTERFACES_IPLAYERSPANELLISTITEM:Class = IPlayersPanelListItem;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_STATS_PLAYERSPANEL_INTERFACES_IRANDOMPLAYERSPANELLISTITEM:Class = IRandomPlayersPanelListItem;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_STATS_PLAYERSPANEL_INTERFACES_IRANKEDPLAYERSPANELLISTITEM:Class = IRankedPlayersPanelListItem;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_STATS_PLAYERSPANEL_LIST_BASEPLAYERSLISTITEMHOLDER:Class = BasePlayersListItemHolder;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_STATS_PLAYERSPANEL_LIST_BASEPLAYERSPANELLIST:Class = BasePlayersPanelList;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_STATS_PLAYERSPANEL_LIST_BASEPLAYERSPANELLISTITEM:Class = BasePlayersPanelListItem;
      
      public static const NET_WG_GUI_BATTLE_COMPONENTS_STATS_PLAYERSPANEL_LIST_HPBARPLAYERSPANELLISTITEM:Class = HPBarPlayersPanelListItem;
      
      public static const NET_WG_GUI_BATTLE_COSMIC_COSMICBATTLEPAGE:Class = CosmicBattlePage;
      
      public static const NET_WG_GUI_BATTLE_COSMIC_BATTLELOADING_COSMICBATTLELOADING:Class = CosmicBattleLoading;
      
      public static const NET_WG_GUI_BATTLE_EPICBATTLE_BATTLELOADING_EPICBATTLELOADING:Class = EpicBattleLoading;
      
      public static const NET_WG_GUI_BATTLE_EPICBATTLE_BATTLELOADING_EPICBATTLELOADINGFORM:Class = EpicBattleLoadingForm;
      
      public static const NET_WG_GUI_BATTLE_EPICBATTLE_BATTLELOADING_COMPONENTS_EPICBATTLELOADINGTANKBALANCE:Class = EpicBattleLoadingTankBalance;
      
      public static const NET_WG_GUI_BATTLE_EPICBATTLE_BATTLELOADING_COMPONENTS_EPICBATTLELOADINGTANKTYPECOMPONENT:Class = EpicBattleLoadingTankTypeComponent;
      
      public static const NET_WG_GUI_BATTLE_EPICBATTLE_BATTLELOADING_COMPONENTS_EPICBATTLESCROLLINGLIST:Class = EpicBattleScrollingList;
      
      public static const NET_WG_GUI_BATTLE_EPICBATTLE_BATTLELOADING_COMPONENTS_EPICBATTLESTATSTABLE:Class = EpicBattleStatsTable;
      
      public static const NET_WG_GUI_BATTLE_EPICBATTLE_BATTLELOADING_COMPONENTS_EPICBATTLESTATSTABLECTRL:Class = EpicBattleStatsTableCtrl;
      
      public static const NET_WG_GUI_BATTLE_EPICBATTLE_BATTLELOADING_EVENTS_EPICBATTLELOADINGEVENT:Class = EpicBattleLoadingEvent;
      
      public static const NET_WG_GUI_BATTLE_EPICBATTLE_BATTLELOADING_RENDERERS_EPICBATTLELOADINGPLAYERITEMRENDERER:Class = EpicBattleLoadingPlayerItemRenderer;
      
      public static const NET_WG_GUI_BATTLE_EPICBATTLE_VIEWS_EPICBATTLEPAGE:Class = EpicBattlePage;
      
      public static const NET_WG_GUI_BATTLE_EPICBATTLE_VIEWS_EPICCAROUSELFILTERPOPOVERVIEW:Class = EpicCarouselFilterPopoverView;
      
      public static const NET_WG_GUI_BATTLE_EPICBATTLE_VIEWS_COMPONENTS_EPICBATTLECONSUMABLEBUTTON:Class = EpicBattleConsumableButton;
      
      public static const NET_WG_GUI_BATTLE_EPICBATTLE_VIEWS_COMPONENTS_EPICBATTLEEQUIPMENTBUTTONGLOW:Class = EpicBattleEquipmentButtonGlow;
      
      public static const NET_WG_GUI_BATTLE_EPICBATTLE_VIEWS_DATA_EPICSTATSDATAPROVIDERBASECTRL:Class = EpicStatsDataProviderBaseCtrl;
      
      public static const NET_WG_GUI_BATTLE_EPICBATTLE_VIEWS_DATA_EPICVEHICLEDATAPROVIDER:Class = EpicVehicleDataProvider;
      
      public static const NET_WG_GUI_BATTLE_EPICBATTLE_VIEWS_STATS_EPICFULLSTATS:Class = EpicFullStats;
      
      public static const NET_WG_GUI_BATTLE_EPICBATTLE_VIEWS_STATS_COMPONENTS_EPICFULLSTATSTABLE:Class = EpicFullStatsTable;
      
      public static const NET_WG_GUI_BATTLE_EPICBATTLE_VIEWS_STATS_COMPONENTS_EPICFULLSTATSTABLECTRL:Class = EpicFullStatsTableCtrl;
      
      public static const NET_WG_GUI_BATTLE_EPICBATTLE_VIEWS_STATS_COMPONENTS_EPICSTATSGENERALBONUS:Class = EpicStatsGeneralBonus;
      
      public static const NET_WG_GUI_BATTLE_EPICBATTLE_VIEWS_STATS_COMPONENTS_EPICSTATSHEADER:Class = EpicStatsHeader;
      
      public static const NET_WG_GUI_BATTLE_EPICBATTLE_VIEWS_STATS_COMPONENTS_EPICSTATSTABLEFILTERGROUP:Class = EpicStatsTableFilterGroup;
      
      public static const NET_WG_GUI_BATTLE_EPICBATTLE_VIEWS_STATS_COMPONENTS_EPICSTATSTABLETABBUTTON:Class = EpicStatsTableTabButton;
      
      public static const NET_WG_GUI_BATTLE_EPICBATTLE_VIEWS_STATS_COMPONENTS_PLAYERSCROLLINGLIST:Class = PlayerScrollingList;
      
      public static const NET_WG_GUI_BATTLE_EPICBATTLE_VIEWS_STATS_EVENTS_EPICFULLSTATSEVENT:Class = EpicFullStatsEvent;
      
      public static const NET_WG_GUI_BATTLE_EPICBATTLE_VIEWS_STATS_EVENTS_EPICFULLSTATSRENDEREREVENT:Class = EpicFullStatsRendererEvent;
      
      public static const NET_WG_GUI_BATTLE_EPICBATTLE_VIEWS_STATS_RENDERERS_EPICSTATSPLAYERRENDERER:Class = EpicStatsPlayerRenderer;
      
      public static const NET_WG_GUI_BATTLE_EPICBATTLE_VO_DAAPI_EPICPLAYERSTATSVO:Class = EpicPlayerStatsVO;
      
      public static const NET_WG_GUI_BATTLE_EPICBATTLE_VO_DAAPI_EPICVEHICLESSTATSVO:Class = EpicVehiclesStatsVO;
      
      public static const NET_WG_GUI_BATTLE_EPICBATTLE_VO_DAAPI_EPICVEHICLESTATSVO:Class = EpicVehicleStatsVO;
      
      public static const NET_WG_GUI_BATTLE_EPICRANDOM_BATTLELOADING_EPICRANDOMBATTLELOADING:Class = EpicRandomBattleLoading;
      
      public static const NET_WG_GUI_BATTLE_EPICRANDOM_BATTLELOADING_EPICRANDOMBATTLELOADINGFORM:Class = EpicRandomBattleLoadingForm;
      
      public static const NET_WG_GUI_BATTLE_EPICRANDOM_BATTLELOADING_COMPONENTS_EPICRANDOMSTATSTABLE:Class = EpicRandomStatsTable;
      
      public static const NET_WG_GUI_BATTLE_EPICRANDOM_BATTLELOADING_COMPONENTS_EPICRANDOMSTATSTABLECTRL:Class = EpicRandomStatsTableCtrl;
      
      public static const NET_WG_GUI_BATTLE_EPICRANDOM_BATTLELOADING_RENDERERS_EPICRANDOMBASEPLAYERITEMRENDERER:Class = EpicRandomBasePlayerItemRenderer;
      
      public static const NET_WG_GUI_BATTLE_EPICRANDOM_BATTLELOADING_RENDERERS_IEPICRANDOMBATTLELOADINGRENDERER:Class = IEpicRandomBattleLoadingRenderer;
      
      public static const NET_WG_GUI_BATTLE_EPICRANDOM_BATTLELOADING_RENDERERS_TABLEEPICRANDOMPLAYERITEMRENDERER:Class = TableEpicRandomPlayerItemRenderer;
      
      public static const NET_WG_GUI_BATTLE_EPICRANDOM_BATTLELOADING_RENDERERS_TIPEPICRANDOMPLAYERITEMRENDERER:Class = TipEpicRandomPlayerItemRenderer;
      
      public static const NET_WG_GUI_BATTLE_EPICRANDOM_INFRASTRUCTURE_EPICRANDOMSTATISTICSDATACONTROLLER:Class = EpicRandomStatisticsDataController;
      
      public static const NET_WG_GUI_BATTLE_EPICRANDOM_VIEWS_EPICRANDOMPAGE:Class = EpicRandomPage;
      
      public static const NET_WG_GUI_BATTLE_EPICRANDOM_VIEWS_STATS_COMPONENTS_FULLSTATS_EPICRANDOMFULLSTATS:Class = EpicRandomFullStats;
      
      public static const NET_WG_GUI_BATTLE_EPICRANDOM_VIEWS_STATS_COMPONENTS_FULLSTATS_EPICRANDOMFULLSTATSLISTITEMRENDERER:Class = EpicRandomFullStatsListItemRenderer;
      
      public static const NET_WG_GUI_BATTLE_EPICRANDOM_VIEWS_STATS_COMPONENTS_FULLSTATS_EPICRANDOMFULLSTATSTABLE:Class = EpicRandomFullStatsTable;
      
      public static const NET_WG_GUI_BATTLE_EPICRANDOM_VIEWS_STATS_COMPONENTS_FULLSTATS_EPICRANDOMFULLSTATSTABLECTRL:Class = EpicRandomFullStatsTableCtrl;
      
      public static const NET_WG_GUI_BATTLE_EPICRANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_PLAYERSPANEL:Class = PlayersPanel;
      
      public static const NET_WG_GUI_BATTLE_EPICRANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_EVENTS_PLAYERSPANELITEMEVENT:Class = PlayersPanelItemEvent;
      
      public static const NET_WG_GUI_BATTLE_EPICRANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_LIST_LISTROWBACKGROUNDCONTAINER:Class = ListRowBackgroundContainer;
      
      public static const NET_WG_GUI_BATTLE_EPICRANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_LIST_LISTROWBACKGROUNDITEM:Class = ListRowBackgroundItem;
      
      public static const NET_WG_GUI_BATTLE_EPICRANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_LIST_PLAYERSPANELDEPLOYMENTGROUPICON:Class = PlayersPanelDeploymentGroupIcon;
      
      public static const NET_WG_GUI_BATTLE_EPICRANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_LIST_PLAYERSPANELLIST:Class = PlayersPanelList;
      
      public static const NET_WG_GUI_BATTLE_EPICRANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_LIST_PLAYERSPANELLISTITEM:Class = PlayersPanelListItem;
      
      public static const NET_WG_GUI_BATTLE_EPICRANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_LIST_PLAYERSPANELLISTITEMHOLDER:Class = PlayersPanelListItemHolder;
      
      public static const NET_WG_GUI_BATTLE_EPICRANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_LIST_PLAYERSPANELLISTITEMSETTINGS:Class = PlayersPanelListItemSettings;
      
      public static const NET_WG_GUI_BATTLE_EPICRANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_LIST_PLAYERSPANELLISTITEMSTATE:Class = PlayersPanelListItemState;
      
      public static const NET_WG_GUI_BATTLE_EPICRANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_LIST_PLAYERSPANELLISTLEFT:Class = PlayersPanelListLeft;
      
      public static const NET_WG_GUI_BATTLE_EPICRANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_LIST_PLAYERSPANELLISTRIGHT:Class = PlayersPanelListRight;
      
      public static const NET_WG_GUI_BATTLE_EPICRANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_PANELSWITCH_PLAYERSPANELSWITCH:Class = PlayersPanelSwitch;
      
      public static const NET_WG_GUI_BATTLE_EPICRANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_PANELSWITCH_PLAYERSPANELSWITCHBUTTONEX:Class = PlayersPanelSwitchButtonEx;
      
      public static const NET_WG_GUI_BATTLE_EPICRANDOM_VIEWS_STATS_EVENTS_EPICRANDOMFULLSTATSLISTITEMRENDEREREVENT:Class = EpicRandomFullStatsListItemRendererEvent;
      
      public static const NET_WG_GUI_BATTLE_EPICRANDOM_VO_DAAPI_EPICRANDOMDAAPIVEHICLEINFOVO:Class = EpicRandomDAAPIVehicleInfoVO;
      
      public static const NET_WG_GUI_BATTLE_EPICRANDOM_VO_DAAPI_EPICRANDOMDAAPIVEHICLESDATAVO:Class = EpicRandomDAAPIVehiclesDataVO;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VIEWS_EVENTBATTLELOADING:Class = EventBattleLoading;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VIEWS_EVENTBATTLEPAGE:Class = EventBattlePage;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VIEWS_BATTLEHINTS_EVENTBATTLEHINT:Class = EventBattleHint;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VIEWS_BATTLEHINTS_EVENTOBJECTIVES:Class = EventObjectives;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VIEWS_BATTLEHINTS_INFOCONTAINER:Class = InfoContainer;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VIEWS_BATTLEHINTS_TEXTCONTAINER:Class = TextContainer;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VIEWS_BATTLEHINTS_DATA_HINTINFOVO:Class = HintInfoVO;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VIEWS_BUFFSPANEL_BUFFSPANEL:Class = BuffsPanel;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VIEWS_BUFFSPANEL_EVENTBUFFBUTTON:Class = EventBuffButton;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VIEWS_CONSUMABLESPANEL_EVENTBATTLEEQUIPMENTBUTTON:Class = EventBattleEquipmentButton;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VIEWS_CONSUMABLESPANEL_EVENTBATTLESHELLBUTTON:Class = EventBattleShellButton;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VIEWS_CONSUMABLESPANEL_EVENTCONSUMABLESPANEL:Class = EventConsumablesPanel;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VIEWS_EVENTPLAYERSPANEL_EVENTHEALTHBAR:Class = EventHealthBar;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VIEWS_EVENTPLAYERSPANEL_EVENTPLAYERSINFO:Class = EventPlayersInfo;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VIEWS_EVENTPLAYERSPANEL_EVENTPLAYERSPANEL:Class = EventPlayersPanel;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VIEWS_EVENTPLAYERSPANEL_EVENTPLAYERSPANELLISTITEM:Class = EventPlayersPanelListItem;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VIEWS_EVENTPLAYERSPANEL_VO_DAAPIPLAYERPANELINFOVO:Class = DAAPIPlayerPanelInfoVO;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VIEWS_EVENTPOINTCOUNTER_EVENTPOINTCOUNTER:Class = EventPointCounter;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VIEWS_EVENTSTATS_EVENTSTATS:Class = EventStats;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VIEWS_EVENTSTATS_RENDERERS_STATSPLAYERRENDERER:Class = StatsPlayerRenderer;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VIEWS_EVENTSTATS_VO_EVENTSTATSPLAYERVO:Class = EventStatsPlayerVO;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VIEWS_EVENTTIMER_EVENTCAPTURETIMER:Class = EventCaptureTimer;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VIEWS_EVENTTIMER_EVENTTIMER:Class = EventTimer;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VIEWS_EVENTTIMER_TIMERMOVIE:Class = TimerMovie;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VIEWS_INTROVIDEOPAGE_EVENTINTROLOGOCONTAINER:Class = EventIntroLogoContainer;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VIEWS_MINIMAP_ENTRIES_CUSTOMDEATHZONEMINIMAPENTRY:Class = CustomDeathZoneMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VIEWS_MINIMAP_ENTRIES_EVENTDEATHZONEMINIMAPENTRY:Class = EventDeathZoneMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VIEWS_PREBATTLETIMER_EVENTPREBATTLETIMERBG:Class = EventPrebattleTimerBg;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VIEWS_RADIALMENU_EVENTRADIALBUTTON:Class = EventRadialButton;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VIEWS_RADIALMENU_EVENTRADIALMENU:Class = EventRadialMenu;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VIEWS_RADIALMENU_COMPONENTS_CHATCONTAINER:Class = ChatContainer;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VIEWS_RADIALMENU_COMPONENTS_COMMANDCONTAINER:Class = CommandContainer;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VIEWS_RADIALMENU_COMPONENTS_EVENTBACKGROUND:Class = EventBackGround;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VIEWS_RADIALMENU_COMPONENTS_EVENTCONTENT:Class = EventContent;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VIEWS_RADIALMENU_COMPONENTS_EVENTSECTORHOVEREDWRAPPER:Class = EventSectorHoveredWrapper;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VIEWS_RADIALMENU_COMPONENTS_ICONROTATIONCONTAINER:Class = IconRotationContainer;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VIEWS_RADIALMENU_COMPONENTS_RADIALPAGING:Class = RadialPaging;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VIEWS_TIMERSPANEL_ITIMERICONCONTENT:Class = ITimerIconContent;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VIEWS_TIMERSPANEL_WTBOMBCARRYICONCONTENT:Class = WtBombCarryIconContent;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VIEWS_TIMERSPANEL_WTTIMER:Class = WtTimer;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VO_DAAPIHUNTERVEHICLEINFOVO:Class = DAAPIHunterVehicleInfoVO;
      
      public static const NET_WG_GUI_BATTLE_EVENTBATTLE_VO_DAAPIHUNTERVEHICLESDATAVO:Class = DAAPIHunterVehiclesDataVO;
      
      public static const NET_WG_GUI_BATTLE_EVENTINFOPANEL_EVENTINFOPANEL:Class = EventInfoPanel;
      
      public static const NET_WG_GUI_BATTLE_EVENTINFOPANEL_DATA_EVENTINFOPANELITEMVO:Class = EventInfoPanelItemVO;
      
      public static const NET_WG_GUI_BATTLE_EVENTINFOPANEL_DATA_EVENTINFOPANELVO:Class = EventInfoPanelVO;
      
      public static const NET_WG_GUI_BATTLE_EVENTINFOPANEL_INTERFACES_IEVENTINFOPANEL:Class = IEventInfoPanel;
      
      public static const NET_WG_GUI_BATTLE_EVENTS_BATTLESOUNDEVENT:Class = BattleSoundEvent;
      
      public static const NET_WG_GUI_BATTLE_EVENTS_REPAIRANIMEVENT:Class = RepairAnimEvent;
      
      public static const NET_WG_GUI_BATTLE_INTERFACES_IBATTLEINFO:Class = IBattleInfo;
      
      public static const NET_WG_GUI_BATTLE_INTERFACES_IFULLSTATS:Class = IFullStats;
      
      public static const NET_WG_GUI_BATTLE_INTERFACES_IPREBATTLETIMERBASE:Class = IPrebattleTimerBase;
      
      public static const NET_WG_GUI_BATTLE_INTERFACES_IQUESTPROGRESSSTATS:Class = IQuestProgressStats;
      
      public static const NET_WG_GUI_BATTLE_INTERFACES_IRESERVESSTATS:Class = IReservesStats;
      
      public static const NET_WG_GUI_BATTLE_INTERFACES_ISTATSTABLECONTROLLER:Class = IStatsTableController;
      
      public static const NET_WG_GUI_BATTLE_INTERFACES_ITABBEDFULLSTATSTABLECONTROLLER:Class = ITabbedFullStatsTableController;
      
      public static const NET_WG_GUI_BATTLE_MAPSTRAINING_VIEWS_MAPSTRAININGBATTLELOADING:Class = MapsTrainingBattleLoading;
      
      public static const NET_WG_GUI_BATTLE_MAPSTRAINING_VIEWS_MAPSTRAININGBATTLEPAGE:Class = MapsTrainingBattlePage;
      
      public static const NET_WG_GUI_BATTLE_MAPSTRAINING_VIEWS_CONSUMABLESPANEL_MAPSTRAININGBATTLESHELLBUTTON:Class = MapsTrainingBattleShellButton;
      
      public static const NET_WG_GUI_BATTLE_MAPSTRAINING_VIEWS_DATA_MAPSTRAININGBATTLELOADINGVO:Class = MapsTrainingBattleLoadingVO;
      
      public static const NET_WG_GUI_BATTLE_MAPSTRAINING_VIEWS_GOALS_MAPSTRAININGGOALS:Class = MapsTrainingGoals;
      
      public static const NET_WG_GUI_BATTLE_MAPSTRAINING_VIEWS_GOALS_DATA_MAPSTRAININGGOALVO:Class = MapsTrainingGoalVO;
      
      public static const NET_WG_GUI_BATTLE_MAPSTRAINING_VIEWS_GOALS_HINT_MAPSTRAININGGOAL:Class = MapsTrainingGoal;
      
      public static const NET_WG_GUI_BATTLE_MAPSTRAINING_VIEWS_GOALS_HINT_MAPSTRAININGGOALITEM:Class = MapsTrainingGoalItem;
      
      public static const NET_WG_GUI_BATTLE_MAPSTRAINING_VIEWS_GOALS_HINT_MAPSTRAININGTIMERANIM:Class = MapsTrainingTimerAnim;
      
      public static const NET_WG_GUI_BATTLE_MAPSTRAINING_VIEWS_GOALS_HINT_MAPSTRAININGTIMERHINT:Class = MapsTrainingTimerHint;
      
      public static const NET_WG_GUI_BATTLE_MAPSTRAINING_VIEWS_LISTTARGETS_LISTTARGETS:Class = ListTargets;
      
      public static const NET_WG_GUI_BATTLE_MAPSTRAINING_VIEWS_MAPSTRAININGMESSAGESPANEL_MAPSTRAININGMESSAGESPANEL:Class = MapsTrainingMessagesPanel;
      
      public static const NET_WG_GUI_BATTLE_MAPSTRAINING_VIEWS_MINIMAP_MAPSTRAININGVEHICLEMINIMAPENTRY:Class = MapsTrainingVehicleMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_MAPSTRAINING_VIEWS_MINIMAP_SHOOTINGPOINTMINIMAPENTRY:Class = ShootingPointMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_MAPSTRAINING_VIEWS_PREBATTLETIMER_MAPSTRAININGPREBATTLETIMER:Class = MapsTrainingPrebattleTimer;
      
      public static const NET_WG_GUI_BATTLE_MAPSTRAINING_VIEWS_PREBATTLETIMER_MAPSTRAININGPREBATTLETIMERBG:Class = MapsTrainingPrebattleTimerBg;
      
      public static const NET_WG_GUI_BATTLE_MAPSTRAINING_VIEWS_PREBATTLETIMER_MAPSTRAININGTEXTFIELDCONTAINER:Class = MapsTrainingTextFieldContainer;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_BATTLELOADING_RENDERERS_RANDOMPLAYERITEMRENDERER:Class = RandomPlayerItemRenderer;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_BATTLELOADING_RENDERERS_RANDOMRENDERERCONTAINER:Class = RandomRendererContainer;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_BATTLEPAGE:Class = BattlePage;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_FRAGCORRELATIONBAR_FRAGCORRELATIONBAR:Class = FragCorrelationBar;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_FRAGCORRELATIONBAR_FRAGSANDENEMIESBAR:Class = FragsAndEnemiesBar;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_FRAGCORRELATIONBAR_COMPONENTS_ALLYTEAMHEALTHBAR:Class = AllyTeamHealthBar;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_FRAGCORRELATIONBAR_COMPONENTS_BASETEAMHEALTHBAR:Class = BaseTeamHealthBar;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_FRAGCORRELATIONBAR_COMPONENTS_FCVEHICLEMARKER:Class = FCVehicleMarker;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_FRAGCORRELATIONBAR_COMPONENTS_IVEHICLEMARKERANIMFINISHEDHANDLER:Class = IVehicleMarkerAnimFinishedHandler;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_FRAGCORRELATIONBAR_COMPONENTS_SCOREHEALTHBARELEMENT:Class = ScoreHealthBarElement;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_FRAGCORRELATIONBAR_COMPONENTS_TIERGROUPINGELEMENT:Class = TierGroupingElement;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_FRAGCORRELATIONBAR_COMPONENTS_VEHICLEMARKERSLIST:Class = VehicleMarkersList;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_FULLSTATS_FULLSTATS:Class = FullStats;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_FULLSTATS_FULLSTATSTABLE:Class = FullStatsTable;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_FULLSTATS_FULLSTATSTABLECTRL:Class = FullStatsTableCtrl;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_FULLSTATS_CONSTANTS_RANDOMFULLSTATSVALIDATIONTYPE:Class = RandomFullStatsValidationType;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_FULLSTATS_INTERFACES_IDYNAMICSQUADCTRL:Class = IDynamicSquadCtrl;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_FULLSTATS_INTERFACES_ISQUADHANDLER:Class = ISquadHandler;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_FULLSTATS_TABLEITEM_DYNAMICSQUADCTRL:Class = DynamicSquadCtrl;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_FULLSTATS_TABLEITEM_STATSTABLEITEM:Class = StatsTableItem;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_FULLSTATS_TABLEITEM_STATSTABLEITEMHOLDER:Class = StatsTableItemHolder;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_PLAYERSPANEL:Class = PlayersPanel;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_CONSTANTS_PLAYERSPANELINVALIDATIONTYPE:Class = PlayersPanelInvalidationType;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_EVENTS_PLAYERSPANELEVENT:Class = PlayersPanelEvent;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_EVENTS_PLAYERSPANELSWITCHEVENT:Class = PlayersPanelSwitchEvent;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_INTERFACES_IEPICPLAYERSPANELLIST:Class = IEpicPlayersPanelList;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_INTERFACES_IPLAYERSPANELLIST:Class = IPlayersPanelList;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_INTERFACES_IPLAYERSPANELLISTITEMHOLDER:Class = IPlayersPanelListItemHolder;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_LIST_INVITERECEIVEDINDICATOR:Class = InviteReceivedIndicator;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_LIST_PLAYERSPANELDYNAMICSQUAD:Class = PlayersPanelDynamicSquad;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_LIST_PLAYERSPANELLIST:Class = PlayersPanelList;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_LIST_PLAYERSPANELLISTITEM:Class = PlayersPanelListItem;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_LIST_PLAYERSPANELLISTITEMHOLDER:Class = PlayersPanelListItemHolder;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_LIST_PLAYERSPANELLISTLEFT:Class = PlayersPanelListLeft;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_LIST_PLAYERSPANELLISTRIGHT:Class = PlayersPanelListRight;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_PANELSWITCH_PLAYERSPANELSWITCH:Class = PlayersPanelSwitch;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_PANELSWITCH_PLAYERSPANELSWITCHBUTTON:Class = PlayersPanelSwitchButton;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_VO_PLAYERSPANELCONTEXTMENUSENTDATA:Class = PlayersPanelContextMenuSentData;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_CONSTANTS_VEHICLEACTIONS:Class = VehicleActions;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_EVENTS_DYNAMICSQUADEVENT:Class = DynamicSquadEvent;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_TEAMBASESPANEL_TEAMBASESPANEL:Class = TeamBasesPanel;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_TEAMBASESPANEL_TEAMCAPTUREBAR:Class = TeamCaptureBar;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_TEAMBASESPANEL_TEAMCAPTUREBARBG:Class = TeamCaptureBarBg;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_TEAMBASESPANEL_TEAMCAPTUREFEEL:Class = TeamCaptureFeel;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_TEAMBASESPANEL_TEAMCAPTUREPROGRESS:Class = TeamCaptureProgress;
      
      public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_TEAMBASESPANEL_TEAMCAPTUREPROGRESSRESET:Class = TeamCaptureProgressReset;
      
      public static const NET_WG_GUI_BATTLE_RANKED_RANKEDBATTLEPAGE:Class = RankedBattlePage;
      
      public static const NET_WG_GUI_BATTLE_RANKED_BATTLELOADING_BATTLELOADING:Class = BattleLoading;
      
      public static const NET_WG_GUI_BATTLE_RANKED_BATTLELOADING_BATTLELOADINGFORM:Class = BattleLoadingForm;
      
      public static const NET_WG_GUI_BATTLE_RANKED_BATTLELOADING_RENDERERS_RANKEDPLAYERITEMRENDERER:Class = RankedPlayerItemRenderer;
      
      public static const NET_WG_GUI_BATTLE_RANKED_BATTLELOADING_RENDERERS_RANKEDRENDERERCONTAINER:Class = RankedRendererContainer;
      
      public static const NET_WG_GUI_BATTLE_RANKED_BATTLELOADING_RENDERERS_TABLEPLAYERITEMRENDERER:Class = TablePlayerItemRenderer;
      
      public static const NET_WG_GUI_BATTLE_RANKED_BATTLELOADING_RENDERERS_TIPPLAYERITEMRENDERER:Class = TipPlayerItemRenderer;
      
      public static const NET_WG_GUI_BATTLE_RANKED_INFRASTRUCTURE_RANKEDSTATISTICSDATACONTROLLER:Class = RankedStatisticsDataController;
      
      public static const NET_WG_GUI_BATTLE_RANKED_STATS_COMPONENTS_FULLSTATS_FULLSTATS:Class = FullStats;
      
      public static const NET_WG_GUI_BATTLE_RANKED_STATS_COMPONENTS_FULLSTATS_FULLSTATSTABLE:Class = FullStatsTable;
      
      public static const NET_WG_GUI_BATTLE_RANKED_STATS_COMPONENTS_FULLSTATS_FULLSTATSTABLECTRL:Class = FullStatsTableCtrl;
      
      public static const NET_WG_GUI_BATTLE_RANKED_STATS_COMPONENTS_FULLSTATS_TABLEITEM_STATSTABLEITEM:Class = StatsTableItem;
      
      public static const NET_WG_GUI_BATTLE_RANKED_STATS_COMPONENTS_FULLSTATS_TABLEITEM_STATSTABLEITEMHOLDER:Class = StatsTableItemHolder;
      
      public static const NET_WG_GUI_BATTLE_RANKED_STATS_COMPONENTS_PLAYERSPANEL_LIST_PLAYERSPANELLIST:Class = PlayersPanelList;
      
      public static const NET_WG_GUI_BATTLE_RANKED_STATS_COMPONENTS_PLAYERSPANEL_LIST_PLAYERSPANELLISTITEM:Class = PlayersPanelListItem;
      
      public static const NET_WG_GUI_BATTLE_RANKED_STATS_COMPONENTS_PLAYERSPANEL_LIST_PLAYERSPANELLISTITEMHOLDER:Class = PlayersPanelListItemHolder;
      
      public static const NET_WG_GUI_BATTLE_RANKED_STATS_COMPONENTS_PLAYERSPANEL_LIST_PLAYERSPANELLISTLEFT:Class = PlayersPanelListLeft;
      
      public static const NET_WG_GUI_BATTLE_RANKED_STATS_COMPONENTS_PLAYERSPANEL_LIST_PLAYERSPANELLISTRIGHT:Class = PlayersPanelListRight;
      
      public static const NET_WG_GUI_BATTLE_RANKED_VO_DAAPI_RANKEDDAAPIVEHICLEINFOVO:Class = RankedDAAPIVehicleInfoVO;
      
      public static const NET_WG_GUI_BATTLE_RANKED_VO_DAAPI_RANKEDDAAPIVEHICLESDATAVO:Class = RankedDAAPIVehiclesDataVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_BASEBATTLEPAGE:Class = BaseBattlePage;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_BATTLEPAGEQUESTSPROGRESS:Class = BattlePageQuestsProgress;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_ACTIONMARKERS_ACTIONMARKERSTATES:Class = ActionMarkerStates;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_ACTIONMARKERS_BASEACTIONMARKER:Class = BaseActionMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_ACTIONMARKERS_REPLIEDMARKER:Class = RepliedMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_ACTIONMARKERS_REPLIEDMARKERICON:Class = RepliedMarkerIcon;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_ACTIONMARKERS_STICKYMARKER:Class = StickyMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_AMMUNITIONPANEL_EPICRESPAWNAMMUNITIONPANELVIEW:Class = EpicRespawnAmmunitionPanelView;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_AMMUNITIONPANEL_PRBAMMUNITIONPANELEVENT:Class = PrbAmmunitionPanelEvent;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_AMMUNITIONPANEL_PREBATTLEAMMUNITIONPANELVIEW:Class = PrebattleAmmunitionPanelView;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_BATTLEENDWARNING_BATTLEENDWARNINGPANEL:Class = BattleEndWarningPanel;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_BATTLEENDWARNING_ENDWARNINGPANELEVENT:Class = EndWarningPanelEvent;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_BATTLEENDWARNING_CONTAINERS_TIMER:Class = Timer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_BATTLELEVELPANEL_BATTLELEVELPANEL:Class = BattleLevelPanel;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_BATTLELEVELPANEL_BATTLELEVELPANELDATA:Class = BattleLevelPanelData;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_BATTLELEVELPANEL_EXPERIENCEDIFFANIMATION:Class = ExperienceDiffAnimation;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_BATTLELEVELPANEL_PROGRESSDELTAANIMATION:Class = ProgressDeltaAnimation;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_BATTLELEVELPANEL_PROGRESSINDICATOR:Class = ProgressIndicator;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_BATTLELEVELPANEL_TEXTANIMATION:Class = TextAnimation;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_BATTLEMESSENGER_BATTLEIMAGESUBSTITUTION:Class = BattleImageSubstitution;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_BATTLEMESSENGER_BATTLEMESSAGE:Class = BattleMessage;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_BATTLEMESSENGER_BATTLEMESSENGER:Class = BattleMessenger;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_BATTLEMESSENGER_BATTLEMESSENGERPOOL:Class = BattleMessengerPool;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_BATTLEMESSENGER_BATTLESMILEYMAP:Class = BattleSmileyMap;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_BATTLEMESSENGER_ACTIONPANEL_BATTLEMESSENGERACTIONCONTAINER:Class = BattleMessengerActionContainer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_BATTLEMESSENGER_INTERFACES_IBATTLEMESSENGER:Class = IBattleMessenger;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_BATTLEMESSENGER_VO_BATTLEMESSENGERRECEIVERVO:Class = BattleMessengerReceiverVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_BATTLEMESSENGER_VO_BATTLEMESSENGERSETTINGSVO:Class = BattleMessengerSettingsVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_BATTLEMESSENGER_VO_BATTLEMESSENGERTOXICVO:Class = BattleMessengerToxicVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_BATTLEMESSENGER_VO_BUTTONTOXICSTATUSVO:Class = ButtonToxicStatusVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_BATTLENOTIFIER_BATTLENOTIFIER:Class = BattleNotifier;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_BATTLETANKCAROUSEL_BATTLECAROUSELENVIRONMENT:Class = BattleCarouselEnvironment;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_BATTLETANKCAROUSEL_BATTLETANKCAROUSEL:Class = BattleTankCarousel;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_BATTLETANKCAROUSEL_BATTLETANKCAROUSELFILTERS:Class = BattleTankCarouselFilters;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_BATTLETANKCAROUSEL_DATA_BATTLEVEHICLECAROUSELVO:Class = BattleVehicleCarouselVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_BATTLETANKCAROUSEL_RENDERERS_BASEBATTLETANKICON:Class = BaseBattleTankIcon;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_BATTLETANKCAROUSEL_RENDERERS_BATTLETANKCAROUSELITEMRENDERER:Class = BattleTankCarouselItemRenderer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_BATTLETIMER_BASEBATTLETIMER:Class = BaseBattleTimer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_BATTLETIMER_BATTLEANIMATIONTIMER:Class = BattleAnimationTimer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_BATTLETIMER_BATTLETIMER:Class = BattleTimer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_BATTLETIMER_EPICBATTLETIMER:Class = EpicBattleTimer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_BATTLETIMER_TIMERDISPLAY:Class = TimerDisplay;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_CALLOUTPANEL_CALLOUTPANEL:Class = CalloutPanel;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_CALLOUTPANEL_COMPONENTS_INTERACTIONDYNAMICTEXTLABEL:Class = InteractionDynamicTextLabel;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_CALLOUTPANEL_COMPONENTS_VEHICLEINFOLABEL:Class = VehicleInfoLabel;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_CONSUMABLESPANEL_BATTLEABILITYEQUIPMENTBUTTON:Class = BattleAbilityEquipmentButton;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_CONSUMABLESPANEL_BATTLEABILITYEQUIPMENTBUTTONGLOW:Class = BattleAbilityEquipmentButtonGlow;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_CONSUMABLESPANEL_BATTLEEQUIPMENTBUTTON:Class = BattleEquipmentButton;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_CONSUMABLESPANEL_BATTLEEQUIPMENTBUTTONGLOW:Class = BattleEquipmentButtonGlow;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_CONSUMABLESPANEL_BATTLEOPTIONALDEVICEBUTTON:Class = BattleOptionalDeviceButton;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_CONSUMABLESPANEL_BATTLESHELLBUTTON:Class = BattleShellButton;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_CONSUMABLESPANEL_CONSUMABLESPANEL:Class = ConsumablesPanel;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_CONSUMABLESPANEL_ENTITIESSTATEPOPUP:Class = EntitiesStatePopup;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_CONSUMABLESPANEL_ENTITYSTATEBUTTON:Class = EntityStateButton;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_CONSUMABLESPANEL_CONSTANTS_COLOR_STATES:Class = COLOR_STATES;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_CONSUMABLESPANEL_EVENTS_CONSUMABLESBUTTONEVENT:Class = ConsumablesButtonEvent;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_CONSUMABLESPANEL_EVENTS_CONSUMABLESPANELEVENT:Class = ConsumablesPanelEvent;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_CONSUMABLESPANEL_INTERFACES_IBATTLEEQUIPMENTBUTTONGLOW:Class = IBattleEquipmentButtonGlow;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_CONSUMABLESPANEL_INTERFACES_IBATTLEOPTIONALDEVICEBUTTON:Class = IBattleOptionalDeviceButton;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_CONSUMABLESPANEL_INTERFACES_IBATTLESHELLBUTTON:Class = IBattleShellButton;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_CONSUMABLESPANEL_INTERFACES_ICONSUMABLESBUTTON:Class = IConsumablesButton;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_CONSUMABLESPANEL_INTERFACES_ICONSUMABLESPANEL:Class = IConsumablesPanel;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_CONSUMABLESPANEL_INTERFACES_IENTITYSTATEBUTTON:Class = IEntityStateButton;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_CONSUMABLESPANEL_VO_CONSUMABLESVO:Class = ConsumablesVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_COSMICHUD_COSMICHUD:Class = CosmicHud;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEINDICATOR_DAMAGEINDICATOR:Class = DamageIndicator;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEINFOPANEL_DAMAGEINFOPANEL:Class = DamageInfoPanel;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEINFOPANEL_COMPONENTS_DAMAGEITEM:Class = DamageItem;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEINFOPANEL_COMPONENTS_FIRE:Class = Fire;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEINFOPANEL_COMPONENTS_TRACKDAMAGEITEM:Class = TrackDamageItem;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_DAMAGEPANEL:Class = DamagePanel;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_DAMAGEPANELITEMCLICKAREA:Class = DamagePanelItemClickArea;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_DAMAGEPANELITEMFRAMESTATES:Class = DamagePanelItemFrameStates;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_FIREINDICATOR:Class = FireIndicator;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_HEALTHBAR:Class = HealthBar;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_MODULES_MODULEASSETS:Class = ModuleAssets;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_MODULES_MODULEREPAIRANIM:Class = ModuleRepairAnim;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_MODULES_MODULESCTRL:Class = ModulesCtrl;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_MODULES_MODULEWARNINGANIM:Class = ModuleWarningAnim;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_MODULES_CHASSIS_MULTITRACKCHASSISSTATE:Class = MultitrackChassisState;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_MODULES_CHASSIS_PARTSTATE:Class = PartState;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_MODULES_CHASSIS_YOHCHASSISSTATE:Class = YohChassisState;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_STATUSINDICATOR_STATUSARROW:Class = StatusArrow;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_STUNINDICATOR_STUNARROW:Class = StunArrow;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_STUNINDICATOR_STUNCOUNTER:Class = StunCounter;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_TANKINDICATOR_ITEMWITHMODULES:Class = ItemWithModules;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_TANKINDICATOR_SPGROTATOR:Class = SPGRotator;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_TANKINDICATOR_TANKINDICATOR:Class = TankIndicator;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_TANKINDICATOR_TANKROTATOR:Class = TankRotator;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_TANKINDICATOR_VEHICLETURRET:Class = VehicleTurret;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_TANKINDICATOR_WHEEL:Class = Wheel;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_TANKINDICATOR_WHEELROTATOR:Class = WheelRotator;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_TANKINDICATOR_WHEELTURRET:Class = WheelTurret;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_TANKMAN_TANKMANASSETS:Class = TankmanAssets;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_TANKMAN_TANKMANDUMPER:Class = TankmanDumper;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_TANKMAN_TANKMANIDENTIFIERS:Class = TankmanIdentifiers;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_TANKMAN_TANKMENCTRL:Class = TankmenCtrl;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_INTERFACES_IASSETCREATOR:Class = IAssetCreator;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_INTERFACES_IDAMAGEPANELCLICKABLEITEM:Class = IDamagePanelClickableItem;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_INTERFACES_IDAMAGEPANELITEMSCTRL:Class = IDamagePanelItemsCtrl;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_VO_DAMAGEPANELTOOLTIPVO:Class = DamagePanelTooltipVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_VO_ITEMSTATES:Class = ItemStates;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_VO_TANKINDICATORITEM:Class = TankIndicatorItem;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_VO_TOOLTIPSTRINGBYITEMSTATEVO:Class = TooltipStringByItemStateVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DEBUGPANEL_DEBUGPANEL:Class = DebugPanel;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DESTROYTIMERS_DESTROYTIMER:Class = DestroyTimer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DESTROYTIMERS_EPICDESTROYTIMERSPANEL:Class = EpicDestroyTimersPanel;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DESTROYTIMERS_EVENTDESTROYTIMERSPANEL:Class = EventDestroyTimersPanel;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DESTROYTIMERS_POIMAINTIMER:Class = PoiMainTimer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DESTROYTIMERS_POISECONDARYTIMER:Class = PoiSecondaryTimer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DESTROYTIMERS_POITIMER:Class = PoiTimer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DESTROYTIMERS_RESUPPLYTIMER:Class = ResupplyTimer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DESTROYTIMERS_SECONDARYTIMER:Class = SecondaryTimer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DESTROYTIMERS_SECONDARYTIMERBASE:Class = SecondaryTimerBase;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DESTROYTIMERS_STATUSNOTIFICATIONTIMER:Class = StatusNotificationTimer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DESTROYTIMERS_COMPONENTS_CIRCLEPROGRESSBAR:Class = CircleProgressBar;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DESTROYTIMERS_COMPONENTS_SECONDARYTIMERCONTAINER:Class = SecondaryTimerContainer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DESTROYTIMERS_COMPONENTS_SECONDARYTIMERSETTING:Class = SecondaryTimerSetting;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DESTROYTIMERS_COMPONENTS_TIMERCONTAINER:Class = TimerContainer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DESTROYTIMERS_COMPONENTS_SECONDARYTIMERFX_ISECONDARYTIMERFX:Class = ISecondaryTimerFX;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DESTROYTIMERS_COMPONENTS_SECONDARYTIMERFX_MULTIPLEHITFXANIMATION:Class = MultipleHitFXAnimation;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DESTROYTIMERS_COMPONENTS_SECONDARYTIMERFX_SECONDARYTIMERFXANIMATION:Class = SecondaryTimerFXAnimation;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DESTROYTIMERS_COMPONENTS_SECONDARYTIMERFX_SECONDARYTIMERFXCONTAINER:Class = SecondaryTimerFXContainer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DESTROYTIMERS_COMPONENTS_SECONDARYTIMERFX_STUNTIMERFX:Class = StunTimerFX;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DESTROYTIMERS_DATA_NOTIFICATIONTIMERSETTINGVO:Class = NotificationTimerSettingVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DESTROYTIMERS_DATA_STATUSNOTIFICATIONSPANELINITVO:Class = StatusNotificationsPanelInitVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DESTROYTIMERS_DATA_STATUSNOTIFICATIONVO:Class = StatusNotificationVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DESTROYTIMERS_DATA_TIMERSPANELINITVO:Class = TimersPanelInitVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DESTROYTIMERS_EVENTS_DESTROYTIMEREVENT:Class = DestroyTimerEvent;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DIRECTIONINDICATOR_ARTYDIRECTIONINDICATOR:Class = ArtyDirectionIndicator;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DIRECTIONINDICATOR_BASEVALUEINDICATOR:Class = BaseValueIndicator;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DIRECTIONINDICATOR_DIRECTIONINDICATOR:Class = DirectionIndicator;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DIRECTIONINDICATOR_DIRECTIONINDICATORIMAGE:Class = DirectionIndicatorImage;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DIRECTIONINDICATOR_DIRECTIONINDICATORSHAPE:Class = DirectionIndicatorShape;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DIRECTIONINDICATOR_DIRNINDICATORDISTANCE:Class = DirnIndicatorDistance;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DUALGUNPANEL_DUALGUNBULLETSTATE:Class = DualGunBulletState;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DUALGUNPANEL_DUALGUNCHANGINGPROGRESSINDICATOR:Class = DualGunChangingProgressIndicator;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DUALGUNPANEL_DUALGUNPANEL:Class = DualGunPanel;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DUALGUNPANEL_DUALGUNPANELGUNINDICATOR:Class = DualGunPanelGunIndicator;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DUALGUNPANEL_DUALGUNPANELSTATE:Class = DualGunPanelState;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_DUALGUNPANEL_DUALGUNPANELTIMER:Class = DualGunPanelTimer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICDAMAGEPANEL_EPICDAMAGEPANEL:Class = EpicDamagePanel;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICDAMAGEPANEL_COMPONENTS_GENERALBONUS:Class = GeneralBonus;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICDEPLOYMENTMAP_EPICDEPLOYMENTMAP:Class = EpicDeploymentMap;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICDEPLOYMENTMAP_COMPONENTS_EPICDEPLOYMENTMAPENTRIESCONTAINER:Class = EpicDeploymentMapEntriesContainer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICDEPLOYMENTMAP_COMPONENTS_EPICMAPCONTAINER:Class = EpicMapContainer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICDEPLOYMENTMAP_CONSTANTS_DEPLOYMENTMAPCONSTANTS:Class = DeploymentMapConstants;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICDEPLOYMENTMAP_EVENTS_EPICDEPLOYMENTMAPEVENT:Class = EpicDeploymentMapEvent;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICINGAMERANK_EPICINGAMERANKANIMATEDPROGRESS:Class = EpicInGameRankAnimatedProgress;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICINGAMERANK_EPICINGAMERANKICON:Class = EpicInGameRankIcon;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICINGAMERANK_EPICINGAMERANKPANEL:Class = EpicInGameRankPanel;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICINGAMERANK_DATA_EPICINGAMERANKVO:Class = EpicInGameRankVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICINGAMERANK_EVENTS_EPICINGAMERANKEVENT:Class = EpicInGameRankEvent;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICMESSAGESPANEL_EPICMESSAGESPANEL:Class = EpicMessagesPanel;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICMESSAGESPANEL_COMPONENTS_BASECAPTUREMESSAGE:Class = BaseCaptureMessage;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICMESSAGESPANEL_COMPONENTS_BASECONTESTEDMESSAGE:Class = BaseContestedMessage;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICMESSAGESPANEL_COMPONENTS_FIRSTGENERALRANKREACHEDMESSAGE:Class = FirstGeneralRankReachedMessage;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICMESSAGESPANEL_COMPONENTS_HEADQUARTERATTACKEDMESSAGE:Class = HeadquarterAttackedMessage;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICMESSAGESPANEL_COMPONENTS_HEADQUARTERDESTROYEDMESSAGE:Class = HeadquarterDestroyedMessage;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICMESSAGESPANEL_COMPONENTS_MESSAGEBASEMARKER:Class = MessageBaseMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICMESSAGESPANEL_COMPONENTS_MESSAGEHQMARKER:Class = MessageHQMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICMESSAGESPANEL_COMPONENTS_OVERTIMEMESSAGE:Class = OverTimeMessage;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICMESSAGESPANEL_COMPONENTS_RANKUPMESSAGE:Class = RankUpMessage;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICMESSAGESPANEL_COMPONENTS_RANKUPSUBELEMENT:Class = RankUpSubElement;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICMESSAGESPANEL_COMPONENTS_RETREATMESSAGE:Class = RetreatMessage;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICMESSAGESPANEL_COMPONENTS_TIMEREMAININGMESSAGE:Class = TimeRemainingMessage;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICMESSAGESPANEL_COMPONENTS_UNLOCKTANKLEVELMESSAGE:Class = UnlockTankLevelMessage;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICMESSAGESPANEL_DATA_FIRSTGENERALRANKREACHEDMESSAGEVO:Class = FirstGeneralRankReachedMessageVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICMESSAGESPANEL_DATA_HEADQUARTERATTACKEDMESSAGEVO:Class = HeadquarterAttackedMessageVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICMESSAGESPANEL_DATA_HEADQUARTERDESTROYEDMESSAGEVO:Class = HeadquarterDestroyedMessageVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICMESSAGESPANEL_DATA_MISSIONCHANGEMESSAGEVO:Class = MissionChangeMessageVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICMESSAGESPANEL_DATA_OVERTIMEMESSAGEVO:Class = OverTimeMessageVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICMESSAGESPANEL_DATA_RANKUPMESSAGEVO:Class = RankUpMessageVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICMESSAGESPANEL_DATA_SECTORBASECONTESTEDMESSAGEVO:Class = SectorBaseContestedMessageVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICMESSAGESPANEL_DATA_SECTORBASEMESSAGEVO:Class = SectorBaseMessageVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICMISSIONSPANEL_EPICMISSIONSPANEL:Class = EpicMissionsPanel;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICMISSIONSPANEL_COMPONENTS_EPICMISSIONSANIMATEDMARKER:Class = EpicMissionsAnimatedMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICMISSIONSPANEL_DATA_EPICMISSIONVO:Class = EpicMissionVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICOVERVIEWMAPSCREEN_EPICOVERVIEWMAPSCREEN:Class = EpicOverviewMapScreen;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICOVERVIEWMAPSCREEN_DATA_EPICOVERVIEWMAPSCREENVO:Class = EpicOverviewMapScreenVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICREINFORCEMENTPANEL_EPICREINFORCEMENTPANEL:Class = EpicReinforcementPanel;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICRESPAWNVIEW_EPICRESPAWNVIEW:Class = EpicRespawnView;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICRESPAWNVIEW_COMPONENTS_EPICRESPAWNDEPLOYBUTTONGROUP:Class = EpicRespawnDeployButtonGroup;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICRESPAWNVIEW_COMPONENTS_EPICRESPAWNMAPENTRIESCONTAINER:Class = EpicRespawnMapEntriesContainer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICRESPAWNVIEW_COMPONENTS_EPICRESPAWNPOINT:Class = EpicRespawnPoint;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICRESPAWNVIEW_DATA_RESPAWNPOINTVO:Class = RespawnPointVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICRESPAWNVIEW_EVENTS_EPICRESPAWNEVENT:Class = EpicRespawnEvent;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICSCOREPANEL_EPICSCOREPANEL:Class = EpicScorePanel;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICSCOREPANEL_COMPONENTS_HEADQUARTERENTRYANIMATED:Class = HeadquarterEntryAnimated;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICSCOREPANEL_COMPONENTS_HEADQUARTERSCOREENTRY:Class = HeadquarterScoreEntry;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICSCOREPANEL_COMPONENTS_SECTORBASEENTRYANIMATED:Class = SectorBaseEntryAnimated;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICSCOREPANEL_COMPONENTS_SECTORBASESCOREENTRY:Class = SectorBaseScoreEntry;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICSCOREPANEL_EVENTS_EPICSCOREPANELEVENT:Class = EpicScorePanelEvent;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_EPICSPECTATORVIEW_EPICSPECTATORVIEW:Class = EpicSpectatorView;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_GAMEMESSAGESPANEL_GAMEMESSAGESPANEL:Class = GameMessagesPanel;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_GAMEMESSAGESPANEL_COMPONENTS_ENDGAMEMESSAGE:Class = EndGameMessage;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_GAMEMESSAGESPANEL_COMPONENTS_ENDGAMEMESSAGETEXTFIELDS:Class = EndGameMessageTextfields;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_GAMEMESSAGESPANEL_COMPONENTS_MESSAGECONTAINERBASE:Class = MessageContainerBase;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_GAMEMESSAGESPANEL_DATA_BASEGAMEMESSAGEVO:Class = BaseGameMessageVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_GAMEMESSAGESPANEL_DATA_ENDGAMEMESSAGEVO:Class = EndGameMessageVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_GAMEMESSAGESPANEL_DATA_GAMEMESSAGEVO:Class = GameMessageVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_GAMEMESSAGESPANEL_EVENTS_GAMEMESSAGESPANELEVENT:Class = GameMessagesPanelEvent;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MAPINFOTIP_MAPINFOTIP:Class = MapInfoTip;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MESSAGES_FADEDMESSAGESPOOL:Class = FadedMessagesPool;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MESSAGES_FADEDTEXTMESSAGE:Class = FadedTextMessage;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MESSAGES_IMESSAGE:Class = IMessage;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MESSAGES_MESSAGELIST:Class = MessageList;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MESSAGES_MESSAGELISTDAAPI:Class = MessageListDAAPI;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MESSAGES_COMPONENTS_TEXTMESSAGERENDERER:Class = TextMessageRenderer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MESSAGES_EVENTS_MESSAGEEVENT:Class = MessageEvent;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MESSAGES_INTERFACES_IMESSAGELIST:Class = IMessageList;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MESSAGES_VO_FADINGMESSAGELISTSETTINGSVO:Class = FadingMessageListSettingsVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MESSAGES_VO_MESSAGELISTSETTINGSVO:Class = MessageListSettingsVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MESSAGES_VO_POOLSETTINGSVO:Class = PoolSettingsVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_BASEMINIMAP:Class = BaseMinimap;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_EPICMINIMAP:Class = EpicMinimap;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_MINIMAP:Class = Minimap;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_MINIMAPENTRYCONTROLLER:Class = MinimapEntryController;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_MINIMAPHINT:Class = MinimapHint;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_MINIMAPHINTICONINFO:Class = MinimapHintIconInfo;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_MINIMAPICONCOLLECTION:Class = MinimapIconCollection;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_SCENARIOLAYER:Class = ScenarioLayer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_ARTY_ARTYHITDOTMARKER:Class = ArtyHitDotMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_ARTY_ARTYMARKERMINIMAPENTRY:Class = ArtyMarkerMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_BACKGROUND_BOOTCAMPTARGETMINIMAPENTRY:Class = BootcampTargetMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_BATTLEROYALE_BRMARKER:Class = BRMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_BATTLEROYALE_DEATHZONEMINIMAPENTRY:Class = DeathZoneMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_BATTLEROYALE_DISCOVEREDITEMMARKER:Class = DiscoveredItemMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_BATTLEROYALE_RADARANIMATION:Class = RadarAnimation;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_COMP7_COMP7POINTRECONMINIMAPENTRY:Class = Comp7PointReconMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_CONSTANTS_ABSORPTIONFLAGENTRYCONST:Class = AbsorptionFlagEntryConst;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_CONSTANTS_BACKGROUNDMINIMAPENTRYCONST:Class = BackgroundMinimapEntryConst;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_CONSTANTS_EPICMINIMAPENTRYCONST:Class = EpicMinimapEntryConst;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_CONSTANTS_FLAGMINIMAPENTRYCONST:Class = FlagMinimapEntryConst;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_CONSTANTS_FORTCONSUMABLESMINIMAPENTRYCONST:Class = FortConsumablesMinimapEntryConst;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_CONSTANTS_PERSONALMINIMAPENTRYCONST:Class = PersonalMinimapEntryConst;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_CONSTANTS_POINTSOFINTERESTMINIMAPENTRYCONST:Class = PointsOfInterestMinimapEntryConst;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_CONSTANTS_REPAIRMINIMAPENTRYCONST:Class = RepairMinimapEntryConst;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_CONSTANTS_SCENARIOMINIMAPENTRYCONST:Class = ScenarioMinimapEntryConst;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_CONSTANTS_TEAMBASEMINIMAPENTRYCONST:Class = TeamBaseMinimapEntryConst;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_CONSTANTS_VEHICLEMINIMAPENTRYCONST:Class = VehicleMinimapEntryConst;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_EPIC_FRONTLINEPOINTENTRY:Class = FrontLinePointEntry;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_EPIC_HEADQUARTERMINIMAPENTRY:Class = HeadquarterMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_EPIC_LANDINGZONEMINIMAPENTRY:Class = LandingZoneMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_EPIC_RECONMINIMAPENTRY:Class = ReconMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_EPIC_RESUPPLYMINIMAPENTRY:Class = ResupplyMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_EPIC_SECTORBASEMINIMAPENTRY:Class = SectorBaseMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_EPIC_SECTORMINIMAPENTRY:Class = SectorMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_EPIC_SECTOROVERLAYMINIMAPENTRY:Class = SectorOverlayMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_FORTCONSUMABLES_AOEARTILLERYMINIMAPENTRY:Class = AOEArtilleryMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_FORTCONSUMABLES_ARTILLERYMINIMAPENTRY:Class = ArtilleryMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_FORTCONSUMABLES_ARTILLERYYELLOWMINIMAPENTRY:Class = ArtilleryYellowMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_FORTCONSUMABLES_BOMBERMINIMAPENTRY:Class = BomberMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_FORTCONSUMABLES_SMOKEMINIMAPENTRY:Class = SmokeMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_INTERFACES_IHIGHLIGHTABLEMINIMAPENTRY:Class = IHighlightableMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_INTERFACES_IMINIMAPENTRYWITHNONSCALECONTENT:Class = IMinimapEntryWithNonScaleContent;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_INTERFACES_IVEHICLEMINIMAPENTRY:Class = IVehicleMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_PERSONAL_ANIMATIONMINIMAPENTRY:Class = AnimationMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_PERSONAL_DEADPOINTMINIMAPENTRY:Class = DeadPointMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_PERSONAL_DIRECTIONMINIMAPENTRY:Class = DirectionMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_PERSONAL_DISTANCEDRAWER:Class = DistanceDrawer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_PERSONAL_PINGFLASHMINIMAPENTRY:Class = PingFlashMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_PERSONAL_RECTANGLEAREAMINIMAPENTRY:Class = RectangleAreaMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_PERSONAL_SIMPLEATTENTIONTOFLASHMINIMAPENTRY:Class = SimpleAttentionToFlashMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_PERSONAL_VIDEOCAMERAMINIMAPENTRY:Class = VideoCameraMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_PERSONAL_VIEWPOINTMINIMAPENTRY:Class = ViewPointMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_PERSONAL_VIEWRANGECIRCLESMINIMAPENTRY:Class = ViewRangeCirclesMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_PERSONAL_VIEWRANGESECTORMINIMAPENTRY:Class = ViewRangeSectorMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_POINTSOFINTEREST_MINIMAPPOIPROGRESSCIRCLE:Class = MinimapPoiProgressCircle;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_POINTSOFINTEREST_POIMINIMAPENTRY:Class = PoiMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_SCENARIO_SCENARIOMINIMAPENTRY:Class = ScenarioMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_SCENARIO_SCENARIOMINIMAPPROGRESSCIRCLE:Class = ScenarioMinimapProgressCircle;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_TEAMBASE_ALLYTEAMBASEMINIMAPENTRY:Class = AllyTeamBaseMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_TEAMBASE_ALLYTEAMSPAWNMINIMAPENTRY:Class = AllyTeamSpawnMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_TEAMBASE_CONTROLPOINTMINIMAPENTRY:Class = ControlPointMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_TEAMBASE_ENEMYTEAMBASEMINIMAPENTRY:Class = EnemyTeamBaseMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_TEAMBASE_ENEMYTEAMSPAWNMINIMAPENTRY:Class = EnemyTeamSpawnMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_TEAMBASE_MINIMAPPROGRESSCIRCLE:Class = MinimapProgressCircle;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_VEHICLE_MARKERTOPANIMATION:Class = MarkerTopAnimation;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_VEHICLE_MINIMAPENTRYLABELHELPER:Class = MinimapEntryLabelHelper;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_VEHICLE_VEHICLEANIMATIONMINIMAPENTRY:Class = VehicleAnimationMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_VEHICLE_VEHICLEMINIMAPENTRY:Class = VehicleMinimapEntry;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_CONSTANTS_MINIMAPCOLORCONST:Class = MinimapColorConst;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_CONSTANTS_MINIMAPSIZECONST:Class = MinimapSizeConst;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_CONTAINERS_EPICMINIMAPENTRIESCONTAINER:Class = EpicMinimapEntriesContainer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_CONTAINERS_MINIMAPENTRIESCONTAINER:Class = MinimapEntriesContainer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_EVENTS_MINIMAPEVENT:Class = MinimapEvent;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_PERKSPANEL_PERKSPANEL:Class = PerksPanel;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_PERKSPANEL_COMPONENTS_PERKITEM:Class = PerkItem;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_PERKSPANEL_DATA_PERKITEMVO:Class = PerkItemVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_PERKSPANEL_EVENTS_PERKITEMEVENT:Class = PerkItemEvent;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_PERSONALRESERVESTAB_PERSONALRESERVESTAB:Class = PersonalReservesTab;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_PIERCINGDEBUGPANEL_PIERCINGDEBUGPANEL:Class = PiercingDebugPanel;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_PIERCINGDEBUGPANEL_PIERCINGDEBUGRENDERER:Class = PiercingDebugRenderer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_PIERCINGDEBUGPANEL_DATA_DEBUGPANELVO:Class = DebugPanelVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_PIERCINGDEBUGPANEL_DATA_PIERCINGITEMVO:Class = PiercingItemVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_POSTMORTEMPANEL_BASEPOSTMORTEMPANEL:Class = BasePostmortemPanel;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_POSTMORTEMPANEL_IVEHICLEPANEL:Class = IVehiclePanel;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_POSTMORTEMPANEL_POSTMORTEMPANEL:Class = PostmortemPanel;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_POSTMORTEMPANEL_VEHICLEPANEL:Class = VehiclePanel;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_POSTMORTEMTIPS_POSTMORTEMTIPS:Class = PostmortemTips;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_PREBATTLEINFO_PREBATTLEINFOCONTAINER:Class = PrebattleInfoContainer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_PREBATTLEINFO_PREBATTLEINFOVIEWBASE:Class = PrebattleInfoViewBase;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_PREBATTLEINFO_QUESTINFO_QUESTINFOFLAG:Class = QuestInfoFlag;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_PREBATTLEINFO_QUESTINFO_QUESTINFOFLAGBG:Class = QuestInfoFlagBg;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_PREBATTLEINFO_QUESTINFO_QUESTINFOFLAGTASKICOCONTAINER:Class = QuestInfoFlagTaskIcoContainer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_PREBATTLEINFO_QUESTINFO_QUESTINFOFLAGVO:Class = QuestInfoFlagVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_PREBATTLETIMER_PREBATTLETIMER:Class = PrebattleTimer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_PREBATTLETIMER_PREBATTLETIMERBASE:Class = PrebattleTimerBase;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_PREBATTLETIMER_PREBATTLETIMERBG:Class = PrebattleTimerBg;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_PREBATTLETIMER_PREBATTLETIMEREVENT:Class = PrebattleTimerEvent;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_QUESTPROGRESS_QUESTPROGRESSANIMATEDWRAPPER:Class = QuestProgressAnimatedWrapper;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_QUESTPROGRESS_QUESTPROGRESSTABVIEW:Class = QuestProgressTabView;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_QUESTPROGRESS_QUESTPROGRESSTOPVIEW:Class = QuestProgressTopView;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_QUESTPROGRESS_QUESTPROGRESSVIEW:Class = QuestProgressView;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_QUESTPROGRESS_ANIMATED_ANIMATIONITEM:Class = AnimationItem;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_QUESTPROGRESS_ANIMATED_ANIMATIONITEMCOMPLETED:Class = AnimationItemCompleted;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_QUESTPROGRESS_ANIMATED_ANIMATIONITEMFAILED:Class = AnimationItemFailed;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_QUESTPROGRESS_ANIMATED_ANIMATIONITEMPROGRESS:Class = AnimationItemProgress;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_QUESTPROGRESS_ANIMATED_ANIMATIONRING:Class = AnimationRing;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_QUESTPROGRESS_ANIMATED_ANIMATIONTOPCONTAINER:Class = AnimationTopContainer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_QUESTPROGRESS_ANIMATED_ANIMICONCONTAINER:Class = AnimIconContainer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_QUESTPROGRESS_ANIMATED_ANIMSTEPPROGRESS:Class = AnimStepProgress;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_QUESTPROGRESS_ANIMATED_ANIMVALUECONTAINER:Class = AnimValueContainer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_QUESTPROGRESS_ANIMATED_IANIMATIONTOPCONTAINER:Class = IAnimationTopContainer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_QUESTPROGRESS_ANIMATED_IQUEUEANIMCONTROLLERITEM:Class = IQueueAnimControllerItem;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_QUESTPROGRESS_ANIMATED_IQUEUEANIMPROGRESSSTATE:Class = IQueueAnimProgressState;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_QUESTPROGRESS_ANIMATED_IQUEUEITEM:Class = IQueueItem;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_QUESTPROGRESS_ANIMATED_QUESTPROGRESSQUEUEANIMABSTRACT:Class = QuestProgressQueueAnimAbstract;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_QUESTPROGRESS_ANIMATED_QUESTPROGRESSQUEUESTATEANIM:Class = QuestProgressQueueStateAnim;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_QUESTPROGRESS_ANIMATED_UPDATEVIEWDATAQUEUEITEM:Class = UpdateViewDataQueueItem;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_QUESTPROGRESS_COMPONENTS_QPFLAG:Class = QPFlag;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_QUESTPROGRESS_COMPONENTS_QPLOCK:Class = QPLock;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_QUESTPROGRESS_COMPONENTS_QPLOCKLINEANIMATION:Class = QPLockLineAnimation;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_QUESTPROGRESS_COMPONENTS_QUESTPROGRESSTRACKING:Class = QuestProgressTracking;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_QUESTPROGRESS_COMPONENTS_QUESTTRACKINGBUTTON:Class = QuestTrackingButton;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_QUESTPROGRESS_COMPONENTS_QUESTTRACKINGONPAUSE:Class = QuestTrackingOnPause;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_QUESTPROGRESS_DATA_QPPROGRESSTRACKINGVO:Class = QPProgressTrackingVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_QUESTPROGRESS_DATA_QPTRACKINGDATAITEMVO:Class = QPTrackingDataItemVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_QUESTPROGRESS_DATA_QUESTPROGRESSPERFORMVO:Class = QuestProgressPerformVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_QUESTPROGRESS_EVENTS_QUESTPROGRESSANIMATEDWRAPPEREVENT:Class = QuestProgressAnimatedWrapperEvent;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_QUESTPROGRESS_EVENTS_QUESTPROGRESSTABEVENT:Class = QuestProgressTabEvent;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_QUESTPROGRESS_HELPER_BATTLEQUESTPROGRESSCONSTS:Class = BattleQuestProgressConsts;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_QUESTPROGRESS_HELPER_QUESTPROGRESSTOPVIEWITEMSPOS:Class = QuestProgressTopViewItemsPos;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_QUESTPROGRESS_INTERFACES_IQUESTPROGRESSDATAHUB:Class = IQuestProgressDataHub;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_QUESTPROGRESS_INTERFACES_IQUESTPROGRESSVIEW:Class = IQuestProgressView;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_QUESTPROGRESS_INTERFACES_IQUESTPROGRESSVIEWOPERATIONSELECTOR:Class = IQuestProgressViewOperationSelector;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_QUESTPROGRESS_INTERFACES_IQUESTPROGRESSVIEWUPDATABLE:Class = IQuestProgressViewUpdatable;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_RADIALMENU_RADIALBUTTON:Class = RadialButton;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_RADIALMENU_RADIALMENU:Class = RadialMenu;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_RADIALMENU_COMPONENTS_BACKGROUND:Class = BackGround;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_RADIALMENU_COMPONENTS_CONTENT:Class = Content;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_RADIALMENU_COMPONENTS_ICONS:Class = Icons;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_RADIALMENU_COMPONENTS_SECTORHOVEREDWRAPPER:Class = SectorHoveredWrapper;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_RADIALMENU_COMPONENTS_SECTORWRAPPER:Class = SectorWrapper;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_RECOVERYPANEL_RECOVERYHINT:Class = RecoveryHint;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_RECOVERYPANEL_RECOVERYPANEL:Class = RecoveryPanel;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_RIBBONSPANEL_ANIMATIONSET:Class = AnimationSet;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_RIBBONSPANEL_EFFICIENCYBONUSANIMATION:Class = EfficiencyBonusAnimation;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_RIBBONSPANEL_RIBBONCTRL:Class = RibbonCtrl;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_RIBBONSPANEL_RIBBONQUEUE:Class = RibbonQueue;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_RIBBONSPANEL_RIBBONSPANEL:Class = RibbonsPanel;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_RIBBONSPANEL_RIBBONSPOOL:Class = RibbonsPool;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_RIBBONSPANEL_DATA_RIBBONANIMATIONSTATES:Class = RibbonAnimationStates;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_RIBBONSPANEL_DATA_RIBBONQUEUEITEM:Class = RibbonQueueItem;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_ROCKETACCELERATORPANEL_ROCKETACCELERATORPANEL:Class = RocketAcceleratorPanel;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_ROLEDESCRIPTION_ROLEACTION:Class = RoleAction;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_ROLEDESCRIPTION_ROLEDESCRIPTION:Class = RoleDescription;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_ROLEDESCRIPTION_DATA_ROLEACTIONVO:Class = RoleActionVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_ROLEDESCRIPTION_DATA_ROLEDESCRIPTIONVO:Class = RoleDescriptionVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_SIEGEMODEPANEL_SIEGEMODEANIMATION:Class = SiegeModeAnimation;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_SIEGEMODEPANEL_SIEGEMODEPANEL:Class = SiegeModePanel;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_SIEGEMODEPANEL_TURBOSIEGEMODEANIMATION:Class = TurboSiegeModeAnimation;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_SIEGEMODEPANEL_YOHCHASSISMODEANIMATION:Class = YohChassisModeAnimation;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_SIXTHSENSE_SIXTHSENSE:Class = SixthSense;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_EPIC_OBJECTIVEIDREPLYSTATE:Class = ObjectiveIdReplyState;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_EPIC_HEADQUARTER_HEADQUARTERACTIONMARKER:Class = HeadquarterActionMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_EPIC_HEADQUARTER_HEADQUARTERANIMATION:Class = HeadquarterAnimation;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_EPIC_HEADQUARTER_HEADQUARTERICON:Class = HeadquarterIcon;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_EPIC_HEADQUARTER_HEADQUARTERLIFESTATES:Class = HeadquarterLifeStates;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_EPIC_HEADQUARTER_HEADQUARTERMARKER:Class = HeadquarterMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_EPIC_RESUPPLYPOINT_RESUPPLYICON:Class = ResupplyIcon;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_EPIC_RESUPPLYPOINT_RESUPPLYMARKER:Class = ResupplyMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_EPIC_SECTORBASE_SECTORBASEACTIONS:Class = SectorBaseActions;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_EPIC_SECTORBASE_SECTORBASEICON:Class = SectorBaseIcon;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_EPIC_SECTORBASE_SECTORBASEMARKER:Class = SectorBaseMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_EPIC_SECTORWARNING_SECTORWARNINGMARKER:Class = SectorWarningMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_EPIC_SECTORWAYPOINT_SECTORWAYPOINTICON:Class = SectorWaypointIcon;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_EPIC_SECTORWAYPOINT_SECTORWAYPOINTMARKER:Class = SectorWaypointMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_FLAG_FLAGICON:Class = FlagIcon;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_FLAG_FLAGMARKER:Class = FlagMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_FLAG_CONSTANT_FLAGMARKERSTATE:Class = FlagMarkerState;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_INTERESTPOINT_INTERESTPOINTMARKER:Class = InterestPointMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_INTERESTPOINT_MARKERPOIPROGRESSCIRCLE:Class = MarkerPoiProgressCircle;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_LOCATION_FLAGLOCATIONACTIONMARKER:Class = FlagLocationActionMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_LOCATION_LOCATIONACTIONMARKER:Class = LocationActionMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_LOCATION_LOCATIONMARKER:Class = LocationMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_REPAIRPOINT_REPAIRPOINTICON:Class = RepairPointIcon;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_REPAIRPOINT_REPAIRPOINTMARKER:Class = RepairPointMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_SAFEZONE_SAFEZONEMARKER:Class = SafeZoneMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_SCENARIO_SCENARIOMARKER:Class = ScenarioMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_SCENARIO_SCENARIOMARKERPROGRESSCIRCLE:Class = ScenarioMarkerProgressCircle;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATS_SPEAKANIMATION:Class = SpeakAnimation;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATS_SQUADTOOLTIP:Class = SquadTooltip;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATS_STATSUSERPROPS:Class = StatsUserProps;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATS_CONSTANTS_DYNAMICSQUADSTATE:Class = DynamicSquadState;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATS_CONSTANTS_FULLSTATSVALIDATIONTYPE:Class = FullStatsValidationType;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATS_CONSTANTS_PLAYERSTATUSSCHEMENAME:Class = PlayerStatusSchemeName;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATS_CONSTANTS_SQUADINVALIDATIONTYPE:Class = SquadInvalidationType;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATS_FULLSTATS_DOGTAGCTRL:Class = DogTagCtrl;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATS_FULLSTATS_FULLSTATSTABLEBASE:Class = FullStatsTableBase;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATS_FULLSTATS_SQUADINVITESTATUSVIEW:Class = SquadInviteStatusView;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATS_FULLSTATS_STATSTABLECONTROLLERBASE:Class = StatsTableControllerBase;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATS_FULLSTATS_STATSTABLEITEMBASE:Class = StatsTableItemBase;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATS_FULLSTATS_STATSTABLEITEMCOMMON:Class = StatsTableItemCommon;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATS_FULLSTATS_STATSTABLEITEMHOLDERBASE:Class = StatsTableItemHolderBase;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATS_FULLSTATS_STATSTABLEITEMHOLDERCOMMON:Class = StatsTableItemHolderCommon;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATS_FULLSTATS_STATSTABLEITEMPOSITIONCONTROLLER:Class = StatsTableItemPositionController;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATS_FULLSTATS_INTERFACES_ISTATSTABLEITEMHANDLER:Class = IStatsTableItemHandler;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATS_FULLSTATS_INTERFACES_ISTATSTABLEITEMHOLDERBASE:Class = IStatsTableItemHolderBase;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATSHINT_STATSHINT:Class = StatsHint;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_SUPERPLATOONPANEL_SUPERPLATOONPANEL:Class = SuperPlatoonPanel;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_SUPERPLATOONPANEL_COMPONENTS_PLATOONINVITEPANEL:Class = PlatoonInvitePanel;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_SUPERPLATOONPANEL_COMPONENTS_PLATOONMEMBERSPANEL:Class = PlatoonMembersPanel;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_SUPERPLATOONPANEL_LIST_PLATOONMEMBERLISTITEMHOLDER:Class = PlatoonMemberListItemHolder;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_SUPERPLATOONPANEL_LIST_PLATOONPANELLIST:Class = PlatoonPanelList;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_SUPERPLATOONPANEL_RENDERERS_PLATOONINVITERENDERER:Class = PlatoonInviteRenderer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_SUPERPLATOONPANEL_RENDERERS_PLATOONMEMBERLISTITEMRENDERER:Class = PlatoonMemberListItemRenderer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_SUPERPLATOONPANEL_RENDERERS_PLAYERINFOCONTAINER:Class = PlayerInfoContainer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_UPGRADEPANEL_BATTLEUPGRADEPANEL:Class = BattleUpgradePanel;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_UPGRADEPANEL_NOTIFICATIONBORDERANIMATION:Class = NotificationBorderAnimation;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_UPGRADEPANEL_NOTIFICATIONBORDERCONTAINER:Class = NotificationBorderContainer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_UPGRADEPANEL_DATA_UPGRADEPANELVO:Class = UpgradePanelVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_ACTIONICONSTATEMARKER:Class = ActionIconStateMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_ANIMATEEXPLOSION:Class = AnimateExplosion;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_BRANDERVEHICLE2DMARKER:Class = BranderVehicle2dMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_COMP7VEHICLEMARKER:Class = Comp7VehicleMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_DAMAGELABEL:Class = DamageLabel;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_FLAGCONTAINER:Class = FlagContainer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_FORTCONSUMABLESMARKER:Class = FortConsumablesMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_HEALTHBAR:Class = HealthBar;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_HEALTHBARANIMATEDLABEL:Class = HealthBarAnimatedLabel;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_HEALTHBARANIMATEDPART:Class = HealthBarAnimatedPart;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_HPFIELDCONTAINER:Class = HPFieldContainer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_IMARKERMANAGERHANDLER:Class = IMarkerManagerHandler;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_IVEHICLEMARKERINVOKABLE:Class = IVehicleMarkerInvokable;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_IVEHICLEMARKERSMANAGER:Class = IVehicleMarkersManager;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_STATICARTYMARKER:Class = StaticArtyMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_STATICOBJECTMARKER:Class = StaticObjectMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_TARGETMARKER:Class = TargetMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VEHICLEACTIONMARKER:Class = VehicleActionMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VEHICLEDISTANCE:Class = VehicleDistance;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VEHICLEICONANIMATION:Class = VehicleIconAnimation;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VEHICLEMARKER:Class = VehicleMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VEHICLEMARKERSCONSTANTS:Class = VehicleMarkersConstants;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VEHICLEMARKERSLINKAGES:Class = VehicleMarkersLinkages;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VEHICLEMARKERSMANAGER:Class = VehicleMarkersManager;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VEHICLESTATUSCONTAINERMARKER:Class = VehicleStatusContainerMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VMATLASITEMNAME:Class = VMAtlasItemName;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_EVENTS_STATUSANIMATIONEVENT:Class = StatusAnimationEvent;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_EVENTS_TIMELINEEVENT:Class = TimelineEvent;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_EVENTS_VEHICLEMARKERSMANAGEREVENT:Class = VehicleMarkersManagerEvent;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_STATUSMARKERS_MARKERASSETCONTAINER:Class = MarkerAssetContainer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_STATUSMARKERS_MARKERTIMER:Class = MarkerTimer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_STATUSMARKERS_VEHICLEANIMATEDSTATUSBASEMARKER:Class = VehicleAnimatedStatusBaseMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_STATUSMARKERS_VEHICLEBERSERKERMARKER:Class = VehicleBerserkerMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_STATUSMARKERS_VEHICLEENGINEEREFFECTMARKER:Class = VehicleEngineerEffectMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_STATUSMARKERS_VEHICLEFLBASICMARKER:Class = VehicleFLBasicMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_STATUSMARKERS_VEHICLEINSPIREMARKER:Class = VehicleInspireMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_STATUSMARKERS_VEHICLEINSPIRETARGETMARKER:Class = VehicleInspireTargetMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_STATUSMARKERS_VEHICLESPECIALABILITYMARKER:Class = VehicleSpecialAbilityMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_STATUSMARKERS_VEHICLESTATUSICONMARKER:Class = VehicleStatusIconMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_STATUSMARKERS_VEHICLESTATUSMARKER:Class = VehicleStatusMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_STATUSMARKERS_VEHICLESTUNMARKER:Class = VehicleStunMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VO_CROSSOFFSET:Class = CrossOffset;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VO_HPDISPLAYMODE:Class = HPDisplayMode;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VO_VEHICLEMARKERFLAGS:Class = VehicleMarkerFlags;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VO_VEHICLEMARKERPART:Class = VehicleMarkerPart;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VO_VEHICLEMARKERSETTINGS:Class = VehicleMarkerSettings;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VO_VEHICLEMARKERVO:Class = VehicleMarkerVO;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMESSAGES_VEHICLEMESSAGE:Class = VehicleMessage;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMESSAGES_VEHICLEMESSAGES:Class = VehicleMessages;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMESSAGES_VEHICLEMESSAGESPOOL:Class = VehicleMessagesPool;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMESSAGES_VEHICLEMESSAGESVOQUEUE:Class = VehicleMessagesVoQueue;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMESSAGES_VO_VEHICLEMESSAGEVO:Class = VehicleMessageVO;
      
      public static const NET_WG_GUI_BATTLE_WINDOWS_INGAMEDETAILSHELPWINDOW:Class = IngameDetailsHelpWindow;
      
      public static const NET_WG_GUI_BATTLE_WINDOWS_INGAMEHELPWINDOW:Class = IngameHelpWindow;
      
      public static const NET_WG_GUI_BATTLE_WINDOWS_INGAMEMENU:Class = IngameMenu;
      
      public static const NET_WG_GUI_BATTLE_WINDOWS_MAPSTRAININGINGAMEHELPWINDOW:Class = MapsTrainingIngameHelpWindow;
      
      public static const NET_WG_GUI_BATTLE_WINDOWS_COMPONENTS_INGAMEDETAILSROLEACTION:Class = IngameDetailsRoleAction;
      
      public static const NET_WG_GUI_BATTLE_WINDOWS_COMPONENTS_INGAMEDETAILSROLEACTIONCONTAINER:Class = IngameDetailsRoleActionContainer;
      
      public static const NET_WG_GUI_BATTLE_WINDOWS_VO_INGAMEDETAILSPAGEVO:Class = IngameDetailsPageVO;
      
      public static const NET_WG_GUI_BATTLE_WINDOWS_VO_INGAMEDETAILSROLEACTIONVO:Class = IngameDetailsRoleActionVO;
      
      public static const NET_WG_GUI_BOOTCAMP_BCBATTLEEQUIPMENTBUTTON:Class = BCBattleEquipmentButton;
      
      public static const NET_WG_GUI_BOOTCAMP_BCBATTLEPAGE:Class = BCBattlePage;
      
      public static const NET_WG_GUI_BOOTCAMP_BCFCVEHICLEMARKER:Class = BCFCVehicleMarker;
      
      public static const NET_WG_GUI_BOOTCAMP_BCFRAGCORRELATIONBAR:Class = BCFragCorrelationBar;
      
      public static const NET_WG_GUI_BOOTCAMP_BCHIGHLIGHTSOVERLAY:Class = BCHighlightsOverlay;
      
      public static const NET_WG_GUI_BOOTCAMP_BCINTROFADEOUT:Class = BCIntroFadeOut;
      
      public static const NET_WG_GUI_BOOTCAMP_BCPREBATTLETIMER:Class = BCPrebattleTimer;
      
      public static const NET_WG_GUI_BOOTCAMP_BCSECONDARYHINT:Class = BCSecondaryHint;
      
      public static const NET_WG_GUI_BOOTCAMP_BCVEHICLEMARKERSLIST:Class = BCVehicleMarkersList;
      
      public static const NET_WG_GUI_BOOTCAMP_PREBATTLEHINTS_BCPREBATTLEHINTS:Class = BCPrebattleHints;
      
      public static const NET_WG_GUI_BOOTCAMP_PREBATTLEHINTS_CONTROLS_CROSSHAIRCONTAINER:Class = CrosshairContainer;
      
      public static const NET_WG_GUI_COMPONENTS_CONTROLS_READONLYSCROLLINGLIST:Class = ReadOnlyScrollingList;
      
      public static const NET_WG_GUI_COMPONENTS_HINTPANEL_HINTPANEL:Class = HintPanel;
      
      public static const NET_WG_GUI_COMPONENTS_HINTPANEL_KEYVIEWER:Class = KeyViewer;
      
      public static const NET_WG_GUI_COMPONENTS_HINTPANEL_KEYVIEWERCONTAINER:Class = KeyViewerContainer;
      
      public static const NET_WG_GUI_COMPONENTS_HINTPANEL_KEYVIEWERCONTAINERANIM:Class = KeyViewerContainerAnim;
      
      public static const NET_WG_GUI_COMPONENTS_HINTPANEL_KEYVIEWERSLIST:Class = KeyViewersList;
      
      public static const NET_WG_GUI_COMPONENTS_HINTPANEL_MESSAGEANIM:Class = MessageAnim;
      
      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_BLOCKS_TEXTPARAMETERWITHICONBLOCK:Class = TextParameterWithIconBlock;
      
      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_DATA_TEXTPARAMETERWITHICONVO:Class = TextParameterWithIconVO;
      
      public static const NET_WG_INFRASTRUCTURE_BASE_BASEBATTLEDAAPICOMPONENT:Class = BaseBattleDAAPIComponent;
      
      public static const NET_WG_INFRASTRUCTURE_HELPERS_STATISTICSDATACONTROLLER_BATTLESTATISTICDATACONTROLLER:Class = BattleStatisticDataController;
      
      public static const NET_WG_INFRASTRUCTURE_HELPERS_STATISTICSDATACONTROLLER_EPICBATTLESTATISTICDATACONTROLLER:Class = EpicBattleStatisticDataController;
      
      public static const NET_WG_INFRASTRUCTURE_HELPERS_STATISTICSDATACONTROLLER_INTARFACES_IBATTLECOMPONENTDATACONTROLLER:Class = IBattleComponentDataController;
      
      public static const NET_WG_INFRASTRUCTURE_HELPERS_STATISTICSDATACONTROLLER_INTARFACES_IEPICBATTLESTATISTICDATACONTROLLER:Class = IEpicBattleStatisticDataController;
       
      
      public function ClassManagerMeta()
      {
         super();
      }
   }
}
