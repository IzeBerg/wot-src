package net.wg.gui.battle.epicBattle.views.stats
{
   import flash.display.Sprite;
   import net.wg.data.VO.daapi.DAAPIArenaInfoVO;
   import net.wg.data.VO.daapi.DAAPIPlayerStatusVO;
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.VO.daapi.DAAPIVehicleStatusVO;
   import net.wg.data.VO.daapi.DAAPIVehicleUserTagsVO;
   import net.wg.data.VO.daapi.DAAPIVehiclesDataVO;
   import net.wg.data.VO.daapi.DAAPIVehiclesInvitationStatusVO;
   import net.wg.data.VO.daapi.DAAPIVehiclesUserTagsVO;
   import net.wg.data.constants.PersonalStatus;
   import net.wg.gui.battle.epicBattle.VO.daapi.EpicPlayerStatsVO;
   import net.wg.gui.battle.epicBattle.VO.daapi.EpicVehiclesStatsVO;
   import net.wg.gui.battle.epicBattle.views.stats.components.EpicFullStatsTable;
   import net.wg.gui.battle.epicBattle.views.stats.components.EpicFullStatsTableCtrl;
   import net.wg.gui.battle.epicBattle.views.stats.components.EpicStatsHeader;
   import net.wg.gui.battle.epicBattle.views.stats.events.EpicFullStatsEvent;
   import net.wg.infrastructure.base.meta.IEpicFullStatsMeta;
   import net.wg.infrastructure.base.meta.impl.EpicFullStatsMeta;
   import net.wg.infrastructure.events.ColorSchemeEvent;
   import net.wg.infrastructure.events.VoiceChatEvent;
   import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IBattleComponentDataController;
   import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IEpicBattleStatisticDataController;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   
   public class EpicFullStats extends EpicFullStatsMeta implements IEpicFullStatsMeta, IBattleComponentDataController, IEpicBattleStatisticDataController
   {
      
      private static const TOP_TABLE_OFFSET:int = 139;
      
      private static const MIN_HEIGHT:int = 768;
       
      
      public var header:EpicStatsHeader = null;
      
      public var statsTable:EpicFullStatsTable = null;
      
      public var modalBgSpr:Sprite = null;
      
      private var _tableCtrl:EpicFullStatsTableCtrl = null;
      
      private var _personalStatus:uint = 0;
      
      private var _isInteractive:Boolean = false;
      
      public function EpicFullStats()
      {
         super();
         this._tableCtrl = new EpicFullStatsTableCtrl(this.statsTable,this);
      }
      
      override public function setCompVisible(param1:Boolean) : void
      {
         super.setCompVisible(param1);
         this._tableCtrl.isRenderingAvailable = param1;
         if(param1)
         {
            this._tableCtrl.focusScrollbar();
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.statsTable.statsFilters.btnTabPlayerLane.selected = true;
         this.statsTable.statsFilters.addEventListener(EpicFullStatsEvent.FILTER_CHANGED,this.onFilterChangedHandler);
         this._tableCtrl.setupSquadElements();
         App.voiceChatMgr.addEventListener(VoiceChatEvent.START_SPEAKING,this.onStartSpeakingHandler);
         App.voiceChatMgr.addEventListener(VoiceChatEvent.STOP_SPEAKING,this.onStopSpeakingHandler);
         App.colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
      }
      
      override protected function onDispose() : void
      {
         App.voiceChatMgr.removeEventListener(VoiceChatEvent.START_SPEAKING,this.onStartSpeakingHandler);
         App.voiceChatMgr.removeEventListener(VoiceChatEvent.STOP_SPEAKING,this.onStopSpeakingHandler);
         App.colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
         this.statsTable.statsFilters.removeEventListener(EpicFullStatsEvent.FILTER_CHANGED,this.onFilterChangedHandler);
         this.header.dispose();
         this.header = null;
         this.statsTable.dispose();
         this.statsTable = null;
         this.modalBgSpr = null;
         this._tableCtrl.dispose();
         this._tableCtrl = null;
         super.onDispose();
      }
      
      public function addVehiclesInfo(param1:IDAAPIDataClass) : void
      {
         var _loc2_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
         this._tableCtrl.addVehiclesInfo(false,_loc2_.leftVehicleInfos,_loc2_.leftVehiclesIDs);
         this._tableCtrl.addVehiclesInfo(true,_loc2_.rightVehicleInfos,_loc2_.rightVehiclesIDs);
      }
      
      public function as_initializeText(param1:String, param2:String) : void
      {
         this.statsTable.statsFilters.setButtonTexts(param1,param2);
      }
      
      public function as_setIsInteractive(param1:Boolean) : void
      {
         this._isInteractive = param1;
         this.applyInteractivity();
      }
      
      public function as_setGeneralBonus(param1:Number) : void
      {
         this.statsTable.generalBonus.bonusValue = param1;
      }
      
      public function setArenaInfo(param1:IDAAPIDataClass) : void
      {
         var _loc2_:DAAPIArenaInfoVO = DAAPIArenaInfoVO(param1);
         this.header.updateMapName(_loc2_.mapName);
         this.header.setBattleTypeName(_loc2_.battleTypeLocaleStr);
         this.header.updateWinText(_loc2_.winText);
         this.header.setBattleTypeFrameName(_loc2_.battleTypeFrameLabel);
         this.statsTable.team1TF.text = _loc2_.allyTeamName;
         this.statsTable.team2TF.text = _loc2_.enemyTeamName;
      }
      
      public function setEpicVehiclesStats(param1:EpicVehiclesStatsVO) : void
      {
         this._tableCtrl.setEpicVehiclesStats(false,param1.leftItems,param1.leftVehiclesIDs);
         this._tableCtrl.setEpicVehiclesStats(true,param1.rightItems,param1.rightVehiclesIDs);
      }
      
      public function setFrags(param1:IDAAPIDataClass) : void
      {
      }
      
      public function setPersonalStatus(param1:uint) : void
      {
         this._personalStatus = param1;
         this.applyPersonalStatus();
      }
      
      public function setQuestStatus(param1:IDAAPIDataClass) : void
      {
      }
      
      public function setUserTags(param1:IDAAPIDataClass) : void
      {
         var _loc2_:DAAPIVehiclesUserTagsVO = DAAPIVehiclesUserTagsVO(param1);
         this._tableCtrl.setUserTags(false,_loc2_.leftUserTags);
         this._tableCtrl.setUserTags(true,_loc2_.rightUserTags);
      }
      
      public function setVehiclesData(param1:IDAAPIDataClass) : void
      {
         var _loc4_:DAAPIVehicleInfoVO = null;
         var _loc2_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
         var _loc3_:Array = [];
         for each(_loc4_ in _loc2_.leftVehicleInfos)
         {
            _loc3_.push(_loc4_);
         }
         this._tableCtrl.setVehiclesData(_loc3_,_loc2_.leftVehiclesIDs,false);
         _loc3_ = [];
         for each(_loc4_ in _loc2_.rightVehicleInfos)
         {
            _loc3_.push(_loc4_);
         }
         this._tableCtrl.setVehiclesData(_loc3_,_loc2_.rightVehiclesIDs,true);
      }
      
      public function resetFrags() : void
      {
      }
      
      public function updateEpicPlayerStats(param1:EpicPlayerStatsVO) : void
      {
         this._tableCtrl.currentLane = param1.lane;
      }
      
      public function updateEpicVehiclesStats(param1:EpicVehiclesStatsVO) : void
      {
         this._tableCtrl.setEpicVehiclesStats(false,param1.leftItems,param1.leftVehiclesIDs);
         this._tableCtrl.setEpicVehiclesStats(true,param1.rightItems,param1.rightVehiclesIDs);
      }
      
      public function updateInvitationsStatuses(param1:IDAAPIDataClass) : void
      {
         var _loc2_:DAAPIVehiclesInvitationStatusVO = DAAPIVehiclesInvitationStatusVO(param1);
         this._tableCtrl.updateInvitationsStatuses(false,_loc2_.leftItems);
         this._tableCtrl.updateInvitationsStatuses(true,_loc2_.rightItems);
      }
      
      public function updatePersonalStatus(param1:uint, param2:uint) : void
      {
         if(param1 > 0)
         {
            this._personalStatus |= param1;
         }
         if(param2 > 0)
         {
            this._personalStatus &= ~param2;
         }
         this.applyPersonalStatus();
      }
      
      public function updatePlayerStatus(param1:IDAAPIDataClass) : void
      {
         var _loc2_:DAAPIPlayerStatusVO = DAAPIPlayerStatusVO(param1);
         this._tableCtrl.setPlayerStatus(_loc2_.isEnemy,_loc2_.vehicleID,_loc2_.status);
      }
      
      public function updateStageSize(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = NaN;
         _loc3_ = param1 >> 1;
         var _loc4_:Number = param2 >> 1;
         this.header.modalBgSpr.width = param1;
         this.header.modalBgSpr.x = -_loc3_;
         this.statsTable.y = _loc4_ - TOP_TABLE_OFFSET * (param2 / MIN_HEIGHT);
         this.statsTable.updateHeight(param2);
         this.modalBgSpr.width = param1;
         this.modalBgSpr.height = param2;
         this.modalBgSpr.x = -_loc3_;
         this.modalBgSpr.y = 0;
         this.x = _loc3_;
         this.y = 0;
      }
      
      public function updateUserTags(param1:IDAAPIDataClass) : void
      {
         var _loc2_:DAAPIVehicleUserTagsVO = DAAPIVehicleUserTagsVO(param1);
         this._tableCtrl.setUserTags(_loc2_.isEnemy,new <DAAPIVehicleUserTagsVO>[_loc2_]);
      }
      
      public function updateVehicleStatus(param1:IDAAPIDataClass) : void
      {
         var _loc2_:DAAPIVehicleStatusVO = DAAPIVehicleStatusVO(param1);
         this._tableCtrl.setVehicleStatus(false,_loc2_.vehicleID,_loc2_.status,_loc2_.leftVehiclesIDs);
         this._tableCtrl.setVehicleStatus(true,_loc2_.vehicleID,_loc2_.status,_loc2_.rightVehiclesIDs);
      }
      
      public function updateVehiclesData(param1:IDAAPIDataClass) : void
      {
         var _loc2_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
         this._tableCtrl.updateVehiclesInfo(false,_loc2_.leftVehicleInfos,_loc2_.leftVehiclesIDs);
         this._tableCtrl.updateVehiclesInfo(true,_loc2_.rightVehicleInfos,_loc2_.rightVehiclesIDs);
      }
      
      public function updateVehiclesStat(param1:IDAAPIDataClass) : void
      {
      }
      
      public function updateTriggeredChatCommands(param1:IDAAPIDataClass) : void
      {
      }
      
      private function applyPersonalStatus() : void
      {
         this._tableCtrl.setIsInviteShown(PersonalStatus.isShowAllyInvites(this._personalStatus),PersonalStatus.isShowEnemyInvites(this._personalStatus));
         this.applyInteractivity();
      }
      
      private function applyInteractivity() : void
      {
         var _loc1_:Boolean = this._isInteractive && !PersonalStatus.isSquadRestrictions(this._personalStatus);
         var _loc2_:Boolean = _loc1_ && PersonalStatus.isCanSendInviteToAlly(this._personalStatus);
         var _loc3_:Boolean = _loc1_ && PersonalStatus.isCanSendInviteToEnemy(this._personalStatus);
         this._tableCtrl.setInteractive(_loc2_,_loc3_);
      }
      
      private function onStartSpeakingHandler(param1:VoiceChatEvent) : void
      {
         this._tableCtrl.setSpeaking(param1.getAccountDBID(),true);
      }
      
      private function onStopSpeakingHandler(param1:VoiceChatEvent) : void
      {
         this._tableCtrl.setSpeaking(param1.getAccountDBID(),false);
      }
      
      private function onFilterChangedHandler(param1:EpicFullStatsEvent) : void
      {
         this._tableCtrl.filterActive = param1.lane > 0;
      }
      
      private function onColorSchemasUpdatedHandler(param1:ColorSchemeEvent) : void
      {
         this._tableCtrl.updateColorBlind();
      }
   }
}
