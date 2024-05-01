package net.wg.gui.lobby.window
{
   import flash.display.Graphics;
   import flash.display.MovieClip;
   import net.wg.data.Aliases;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.windows.Window;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.profile.ProfileConstants;
   import net.wg.gui.lobby.profile.ProfileTabNavigator;
   import net.wg.infrastructure.base.meta.IProfileWindowMeta;
   import net.wg.infrastructure.base.meta.impl.ProfileWindowMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class ProfileWindow extends ProfileWindowMeta implements IProfileWindowMeta
   {
      
      private static const INIT_DATA_INV:String = "initDataInv";
      
      private static const ADD_FRIEND_AVAILABLE:String = "addAvailableChanged";
      
      private static const ADD_TO_CLAN_AVAILABLE:String = "addToClanAvailableChanged";
      
      private static const ADD_TO_CLAN_VISIBLE:String = "addToClanVisibleChanged";
      
      private static const SET_IGNORED_AVAILABLE:String = "setIgnoreChanged";
      
      private static const CREATE_PRIVATE_CHANNEL_AVAILABLE:String = "createChannelChanged";
      
      private static const WINDOW_WIDTH:int = 1000;
      
      private static const WINDOW_HEIGHT:int = 585;
      
      private static const WINDOW_CONTENT_OFFSET:int = 30;
      
      private static const BTN_GAP:int = 5;
       
      
      public var tabNavigator:ProfileTabNavigator = null;
      
      public var btnAddToFriends:SoundButtonEx = null;
      
      public var btnAddToClan:SoundButtonEx = null;
      
      public var btnAddToIgnore:SoundButtonEx = null;
      
      public var btnCreatePrivateChannel:SoundButtonEx = null;
      
      private var _maskObj:MovieClip;
      
      private var _initData:ProfileWindowInitVO = null;
      
      private var _isAddFriendAvailable:Boolean = false;
      
      private var _isAddToClanAvailable:Boolean = false;
      
      private var _isAddToClanVisible:Boolean = false;
      
      private var _isSetIgnoreAvailable:Boolean = false;
      
      private var _isCreateChannelAvailable:Boolean = false;
      
      private var _buttonsOrder:Vector.<ISoundButtonEx> = null;
      
      public function ProfileWindow()
      {
         this._maskObj = new MovieClip();
         super();
         showWindowBgForm = false;
         addChild(this._maskObj);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.tabNavigator.centerOffset = ProfileConstants.WINDOW_CENTER_OFFSET;
         this.btnAddToFriends.label = MESSENGER.DIALOGS_CONTACTS_CONTACT_ADDTOFRIENDS;
         this.btnAddToClan.label = MESSENGER.DIALOGS_CONTACTS_CONTACT_ADDTOCLAN;
         this.btnAddToIgnore.label = MESSENGER.DIALOGS_CONTACTS_CONTACT_ADDTOIGNORED;
         this.btnCreatePrivateChannel.label = MESSENGER.DIALOGS_CONTACTS_CONTACT_CREATEPRIVATECHANNEL;
         this.btnAddToFriends.addEventListener(ButtonEvent.CLICK,this.onBtnAddToFriendsClickHandler,false,0,true);
         this.btnAddToClan.addEventListener(ButtonEvent.CLICK,this.onBtnAddToClanClickHandler,false,0,true);
         this.btnAddToIgnore.addEventListener(ButtonEvent.CLICK,this.onBtnAddToIgnoreClickHandler,false,0,true);
         this.btnCreatePrivateChannel.addEventListener(ButtonEvent.CLICK,this.onBtnCreatePrivateChannelClickHandler,false,0,true);
         this._buttonsOrder = new <ISoundButtonEx>[this.btnAddToFriends,this.btnAddToClan,this.btnAddToIgnore,this.btnCreatePrivateChannel];
         this.tabNavigator.isWindowed = true;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Graphics = null;
         var _loc2_:Number = NaN;
         super.draw();
         if(window && this._initData && isInvalid(INIT_DATA_INV))
         {
            Window(window).title = this._initData.fullName;
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = this._maskObj.graphics;
            _loc1_.clear();
            _loc1_.beginFill(0);
            _loc2_ = WINDOW_HEIGHT + WINDOW_CONTENT_OFFSET;
            _loc1_.drawRect(0,0,WINDOW_WIDTH,_loc2_);
            _loc1_.endFill();
            if(!this.mask)
            {
               this.tabNavigator.mask = this._maskObj;
            }
            this.tabNavigator.setAvailableSize(WINDOW_WIDTH,_loc2_);
         }
         if(isInvalid(ADD_FRIEND_AVAILABLE))
         {
            this.btnAddToFriends.enabled = this._isAddFriendAvailable;
         }
         if(isInvalid(ADD_TO_CLAN_AVAILABLE))
         {
            this.btnAddToClan.enabled = this._isAddToClanAvailable;
         }
         if(isInvalid(SET_IGNORED_AVAILABLE))
         {
            this.btnAddToIgnore.enabled = this._isSetIgnoreAvailable;
         }
         if(isInvalid(CREATE_PRIVATE_CHANNEL_AVAILABLE))
         {
            this.btnCreatePrivateChannel.enabled = this._isCreateChannelAvailable;
         }
         if(isInvalid(ADD_TO_CLAN_VISIBLE))
         {
            this.btnAddToClan.visible = this._isAddToClanVisible;
            this.layoutBottomButtons();
         }
      }
      
      override protected function onDispose() : void
      {
         this.tabNavigator.mask = null;
         this._maskObj = null;
         this._initData = null;
         this.tabNavigator = null;
         this.btnAddToFriends.removeEventListener(ButtonEvent.CLICK,this.onBtnAddToFriendsClickHandler);
         this.btnAddToClan.removeEventListener(ButtonEvent.CLICK,this.onBtnAddToClanClickHandler);
         this.btnAddToIgnore.removeEventListener(ButtonEvent.CLICK,this.onBtnAddToIgnoreClickHandler);
         this.btnCreatePrivateChannel.removeEventListener(ButtonEvent.CLICK,this.onBtnCreatePrivateChannelClickHandler);
         this.btnAddToFriends.dispose();
         this.btnAddToFriends = null;
         this.btnAddToClan.dispose();
         this.btnAddToClan = null;
         this.btnAddToIgnore.dispose();
         this.btnAddToIgnore = null;
         this.btnCreatePrivateChannel.dispose();
         this.btnCreatePrivateChannel = null;
         this._buttonsOrder.splice(0,this._buttonsOrder.length);
         this._buttonsOrder = null;
         super.onDispose();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         registerFlashComponentS(this.tabNavigator,Aliases.PROFILE_TAB_NAVIGATOR);
      }
      
      public function as_addFriendAvailable(param1:Boolean) : void
      {
         this._isAddFriendAvailable = param1;
         invalidate(ADD_FRIEND_AVAILABLE);
      }
      
      public function as_addToClanAvailable(param1:Boolean) : void
      {
         this._isAddToClanAvailable = param1;
         invalidate(ADD_TO_CLAN_AVAILABLE);
      }
      
      public function as_addToClanVisible(param1:Boolean) : void
      {
         this._isAddToClanVisible = param1;
         invalidate(ADD_TO_CLAN_VISIBLE);
      }
      
      public function as_setCreateChannelAvailable(param1:Boolean) : void
      {
         this._isCreateChannelAvailable = param1;
         invalidate(CREATE_PRIVATE_CHANNEL_AVAILABLE);
      }
      
      public function as_setIgnoredAvailable(param1:Boolean) : void
      {
         this._isSetIgnoreAvailable = param1;
         invalidate(SET_IGNORED_AVAILABLE);
      }
      
      override protected function setInitData(param1:ProfileWindowInitVO) : void
      {
         this._initData = param1;
         invalidate(INIT_DATA_INV);
      }
      
      private function layoutBottomButtons() : void
      {
         var _loc2_:ISoundButtonEx = null;
         var _loc1_:int = 0;
         for each(_loc2_ in this._buttonsOrder)
         {
            if(_loc2_.visible)
            {
               _loc2_.x = _loc1_;
               _loc1_ += _loc2_.width + BTN_GAP;
            }
         }
      }
      
      private function onBtnAddToClanClickHandler(param1:ButtonEvent) : void
      {
         this.userAddToClanS();
      }
      
      private function onBtnCreatePrivateChannelClickHandler(param1:ButtonEvent) : void
      {
         this.userCreatePrivateChannelS();
      }
      
      private function onBtnAddToIgnoreClickHandler(param1:ButtonEvent) : void
      {
         this.userSetIgnoredS();
      }
      
      private function onBtnAddToFriendsClickHandler(param1:ButtonEvent) : void
      {
         this.userAddFriendS();
      }
   }
}
