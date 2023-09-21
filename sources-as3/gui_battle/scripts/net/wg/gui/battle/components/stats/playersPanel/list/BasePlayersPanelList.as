package net.wg.gui.battle.components.stats.playersPanel.list
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.components.events.PlayersPanelListEvent;
   import net.wg.gui.battle.components.stats.playersPanel.events.PlayersPanelItemEvent;
   import net.wg.gui.battle.components.stats.playersPanel.interfaces.IPlayersPanelListItem;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.interfaces.IPlayersPanelList;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.interfaces.IPlayersPanelListItemHolder;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.list.PlayersPanelDynamicSquad;
   import net.wg.gui.battle.views.minimap.MinimapEntryController;
   import net.wg.gui.components.dogtag.DogtagComponent;
   import net.wg.gui.components.dogtag.VO.DogTagVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.IClassFactory;
   import net.wg.utils.ICommons;
   import net.wg.utils.ILocale;
   
   public class BasePlayersPanelList extends Sprite implements IPlayersPanelList
   {
      
      private static const DOG_TAG_OFFSET_X:int = 30;
      
      private static const ITEM_HEIGHT:int = 25;
       
      
      protected var panelListItems:Vector.<IPlayersPanelListItem>;
      
      protected var renderersContainer:Sprite;
      
      private var _state:int;
      
      private var _items:Vector.<IPlayersPanelListItemHolder>;
      
      private var _itemsHealth:Dictionary;
      
      private var _currOrder:Vector.<Number>;
      
      private var _holderItemUnderMouseID:int = -1;
      
      private var _isVehicleLevelVisible:Boolean = true;
      
      private var _isCursorVisible:Boolean = false;
      
      private var _mapHolderByVehicleID:Dictionary;
      
      private var _currentPlayerIsAnonymized:Boolean = false;
      
      private var _toolTipString:String = null;
      
      private var _dogTag:DogtagComponent;
      
      private var _isChatCommVisible:Boolean = true;
      
      private var _commons:ICommons;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _locale:ILocale;
      
      private var _classFactory:IClassFactory;
      
      private var _HPBarVisibilityState:uint = 0;
      
      private var _overrideExInfoValue:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      public function BasePlayersPanelList()
      {
         this.panelListItems = new Vector.<IPlayersPanelListItem>();
         this.renderersContainer = new Sprite();
         this._items = new Vector.<IPlayersPanelListItemHolder>();
         this._itemsHealth = new Dictionary();
         this._currOrder = new Vector.<Number>();
         this._mapHolderByVehicleID = new Dictionary();
         this._commons = App.utils.commons;
         this._tooltipMgr = App.toolTipMgr;
         this._locale = App.utils.locale;
         this._classFactory = App.utils.classFactory;
         super();
         addChild(this.renderersContainer);
         this.initDogTag();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.onDispose();
      }
      
      public function getItemHolderClass() : Class
      {
         throw new AbstractException(Errors.ABSTRACT_INVOKE);
      }
      
      public function getRenderersVisibleWidth() : uint
      {
         var _loc1_:Rectangle = this.renderersContainer.getBounds(this);
         return _loc1_.x + _loc1_.width;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function removeAllItems() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:IPlayersPanelListItem = null;
         if(this._mapHolderByVehicleID)
         {
            App.utils.data.cleanupDynamicObject(this._mapHolderByVehicleID);
         }
         if(this._items)
         {
            _loc1_ = this._items.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               this._items[_loc2_].dispose();
               _loc2_++;
            }
            this._items.splice(0,_loc1_);
         }
         if(this._currOrder)
         {
            this._currOrder.splice(0,this._currOrder.length);
         }
         if(this.panelListItems)
         {
            for each(_loc3_ in this.panelListItems)
            {
               _loc3_.removeEventListener(MouseEvent.MOUSE_OVER,this.onHitMouseOverHandler);
               _loc3_.removeEventListener(MouseEvent.MOUSE_OUT,this.onHitMouseOutHandler);
               _loc3_.removeEventListener(MouseEvent.MOUSE_OVER,this.onHitDogTagMouseOverHandler);
               _loc3_.removeEventListener(MouseEvent.MOUSE_OUT,this.onHitDogTagMouseOutHandler);
               _loc3_.dispose();
            }
            this.panelListItems.splice(0,this.panelListItems.length);
         }
         if(this.renderersContainer != null)
         {
            _loc1_ = this.renderersContainer.numChildren;
            while(--_loc1_ >= 0)
            {
               this.renderersContainer.removeChildAt(0);
            }
         }
         this._toolTipString = null;
      }
      
      public function resetFrags() : void
      {
         if(this.panelListItems == null)
         {
            return;
         }
         var _loc1_:int = this.panelListItems.length;
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_)
         {
            this.panelListItems[_loc2_].setFrags(0);
            _loc2_++;
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
      
      public function setChatCommandVisibility(param1:Boolean) : void
      {
         var _loc2_:IPlayersPanelListItem = null;
         if(param1 == this._isChatCommVisible)
         {
            return;
         }
         this._isChatCommVisible = param1;
         for each(_loc2_ in this.panelListItems)
         {
            _loc2_.setChatCommandVisibility(param1);
         }
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
         if(this._holderItemUnderMouseID != Values.DEFAULT_INT)
         {
            if(this._isCursorVisible)
            {
               _loc2_ = this._items[this._holderItemUnderMouseID];
               MinimapEntryController.instance.highlight(_loc2_.vehicleID);
            }
            else
            {
               this._holderItemUnderMouseID = Values.DEFAULT_INT;
               MinimapEntryController.instance.unhighlight();
            }
         }
      }
      
      public function setIsInteractive(param1:Boolean) : void
      {
      }
      
      public function setIsInviteShown(param1:Boolean) : void
      {
      }
      
      public function setOverrideExInfo(param1:Boolean) : void
      {
         var _loc2_:IPlayersPanelListItemHolder = null;
         this._overrideExInfoValue = param1;
         for each(_loc2_ in this._items)
         {
            _loc2_.setOverrideExInfo(param1);
         }
      }
      
      public function setPanelHPBarVisibilityState(param1:uint) : void
      {
         var _loc2_:IPlayersPanelListItem = null;
         if(param1 == this._HPBarVisibilityState)
         {
            return;
         }
         this._HPBarVisibilityState = param1;
         for each(_loc2_ in this.panelListItems)
         {
            _loc2_.setPanelHPBarVisibilityState(param1);
         }
      }
      
      public function setPlayerHP(param1:int, param2:int) : void
      {
         var _loc3_:IPlayersPanelListItemHolder = this.getHolderByVehicleID(param1);
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
      
      public function setPlayerStatus(param1:Number, param2:uint) : void
      {
         var _loc3_:IPlayersPanelListItemHolder = this.getHolderByVehicleID(param1);
         if(_loc3_)
         {
            _loc3_.setPlayerStatus(param2);
         }
      }
      
      public function setShowDogTag(param1:Boolean) : void
      {
      }
      
      public function setSpeaking(param1:Number, param2:Boolean) : void
      {
         var _loc3_:IPlayersPanelListItem = this.getItemByAccountID(param1);
         if(_loc3_)
         {
            _loc3_.setIsSpeaking(param2);
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
         var _loc2_:DAAPIVehicleInfoVO = null;
         var _loc3_:IPlayersPanelListItemHolder = null;
         for each(_loc2_ in param1)
         {
            _loc3_ = this.getHolderByVehicleID(_loc2_.vehicleID);
            if(_loc3_)
            {
               _loc3_.setVehicleData(_loc2_);
            }
            else
            {
               this.addItem(_loc2_);
            }
         }
         if(this._currentPlayerIsAnonymized && _loc2_)
         {
            this.setSquadTooltipInfo(_loc2_.clanAbbrev != Values.EMPTY_STR);
         }
         this.updatePlayerNameWidth();
         this.updateVehicleData();
         dispatchEvent(new PlayersPanelListEvent(PlayersPanelListEvent.ITEMS_COUNT_CHANGE,0));
         this.setMouseListenersEnabled(this._isCursorVisible);
      }
      
      public function setVehicleLevelVisible(param1:Boolean) : void
      {
         var _loc2_:IPlayersPanelListItem = null;
         if(this._isVehicleLevelVisible == param1)
         {
            return;
         }
         this._isVehicleLevelVisible = param1;
         for each(_loc2_ in this.panelListItems)
         {
            _loc2_.setVehicleLevelVisible(param1);
         }
      }
      
      public function setVehicleStatus(param1:Number, param2:uint) : void
      {
         var _loc3_:IPlayersPanelListItemHolder = this.getHolderByVehicleID(param1);
         if(_loc3_)
         {
            _loc3_.setVehicleStatus(param2);
         }
      }
      
      public function showDogTag(param1:Number, param2:DogTagVO) : void
      {
         var _loc4_:IPlayersPanelListItem = null;
         var _loc3_:IPlayersPanelListItemHolder = this.getHolderByVehicleID(param1);
         if(_loc3_)
         {
            _loc4_ = _loc3_.getListItem();
            _loc4_.showDogTag();
            _loc4_.addEventListener(MouseEvent.MOUSE_OVER,this.onHitDogTagMouseOverHandler);
            _loc4_.addEventListener(MouseEvent.MOUSE_OUT,this.onHitDogTagMouseOutHandler);
            _loc3_.setDogTag(param2);
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
      
      public function updateColorBlind() : void
      {
         var _loc1_:IPlayersPanelListItem = null;
         for each(_loc1_ in this.panelListItems)
         {
            _loc1_.updateColorBlind();
         }
      }
      
      public function updateOrder(param1:Vector.<Number>) : void
      {
         var _loc4_:IPlayersPanelListItem = null;
         if(!param1 || !this.checkIfOrderIsValid(param1))
         {
            return;
         }
         var _loc2_:int = this._items.length;
         var _loc3_:Number = 0;
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = param1[_loc5_];
            if(this._currOrder[_loc5_] != _loc3_)
            {
               _loc4_ = this.getItemByVehicleID(_loc3_);
               if(_loc4_)
               {
                  _loc4_.y = this.itemHeight * _loc5_;
                  this._currOrder[_loc5_] = _loc3_;
               }
            }
            _loc5_++;
         }
      }
      
      protected function updateVehicleData() : void
      {
      }
      
      protected function onDispose() : void
      {
         this.setMouseListenersEnabled(false);
         this._holderItemUnderMouseID = Values.DEFAULT_INT;
         this.removeAllItems();
         this._mapHolderByVehicleID = null;
         if(this._itemsHealth)
         {
            App.utils.data.cleanupDynamicObject(this._itemsHealth);
         }
         this._itemsHealth = null;
         this._items = null;
         this._currOrder = null;
         this.panelListItems = null;
         this.renderersContainer = null;
         this._toolTipString = null;
         this._currentPlayerIsAnonymized = false;
         if(this._dogTag)
         {
            this._dogTag.dispose();
            this._dogTag = null;
         }
         this._commons = null;
         this._tooltipMgr = null;
         this._locale = null;
         this._classFactory = null;
      }
      
      protected function initializeListItem(param1:IPlayersPanelListItem) : void
      {
      }
      
      protected function initializeState() : void
      {
      }
      
      protected function getHolderByVehicleID(param1:Number) : IPlayersPanelListItemHolder
      {
         return this._mapHolderByVehicleID[param1];
      }
      
      protected function getItemHolderByIndex(param1:uint) : IPlayersPanelListItemHolder
      {
         return this._items.length > param1 ? this._items[param1] : null;
      }
      
      protected function checkInviteReceived() : Boolean
      {
         var _loc2_:IPlayersPanelListItemHolder = null;
         var _loc1_:Boolean = false;
         for each(_loc2_ in this._items)
         {
            if(_loc2_.isInviteReceived)
            {
               _loc1_ = true;
               break;
            }
         }
         return _loc1_;
      }
      
      protected function get itemHeight() : int
      {
         return ITEM_HEIGHT;
      }
      
      private function initDogTag() : void
      {
         this._dogTag = App.utils.classFactory.getComponent(Linkages.DOGTAG,DogtagComponent);
         this._dogTag.hideNameAndClan();
         this._dogTag.x = -this._dogTag.width - DOG_TAG_OFFSET_X;
         this._dogTag.goToLabel(DogtagComponent.DOGTAG_LABEL_END_FULL);
         this._dogTag.alpha = 0;
      }
      
      private function addItem(param1:DAAPIVehicleInfoVO) : void
      {
         var _loc2_:IPlayersPanelListItem = this._classFactory.getComponent(this.itemLinkage,IPlayersPanelListItem);
         var _loc3_:int = this._items.length;
         this.initializeListItem(_loc2_);
         _loc2_.setVehicleLevelVisible(this._isVehicleLevelVisible);
         _loc2_.setState(this._state);
         _loc2_.y = _loc3_ * this.itemHeight;
         _loc2_.setIsRightAligned(this.isRightAligned);
         _loc2_.holderItemID = _loc3_;
         _loc2_.setChatCommandVisibility(this._isChatCommVisible);
         _loc2_.setPanelHPBarVisibilityState(this._HPBarVisibilityState);
         if(this._overrideExInfoValue)
         {
            _loc2_.setOverrideExInfo(this._overrideExInfoValue);
         }
         this.renderersContainer.addChild(DisplayObject(_loc2_));
         this.panelListItems.push(_loc2_);
         var _loc4_:Class = this.getItemHolderClass();
         var _loc5_:IPlayersPanelListItemHolder = new _loc4_(_loc2_);
         _loc5_.setVehicleData(param1);
         var _loc6_:Number = param1.vehicleID;
         this._mapHolderByVehicleID[_loc6_] = _loc5_;
         this._items.push(_loc5_);
         this._currOrder.push(_loc6_);
         if(this._itemsHealth[_loc6_] !== undefined)
         {
            _loc5_.setPlayerHP(this._itemsHealth[_loc6_]);
         }
         if(!this._toolTipString && _loc5_.isCurrentPlayer && param1.isAnonymized)
         {
            _loc2_.addEventListener(MouseEvent.MOUSE_OVER,this.onHitMouseOverHandler);
            _loc2_.addEventListener(MouseEvent.MOUSE_OUT,this.onHitMouseOutHandler);
            this.makeTooltipString(param1.playerFakeName,param1.clanAbbrev != Values.EMPTY_STR);
            this._currentPlayerIsAnonymized = true;
         }
      }
      
      private function makeTooltipString(param1:String, param2:Boolean) : void
      {
         this._toolTipString = !!param2 ? this._locale.makeString(TOOLTIPS.ANONYMIZER_BATTLE_TEAMLIST_CLAN,{"fakeName":param1}) : this._locale.makeString(TOOLTIPS.ANONYMIZER_BATTLE_TEAMLIST_NOCLAN,{"fakeName":param1});
      }
      
      private function setDogTagVisibleOff() : void
      {
         removeChild(this._dogTag);
      }
      
      private function setMouseListenersEnabled(param1:Boolean) : void
      {
         var _loc2_:IPlayersPanelListItem = null;
         if(param1)
         {
            for each(_loc2_ in this.panelListItems)
            {
               _loc2_.addEventListener(PlayersPanelItemEvent.ON_ITEM_OVER,this.onPlayersListItemOnItemOverHandler);
               _loc2_.addEventListener(PlayersPanelItemEvent.ON_ITEM_OUT,this.onPlayersListItemOnItemOutHandler);
               _loc2_.addEventListener(PlayersPanelItemEvent.ON_ITEM_CLICK,this.onPlayersListItemOnItemClickHandler);
            }
         }
         else
         {
            for each(_loc2_ in this.panelListItems)
            {
               _loc2_.removeEventListener(PlayersPanelItemEvent.ON_ITEM_OVER,this.onPlayersListItemOnItemOverHandler);
               _loc2_.removeEventListener(PlayersPanelItemEvent.ON_ITEM_OUT,this.onPlayersListItemOnItemOutHandler);
               _loc2_.removeEventListener(PlayersPanelItemEvent.ON_ITEM_CLICK,this.onPlayersListItemOnItemClickHandler);
            }
         }
      }
      
      private function updatePlayerNameWidth() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = this.panelListItems.length;
         if(!_loc1_)
         {
            return;
         }
         var _loc2_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = Math.max(_loc2_,this.panelListItems[_loc3_].getPlayerNameFullWidth());
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            this.panelListItems[_loc3_].setPlayerNameFullWidth(_loc2_);
            _loc3_++;
         }
      }
      
      private function getItemByVehicleID(param1:Number) : IPlayersPanelListItem
      {
         var _loc2_:int = this._items.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(this._items[_loc3_].vehicleID == param1)
            {
               return this.panelListItems[_loc3_];
            }
            _loc3_++;
         }
         return null;
      }
      
      private function getItemByAccountID(param1:Number) : IPlayersPanelListItem
      {
         var _loc2_:int = this._items.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(this._items[_loc3_].accountDBID == param1)
            {
               return this.panelListItems[_loc3_];
            }
            _loc3_++;
         }
         return null;
      }
      
      private function checkIfOrderIsValid(param1:Vector.<Number>) : Boolean
      {
         var _loc2_:int = param1.length;
         if(_loc2_ != this._currOrder.length)
         {
            return false;
         }
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(this._currOrder.indexOf(param1[_loc3_]) == Values.DEFAULT_INT)
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      private function setSquadTooltipInfo(param1:Boolean) : void
      {
         var _loc2_:IPlayersPanelListItem = null;
         var _loc3_:PlayersPanelDynamicSquad = null;
         for each(_loc2_ in this.panelListItems)
         {
            _loc3_ = _loc2_.getDynamicSquad();
            if(_loc3_)
            {
               _loc3_.setCurrentPlayerAnonymized();
               _loc3_.setIsCurrentPlayerInClan(param1);
            }
         }
      }
      
      public function get state() : int
      {
         return this._state;
      }
      
      public function set state(param1:int) : void
      {
         var _loc2_:IPlayersPanelListItem = null;
         if(this._state == param1)
         {
            return;
         }
         for each(_loc2_ in this.panelListItems)
         {
            _loc2_.setState(param1);
         }
         this._state = param1;
         this.initializeState();
      }
      
      public function get isInviteReceived() : Boolean
      {
         return false;
      }
      
      protected function get itemLinkage() : String
      {
         throw new AbstractException(Errors.ABSTRACT_INVOKE);
      }
      
      protected function get items() : Vector.<IPlayersPanelListItemHolder>
      {
         return this._items;
      }
      
      protected function get isRightAligned() : Boolean
      {
         throw new AbstractException(Errors.ABSTRACT_INVOKE);
      }
      
      protected function onPlayersListItemRightClick(param1:PlayersPanelItemEvent) : void
      {
      }
      
      private function onHitMouseOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.show(this._toolTipString);
      }
      
      private function onHitMouseOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
      
      private function onHitDogTagMouseOverHandler(param1:MouseEvent) : void
      {
         var _loc3_:IPlayersPanelListItemHolder = null;
         var _loc4_:DogTagVO = null;
         var _loc2_:IPlayersPanelListItem = param1.currentTarget as IPlayersPanelListItem;
         if(_loc2_)
         {
            _loc3_ = this._items[_loc2_.holderItemID];
            _loc4_ = _loc3_.getDogTag();
            addChild(this._dogTag);
            this._dogTag.setDogTagInfo(_loc4_);
            this._dogTag.y = _loc2_.y;
         }
         this._dogTag.fadeIn();
      }
      
      private function onHitDogTagMouseOutHandler(param1:MouseEvent) : void
      {
         if(this._dogTag)
         {
            this._dogTag.fadeOut(this.setDogTagVisibleOff);
         }
      }
      
      private function onPlayersListItemOnItemOverHandler(param1:PlayersPanelItemEvent) : void
      {
         this._holderItemUnderMouseID = param1.holderItemID;
         var _loc2_:IPlayersPanelListItemHolder = this._items[this._holderItemUnderMouseID];
         MinimapEntryController.instance.highlight(_loc2_.vehicleID);
      }
      
      private function onPlayersListItemOnItemOutHandler(param1:PlayersPanelItemEvent) : void
      {
         this._holderItemUnderMouseID = Values.DEFAULT_INT;
         MinimapEntryController.instance.unhighlight();
      }
      
      private function onPlayersListItemOnItemClickHandler(param1:PlayersPanelItemEvent) : void
      {
         var _loc2_:IPlayersPanelListItemHolder = this._items[param1.holderItemID];
         if(this._commons.isRightButton(param1.mEvent) && !_loc2_.isCurrentPlayer)
         {
            this.onPlayersListItemRightClick(param1);
         }
         else
         {
            dispatchEvent(new PlayersPanelListEvent(PlayersPanelListEvent.ITEM_SELECTED,_loc2_.vehicleID));
         }
      }
   }
}
