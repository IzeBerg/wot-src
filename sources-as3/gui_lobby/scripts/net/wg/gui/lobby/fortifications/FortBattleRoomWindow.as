package net.wg.gui.lobby.fortifications
{
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
   import net.wg.gui.components.common.waiting.WaitingComponent;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.windows.Window;
   import net.wg.gui.cyberSport.interfaces.IChannelComponentHolder;
   import net.wg.gui.lobby.fortifications.battleRoom.clanBattle.FortClanBattleRoom;
   import net.wg.gui.lobby.fortifications.cmp.drctn.impl.ConnectedDirects;
   import net.wg.gui.lobby.stronghold.StrongholdListView;
   import net.wg.gui.rally.events.RallyViewsEvent;
   import net.wg.infrastructure.base.meta.IAbstractRallyViewMeta;
   import net.wg.infrastructure.base.meta.IFortBattleRoomWindowMeta;
   import net.wg.infrastructure.base.meta.impl.FortBattleRoomWindowMeta;
   import net.wg.infrastructure.events.FocusChainChangeEvent;
   import net.wg.infrastructure.interfaces.IFocusChainContainer;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   
   public class FortBattleRoomWindow extends FortBattleRoomWindowMeta implements IFortBattleRoomWindowMeta, IFocusChainContainer
   {
      
      private static const FOCUS_CHAIN:String = "focusChain";
      
      private static const PREBATTLE_WINDOW_WIDTH:int = 1013;
      
      private static const PREBATTLE_WINDOW_HEIGHT:int = 653;
       
      
      public var info:TextField = null;
      
      public var btnRefresh:SoundButtonEx = null;
      
      public var backgroundMc:MovieClip = null;
      
      public var waitingCmp:WaitingComponent = null;
      
      private var _focusChain:Vector.<InteractiveObject>;
      
      public function FortBattleRoomWindow()
      {
         this._focusChain = new Vector.<InteractiveObject>();
         super();
         _deferredDispose = true;
         isSourceTracked = true;
         showWindowBgForm = true;
         canMinimize = true;
      }
      
      public function as_setWindowTitle(param1:String) : void
      {
         window.title = param1;
      }
      
      override protected function getWindowTitle() : String
      {
         return Values.EMPTY_STR;
      }
      
      override protected function updateFocus() : void
      {
         var _loc1_:IAbstractRallyViewMeta = getCurrentView();
         var _loc2_:IChannelComponentHolder = _loc1_ as IChannelComponentHolder;
         if(autoSearch.visible)
         {
            autoSearchUpdateFocus();
         }
         else if(_loc2_ && isChatFocusNeeded())
         {
            setFocus(_loc2_.getChannelComponent().messageInput);
            resetChatFocusRequirement();
         }
         else if(lastFocusedElement)
         {
            setFocus(lastFocusedElement);
         }
      }
      
      private function connectedDirectionsPlayAnimation(param1:Boolean) : void
      {
         var _loc3_:ConnectedDirects = null;
         var _loc2_:IAbstractRallyViewMeta = getCurrentView();
         if(_loc2_ is FortClanBattleRoom)
         {
            _loc3_ = FortClanBattleRoom(_loc2_).connectedDirections;
            if(_loc3_ != null)
            {
               _loc3_.playAnimation(param1);
            }
         }
      }
      
      override protected function onSetModalFocus(param1:InteractiveObject) : void
      {
         super.onSetModalFocus(param1);
         this.connectedDirectionsPlayAnimation(true);
         var _loc2_:StrongholdListView = getCurrentView() as StrongholdListView;
         if(_loc2_)
         {
            _loc2_.onFocusChangeS(true);
         }
      }
      
      override protected function onLeaveModalFocus() : void
      {
         super.onLeaveModalFocus();
         this.connectedDirectionsPlayAnimation(false);
         var _loc1_:StrongholdListView = getCurrentView() as StrongholdListView;
         if(_loc1_ && !_loc1_.disposed)
         {
            _loc1_.onFocusChangeS(false);
         }
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         addEventListener(FocusChainChangeEvent.FOCUS_CHAIN_CHANGE,this.onFocusChainChangeHandler);
         this.info.visible = false;
         this.btnRefresh.visible = false;
         this.btnRefresh.addEventListener(MouseEvent.CLICK,this.onRefreshClickHandler);
         autoSearch.width = PREBATTLE_WINDOW_WIDTH;
         autoSearch.height = PREBATTLE_WINDOW_HEIGHT;
         this.backgroundMc.width = autoSearch.width;
         this.backgroundMc.height = autoSearch.height;
         this.backgroundMc.visible = false;
         this.waitingCmp.setSize(autoSearch.width,autoSearch.height);
         this.waitingCmp.visible = false;
         this.waitingCmp.setAnimationStatus(true);
      }
      
      override protected function onBeforeDispose() : void
      {
         removeEventListener(FocusChainChangeEvent.FOCUS_CHAIN_CHANGE,this.onFocusChainChangeHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this._focusChain.splice(0,this._focusChain.length);
         this._focusChain = null;
         this.info = null;
         this.btnRefresh.removeEventListener(MouseEvent.CLICK,this.onRefreshClickHandler);
         this.btnRefresh.dispose();
         this.btnRefresh = null;
         this.backgroundMc = null;
         this.waitingCmp.dispose();
         this.waitingCmp = null;
         super.onDispose();
      }
      
      override protected function registerCurrentView(param1:IViewStackContent, param2:String) : void
      {
         super.registerCurrentView(param1,param2);
         if(App.utils.focusHandler.hasModalFocus(this))
         {
            this.onSetModalFocus(this);
         }
         invalidate(FOCUS_CHAIN);
      }
      
      override protected function draw() : void
      {
         if(isInvalid(FOCUS_CHAIN))
         {
            this.refreshFocusChain();
         }
         super.draw();
      }
      
      override protected function onViewLoadRequest(param1:*) : void
      {
         super.onViewLoadRequest(param1);
         if(!param1)
         {
            return;
         }
         if(param1.alias == FORTIFICATION_ALIASES.FORT_CLAN_BATTLE_ROOM_VIEW_UI)
         {
            if(param1.itemId)
            {
               onJoinClanBattleS(param1.itemId,param1.slotIndex,param1.peripheryID);
            }
         }
         else if(param1.alias == RallyViewsEvent.CREATE_CLAN_BATTLE_ROOM)
         {
            onCreatedBattleRoomS(param1.itemId,param1.peripheryID);
         }
      }
      
      public function getFocusChain() : Vector.<InteractiveObject>
      {
         var _loc1_:Vector.<InteractiveObject> = IFocusChainContainer(this.currentView).getFocusChain();
         _loc1_.push(window.getCloseBtn());
         _loc1_.push(Window(window).minimizeBtn);
         return _loc1_;
      }
      
      private function refreshFocusChain() : void
      {
         var _loc1_:int = this._focusChain.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this._focusChain[_loc2_].tabIndex = -1;
            _loc2_++;
         }
         this._focusChain.splice(0,this._focusChain.length);
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         if(param1.handled)
         {
            return;
         }
         var _loc2_:InputDetails = param1.details;
         if(_loc2_.code == Keyboard.ESCAPE && _loc2_.value == InputValue.KEY_DOWN)
         {
            if(autoSearch.visible)
            {
               autoSearch.handleInput(param1);
            }
            else if(window.getCloseBtn().enabled)
            {
               if(canGoBackS())
               {
                  param1.handled = true;
                  App.contextMenuMgr.hide();
                  onBackClickS();
               }
               else if(window.getCloseBtn().enabled)
               {
                  param1.handled = true;
                  onWindowCloseS();
               }
            }
         }
      }
      
      private function onFocusChainChangeHandler(param1:FocusChainChangeEvent) : void
      {
         invalidate(FOCUS_CHAIN);
      }
      
      public function as_setInfo(param1:Boolean, param2:String, param3:String) : void
      {
         this.info.visible = param1;
         this.info.htmlText = param2;
         this.btnRefresh.visible = param1;
         this.btnRefresh.label = param3;
         this.backgroundMc.visible = param1;
      }
      
      private function onRefreshClickHandler(param1:MouseEvent) : void
      {
         refreshS();
      }
      
      public function as_setWaiting(param1:Boolean, param2:String) : void
      {
         this.waitingCmp.visible = param1;
         this.waitingCmp.setAnimationStatus(!param1);
         this.waitingCmp.setMessage(param2);
      }
   }
}
