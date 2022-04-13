package net.wg.gui.battle.commander.views.fullStats
{
   import flash.display.Sprite;
   import net.wg.data.VO.daapi.DAAPIQuestStatusVO;
   import net.wg.data.constants.LobbyMetrics;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.TEXT_MANAGER_STYLES;
   import net.wg.gui.battle.commander.VO.daapi.DAAPICommanderDataVO;
   import net.wg.gui.battle.commander.VO.daapi.DAAPICommanderInfoVO;
   import net.wg.gui.battle.commander.VO.daapi.DAAPISuppliesDataVO;
   import net.wg.gui.battle.components.FullStatsHeader;
   import net.wg.gui.battle.components.FullStatsTitle;
   import net.wg.gui.battle.interfaces.IFullStats;
   import net.wg.gui.battle.interfaces.ITabbedFullStatsTableController;
   import net.wg.gui.battle.views.questProgress.interfaces.IQuestProgressView;
   import net.wg.infrastructure.base.meta.IRTSFullStatsMeta;
   import net.wg.infrastructure.base.meta.impl.RTSFullStatsMeta;
   import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IRTSBattleStatisticDataController;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   
   public class RTSFullStats extends RTSFullStatsMeta implements IRTSFullStatsMeta, IFullStats, IRTSBattleStatisticDataController
   {
      
      private static const MIN_HEIGHT:int = 880;
      
      private static const TABLE_SMALL_Y_SHIFT:int = -30;
      
      private static const STATS_TABLE_Y_SHIFT:int = 103;
       
      
      public var modalBgSpr:Sprite = null;
      
      public var header:FullStatsHeader = null;
      
      public var statsTable:RTSFullStatsTable = null;
      
      public var title:FullStatsTitle = null;
      
      public function RTSFullStats()
      {
         super();
         visible = false;
         this.header.setMinHeight(MIN_HEIGHT);
      }
      
      override protected function configUI() : void
      {
         this.title.setStatus(new DAAPIQuestStatusVO({"status":Values.EMPTY_STR}));
         this.title.setTitle(App.textMgr.getTextStyleById(TEXT_MANAGER_STYLES.SUPER_PROMO_TITLE,App.utils.locale.makeString(INGAME_GUI.STATISTICS_TAB_LINE_UP_TITLE)));
         super.configUI();
      }
      
      override protected function onDispose() : void
      {
         this.modalBgSpr = null;
         this.header.dispose();
         this.header = null;
         this.statsTable.dispose();
         this.statsTable = null;
         this.title.dispose();
         this.title = null;
         super.onDispose();
      }
      
      public function updateStageSize(param1:Number, param2:Number) : void
      {
         var _loc3_:int = 0;
         this.modalBgSpr.visible = false;
         _loc3_ = param1 >> 1;
         var _loc4_:int = 0;
         x = _loc3_;
         y = _loc4_;
         this.modalBgSpr.x = -_loc3_;
         this.modalBgSpr.y = _loc4_;
         this.modalBgSpr.width = param1;
         this.modalBgSpr.height = param2;
         this.modalBgSpr.visible = true;
         this.header.updateSize(param1,param2);
         this.title.y = this.getTitleY();
         var _loc5_:int = param2 < MIN_HEIGHT ? int(TABLE_SMALL_Y_SHIFT) : int(0);
         this.statsTable.y = this.title.y + STATS_TABLE_Y_SHIFT + _loc5_;
      }
      
      public function addVehiclesInfo(param1:IDAAPIDataClass) : void
      {
         this.statsTable.addVehiclesInfo(param1);
      }
      
      public function setVehiclesData(param1:IDAAPIDataClass) : void
      {
         this.statsTable.setVehiclesData(param1);
      }
      
      public function setRTSCommanderMode(param1:Boolean) : void
      {
         this.statsTable.setRTSCommanderMode(param1);
      }
      
      public function setRTSIsSpotted(param1:Number, param2:Boolean) : void
      {
         this.statsTable.setRTSIsSpotted(param1,param2);
      }
      
      public function setRTSCommanderInfo(param1:DAAPICommanderInfoVO) : void
      {
         this.statsTable.setRTSCommanderInfo(param1);
      }
      
      public function setRTSCommanderData(param1:DAAPICommanderDataVO) : void
      {
         this.statsTable.setRTSCommanderData(param1);
      }
      
      public function setRTSOrder(param1:Number, param2:Number, param3:Boolean) : void
      {
         this.statsTable.setRTSOrder(param1,param2,param3);
      }
      
      public function setRTSPlayerCommander(param1:Boolean) : void
      {
         this.statsTable.setRTSPlayerCommander(param1);
      }
      
      public function updateVehiclesData(param1:IDAAPIDataClass) : void
      {
         this.statsTable.updateVehiclesData(param1);
      }
      
      public function updateVehicleStatus(param1:IDAAPIDataClass) : void
      {
         this.statsTable.updateVehicleStatus(param1);
      }
      
      public function updatePersonalStatus(param1:uint, param2:uint) : void
      {
         this.statsTable.updatePersonalStatus(param1,param2);
      }
      
      public function resetFrags() : void
      {
         this.statsTable.resetFrags();
      }
      
      public function setRTSVehicleDisabled(param1:int, param2:Boolean) : void
      {
      }
      
      public function setFrags(param1:IDAAPIDataClass) : void
      {
         this.statsTable.setFrags(param1);
      }
      
      public function updateVehiclesStat(param1:IDAAPIDataClass) : void
      {
         this.statsTable.updateVehiclesStat(param1);
      }
      
      public function updatePlayerStatus(param1:IDAAPIDataClass) : void
      {
         this.statsTable.updatePlayerStatus(param1);
      }
      
      public function setArenaInfo(param1:IDAAPIDataClass) : void
      {
         this.statsTable.setArenaInfo(param1);
         this.header.update(param1);
      }
      
      public function setQuestStatus(param1:IDAAPIDataClass) : void
      {
         this.statsTable.setQuestStatus(param1);
      }
      
      public function setUserTags(param1:IDAAPIDataClass) : void
      {
         this.statsTable.setUserTags(param1);
      }
      
      public function updateUserTags(param1:IDAAPIDataClass) : void
      {
         this.statsTable.updateUserTags(param1);
      }
      
      public function setPersonalStatus(param1:uint) : void
      {
         this.statsTable.setPersonalStatus(param1);
      }
      
      public function updateInvitationsStatuses(param1:IDAAPIDataClass) : void
      {
         this.statsTable.updateInvitationsStatuses(param1);
      }
      
      public function updateTriggeredChatCommands(param1:IDAAPIDataClass) : void
      {
         this.statsTable.updateTriggeredChatCommands(param1);
      }
      
      protected function getTitleY() : int
      {
         var _loc1_:int = height - LobbyMetrics.MIN_STAGE_HEIGHT >> 2;
         return this.header.y + this.header.height + 10 + _loc1_;
      }
      
      public function getTableCtrl() : ITabbedFullStatsTableController
      {
         return null;
      }
      
      public function getStatsProgressView() : IQuestProgressView
      {
         return null;
      }
      
      public function setRTSSupplyData(param1:DAAPISuppliesDataVO) : void
      {
         this.statsTable.setRTSSupplyData(param1);
      }
      
      public function setRTSVehicleGroup(param1:int, param2:int) : void
      {
      }
      
      public function setRTSVehicleInFocus(param1:int) : void
      {
      }
      
      public function setRTSVehiclesInFocus(param1:Vector.<int>, param2:Boolean) : void
      {
      }
      
      public function setRTSReloading(param1:int, param2:Number, param3:Number, param4:Number) : void
      {
      }
      
      public function setRTSSelectedVehicles(param1:Vector.<int>) : void
      {
      }
      
      public function setRTSSpeakingVehicle(param1:int, param2:Boolean) : void
      {
      }
      
      public function setRTSClipData(param1:int, param2:int, param3:int, param4:Boolean, param5:Boolean) : void
      {
      }
      
      public function setRTSVehicleModuleDamaged(param1:int, param2:String) : void
      {
      }
      
      public function setRTSVehicleModuleRepaired(param1:int, param2:String) : void
      {
      }
      
      public function setRTSCondition(param1:Number, param2:String) : void
      {
      }
   }
}
