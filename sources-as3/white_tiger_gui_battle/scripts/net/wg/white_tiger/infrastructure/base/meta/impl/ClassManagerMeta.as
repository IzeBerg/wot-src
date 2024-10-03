package net.wg.white_tiger.infrastructure.base.meta.impl
{
   import net.wg.white_tiger.gui.battle.WTBattlePage;
   import net.wg.white_tiger.gui.battle.infrastructure.WTBattleStatisticDataController;
   import net.wg.white_tiger.gui.battle.views.shared.GeneratorProgressCircle;
   import net.wg.white_tiger.gui.battle.views.shared.HunterResurrectTimer;
   import net.wg.white_tiger.gui.battle.views.shared.TimerAnimHelper;
   import net.wg.white_tiger.gui.battle.views.shared.WTDeploymentMapView;
   import net.wg.white_tiger.gui.battle.views.shared.interfaces.ITimerAnimation;
   import net.wg.white_tiger.gui.battle.views.staticMarkers.BombActionMarker;
   import net.wg.white_tiger.gui.battle.views.staticMarkers.BombActionMarkerTimer;
   import net.wg.white_tiger.gui.battle.views.staticMarkers.BombContent;
   import net.wg.white_tiger.gui.battle.views.staticMarkers.BombMarker;
   import net.wg.white_tiger.gui.battle.views.staticMarkers.GeneratorContent;
   import net.wg.white_tiger.gui.battle.views.staticMarkers.IndexedActionMarker;
   import net.wg.white_tiger.gui.battle.views.staticMarkers.IndexedContent;
   import net.wg.white_tiger.gui.battle.views.staticMarkers.IndexedMarker;
   import net.wg.white_tiger.gui.battle.views.staticMarkers.ScaleAnimation;
   import net.wg.white_tiger.gui.battle.views.staticMarkers.ScaleContainer;
   import net.wg.white_tiger.gui.battle.views.vehicleMarkers.DamageLabel;
   import net.wg.white_tiger.gui.battle.views.vehicleMarkers.PlasmaDamageAnimatedLabel;
   import net.wg.white_tiger.gui.battle.views.vehicleMarkers.WTVehicleMarker;
   import net.wg.white_tiger.gui.battle.views.vehicleMarkers.statusMarkers.VehicleBombMarker;
   import net.wg.white_tiger.gui.battle.views.windows.wtIngameDetailsHelpWindow.WTIngameDetailsHelpWindow;
   import net.wg.white_tiger.gui.battle.views.wtBattleHints.BattleHint;
   import net.wg.white_tiger.gui.battle.views.wtBattleHints.InfoContainer;
   import net.wg.white_tiger.gui.battle.views.wtBattleHints.TextContainer;
   import net.wg.white_tiger.gui.battle.views.wtBattleHints.TimerContainer;
   import net.wg.white_tiger.gui.battle.views.wtBattleHints.data.HintInfoVO;
   import net.wg.white_tiger.gui.battle.views.wtBattleLoading.WTBattleLoading;
   import net.wg.white_tiger.gui.battle.views.wtBattleTimer.AddTimeAnimation;
   import net.wg.white_tiger.gui.battle.views.wtBattleTimer.BattleTimerEvent;
   import net.wg.white_tiger.gui.battle.views.wtBattleTimer.WTBattleTimer;
   import net.wg.white_tiger.gui.battle.views.wtBattleTimer.WTTextFieldContainer;
   import net.wg.white_tiger.gui.battle.views.wtBossWidget.BossWidget;
   import net.wg.white_tiger.gui.battle.views.wtBossWidget.components.BossBackground;
   import net.wg.white_tiger.gui.battle.views.wtBossWidget.components.BossHyperion;
   import net.wg.white_tiger.gui.battle.views.wtBossWidget.components.BossShield;
   import net.wg.white_tiger.gui.battle.views.wtBossWidget.components.BossTankIcon;
   import net.wg.white_tiger.gui.battle.views.wtBossWidget.components.BossVehicle;
   import net.wg.white_tiger.gui.battle.views.wtBossWidget.components.BossVehicleDebuff;
   import net.wg.white_tiger.gui.battle.views.wtBossWidget.components.BossVehicleShield;
   import net.wg.white_tiger.gui.battle.views.wtBossWidget.components.BossWidgetMainProgressBar;
   import net.wg.white_tiger.gui.battle.views.wtBossWidget.components.Generator;
   import net.wg.white_tiger.gui.battle.views.wtBossWidget.components.GeneratorBar;
   import net.wg.white_tiger.gui.battle.views.wtBossWidget.components.Generators;
   import net.wg.white_tiger.gui.battle.views.wtBossWidget.components.ProgressBar;
   import net.wg.white_tiger.gui.battle.views.wtBossWidget.data.BossWidgetVO;
   import net.wg.white_tiger.gui.battle.views.wtBossWidget.events.BossWidgetEvent;
   import net.wg.white_tiger.gui.battle.views.wtConsumablesPanel.BattleEquipmentButton;
   import net.wg.white_tiger.gui.battle.views.wtConsumablesPanel.BattleEquipmentButtonGlow;
   import net.wg.white_tiger.gui.battle.views.wtConsumablesPanel.BattleShellButton;
   import net.wg.white_tiger.gui.battle.views.wtConsumablesPanel.ConsumablesPanel;
   import net.wg.white_tiger.gui.battle.views.wtConsumablesPanel.IWTConsumablesButton;
   import net.wg.white_tiger.gui.battle.views.wtFullStats.FullStats;
   import net.wg.white_tiger.gui.battle.views.wtFullStats.FullStatsTable;
   import net.wg.white_tiger.gui.battle.views.wtFullStats.FullStatsTableCtrl;
   import net.wg.white_tiger.gui.battle.views.wtFullStats.FullStatsTableItem;
   import net.wg.white_tiger.gui.battle.views.wtFullStats.FullStatsTableItemHolder;
   import net.wg.white_tiger.gui.battle.views.wtHunterRespawn.WTHunterRespawnHint;
   import net.wg.white_tiger.gui.battle.views.wtHunterRespawn.WTHunterRespawnView;
   import net.wg.white_tiger.gui.battle.views.wtMinimap.WTDeploymentMapEntriesContainer;
   import net.wg.white_tiger.gui.battle.views.wtMinimap.WTMinimap;
   import net.wg.white_tiger.gui.battle.views.wtMinimap.WTMinimapSizeConst;
   import net.wg.white_tiger.gui.battle.views.wtMinimap.entries.WTDeploymentPointMinimapEntry;
   import net.wg.white_tiger.gui.battle.views.wtMinimap.entries.WTGeneratorMinimapEntry;
   import net.wg.white_tiger.gui.battle.views.wtMinimap.entries.WTIndexedMinimapEntry;
   import net.wg.white_tiger.gui.battle.views.wtPlayersPanel.BossBombList;
   import net.wg.white_tiger.gui.battle.views.wtPlayersPanel.BossBombListItem;
   import net.wg.white_tiger.gui.battle.views.wtPlayersPanel.BossBotList;
   import net.wg.white_tiger.gui.battle.views.wtPlayersPanel.BossBotListItem;
   import net.wg.white_tiger.gui.battle.views.wtPlayersPanel.BossPanelList;
   import net.wg.white_tiger.gui.battle.views.wtPlayersPanel.HunterPanelList;
   import net.wg.white_tiger.gui.battle.views.wtPlayersPanel.HunterPanelListItem;
   import net.wg.white_tiger.gui.battle.views.wtPlayersPanel.HunterPanelListItemHolder;
   import net.wg.white_tiger.gui.battle.views.wtPlayersPanel.HunterPanelListLeft;
   import net.wg.white_tiger.gui.battle.views.wtPlayersPanel.HunterPanelListRight;
   import net.wg.white_tiger.gui.battle.views.wtPlayersPanel.IHunterPanelListItem;
   import net.wg.white_tiger.gui.battle.views.wtPlayersPanel.PlayersPanel;
   import net.wg.white_tiger.gui.battle.views.wtPlayersPanel.VO.BossBotInfoVO;
   import net.wg.white_tiger.gui.battle.views.wtPlayersPanel.comps.BotHealthBar;
   import net.wg.white_tiger.gui.battle.views.wtPlayersPanel.comps.BotHealthBarLeft;
   import net.wg.white_tiger.gui.battle.views.wtPlayersPanel.comps.BotHealthBarRight;
   import net.wg.white_tiger.gui.battle.views.wtPlayersPanel.comps.BotListInfo;
   import net.wg.white_tiger.gui.battle.views.wtPlayersPanel.comps.BotListInfoIcon;
   import net.wg.white_tiger.gui.battle.views.wtPlayersPanel.comps.HunterBombTimer;
   import net.wg.white_tiger.gui.battle.views.wtTeamBasePanel.TeamBasesPanel;
   import net.wg.white_tiger.gui.battle.views.wtTeamBasePanel.TeamCaptureBar;
   import net.wg.white_tiger.gui.battle.views.wtTeamBasePanel.TeamCaptureProgress;
   import net.wg.white_tiger.gui.battle.views.wtTeamBasePanel.TeamCaptureProgressReset;
   import net.wg.white_tiger.gui.battle.views.wtTeleportView.WTBossTeleportView;
   
   public class ClassManagerMeta
   {
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_WTBATTLEPAGE:Class = WTBattlePage;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_INFRASTRUCTURE_WTBATTLESTATISTICDATACONTROLLER:Class = WTBattleStatisticDataController;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_SHARED_GENERATORPROGRESSCIRCLE:Class = GeneratorProgressCircle;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_SHARED_HUNTERRESURRECTTIMER:Class = HunterResurrectTimer;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_SHARED_TIMERANIMHELPER:Class = TimerAnimHelper;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_SHARED_WTDEPLOYMENTMAPVIEW:Class = WTDeploymentMapView;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_SHARED_INTERFACES_ITIMERANIMATION:Class = ITimerAnimation;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_STATICMARKERS_BOMBACTIONMARKER:Class = BombActionMarker;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_STATICMARKERS_BOMBACTIONMARKERTIMER:Class = BombActionMarkerTimer;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_STATICMARKERS_BOMBCONTENT:Class = BombContent;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_STATICMARKERS_BOMBMARKER:Class = BombMarker;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_STATICMARKERS_GENERATORCONTENT:Class = GeneratorContent;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_STATICMARKERS_INDEXEDACTIONMARKER:Class = IndexedActionMarker;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_STATICMARKERS_INDEXEDCONTENT:Class = IndexedContent;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_STATICMARKERS_INDEXEDMARKER:Class = IndexedMarker;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_STATICMARKERS_SCALEANIMATION:Class = ScaleAnimation;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_STATICMARKERS_SCALECONTAINER:Class = ScaleContainer;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_VEHICLEMARKERS_DAMAGELABEL:Class = DamageLabel;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_VEHICLEMARKERS_PLASMADAMAGEANIMATEDLABEL:Class = PlasmaDamageAnimatedLabel;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_VEHICLEMARKERS_WTVEHICLEMARKER:Class = WTVehicleMarker;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_VEHICLEMARKERS_STATUSMARKERS_VEHICLEBOMBMARKER:Class = VehicleBombMarker;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WINDOWS_WTINGAMEDETAILSHELPWINDOW_WTINGAMEDETAILSHELPWINDOW:Class = WTIngameDetailsHelpWindow;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTBATTLEHINTS_BATTLEHINT:Class = BattleHint;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTBATTLEHINTS_INFOCONTAINER:Class = InfoContainer;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTBATTLEHINTS_TEXTCONTAINER:Class = TextContainer;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTBATTLEHINTS_TIMERCONTAINER:Class = TimerContainer;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTBATTLEHINTS_DATA_HINTINFOVO:Class = HintInfoVO;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTBATTLELOADING_WTBATTLELOADING:Class = WTBattleLoading;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTBATTLETIMER_ADDTIMEANIMATION:Class = AddTimeAnimation;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTBATTLETIMER_BATTLETIMEREVENT:Class = BattleTimerEvent;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTBATTLETIMER_WTBATTLETIMER:Class = WTBattleTimer;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTBATTLETIMER_WTTEXTFIELDCONTAINER:Class = WTTextFieldContainer;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTBOSSWIDGET_BOSSWIDGET:Class = BossWidget;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTBOSSWIDGET_COMPONENTS_BOSSBACKGROUND:Class = BossBackground;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTBOSSWIDGET_COMPONENTS_BOSSHYPERION:Class = BossHyperion;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTBOSSWIDGET_COMPONENTS_BOSSSHIELD:Class = BossShield;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTBOSSWIDGET_COMPONENTS_BOSSTANKICON:Class = BossTankIcon;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTBOSSWIDGET_COMPONENTS_BOSSVEHICLE:Class = BossVehicle;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTBOSSWIDGET_COMPONENTS_BOSSVEHICLEDEBUFF:Class = BossVehicleDebuff;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTBOSSWIDGET_COMPONENTS_BOSSVEHICLESHIELD:Class = BossVehicleShield;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTBOSSWIDGET_COMPONENTS_BOSSWIDGETMAINPROGRESSBAR:Class = BossWidgetMainProgressBar;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTBOSSWIDGET_COMPONENTS_GENERATOR:Class = Generator;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTBOSSWIDGET_COMPONENTS_GENERATORBAR:Class = GeneratorBar;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTBOSSWIDGET_COMPONENTS_GENERATORS:Class = Generators;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTBOSSWIDGET_COMPONENTS_PROGRESSBAR:Class = ProgressBar;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTBOSSWIDGET_DATA_BOSSWIDGETVO:Class = BossWidgetVO;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTBOSSWIDGET_EVENTS_BOSSWIDGETEVENT:Class = BossWidgetEvent;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTCONSUMABLESPANEL_BATTLEEQUIPMENTBUTTON:Class = BattleEquipmentButton;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTCONSUMABLESPANEL_BATTLEEQUIPMENTBUTTONGLOW:Class = BattleEquipmentButtonGlow;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTCONSUMABLESPANEL_BATTLESHELLBUTTON:Class = BattleShellButton;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTCONSUMABLESPANEL_CONSUMABLESPANEL:Class = ConsumablesPanel;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTCONSUMABLESPANEL_IWTCONSUMABLESBUTTON:Class = IWTConsumablesButton;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTFULLSTATS_FULLSTATS:Class = FullStats;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTFULLSTATS_FULLSTATSTABLE:Class = FullStatsTable;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTFULLSTATS_FULLSTATSTABLECTRL:Class = FullStatsTableCtrl;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTFULLSTATS_FULLSTATSTABLEITEM:Class = FullStatsTableItem;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTFULLSTATS_FULLSTATSTABLEITEMHOLDER:Class = FullStatsTableItemHolder;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTHUNTERRESPAWN_WTHUNTERRESPAWNHINT:Class = WTHunterRespawnHint;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTHUNTERRESPAWN_WTHUNTERRESPAWNVIEW:Class = WTHunterRespawnView;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTMINIMAP_WTDEPLOYMENTMAPENTRIESCONTAINER:Class = WTDeploymentMapEntriesContainer;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTMINIMAP_WTMINIMAP:Class = WTMinimap;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTMINIMAP_WTMINIMAPSIZECONST:Class = WTMinimapSizeConst;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTMINIMAP_ENTRIES_WTDEPLOYMENTPOINTMINIMAPENTRY:Class = WTDeploymentPointMinimapEntry;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTMINIMAP_ENTRIES_WTGENERATORMINIMAPENTRY:Class = WTGeneratorMinimapEntry;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTMINIMAP_ENTRIES_WTINDEXEDMINIMAPENTRY:Class = WTIndexedMinimapEntry;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTPLAYERSPANEL_BOSSBOMBLIST:Class = BossBombList;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTPLAYERSPANEL_BOSSBOMBLISTITEM:Class = BossBombListItem;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTPLAYERSPANEL_BOSSBOTLIST:Class = BossBotList;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTPLAYERSPANEL_BOSSBOTLISTITEM:Class = BossBotListItem;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTPLAYERSPANEL_BOSSPANELLIST:Class = BossPanelList;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTPLAYERSPANEL_HUNTERPANELLIST:Class = HunterPanelList;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTPLAYERSPANEL_HUNTERPANELLISTITEM:Class = HunterPanelListItem;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTPLAYERSPANEL_HUNTERPANELLISTITEMHOLDER:Class = HunterPanelListItemHolder;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTPLAYERSPANEL_HUNTERPANELLISTLEFT:Class = HunterPanelListLeft;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTPLAYERSPANEL_HUNTERPANELLISTRIGHT:Class = HunterPanelListRight;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTPLAYERSPANEL_IHUNTERPANELLISTITEM:Class = IHunterPanelListItem;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTPLAYERSPANEL_PLAYERSPANEL:Class = PlayersPanel;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTPLAYERSPANEL_COMPS_BOTHEALTHBAR:Class = BotHealthBar;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTPLAYERSPANEL_COMPS_BOTHEALTHBARLEFT:Class = BotHealthBarLeft;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTPLAYERSPANEL_COMPS_BOTHEALTHBARRIGHT:Class = BotHealthBarRight;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTPLAYERSPANEL_COMPS_BOTLISTINFO:Class = BotListInfo;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTPLAYERSPANEL_COMPS_BOTLISTINFOICON:Class = BotListInfoIcon;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTPLAYERSPANEL_COMPS_HUNTERBOMBTIMER:Class = HunterBombTimer;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTPLAYERSPANEL_VO_BOSSBOTINFOVO:Class = BossBotInfoVO;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTTEAMBASEPANEL_TEAMBASESPANEL:Class = TeamBasesPanel;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTTEAMBASEPANEL_TEAMCAPTUREBAR:Class = TeamCaptureBar;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTTEAMBASEPANEL_TEAMCAPTUREPROGRESS:Class = TeamCaptureProgress;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTTEAMBASEPANEL_TEAMCAPTUREPROGRESSRESET:Class = TeamCaptureProgressReset;
      
      public static const NET_WG_WHITE_TIGER_GUI_BATTLE_VIEWS_WTTELEPORTVIEW_WTBOSSTELEPORTVIEW:Class = WTBossTeleportView;
       
      
      public function ClassManagerMeta()
      {
         super();
      }
   }
}
