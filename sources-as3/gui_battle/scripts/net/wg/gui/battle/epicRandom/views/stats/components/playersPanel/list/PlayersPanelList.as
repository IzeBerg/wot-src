package net.wg.gui.battle.epicRandom.views.stats.components.playersPanel.list
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.PlayerStatus;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.PLAYERS_PANEL_STATE;
   import net.wg.gui.battle.components.events.PlayersPanelListEvent;
   import net.wg.gui.battle.epicRandom.VO.daapi.EpicRandomDAAPIVehicleInfoVO;
   import net.wg.gui.battle.epicRandom.views.stats.components.playersPanel.events.PlayersPanelItemEvent;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.interfaces.IEpicPlayersPanelList;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.interfaces.IPlayersPanelListItemHolder;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.list.InviteReceivedIndicator;
   import net.wg.gui.battle.views.minimap.MinimapEntryController;
   import net.wg.gui.components.dogtag.DogtagComponent;
   import net.wg.gui.components.dogtag.VO.DogTagVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.infrastructure.managers.ITooltipMgr;
   
   public class PlayersPanelList extends MovieClip implements IEpicPlayersPanelList
   {
      
      private static const ITEM_HEIGHT:int = 32;
      
      private static const SELF_BG_SHORT_WIDTH:int = 56;
      
      private static const SELF_BG_LONG_WIDTH:int = 119;
      
      private static const INITIAL_HEIGHT_OFFSET:int = 32;
      
      private static const LIST_STATE_HIDDEN:String = "hidden";
      
      private static const LIST_STATE_SINGLE_SHORT:String = "1col_short";
      
      private static const LIST_STATE_SINGLE_MEDIUM:String = "1col_medium";
      
      private static const LIST_STATE_TRIPLE_COLUMN_SHORT:String = "3col_short";
      
      private static const LIST_STATE_TRIPLE_COLUMN_SHORT_SECOND_FOCUS:String = "3col_short_2nd";
      
      private static const LIST_STATE_TRIPLE_COLUMN_SHORT_THIRD_FOCUS:String = "3col_short_3rd";
      
      private static const LIST_STATE_TRIPLE_COLUMN_MEDIUM:String = "3col_medium";
      
      private static const LIST_STATE_TRIPLE_COLUMN_MEDIUM_SECOND_FOCUS:String = "3col_medium_2nd";
      
      private static const LIST_STATE_TRIPLE_COLUMN_MEDIUM_THIRD_FOCUS:String = "3col_medium_3rd";
      
      private static const WRONG_GROUP_ERROR_MSG:String = "[PlayersPanelList] Player group set to 0 or less for vehicleId: ";
      
      private static const INVALID_STATE_ERROR_MSG:String = "[PlayersPanelList] In setListBackgroundState the value is invalid!";
      
      private static const LIST_WIDTH_HIDDEN:int = 0;
      
      private static const LIST_WIDTH_ONE_COL_SHORT:int = 158;
      
      private static const LIST_WIDTH_ONE_COL_MEDIUM:int = 226;
      
      private static const LIST_WIDTH_THREE_COL_SHORT:int = 266;
      
      private static const LIST_WIDTH_THREE_COL_MEDIUM:int = 338;
      
      private static const FIRST_COLUMN:int = 0;
      
      private static const SECOND_COLUMN:int = 1;
      
      private static const THIRD_COLUMN:int = 2;
      
      private static const DOG_TAG_OFFSET_X:int = 30;
       
      
      public var inviteReceivedIndicator:InviteReceivedIndicator;
      
      public var spawnGroupIcon1:PlayersPanelDeploymentGroupIcon = null;
      
      public var spawnGroupIcon2:PlayersPanelDeploymentGroupIcon = null;
      
      public var spawnGroupIcon3:PlayersPanelDeploymentGroupIcon = null;
      
      public var selfBg:MovieClip = null;
      
      public var rowContainer:ListRowBackgroundContainer = null;
      
      private var _playerGroupID:int = 2;
      
      private var _items:Vector.<IPlayersPanelListItemHolder> = null;
      
      private var _itemsHealth:Dictionary = null;
      
      private var _panelListItems:Vector.<PlayersPanelListItem> = null;
      
      private var _vehicleIDtoPlayerGroup:Dictionary = null;
      
      private var _currOrder:Vector.<Vector.<Number>> = null;
      
      private var _spawnGroupIcons:Vector.<PlayersPanelDeploymentGroupIcon> = null;
      
      private var _itemUnderMouse:PlayersPanelListItem = null;
      
      private var _isInviteReceived:Boolean = false;
      
      private var _playerVehicleID:Number = 0;
      
      private var _isInteractive:Boolean = false;
      
      private var _isInviteShown:Boolean = false;
      
      private var _isCursorVisible:Boolean = false;
      
      private var _lengthChanged:Boolean = false;
      
      private var _renderersContainer:Sprite = null;
      
      private var _rendererStates:Vector.<uint> = null;
      
      private var _state:int = -1;
      
      private var _listStates:Dictionary = null;
      
      private var _listWidths:Dictionary = null;
      
      private var _currentState:Number = 0;
      
      private var _toolTipString:String = null;
      
      private var _tooltipMgr:ITooltipMgr = null;
      
      private var _dogTag:DogtagComponent = null;
      
      private var _HPBarVisibilityState:uint = 0;
      
      public function PlayersPanelList()
      {
         super();
         this._tooltipMgr = App.toolTipMgr;
         this._listStates = new Dictionary();
         this._listStates[PLAYERS_PANEL_STATE.HIDDEN] = LIST_STATE_HIDDEN;
         this._listStates[PLAYERS_PANEL_STATE.SHORT] = LIST_STATE_SINGLE_SHORT;
         this._listStates[PLAYERS_PANEL_STATE.EPIC_RANDOM_SINGLE_COLUMN_MEDIUM_PLAYER] = LIST_STATE_SINGLE_MEDIUM;
         this._listStates[PLAYERS_PANEL_STATE.EPIC_RANDOM_SINGLE_COLUMN_MEDIUM_TANK] = LIST_STATE_SINGLE_MEDIUM;
         this._listStates[PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_HIDDEN] = LIST_STATE_HIDDEN;
         this._listStates[PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_SHORT] = LIST_STATE_TRIPLE_COLUMN_SHORT;
         this._listStates[PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_PLAYER] = LIST_STATE_TRIPLE_COLUMN_MEDIUM;
         this._listStates[PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_TANK] = LIST_STATE_TRIPLE_COLUMN_MEDIUM;
         this._listStates[PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_SHORT_SECOND_FOCUS] = LIST_STATE_TRIPLE_COLUMN_SHORT_SECOND_FOCUS;
         this._listStates[PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_PLAYER_SECOND_FOCUS] = LIST_STATE_TRIPLE_COLUMN_MEDIUM_SECOND_FOCUS;
         this._listStates[PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_TANK_SECOND_FOCUS] = LIST_STATE_TRIPLE_COLUMN_MEDIUM_SECOND_FOCUS;
         this._listStates[PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_SHORT_THIRD_FOCUS] = LIST_STATE_TRIPLE_COLUMN_SHORT_THIRD_FOCUS;
         this._listStates[PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_PLAYER_THIRD_FOCUS] = LIST_STATE_TRIPLE_COLUMN_MEDIUM_THIRD_FOCUS;
         this._listStates[PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_TANK_THIRD_FOCUS] = LIST_STATE_TRIPLE_COLUMN_MEDIUM_THIRD_FOCUS;
         this._listWidths = new Dictionary();
         this._listWidths[PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_HIDDEN] = LIST_WIDTH_HIDDEN;
         this._listWidths[PLAYERS_PANEL_STATE.HIDDEN] = LIST_WIDTH_HIDDEN;
         this._listWidths[PLAYERS_PANEL_STATE.SHORT] = LIST_WIDTH_ONE_COL_SHORT;
         this._listWidths[PLAYERS_PANEL_STATE.EPIC_RANDOM_SINGLE_COLUMN_MEDIUM_PLAYER] = LIST_WIDTH_ONE_COL_MEDIUM;
         this._listWidths[PLAYERS_PANEL_STATE.EPIC_RANDOM_SINGLE_COLUMN_MEDIUM_TANK] = LIST_WIDTH_ONE_COL_MEDIUM;
         this._listWidths[PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_SHORT] = LIST_WIDTH_THREE_COL_SHORT;
         this._listWidths[PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_PLAYER] = LIST_WIDTH_THREE_COL_MEDIUM;
         this._listWidths[PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_TANK] = LIST_WIDTH_THREE_COL_MEDIUM;
         this._listWidths[PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_SHORT_SECOND_FOCUS] = LIST_WIDTH_THREE_COL_SHORT;
         this._listWidths[PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_PLAYER_SECOND_FOCUS] = LIST_WIDTH_THREE_COL_MEDIUM;
         this._listWidths[PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_TANK_SECOND_FOCUS] = LIST_WIDTH_THREE_COL_MEDIUM;
         this._listWidths[PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_SHORT_THIRD_FOCUS] = LIST_WIDTH_THREE_COL_SHORT;
         this._listWidths[PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_PLAYER_THIRD_FOCUS] = LIST_WIDTH_THREE_COL_MEDIUM;
         this._listWidths[PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_TANK_THIRD_FOCUS] = LIST_WIDTH_THREE_COL_MEDIUM;
         this._items = new Vector.<IPlayersPanelListItemHolder>();
         this._itemsHealth = new Dictionary();
         this._panelListItems = new Vector.<PlayersPanelListItem>();
         this._currOrder = new <Vector.<Number>>[new Vector.<Number>(),new Vector.<Number>(),new Vector.<Number>()];
         this._rendererStates = new <uint>[0,0,0];
         this._vehicleIDtoPlayerGroup = new Dictionary();
         this._renderersContainer = new Sprite();
         addChild(this._renderersContainer);
         this.inviteReceivedIndicator.visible = false;
         this._spawnGroupIcons = new <PlayersPanelDeploymentGroupIcon>[this.spawnGroupIcon1,this.spawnGroupIcon2,this.spawnGroupIcon3];
         this.spawnGroupIcon1.addEventListener(MouseEvent.CLICK,this.onFirstSpawnGroupClickHandler);
         this.spawnGroupIcon2.addEventListener(MouseEvent.CLICK,this.onSecondSpawnGroupClickHandler);
         this.spawnGroupIcon3.addEventListener(MouseEvent.CLICK,this.onThirdSpawnGroupClickHandler);
         this.spawnGroupIcon1.addEventListener(MouseEvent.MOUSE_OVER,this.onFirstSpawnGroupMouseOverHandler);
         this.spawnGroupIcon2.addEventListener(MouseEvent.MOUSE_OVER,this.onSecondSpawnGroupMouseOverHandler);
         this.spawnGroupIcon3.addEventListener(MouseEvent.MOUSE_OVER,this.onThirdSpawnGroupMouseOverHandler);
      }
      
      public function initDogTag() : void
      {
         this._dogTag = App.utils.classFactory.getComponent(Linkages.DOGTAG,DogtagComponent);
         this._dogTag.hideNameAndClan();
         this._dogTag.goToLabel(DogtagComponent.DOGTAG_LABEL_END_FULL);
         this._dogTag.alpha = 0;
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
      
      public function getItemHolderClass() : Class
      {
         return PlayersPanelListItemHolder;
      }
      
      public function getListItemClass() : Class
      {
         return PlayersPanelListItem;
      }
      
      public function getRenderersVisibleWidth() : uint
      {
         return this._listWidths[this._currentState];
      }
      
      public function removeAllItems() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Vector.<Number> = null;
         var _loc3_:PlayersPanelListItem = null;
         var _loc4_:int = 0;
         if(this._panelListItems)
         {
            for each(_loc3_ in this._panelListItems)
            {
               _loc3_.removeEventListener(MouseEvent.MOUSE_OVER,this.onHitMouseOverHandler);
               _loc3_.removeEventListener(MouseEvent.MOUSE_OUT,this.onHitMouseOutHandler);
               _loc3_.dispose();
            }
            this._panelListItems.splice(0,this._panelListItems.length);
         }
         if(this._items != null)
         {
            _loc1_ = this._items.length;
            _loc4_ = 0;
            while(_loc4_ < _loc1_)
            {
               this._items[_loc4_].dispose();
               _loc4_++;
            }
            this._items.length = 0;
         }
         if(this._renderersContainer != null)
         {
            _loc1_ = this._renderersContainer.numChildren;
            while(--_loc1_ >= 0)
            {
               this._renderersContainer.removeChildAt(0);
            }
         }
         for each(_loc2_ in this._currOrder)
         {
            _loc2_.length = 0;
         }
         this._playerVehicleID = 0;
      }
      
      public function resetFrags() : void
      {
      }
      
      public function setAndSortByGroup(param1:int, param2:Number) : void
      {
         if(this.selectedPlayerGroup == param1)
         {
            return;
         }
         this.selectedPlayerGroup = param1;
         this._playerVehicleID = param2;
         this.sortColumns(this._currOrder,param1);
         this.respositionSelfBg(this._currOrder[this._playerGroupID - 1].indexOf(this._playerVehicleID));
         this.refreshSelfBackground();
      }
      
      public function setFrags(param1:Number, param2:int) : void
      {
         var _loc3_:IPlayersPanelListItemHolder = this.getHolderByVehicleID(param1);
         if(_loc3_)
         {
            _loc3_.setFrags(param2);
         }
      }
      
      public function setInvitationStatus(param1:Number, param2:uint) : void
      {
         var _loc3_:IPlayersPanelListItemHolder = this.getHolderByVehicleID(param1);
         if(!_loc3_)
         {
            return;
         }
         _loc3_.setInvitationStatus(param2);
         if(_loc3_.isInviteReceived)
         {
            this._isInviteReceived = true;
         }
         else
         {
            this._isInviteReceived = false;
            for each(_loc3_ in this._items)
            {
               if(_loc3_.isInviteReceived)
               {
                  this._isInviteReceived = true;
                  break;
               }
            }
         }
         this.updateInviteIndicator();
      }
      
      public function setIsCursorVisible(param1:Boolean) : void
      {
         var _loc2_:IPlayersPanelListItemHolder = null;
         if(this._isCursorVisible == param1)
         {
            return;
         }
         this._isCursorVisible = param1;
         this.setMouseListenersEnabled(param1);
         if(this._itemUnderMouse)
         {
            if(this._isCursorVisible)
            {
               _loc2_ = this._items[this._itemUnderMouse.holderItemID];
               MinimapEntryController.instance.highlight(_loc2_.vehicleID);
            }
            else
            {
               this._itemUnderMouse = null;
               MinimapEntryController.instance.unhighlight();
            }
         }
         if(!this._isCursorVisible && this._dogTag)
         {
            removeChild(this._dogTag);
         }
      }
      
      public function setIsInteractive(param1:Boolean) : void
      {
         var _loc2_:PlayersPanelListItem = null;
         if(this._isInteractive == param1)
         {
            return;
         }
         this._isInteractive = param1;
         for each(_loc2_ in this._panelListItems)
         {
            _loc2_.setIsInteractive(param1);
         }
      }
      
      public function setIsInviteShown(param1:Boolean) : void
      {
         var _loc2_:PlayersPanelListItem = null;
         if(this._isInviteShown == param1)
         {
            return;
         }
         this._isInviteShown = param1;
         for each(_loc2_ in this._panelListItems)
         {
            _loc2_.setIsInviteShown(param1);
         }
      }
      
      public function setPlayerStatus(param1:Number, param2:uint) : void
      {
         var _loc3_:IPlayersPanelListItemHolder = this.getHolderByVehicleID(param1);
         if(_loc3_)
         {
            _loc3_.setPlayerStatus(param2);
            if(PlayerStatus.isSelected(param2))
            {
               if(this._vehicleIDtoPlayerGroup[param1] != this._playerGroupID)
               {
                  dispatchEvent(new PlayersPanelListEvent(PlayersPanelListEvent.ITEMS_GROUP_CHANGED,param1,this._vehicleIDtoPlayerGroup[param1]));
               }
               else if(param1 != this._playerVehicleID)
               {
                  this.respositionSelfBg(this._currOrder[this._playerGroupID - 1].indexOf(param1));
                  this._playerVehicleID = param1;
                  this.refreshSelfBackground();
               }
            }
            else if(param1 == this._playerVehicleID)
            {
               this._playerVehicleID = 0;
               this.refreshSelfBackground();
            }
         }
      }
      
      public function setSpeaking(param1:Number, param2:Boolean) : void
      {
         var _loc3_:PlayersPanelListItem = this.getItemByAccountID(param1);
         if(_loc3_)
         {
            _loc3_.setIsSpeaking(param2);
         }
      }
      
      public function setUserTags(param1:Number, param2:Array) : void
      {
         var _loc3_:IPlayersPanelListItemHolder = this.getHolderByVehicleID(param1);
         if(_loc3_)
         {
            _loc3_.setUserTags(param2);
         }
      }
      
      public function setVehicleData(param1:Vector.<DAAPIVehicleInfoVO>) : void
      {
         var _loc3_:EpicRandomDAAPIVehicleInfoVO = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:IPlayersPanelListItemHolder = null;
         var _loc8_:int = 0;
         var _loc9_:Boolean = false;
         var _loc2_:uint = this._items.length;
         for each(_loc3_ in param1)
         {
            _loc7_ = this.getHolderByVehicleID(_loc3_.vehicleID);
            if(_loc7_)
            {
               _loc8_ = this._vehicleIDtoPlayerGroup[_loc3_.vehicleID];
               if(_loc8_ != _loc3_.playerGroup)
               {
                  this._currOrder[_loc8_ - 1].pop();
                  this._currOrder[_loc3_.playerGroup - 1].push(_loc3_.vehicleID);
                  this._lengthChanged = true;
                  this._vehicleIDtoPlayerGroup[_loc3_.vehicleID] = _loc3_.playerGroup;
               }
               _loc7_.setVehicleData(_loc3_);
            }
            else
            {
               _loc9_ = this.addItem(_loc3_,_loc2_);
               if(_loc9_)
               {
                  this._vehicleIDtoPlayerGroup[_loc3_.vehicleID] = _loc3_.playerGroup;
                  this._lengthChanged = true;
                  _loc2_++;
               }
            }
         }
         _loc4_ = 0;
         _loc5_ = this._currOrder.length;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            if(this._currOrder[_loc6_].length > _loc4_)
            {
               _loc4_ = this._currOrder[_loc6_].length;
            }
            _loc6_++;
         }
         this.rowContainer.setBackgroundRowEntries(_loc4_);
         this.updateInviteIndicator();
      }
      
      public function setVehicleLevelVisible(param1:Boolean) : void
      {
      }
      
      public function setVehicleStatus(param1:Number, param2:uint) : void
      {
         var _loc3_:IPlayersPanelListItemHolder = this.getHolderByVehicleID(param1);
         if(_loc3_)
         {
            _loc3_.setVehicleStatus(param2);
         }
      }
      
      public function updateColorBlind() : void
      {
         var _loc1_:PlayersPanelListItem = null;
         for each(_loc1_ in this._panelListItems)
         {
            _loc1_.updateColorBlind();
         }
      }
      
      public function setChatCommand(param1:Number, param2:String, param3:uint) : void
      {
         var _loc4_:IPlayersPanelListItemHolder = this.getHolderByVehicleID(param1);
         if(_loc4_)
         {
            _loc4_.setChatCommand(param2,param3);
         }
      }
      
      public function triggerChatCommand(param1:Number, param2:String) : void
      {
         var _loc3_:IPlayersPanelListItemHolder = this.getHolderByVehicleID(param1);
         if(_loc3_)
         {
            _loc3_.triggerChatCommand(param2);
         }
      }
      
      public function setSpottedStatus(param1:Number, param2:uint) : void
      {
         var _loc3_:IPlayersPanelListItemHolder = this.getHolderByVehicleID(param1);
         if(_loc3_)
         {
            _loc3_.setSpottedStatus(param2);
         }
      }
      
      public function updateOrder(param1:Vector.<Number>) : void
      {
         if(!param1 || this._playerGroupID == -1)
         {
            return;
         }
         var _loc2_:Vector.<Number> = new Vector.<Number>();
         var _loc3_:Vector.<Number> = new Vector.<Number>();
         var _loc4_:Vector.<Number> = new Vector.<Number>();
         var _loc5_:Vector.<Vector.<Number>> = new <Vector.<Number>>[_loc2_,_loc3_,_loc4_];
         var _loc6_:int = param1.length;
         var _loc7_:Number = 0;
         var _loc8_:int = -1;
         var _loc9_:int = 0;
         while(_loc9_ < _loc6_)
         {
            _loc7_ = param1[_loc9_];
            if(this._vehicleIDtoPlayerGroup[_loc7_] != -1)
            {
               _loc8_ = this._vehicleIDtoPlayerGroup[_loc7_];
            }
            if(_loc8_ <= 0)
            {
               DebugUtils.LOG_ERROR(WRONG_GROUP_ERROR_MSG,_loc7_);
            }
            else
            {
               _loc5_[_loc8_ - 1].push(_loc7_);
            }
            _loc9_++;
         }
         this.evaluateRendererStates(this._state);
         this.sortColumns(_loc5_,this.selectedPlayerGroup);
         this.respositionSelfBg(this._currOrder[this._playerGroupID - 1].indexOf(this._playerVehicleID));
      }
      
      protected function onDispose() : void
      {
         this.setMouseListenersEnabled(false);
         this.spawnGroupIcon1.removeEventListener(MouseEvent.CLICK,this.onFirstSpawnGroupClickHandler);
         this.spawnGroupIcon2.removeEventListener(MouseEvent.CLICK,this.onSecondSpawnGroupClickHandler);
         this.spawnGroupIcon3.removeEventListener(MouseEvent.CLICK,this.onThirdSpawnGroupClickHandler);
         this.spawnGroupIcon1.removeEventListener(MouseEvent.MOUSE_OVER,this.onFirstSpawnGroupMouseOverHandler);
         this.spawnGroupIcon2.removeEventListener(MouseEvent.MOUSE_OVER,this.onSecondSpawnGroupMouseOverHandler);
         this.spawnGroupIcon3.removeEventListener(MouseEvent.MOUSE_OVER,this.onThirdSpawnGroupMouseOverHandler);
         this.spawnGroupIcon1.dispose();
         this.spawnGroupIcon1 = null;
         this.spawnGroupIcon2.dispose();
         this.spawnGroupIcon2 = null;
         this.spawnGroupIcon3.dispose();
         this.spawnGroupIcon3 = null;
         this._spawnGroupIcons.splice(0,this._spawnGroupIcons.length);
         this._spawnGroupIcons = null;
         this.rowContainer.dispose();
         this.rowContainer = null;
         this.inviteReceivedIndicator.dispose();
         this.inviteReceivedIndicator = null;
         this._itemUnderMouse = null;
         this.selfBg = null;
         this._rendererStates.splice(0,this._rendererStates.length);
         this._rendererStates = null;
         App.utils.data.cleanupDynamicObject(this._vehicleIDtoPlayerGroup);
         this._vehicleIDtoPlayerGroup = null;
         this.removeAllItems();
         this._items = null;
         this._currOrder.length = 0;
         this._currOrder = null;
         this._panelListItems = null;
         App.utils.data.cleanupDynamicObject(this._listStates);
         this._listStates = null;
         App.utils.data.cleanupDynamicObject(this._listWidths);
         this._listWidths = null;
         if(this._itemsHealth)
         {
            App.utils.data.cleanupDynamicObject(this._itemsHealth);
         }
         this._itemsHealth = null;
         this._renderersContainer = null;
         this._tooltipMgr = null;
         if(this._dogTag)
         {
            this._dogTag.dispose();
            this._dogTag = null;
         }
      }
      
      protected function setGroupIcons() : void
      {
         var _loc1_:uint = this._playerGroupID - 1;
         var _loc2_:uint = 1 << _loc1_ & 3;
         var _loc3_:uint = 1 << _loc2_ & 3;
         this.spawnGroupIcon1.setText((_loc1_ + 1).toString());
         this.spawnGroupIcon2.setText((_loc2_ + 1).toString());
         this.spawnGroupIcon3.setText((_loc3_ + 1).toString());
         var _loc4_:Boolean = this._currentState != PLAYERS_PANEL_STATE.HIDDEN && this._currentState != PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_HIDDEN;
         this.spawnGroupIcon1.visible = this.spawnGroupIcon2.visible = this.spawnGroupIcon3.visible = _loc4_;
      }
      
      private function updateInviteIndicator() : void
      {
         this.inviteReceivedIndicator.visible = (this.state == PLAYERS_PANEL_STATE.HIDDEN || this.state == PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_HIDDEN) && this._isInviteReceived;
      }
      
      private function sortColumns(param1:Vector.<Vector.<Number>>, param2:int) : void
      {
         var _loc3_:int = 1 << param2 - 1 & 3;
         var _loc4_:int = 1 << _loc3_ & 3;
         this.sortColumn(param1[param2 - 1],this._currOrder[param2 - 1],0);
         this.sortColumn(param1[_loc3_],this._currOrder[_loc3_],1);
         this.sortColumn(param1[_loc4_],this._currOrder[_loc4_],2);
      }
      
      private function sortColumn(param1:Vector.<Number>, param2:Vector.<Number>, param3:int) : void
      {
         var _loc8_:PlayersPanelListItemHolder = null;
         var _loc4_:int = param1.length;
         var _loc5_:int = param2.length;
         if(this._lengthChanged || _loc5_ != _loc4_)
         {
            param2.length = _loc4_;
            this._lengthChanged = true;
         }
         var _loc6_:Number = 0;
         var _loc7_:int = 0;
         while(_loc7_ < _loc4_)
         {
            _loc6_ = param1[_loc7_];
            if(this._lengthChanged || param2[_loc7_] != _loc6_)
            {
               _loc8_ = this.getHolderByVehicleID(param1[_loc7_]);
               if(_loc8_)
               {
                  if(_loc8_.listItem.columnNumber != param3)
                  {
                     _loc8_.listItem.columnNumber = param3;
                  }
                  _loc8_.listItem.y = _loc7_ * ITEM_HEIGHT + INITIAL_HEIGHT_OFFSET;
                  _loc8_.listItem.setState(this._rendererStates[param3]);
                  param2[_loc7_] = _loc6_;
               }
            }
            _loc7_++;
         }
      }
      
      private function refreshSelfBackground() : void
      {
         var _loc1_:int = this._currOrder[this._playerGroupID - 1].indexOf(this._playerVehicleID);
         this.selfBg.visible = _loc1_ > -1 && this._currentState != PLAYERS_PANEL_STATE.HIDDEN && this._currentState != PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_HIDDEN;
      }
      
      private function setListBackgroundState(param1:int) : void
      {
         this._currentState = param1;
         this.setGroupIcons();
         var _loc2_:String = this._listStates[param1];
         if(_loc2_)
         {
            gotoAndStop(_loc2_);
         }
         else
         {
            DebugUtils.LOG_ERROR(INVALID_STATE_ERROR_MSG);
         }
         this.refreshSelfBackground();
         this.rowContainer.setRowBackgroundEntriesState(_loc2_);
         this.rowContainer.visible = this._currentState != PLAYERS_PANEL_STATE.HIDDEN && this._currentState != PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_HIDDEN;
      }
      
      private function respositionSelfBg(param1:int) : void
      {
         this.selfBg.y = param1 * ITEM_HEIGHT + INITIAL_HEIGHT_OFFSET;
      }
      
      private function addItem(param1:EpicRandomDAAPIVehicleInfoVO, param2:uint) : Boolean
      {
         var _loc3_:int = param1.playerGroup;
         if(_loc3_ <= 0)
         {
            DebugUtils.LOG_ERROR(WRONG_GROUP_ERROR_MSG,param1.vehicleID,param1.playerName);
            return false;
         }
         var _loc4_:PlayersPanelListItem = App.utils.classFactory.getComponent(this.itemLinkage,PlayersPanelListItem);
         _loc4_.setIsInviteShown(this._isInviteShown);
         _loc4_.setIsInteractive(this._isInteractive);
         if(PlayerStatus.isSelected(param1.playerStatus))
         {
            this.selectedPlayerGroup = _loc3_;
            this._playerVehicleID = param1.vehicleID;
         }
         _loc4_.y = this._currOrder[_loc3_ - 1].length * ITEM_HEIGHT + INITIAL_HEIGHT_OFFSET;
         _loc4_.setIsRightAligned(this.isRightAligned);
         _loc4_.columnNumber = _loc3_ - 1;
         _loc4_.holderItemID = param2;
         _loc4_.setPanelHPBarVisibilityState(this._HPBarVisibilityState);
         this._renderersContainer.addChild(_loc4_);
         this._panelListItems.push(_loc4_);
         var _loc5_:IPlayersPanelListItemHolder = new PlayersPanelListItemHolder(_loc4_);
         _loc5_.setVehicleData(param1);
         this._items.push(_loc5_);
         _loc4_.setState(this._rendererStates[_loc3_ - 1]);
         if(this._itemsHealth[param1.vehicleID] !== undefined)
         {
            _loc5_.setPlayerHP(this._itemsHealth[param1.vehicleID]);
         }
         this._currOrder[_loc3_ - 1].push(param1.vehicleID);
         if(_loc5_.isCurrentPlayer && param1.isAnonymized)
         {
            _loc4_.dynamicSquad.setCurrentPlayerAnonymized();
            _loc4_.dynamicSquad.setIsCurrentPlayerInClan(param1.clanAbbrev != Values.EMPTY_STR);
            if(!this._toolTipString)
            {
               _loc4_.addEventListener(MouseEvent.MOUSE_OVER,this.onHitMouseOverHandler);
               _loc4_.addEventListener(MouseEvent.MOUSE_OUT,this.onHitMouseOutHandler);
               this.makeTooltipString(param1.playerFakeName,param1.clanAbbrev != Values.EMPTY_STR);
            }
         }
         return true;
      }
      
      private function makeTooltipString(param1:String, param2:Boolean) : void
      {
         this._toolTipString = !!param2 ? App.utils.locale.makeString(TOOLTIPS.ANONYMIZER_BATTLE_TEAMLIST_CLAN,{"fakeName":param1}) : App.utils.locale.makeString(TOOLTIPS.ANONYMIZER_BATTLE_TEAMLIST_NOCLAN,{"fakeName":param1});
      }
      
      public function setShowDogTag(param1:Boolean) : void
      {
      }
      
      public function showDogTag(param1:Number, param2:DogTagVO) : void
      {
         var _loc3_:PlayersPanelListItemHolder = this.getHolderByVehicleID(param1);
         _loc3_.listItem.showDogTag(param2);
      }
      
      private function getHolderByVehicleID(param1:Number) : PlayersPanelListItemHolder
      {
         var _loc2_:PlayersPanelListItemHolder = null;
         for each(_loc2_ in this._items)
         {
            if(_loc2_.vehicleID == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function getItemByAccountID(param1:Number) : PlayersPanelListItem
      {
         var _loc2_:int = this._items.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(this._items[_loc3_].accountDBID == param1)
            {
               return this._panelListItems[_loc3_];
            }
            _loc3_++;
         }
         return null;
      }
      
      private function setMouseListenersEnabled(param1:Boolean) : void
      {
         var _loc2_:PlayersPanelListItem = null;
         if(param1)
         {
            for each(_loc2_ in this._panelListItems)
            {
               _loc2_.addEventListener(PlayersPanelItemEvent.ON_ITEM_OVER,this.onPlayersPanelOnItemOverHandler);
               _loc2_.addEventListener(PlayersPanelItemEvent.ON_ITEM_OUT,this.onPlayersPanelOnItemOutHandler);
               _loc2_.addEventListener(PlayersPanelItemEvent.ON_ITEM_CLICK,this.onPlayersPanelOnItemClickHandler);
            }
         }
         else
         {
            for each(_loc2_ in this._panelListItems)
            {
               _loc2_.removeEventListener(PlayersPanelItemEvent.ON_ITEM_OVER,this.onPlayersPanelOnItemOverHandler);
               _loc2_.removeEventListener(PlayersPanelItemEvent.ON_ITEM_OUT,this.onPlayersPanelOnItemOutHandler);
               _loc2_.removeEventListener(PlayersPanelItemEvent.ON_ITEM_CLICK,this.onPlayersPanelOnItemClickHandler);
            }
         }
      }
      
      private function setListRenderersState(param1:int) : void
      {
         var _loc2_:PlayersPanelListItem = null;
         this.evaluateRendererStates(param1);
         for each(_loc2_ in this._panelListItems)
         {
            _loc2_.setState(this._rendererStates[_loc2_.columnNumber]);
         }
      }
      
      private function evaluateRendererStates(param1:int) : void
      {
         var _loc2_:int = this._rendererStates.length;
         var _loc3_:int = 0;
         if(param1 <= PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_TANK)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               this._rendererStates[_loc3_] = PlayersPanelListItemState.transformToSingleColumnListItemState(param1,_loc3_);
               _loc3_++;
            }
         }
         else
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               this._rendererStates[_loc3_] = PlayersPanelListItemState.transformToMultiColumnListItemState(param1,_loc3_);
               _loc3_++;
            }
         }
         var _loc4_:int = this._spawnGroupIcons.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            this._spawnGroupIcons[_loc5_].setSize(this._rendererStates[_loc5_]);
            _loc5_++;
         }
      }
      
      public function get state() : int
      {
         return this._state;
      }
      
      public function set state(param1:int) : void
      {
         if(this._state == param1)
         {
            return;
         }
         if(param1 == PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_SHORT_SECOND_FOCUS || param1 == PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_TANK_SECOND_FOCUS || param1 == PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_PLAYER_SECOND_FOCUS || param1 == PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_SHORT_THIRD_FOCUS || param1 == PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_TANK_THIRD_FOCUS || param1 == PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_PLAYER_THIRD_FOCUS)
         {
            this.selfBg.width = SELF_BG_SHORT_WIDTH;
         }
         else
         {
            this.selfBg.width = SELF_BG_LONG_WIDTH;
         }
         this.setListBackgroundState(param1);
         this.setListRenderersState(param1);
         this._state = param1;
         this.updateInviteIndicator();
      }
      
      public function get selectedPlayerGroup() : int
      {
         return this._playerGroupID;
      }
      
      public function set selectedPlayerGroup(param1:int) : void
      {
         if(this._playerGroupID == param1)
         {
            return;
         }
         this._playerGroupID = param1;
         this.setGroupIcons();
      }
      
      protected function get itemLinkage() : String
      {
         throw new AbstractException(Errors.ABSTRACT_INVOKE);
      }
      
      protected function get isRightAligned() : Boolean
      {
         throw new AbstractException(Errors.ABSTRACT_INVOKE);
      }
      
      private function onHitMouseOverHandler(param1:MouseEvent) : void
      {
         if(this._toolTipString)
         {
            this._tooltipMgr.show(this._toolTipString);
         }
      }
      
      private function onHitMouseOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
      
      private function onThirdSpawnGroupClickHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new PlayersPanelListEvent(PlayersPanelListEvent.ITEM_SELECTED,-1,THIRD_COLUMN));
      }
      
      private function onSecondSpawnGroupClickHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new PlayersPanelListEvent(PlayersPanelListEvent.ITEM_SELECTED,-1,SECOND_COLUMN));
      }
      
      private function onFirstSpawnGroupClickHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new PlayersPanelListEvent(PlayersPanelListEvent.ITEM_SELECTED,-1,FIRST_COLUMN));
      }
      
      private function onThirdSpawnGroupMouseOverHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new PlayersPanelListEvent(PlayersPanelListEvent.ITEMS_GROUP_MOUSE_OVER_CHANGED,-1,THIRD_COLUMN));
      }
      
      private function onSecondSpawnGroupMouseOverHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new PlayersPanelListEvent(PlayersPanelListEvent.ITEMS_GROUP_MOUSE_OVER_CHANGED,-1,SECOND_COLUMN));
      }
      
      private function onFirstSpawnGroupMouseOverHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new PlayersPanelListEvent(PlayersPanelListEvent.ITEMS_GROUP_MOUSE_OVER_CHANGED,-1,FIRST_COLUMN));
      }
      
      private function onPlayersPanelOnItemOverHandler(param1:PlayersPanelItemEvent) : void
      {
         var _loc2_:IPlayersPanelListItemHolder = this._items[param1.holderItemID];
         this._itemUnderMouse = param1.playersListItem;
         MinimapEntryController.instance.highlight(_loc2_.vehicleID);
         if(this._state > PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_HIDDEN)
         {
            dispatchEvent(new PlayersPanelListEvent(PlayersPanelListEvent.ITEMS_GROUP_MOUSE_OVER_CHANGED,_loc2_.vehicleID,this._itemUnderMouse.columnNumber));
         }
         if(this._itemUnderMouse.dogTag)
         {
            addChild(this._dogTag);
            this._dogTag.setDogTagInfo(this._itemUnderMouse.dogTag);
            this._dogTag.x = this._itemUnderMouse.x - this._dogTag.width - DOG_TAG_OFFSET_X;
            this._dogTag.y = this._itemUnderMouse.y;
            this._dogTag.fadeIn();
         }
      }
      
      private function onPlayersPanelOnItemOutHandler(param1:PlayersPanelItemEvent) : void
      {
         this._itemUnderMouse = null;
         MinimapEntryController.instance.unhighlight();
         if(this._dogTag)
         {
            this._dogTag.fadeOut(this.removeDogTag);
         }
      }
      
      private function removeDogTag() : void
      {
         removeChild(this._dogTag);
      }
      
      private function onPlayersPanelOnItemClickHandler(param1:PlayersPanelItemEvent) : void
      {
         var _loc2_:PlayersPanelListItemHolder = this._items[param1.holderItemID] as PlayersPanelListItemHolder;
         if(_loc2_)
         {
            if(App.utils.commons.isRightButton(param1.mEvent))
            {
               if(!PlayerStatus.isActionDisabled(_loc2_.playerStatus) && !_loc2_.isCurrentPlayer)
               {
                  param1.playersListItem.dynamicSquad.onItemOut();
                  dispatchEvent(new PlayersPanelListEvent(PlayersPanelListEvent.ITEM_CONTEXT_MENU_OPEN,_loc2_.vehicleID,_loc2_.listItem.columnNumber));
                  MinimapEntryController.instance.unhighlight();
                  App.toolTipMgr.hide();
               }
            }
            else
            {
               dispatchEvent(new PlayersPanelListEvent(PlayersPanelListEvent.ITEM_SELECTED,_loc2_.vehicleID,_loc2_.listItem.columnNumber));
            }
         }
      }
      
      public function get isInviteReceived() : Boolean
      {
         return this._isInviteReceived;
      }
      
      public function setChatCommandVisibility(param1:Boolean) : void
      {
         var _loc2_:PlayersPanelListItem = null;
         if(this._panelListItems)
         {
            for each(_loc2_ in this._panelListItems)
            {
               _loc2_.setChatCommandVisibility(param1);
            }
         }
      }
      
      public function setPanelHPBarVisibilityState(param1:uint) : void
      {
         var _loc2_:PlayersPanelListItem = null;
         if(this._HPBarVisibilityState == param1)
         {
            return;
         }
         this._HPBarVisibilityState = param1;
         if(this._panelListItems)
         {
            for each(_loc2_ in this._panelListItems)
            {
               _loc2_.setPanelHPBarVisibilityState(param1);
            }
         }
      }
      
      public function setPlayerHP(param1:int, param2:int) : void
      {
         var _loc3_:PlayersPanelListItemHolder = this.getHolderByVehicleID(param1);
         if(_loc3_)
         {
            _loc3_.setPlayerHP(param2);
            this._itemsHealth[param1] = param2;
         }
         else
         {
            this._itemsHealth[param1] = param2;
         }
      }
      
      public function setOverrideExInfo(param1:Boolean) : void
      {
         var _loc2_:IPlayersPanelListItemHolder = null;
         for each(_loc2_ in this._items)
         {
            _loc2_.setOverrideExInfo(param1);
         }
      }
   }
}
