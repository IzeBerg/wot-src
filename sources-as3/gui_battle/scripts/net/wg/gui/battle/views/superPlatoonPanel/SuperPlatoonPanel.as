package net.wg.gui.battle.views.superPlatoonPanel
{
   import flash.utils.Dictionary;
   import net.wg.data.VO.daapi.DAAPIInvitationStatusVO;
   import net.wg.data.VO.daapi.DAAPIPlayerStatusVO;
   import net.wg.data.VO.daapi.DAAPITriggeredCommandVO;
   import net.wg.data.VO.daapi.DAAPITriggeredCommandsVO;
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.VO.daapi.DAAPIVehicleStatusVO;
   import net.wg.data.VO.daapi.DAAPIVehicleUserTagsVO;
   import net.wg.data.VO.daapi.DAAPIVehiclesDataVO;
   import net.wg.data.VO.daapi.DAAPIVehiclesInvitationStatusVO;
   import net.wg.data.VO.daapi.DAAPIVehiclesUserTagsVO;
   import net.wg.data.constants.InvitationStatus;
   import net.wg.gui.battle.epicBattle.VO.daapi.EpicPlayerStatsVO;
   import net.wg.gui.battle.epicBattle.VO.daapi.EpicVehicleStatsVO;
   import net.wg.gui.battle.epicBattle.VO.daapi.EpicVehiclesStatsVO;
   import net.wg.gui.battle.random.views.stats.events.DynamicSquadEvent;
   import net.wg.gui.battle.views.superPlatoonPanel.components.PlatoonInvitePanel;
   import net.wg.gui.battle.views.superPlatoonPanel.components.PlatoonMembersPanel;
   import net.wg.infrastructure.base.meta.IPlayersPanelMeta;
   import net.wg.infrastructure.base.meta.IStatsBaseMeta;
   import net.wg.infrastructure.base.meta.ISuperPlatoonPanelMeta;
   import net.wg.infrastructure.base.meta.impl.SuperPlatoonPanelMeta;
   import net.wg.infrastructure.events.ColorSchemeEvent;
   import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IBattleComponentDataController;
   import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IEpicBattleStatisticDataController;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   
   public class SuperPlatoonPanel extends SuperPlatoonPanelMeta implements IEpicBattleStatisticDataController, IBattleComponentDataController, ISuperPlatoonPanelMeta, IStatsBaseMeta, IPlayersPanelMeta
   {
      
      private static const INVITED_STATE:uint = 1;
      
      private static const IN_PLATOON_STATE:uint = 2;
       
      
      public var platoonMembersPanel:PlatoonMembersPanel = null;
      
      public var platoonInvitePanel:PlatoonInvitePanel = null;
      
      private var _playerVehicleId:Number = -1;
      
      private var _playerSquad:int = 0;
      
      private var _platoonPanelState:uint = 0;
      
      private var _vehicleDataCache:Object = null;
      
      private var _epicStatsDict:Dictionary = null;
      
      private var _colorSchemeMgr:IColorSchemeManager;
      
      public function SuperPlatoonPanel()
      {
         this._colorSchemeMgr = App.colorSchemeMgr;
         super();
         this._vehicleDataCache = [];
         this._epicStatsDict = new Dictionary();
         this._platoonPanelState = INVITED_STATE;
         this.platoonMembersPanel.visible = this.platoonInvitePanel.visible = false;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(DynamicSquadEvent.ACCEPT,this.onDynamicSquadAcceptHandler);
         this._colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:DAAPIVehicleInfoVO = null;
         removeEventListener(DynamicSquadEvent.ACCEPT,this.onDynamicSquadAcceptHandler);
         this._colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
         this.platoonMembersPanel.dispose();
         this.platoonMembersPanel = null;
         if(this.platoonInvitePanel)
         {
            this.platoonInvitePanel.dispose();
            this.platoonInvitePanel = null;
         }
         for each(_loc1_ in this._vehicleDataCache)
         {
            _loc1_.dispose();
         }
         this._vehicleDataCache = null;
         if(this._epicStatsDict != null)
         {
            App.utils.data.cleanupDynamicObject(this._epicStatsDict);
         }
         this._epicStatsDict = null;
         this._colorSchemeMgr = null;
         super.onDispose();
      }
      
      public function addVehiclesInfo(param1:IDAAPIDataClass) : void
      {
         this.applyVehicleData(DAAPIVehiclesDataVO(param1));
      }
      
      public function as_setChatCommandsVisibility(param1:Boolean) : void
      {
         this.platoonMembersPanel.setChatCommandsVisibility(param1);
      }
      
      public function as_setPanelHPBarVisibilityState(param1:uint) : void
      {
         this.platoonMembersPanel.setPanelHPBarVisibilityState(param1);
      }
      
      public function as_setIsInteractive(param1:Boolean) : void
      {
      }
      
      public function as_setMaxDisplayedInviteMessages(param1:int) : void
      {
         this.platoonInvitePanel.maxInvites = param1;
      }
      
      public function as_setPanelMode(param1:int) : void
      {
      }
      
      public function as_setPlatoonTitle(param1:String) : void
      {
         this.platoonMembersPanel.setPlatoonTitle(param1.toUpperCase());
      }
      
      public function resetFrags() : void
      {
      }
      
      public function setArenaInfo(param1:IDAAPIDataClass) : void
      {
      }
      
      public function setEpicVehiclesStats(param1:EpicVehiclesStatsVO) : void
      {
         this.updateEpicStats(param1.leftItems,param1.leftVehiclesIDs);
      }
      
      public function setFrags(param1:IDAAPIDataClass) : void
      {
      }
      
      public function setPersonalStatus(param1:uint) : void
      {
      }
      
      public function setQuestStatus(param1:IDAAPIDataClass) : void
      {
      }
      
      public function setUserTags(param1:IDAAPIDataClass) : void
      {
         var _loc2_:DAAPIVehiclesUserTagsVO = null;
         var _loc3_:Vector.<DAAPIVehicleUserTagsVO> = null;
         var _loc4_:DAAPIVehicleUserTagsVO = null;
         if(this._playerSquad > 0)
         {
            _loc2_ = DAAPIVehiclesUserTagsVO(param1);
            _loc3_ = _loc2_.leftUserTags;
            for each(_loc4_ in _loc3_)
            {
               if(this._vehicleDataCache[_loc4_.vehicleID])
               {
                  this._vehicleDataCache[_loc4_.vehicleID].userTags = _loc4_.userTags;
               }
               if(this._vehicleDataCache[_loc4_.vehicleID].squadIndex == this._playerSquad)
               {
                  this.platoonMembersPanel.setUserTags(_loc4_);
               }
            }
         }
      }
      
      public function setVehiclesData(param1:IDAAPIDataClass) : void
      {
         this.applyVehicleData(DAAPIVehiclesDataVO(param1));
      }
      
      public function updateEpicPlayerStats(param1:EpicPlayerStatsVO) : void
      {
      }
      
      public function updateEpicVehiclesStats(param1:EpicVehiclesStatsVO) : void
      {
         this.updateEpicStats(param1.leftItems,param1.leftVehiclesIDs);
      }
      
      public function updateInvitationsStatuses(param1:IDAAPIDataClass) : void
      {
         var _loc4_:DAAPIInvitationStatusVO = null;
         var _loc5_:DAAPIVehicleInfoVO = null;
         var _loc2_:DAAPIVehiclesInvitationStatusVO = DAAPIVehiclesInvitationStatusVO(param1);
         var _loc3_:Vector.<DAAPIInvitationStatusVO> = _loc2_.leftItems;
         for each(_loc4_ in _loc3_)
         {
            if(InvitationStatus.isReceived(_loc4_.status) && this._playerSquad <= DAAPIVehicleInfoVO.DEFAULT_SQUAD_IDX)
            {
               _loc5_ = this._vehicleDataCache[_loc4_.vehicleID] as DAAPIVehicleInfoVO;
               if(_loc5_)
               {
                  this.platoonInvitePanel.updatePlatoonInvite(_loc4_.vehicleID,_loc5_,_loc4_.status);
               }
            }
         }
      }
      
      public function updatePersonalStatus(param1:uint, param2:uint) : void
      {
      }
      
      public function updatePlayerStatus(param1:IDAAPIDataClass) : void
      {
         var _loc2_:DAAPIPlayerStatusVO = DAAPIPlayerStatusVO(param1);
         if(this._playerVehicleId == -1)
         {
            this._playerVehicleId = _loc2_.vehicleID;
         }
         if(this._vehicleDataCache[this._playerVehicleId] && this._vehicleDataCache[this._playerVehicleId].squadIndex > 0)
         {
            if(this._platoonPanelState == IN_PLATOON_STATE)
            {
               this.platoonMembersPanel.setPlayerStatus(_loc2_);
            }
            else
            {
               this._playerSquad = this._vehicleDataCache[this._playerVehicleId].squadIndex;
               this._platoonPanelState = IN_PLATOON_STATE;
               this.initializePlatoon(this._vehicleDataCache[this._playerVehicleId].squadIndex);
            }
         }
      }
      
      public function updateTriggeredChatCommands(param1:IDAAPIDataClass) : void
      {
         var _loc4_:DAAPITriggeredCommandVO = null;
         if(this._playerSquad == DAAPIVehicleInfoVO.DEFAULT_SQUAD_IDX)
         {
            return;
         }
         var _loc2_:DAAPITriggeredCommandsVO = DAAPITriggeredCommandsVO(param1);
         var _loc3_:Vector.<DAAPITriggeredCommandVO> = _loc2_.triggeredCommands;
         for each(_loc4_ in _loc3_)
         {
            this.platoonMembersPanel.triggerChatCommand(_loc4_.vehicleID,_loc4_.chatCommandName);
         }
      }
      
      public function updateUserTags(param1:IDAAPIDataClass) : void
      {
         var _loc2_:DAAPIVehicleUserTagsVO = DAAPIVehicleUserTagsVO(param1);
         if(this._vehicleDataCache[_loc2_.vehicleID])
         {
            this._vehicleDataCache[_loc2_.vehicleID].userTags = _loc2_.userTags;
         }
         if(!_loc2_.isEnemy && this._playerSquad != DAAPIVehicleInfoVO.DEFAULT_SQUAD_IDX && this._vehicleDataCache[_loc2_.vehicleID].squadIndex == this._playerSquad)
         {
            this.platoonMembersPanel.setUserTags(_loc2_);
         }
      }
      
      public function updateVehicleStatus(param1:IDAAPIDataClass) : void
      {
         var _loc2_:DAAPIVehicleStatusVO = DAAPIVehicleStatusVO(param1);
         var _loc3_:DAAPIVehicleInfoVO = this._vehicleDataCache[_loc2_.vehicleID] as DAAPIVehicleInfoVO;
         if(_loc3_)
         {
            if(this._vehicleDataCache[_loc2_.vehicleID])
            {
               this._vehicleDataCache[_loc2_.vehicleID].vehicleStatus = _loc2_.status;
            }
            if(this._playerSquad > 0 && _loc3_.squadIndex == this._playerSquad)
            {
               this.platoonMembersPanel.updateVehicleStatus(_loc2_);
            }
         }
      }
      
      public function updateVehiclesData(param1:IDAAPIDataClass) : void
      {
         this.applyVehicleData(DAAPIVehiclesDataVO(param1));
      }
      
      public function updateVehiclesStat(param1:IDAAPIDataClass) : void
      {
      }
      
      private function applyVehicleData(param1:DAAPIVehiclesDataVO) : void
      {
         var _loc3_:DAAPIVehicleInfoVO = null;
         var _loc4_:EpicVehicleStatsVO = null;
         var _loc2_:Boolean = false;
         for each(_loc3_ in param1.leftVehicleInfos)
         {
            this._vehicleDataCache[_loc3_.vehicleID] = _loc3_.clone();
            if(_loc3_.squadIndex != DAAPIVehicleInfoVO.DEFAULT_SQUAD_IDX)
            {
               if(this._playerSquad == DAAPIVehicleInfoVO.DEFAULT_SQUAD_IDX)
               {
                  if(_loc3_.vehicleID == this._playerVehicleId)
                  {
                     this._playerSquad = _loc3_.squadIndex;
                     this._platoonPanelState = IN_PLATOON_STATE;
                     _loc2_ = true;
                  }
                  else
                  {
                     this.platoonInvitePanel.updateVehicleInfo(_loc3_);
                  }
               }
               if(_loc3_.squadIndex == this._playerSquad)
               {
                  if(this.platoonMembersPanel.setVehicleData(_loc3_))
                  {
                     _loc4_ = this._epicStatsDict[_loc3_.vehicleID] as EpicVehicleStatsVO;
                     if(_loc4_)
                     {
                        this.platoonMembersPanel.setEpicVehiclesStats(_loc4_);
                     }
                  }
                  this.platoonMembersPanel.forceOrderUpdate();
               }
            }
         }
         if(_loc2_)
         {
            this.initializePlatoon(this._playerSquad);
         }
      }
      
      private function initializePlatoon(param1:int) : void
      {
         var _loc3_:DAAPIVehicleInfoVO = null;
         var _loc4_:EpicVehicleStatsVO = null;
         var _loc5_:DAAPIVehicleInfoVO = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:Vector.<DAAPIVehicleInfoVO> = new Vector.<DAAPIVehicleInfoVO>(0);
         for each(_loc3_ in this._vehicleDataCache)
         {
            if(_loc3_.squadIndex == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         _loc6_ = _loc2_.length;
         _loc7_ = 0;
         while(_loc7_ < _loc6_)
         {
            if(_loc2_[_loc7_])
            {
               _loc5_ = this._vehicleDataCache[_loc2_[_loc7_].vehicleID] as DAAPIVehicleInfoVO;
               if(_loc5_)
               {
                  this.platoonMembersPanel.setVehicleData(_loc5_);
               }
               _loc4_ = this._epicStatsDict[_loc2_[_loc7_].vehicleID] as EpicVehicleStatsVO;
               if(_loc4_)
               {
                  this.platoonMembersPanel.setEpicVehiclesStats(_loc4_);
               }
            }
            _loc7_++;
         }
         this.platoonMembersPanel.setSquadIndex(param1);
         this.platoonMembersPanel.forceOrderUpdate();
         this.platoonInvitePanel.visible = false;
         this.platoonInvitePanel.dispose();
         this.platoonInvitePanel = null;
      }
      
      private function updateEpicStats(param1:Vector.<EpicVehicleStatsVO>, param2:Vector.<Number>) : void
      {
         var _loc3_:EpicVehicleStatsVO = null;
         for each(_loc3_ in param1)
         {
            if(this._epicStatsDict[_loc3_.vehicleID])
            {
               this._epicStatsDict[_loc3_.vehicleID].frags = _loc3_.frags;
               this._epicStatsDict[_loc3_.vehicleID].rank = _loc3_.rank;
               this._epicStatsDict[_loc3_.vehicleID].chatCommand = _loc3_.chatCommand;
               this._epicStatsDict[_loc3_.vehicleID].chatCommandFlags = _loc3_.chatCommandFlags;
            }
            else
            {
               this._epicStatsDict[_loc3_.vehicleID] = _loc3_;
            }
            if(this._playerSquad != DAAPIVehicleInfoVO.DEFAULT_SQUAD_IDX)
            {
               this.platoonMembersPanel.setEpicVehiclesStats(_loc3_);
            }
         }
         this.platoonMembersPanel.updateOrder(param2);
         if(this._playerSquad != DAAPIVehicleInfoVO.DEFAULT_SQUAD_IDX)
         {
            this.platoonMembersPanel.forceOrderUpdate();
         }
      }
      
      private function onColorSchemasUpdatedHandler(param1:ColorSchemeEvent) : void
      {
         this.platoonMembersPanel.updateColorBlind();
      }
      
      private function onDynamicSquadAcceptHandler(param1:DynamicSquadEvent) : void
      {
         this._platoonPanelState = IN_PLATOON_STATE;
         acceptSquadS(param1.sessionID);
      }
      
      public function as_setPlayerHP(param1:Boolean, param2:int, param3:int) : void
      {
         this.platoonMembersPanel.setPlayerHP(param1,param2,param3);
      }
      
      public function as_setOverrideExInfo(param1:Boolean) : void
      {
         this.platoonMembersPanel.setOverrideExInfo(param1);
      }
   }
}
