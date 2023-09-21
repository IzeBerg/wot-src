package net.wg.gui.battle.components
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.data.VO.daapi.DAAPIInvitationStatusVO;
   import net.wg.data.VO.daapi.DAAPIPlayerStatusVO;
   import net.wg.data.VO.daapi.DAAPITriggeredCommandVO;
   import net.wg.data.VO.daapi.DAAPITriggeredCommandsVO;
   import net.wg.data.VO.daapi.DAAPIVehicleStatsVO;
   import net.wg.data.VO.daapi.DAAPIVehicleStatusVO;
   import net.wg.data.VO.daapi.DAAPIVehicleUserTagsVO;
   import net.wg.data.VO.daapi.DAAPIVehiclesInvitationStatusVO;
   import net.wg.data.VO.daapi.DAAPIVehiclesStatsVO;
   import net.wg.data.VO.daapi.DAAPIVehiclesUserTagsVO;
   import net.wg.data.constants.PersonalStatus;
   import net.wg.data.constants.generated.BATTLE_CONTEXT_MENU_HANDLER_TYPE;
   import net.wg.data.constants.generated.PLAYERS_PANEL_STATE;
   import net.wg.gui.battle.components.events.PlayersPanelListEvent;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.VO.PlayersPanelContextMenuSentData;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.events.PlayersPanelEvent;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.events.PlayersPanelSwitchEvent;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.interfaces.IPlayersPanelList;
   import net.wg.gui.battle.random.views.stats.events.DynamicSquadEvent;
   import net.wg.gui.battle.views.minimap.MinimapEntryController;
   import net.wg.infrastructure.base.meta.IPlayersPanelMeta;
   import net.wg.infrastructure.base.meta.IStatsBaseMeta;
   import net.wg.infrastructure.base.meta.impl.PlayersPanelMeta;
   import net.wg.infrastructure.events.ColorSchemeEvent;
   import net.wg.infrastructure.events.VoiceChatEvent;
   import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IBattleComponentDataController;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   import net.wg.infrastructure.managers.IContextMenuManager;
   
   public class PlayersPanelBase extends PlayersPanelMeta implements IBattleComponentDataController, IPlayersPanelMeta, IStatsBaseMeta
   {
       
      
      public var listLeft:IPlayersPanelList = null;
      
      public var listRight:IPlayersPanelList = null;
      
      public var panelSwitch:PlayersPanelSwitchBase = null;
      
      protected var contextMenuMgr:IContextMenuManager;
      
      protected var expandState:int = -1;
      
      protected var currentColumnOver:int = -1;
      
      protected var isPlayerSwitchingAllowed:Boolean = true;
      
      private var _state:int = -1;
      
      private var _isStateRequested:Boolean = false;
      
      private var _personalStatus:uint = 0;
      
      private var _isInteractive:Boolean = false;
      
      public function PlayersPanelBase()
      {
         this.contextMenuMgr = App.contextMenuMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.listLeft.addEventListener(MouseEvent.ROLL_OVER,this.onListRollOverHandler);
         this.listLeft.addEventListener(MouseEvent.ROLL_OUT,this.onListRollOutHandler);
         this.listLeft.addEventListener(PlayersPanelListEvent.ITEM_SELECTED,this.onListItemSelectedHandler);
         this.listLeft.addEventListener(PlayersPanelListEvent.ITEM_CONTEXT_MENU_OPEN,this.onListItemContextMenuOpenHandler);
         this.listRight.addEventListener(MouseEvent.ROLL_OVER,this.onListRollOverHandler);
         this.listRight.addEventListener(MouseEvent.ROLL_OUT,this.onListRollOutHandler);
         this.listRight.addEventListener(PlayersPanelListEvent.ITEM_SELECTED,this.onListItemSelectedHandler);
         this.listRight.addEventListener(PlayersPanelListEvent.ITEMS_COUNT_CHANGE,this.onListItemsCountChangeHandler);
         this.listRight.addEventListener(PlayersPanelListEvent.ITEM_CONTEXT_MENU_OPEN,this.onListItemContextMenuOpenHandler);
         if(this.panelSwitch)
         {
            this.panelSwitch.addEventListener(PlayersPanelSwitchEvent.STATE_REQUESTED,this.onPanelSwitchStateRequestedHandler);
         }
         App.voiceChatMgr.addEventListener(VoiceChatEvent.START_SPEAKING,this.onVoiceChatStartSpeakingHandler);
         App.voiceChatMgr.addEventListener(VoiceChatEvent.STOP_SPEAKING,this.onVoiceChatStopSpeakingHandler);
         App.colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
         addEventListener(DynamicSquadEvent.ACCEPT,this.onDynamicSquadAcceptHandler);
         addEventListener(DynamicSquadEvent.ADD,this.onDynamicSquadAddHandler);
      }
      
      override protected function onBeforeDispose() : void
      {
         this.listLeft.removeEventListener(MouseEvent.ROLL_OVER,this.onListRollOverHandler);
         this.listLeft.removeEventListener(MouseEvent.ROLL_OUT,this.onListRollOutHandler);
         this.listLeft.removeEventListener(PlayersPanelListEvent.ITEM_SELECTED,this.onListItemSelectedHandler);
         this.listLeft.removeEventListener(PlayersPanelListEvent.ITEM_CONTEXT_MENU_OPEN,this.onListItemContextMenuOpenHandler);
         this.listRight.removeEventListener(MouseEvent.ROLL_OVER,this.onListRollOverHandler);
         this.listRight.removeEventListener(MouseEvent.ROLL_OUT,this.onListRollOutHandler);
         this.listRight.removeEventListener(PlayersPanelListEvent.ITEM_SELECTED,this.onListItemSelectedHandler);
         this.listRight.removeEventListener(PlayersPanelListEvent.ITEMS_COUNT_CHANGE,this.onListItemsCountChangeHandler);
         this.listRight.removeEventListener(PlayersPanelListEvent.ITEM_CONTEXT_MENU_OPEN,this.onListItemContextMenuOpenHandler);
         App.voiceChatMgr.removeEventListener(VoiceChatEvent.START_SPEAKING,this.onVoiceChatStartSpeakingHandler);
         App.voiceChatMgr.removeEventListener(VoiceChatEvent.STOP_SPEAKING,this.onVoiceChatStopSpeakingHandler);
         App.colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
         removeEventListener(DynamicSquadEvent.ACCEPT,this.onDynamicSquadAcceptHandler);
         removeEventListener(DynamicSquadEvent.ADD,this.onDynamicSquadAddHandler);
         App.utils.scheduler.cancelTask(this.addMouseClickHandlerToStageTask);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.listLeft.dispose();
         this.listRight.dispose();
         if(this.panelSwitch)
         {
            this.panelSwitch.removeEventListener(PlayersPanelSwitchEvent.STATE_REQUESTED,this.onPanelSwitchStateRequestedHandler);
            this.panelSwitch.dispose();
         }
         this.listLeft = null;
         this.listRight = null;
         this.panelSwitch = null;
         this.contextMenuMgr = null;
         super.onDispose();
      }
      
      public function addVehiclesInfo(param1:IDAAPIDataClass) : void
      {
         this.applyVehicleData(param1);
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function as_setChatCommandsVisibility(param1:Boolean) : void
      {
         this.listLeft.setChatCommandVisibility(param1);
         this.listRight.setChatCommandVisibility(param1);
      }
      
      public function as_setIsInteractive(param1:Boolean) : void
      {
         if(this.panelSwitch)
         {
            this.panelSwitch.setIsInteractive(param1);
         }
         this.listLeft.setIsCursorVisible(param1);
         this.listRight.setIsCursorVisible(param1);
         if(!param1)
         {
            App.toolTipMgr.hide();
            this.currentColumnOver = -1;
            if(this.expandState != PLAYERS_PANEL_STATE.NONE)
            {
               this.setListsState(this.expandState);
               this.expandState = PLAYERS_PANEL_STATE.NONE;
            }
         }
         this._isInteractive = param1;
         this.applyListsInteractivity();
      }
      
      public function as_setOverrideExInfo(param1:Boolean) : void
      {
         this.listRight.setOverrideExInfo(param1);
         this.listLeft.setOverrideExInfo(param1);
      }
      
      public function as_setPanelHPBarVisibilityState(param1:uint) : void
      {
         this.listLeft.setPanelHPBarVisibilityState(param1);
         this.listRight.setPanelHPBarVisibilityState(param1);
      }
      
      public function as_setPanelMode(param1:int) : void
      {
         this._isStateRequested = false;
         if(this.expandState != PLAYERS_PANEL_STATE.NONE)
         {
            this.expandState = param1;
         }
         else if(this._state != param1)
         {
            this.setListsState(param1);
         }
         if(this.panelSwitch)
         {
            this.panelSwitch.setState(param1);
         }
      }
      
      public function as_setPlayerHP(param1:Boolean, param2:int, param3:int) : void
      {
         if(param1)
         {
            this.listLeft.setPlayerHP(param2,param3);
         }
         else
         {
            this.listRight.setPlayerHP(param2,param3);
         }
      }
      
      public function resetFrags() : void
      {
         this.listLeft.resetFrags();
         this.listRight.resetFrags();
      }
      
      public function setArenaInfo(param1:IDAAPIDataClass) : void
      {
      }
      
      public function setFrags(param1:IDAAPIDataClass) : void
      {
         this.updateFrags(param1);
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
         var _loc4_:DAAPIVehicleUserTagsVO = null;
         var _loc2_:DAAPIVehiclesUserTagsVO = DAAPIVehiclesUserTagsVO(param1);
         var _loc3_:Vector.<DAAPIVehicleUserTagsVO> = _loc2_.leftUserTags;
         for each(_loc4_ in _loc3_)
         {
            this.listLeft.setUserTags(_loc4_.vehicleID,_loc4_.userTags);
         }
         _loc3_ = _loc2_.rightUserTags;
         for each(_loc4_ in _loc3_)
         {
            this.listRight.setUserTags(_loc4_.vehicleID,_loc4_.userTags);
         }
      }
      
      public function setVehiclesData(param1:IDAAPIDataClass) : void
      {
         this.clearVehicleData();
         this.applyVehicleData(param1);
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function updateInvitationsStatuses(param1:IDAAPIDataClass) : void
      {
         var _loc4_:DAAPIInvitationStatusVO = null;
         var _loc2_:DAAPIVehiclesInvitationStatusVO = DAAPIVehiclesInvitationStatusVO(param1);
         var _loc3_:Vector.<DAAPIInvitationStatusVO> = _loc2_.leftItems;
         for each(_loc4_ in _loc3_)
         {
            this.listLeft.setInvitationStatus(_loc4_.vehicleID,_loc4_.status);
         }
         _loc3_ = _loc2_.rightItems;
         for each(_loc4_ in _loc3_)
         {
            this.listRight.setInvitationStatus(_loc4_.vehicleID,_loc4_.status);
         }
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
         if(_loc2_.isEnemy)
         {
            this.listRight.setPlayerStatus(_loc2_.vehicleID,_loc2_.status);
         }
         else
         {
            this.listLeft.setPlayerStatus(_loc2_.vehicleID,_loc2_.status);
         }
      }
      
      public function updateStageSize(param1:Number, param2:Number) : void
      {
         this.listRight.x = param1;
      }
      
      public function updateTriggeredChatCommands(param1:IDAAPIDataClass) : void
      {
         var _loc2_:DAAPITriggeredCommandsVO = null;
         var _loc4_:DAAPITriggeredCommandVO = null;
         _loc2_ = DAAPITriggeredCommandsVO(param1);
         var _loc3_:Vector.<DAAPITriggeredCommandVO> = _loc2_.triggeredCommands;
         for each(_loc4_ in _loc3_)
         {
            this.listLeft.triggerChatCommand(_loc4_.vehicleID,_loc4_.chatCommandName);
         }
      }
      
      public function updateUserTags(param1:IDAAPIDataClass) : void
      {
         var _loc2_:DAAPIVehicleUserTagsVO = DAAPIVehicleUserTagsVO(param1);
         if(_loc2_.isEnemy)
         {
            this.listRight.setUserTags(_loc2_.vehicleID,_loc2_.userTags);
         }
         else
         {
            this.listLeft.setUserTags(_loc2_.vehicleID,_loc2_.userTags);
         }
      }
      
      public function updateVehicleStatus(param1:IDAAPIDataClass) : void
      {
         var _loc2_:DAAPIVehicleStatusVO = DAAPIVehicleStatusVO(param1);
         if(_loc2_.isEnemy)
         {
            this.listRight.setVehicleStatus(_loc2_.vehicleID,_loc2_.status);
            if(_loc2_.dogTag)
            {
               this.listRight.showDogTag(_loc2_.vehicleID,_loc2_.dogTag);
            }
            if(_loc2_.rightVehiclesIDs)
            {
               this.listRight.updateOrder(_loc2_.rightVehiclesIDs);
            }
         }
         else
         {
            this.listLeft.setVehicleStatus(_loc2_.vehicleID,_loc2_.status);
            if(_loc2_.leftVehiclesIDs)
            {
               this.listLeft.updateOrder(_loc2_.leftVehiclesIDs);
            }
         }
      }
      
      public function updateVehiclesData(param1:IDAAPIDataClass) : void
      {
      }
      
      public function updateVehiclesStat(param1:IDAAPIDataClass) : void
      {
         var _loc4_:DAAPIVehicleStatsVO = null;
         var _loc2_:DAAPIVehiclesStatsVO = DAAPIVehiclesStatsVO(param1);
         var _loc3_:Vector.<DAAPIVehicleStatsVO> = _loc2_.leftFrags;
         for each(_loc4_ in _loc3_)
         {
            this.listLeft.setFrags(_loc4_.vehicleID,_loc4_.frags);
            this.listLeft.setChatCommand(_loc4_.vehicleID,_loc4_.chatCommand,_loc4_.chatCommandFlags);
         }
         _loc3_ = _loc2_.rightFrags;
         for each(_loc4_ in _loc3_)
         {
            this.listRight.setFrags(_loc4_.vehicleID,_loc4_.frags);
            this.listRight.setChatCommand(_loc4_.vehicleID,_loc4_.chatCommand,_loc4_.chatCommandFlags);
            this.listRight.setSpottedStatus(_loc4_.vehicleID,_loc4_.spottedStatus);
         }
      }
      
      protected function applyVehicleData(param1:IDAAPIDataClass) : void
      {
      }
      
      protected function setListsState(param1:int) : void
      {
      }
      
      protected function requestState(param1:int) : void
      {
         if(this.state == param1)
         {
            return;
         }
         this._isStateRequested = true;
         tryToSetPanelModeByMouseS(param1);
      }
      
      protected function notifyChangeItemsCount() : void
      {
         dispatchEvent(new PlayersPanelEvent(PlayersPanelEvent.ON_ITEMS_COUNT_CHANGE));
      }
      
      private function clearVehicleData() : void
      {
         this.listLeft.removeAllItems();
         this.listRight.removeAllItems();
      }
      
      private function updateFrags(param1:IDAAPIDataClass) : void
      {
         var _loc4_:DAAPIVehicleStatsVO = null;
         var _loc2_:DAAPIVehiclesStatsVO = DAAPIVehiclesStatsVO(param1);
         var _loc3_:Vector.<DAAPIVehicleStatsVO> = _loc2_.leftFrags;
         for each(_loc4_ in _loc3_)
         {
            this.listLeft.setFrags(_loc4_.vehicleID,_loc4_.frags);
         }
         _loc3_ = _loc2_.rightFrags;
         for each(_loc4_ in _loc3_)
         {
            this.listRight.setFrags(_loc4_.vehicleID,_loc4_.frags);
         }
      }
      
      private function applyPersonalStatus() : void
      {
         var _loc1_:Boolean = PersonalStatus.isVehicleLevelShown(this._personalStatus);
         this.listLeft.setIsInviteShown(PersonalStatus.isShowAllyInvites(this._personalStatus));
         this.listRight.setIsInviteShown(PersonalStatus.isShowEnemyInvites(this._personalStatus));
         this.listLeft.setVehicleLevelVisible(_loc1_);
         this.listRight.setVehicleLevelVisible(_loc1_);
         this.applyListsInteractivity();
      }
      
      private function applyListsInteractivity() : void
      {
         var _loc1_:Boolean = this._isInteractive && !PersonalStatus.isSquadRestrictions(this._personalStatus);
         this.listLeft.setIsInteractive(_loc1_ && PersonalStatus.isCanSendInviteToAlly(this._personalStatus));
         this.listRight.setIsInteractive(_loc1_ && PersonalStatus.isCanSendInviteToEnemy(this._personalStatus));
      }
      
      private function addMouseClickHandlerToStageTask() : void
      {
         App.utils.scheduler.cancelTask(this.addMouseClickHandlerToStageTask);
         App.stage.addEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
      }
      
      public function get state() : int
      {
         return this._state;
      }
      
      public function set state(param1:int) : void
      {
         this._state = param1;
      }
      
      public function get panelHeight() : Number
      {
         return this.y + this.listRight.y + this.listRight.height;
      }
      
      protected function onListItemSelected(param1:PlayersPanelListEvent) : void
      {
      }
      
      protected function onListRollOver(param1:MouseEvent) : void
      {
      }
      
      protected function onListRollOut(param1:MouseEvent) : void
      {
      }
      
      protected function onListItemContextMenuOpen(param1:PlayersPanelListEvent) : void
      {
      }
      
      private function onListItemsCountChangeHandler(param1:PlayersPanelListEvent) : void
      {
         this.notifyChangeItemsCount();
      }
      
      private function onListItemContextMenuOpenHandler(param1:PlayersPanelListEvent) : void
      {
         this.contextMenuMgr.show(BATTLE_CONTEXT_MENU_HANDLER_TYPE.PLAYERS_PANEL,this,new PlayersPanelContextMenuSentData(param1.vehicleID));
         MinimapEntryController.instance.unhighlight();
         App.toolTipMgr.hide();
         App.utils.scheduler.scheduleOnNextFrame(this.addMouseClickHandlerToStageTask);
         this.onListItemContextMenuOpen(param1);
      }
      
      private function onListItemSelectedHandler(param1:PlayersPanelListEvent) : void
      {
         this.onListItemSelected(param1);
         if(this.contextMenuMgr.isShown())
         {
            App.stage.removeEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
         }
         if(this.isPlayerSwitchingAllowed)
         {
            switchToOtherPlayerS(param1.vehicleID);
         }
      }
      
      private function onListRollOverHandler(param1:MouseEvent) : void
      {
         if(this._isInteractive && !this._isStateRequested && !this.contextMenuMgr.isShown() && this.expandState == PLAYERS_PANEL_STATE.NONE)
         {
            this.expandState = this._state;
            this.onListRollOver(param1);
         }
      }
      
      private function onListRollOutHandler(param1:MouseEvent) : void
      {
         if(this._isInteractive && !this._isStateRequested && !this.contextMenuMgr.isShown() && this.expandState != PLAYERS_PANEL_STATE.NONE)
         {
            this.onListRollOut(param1);
         }
      }
      
      private function onVoiceChatStartSpeakingHandler(param1:VoiceChatEvent) : void
      {
         var _loc2_:Number = param1.getAccountDBID();
         this.listLeft.setSpeaking(_loc2_,true);
         this.listRight.setSpeaking(_loc2_,true);
      }
      
      private function onVoiceChatStopSpeakingHandler(param1:VoiceChatEvent) : void
      {
         var _loc2_:Number = param1.getAccountDBID();
         this.listLeft.setSpeaking(_loc2_,false);
         this.listRight.setSpeaking(_loc2_,false);
      }
      
      private function onColorSchemasUpdatedHandler(param1:ColorSchemeEvent) : void
      {
         this.listLeft.updateColorBlind();
         this.listRight.updateColorBlind();
      }
      
      private function onPanelSwitchStateRequestedHandler(param1:PlayersPanelSwitchEvent) : void
      {
         this.requestState(param1.state);
      }
      
      private function onDynamicSquadAcceptHandler(param1:DynamicSquadEvent) : void
      {
         acceptSquadS(param1.sessionID);
      }
      
      private function onDynamicSquadAddHandler(param1:DynamicSquadEvent) : void
      {
         addToSquadS(param1.sessionID);
      }
      
      private function onMouseClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = this.listLeft as MovieClip;
         var _loc3_:MovieClip = this.listRight as MovieClip;
         var _loc4_:Boolean = !_loc2_ || !_loc2_.hitTestPoint(stage.mouseX,stage.mouseY);
         var _loc5_:Boolean = !_loc3_ || !_loc3_.hitTestPoint(stage.mouseX,stage.mouseY);
         if(_loc4_ && _loc5_)
         {
            this.onListRollOutHandler(new MouseEvent(MouseEvent.ROLL_OUT));
         }
         App.stage.removeEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
      }
   }
}
