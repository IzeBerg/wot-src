package net.wg.gui.notification
{
   import fl.transitions.easing.Strong;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.LAYER_NAMES;
   import net.wg.gui.notification.events.NotificationLayoutEvent;
   import net.wg.gui.notification.events.ServiceMessageEvent;
   import net.wg.gui.notification.vo.PopUpNotificationInfoVO;
   import net.wg.gui.utils.ExcludeTweenManager;
   import net.wg.infrastructure.base.meta.INotificationPopUpViewerMeta;
   import net.wg.infrastructure.base.meta.impl.NotificationPopUpViewerMeta;
   import net.wg.infrastructure.events.ContainerManagerEvent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.managers.IContainerManager;
   import scaleform.clik.motion.Tween;
   
   public class NotificationPopUpViewer extends NotificationPopUpViewerMeta implements INotificationPopUpViewerMeta
   {
      
      private static const TWEEN_DURATION:uint = 500;
      
      private static const DELAY:Number = 50;
      
      private static const DEFAULT_PADDING:Point = new Point(4,40);
       
      
      private var _pendingForDisplay:Vector.<PopUpNotificationInfoVO>;
      
      private var _displayingNowPopUps:Vector.<ServiceMessagePopUp>;
      
      private var _animationManager:ExcludeTweenManager;
      
      private var _smContainer:DisplayObjectContainer = null;
      
      private var _stageDimensions:Point = null;
      
      private var _popupClass:Class = null;
      
      private var _popupPadding:uint = 0;
      
      private var _isMessagesCountInvalid:Boolean = false;
      
      private var _arrangeLayout:Boolean = false;
      
      private var _maxAvailableMessagesCount:uint = 5;
      
      private var _padding:Point = null;
      
      private var _containerMgr:IContainerManager = null;
      
      public function NotificationPopUpViewer(param1:Class)
      {
         this._pendingForDisplay = new Vector.<PopUpNotificationInfoVO>();
         this._displayingNowPopUps = new Vector.<ServiceMessagePopUp>();
         this._animationManager = new ExcludeTweenManager();
         super();
         this._padding = DEFAULT_PADDING;
         this._smContainer = App.systemMessages;
         this._containerMgr = App.instance.containerMgr;
         this._popupClass = param1;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._smContainer.addEventListener(MouseEvent.MOUSE_OVER,this.onSMContainerMouseOverHandler);
         this._smContainer.addEventListener(MouseEvent.MOUSE_OUT,this.onSMContainerMouseOutHandler);
         this._smContainer.addEventListener(NotificationLayoutEvent.UPDATE_LAYOUT,this.onSmContainerUpdateLayoutHandler);
         this._containerMgr.addEventListener(ContainerManagerEvent.VIEW_ADDED,this.onContainerMgrViewLoadingHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:ServiceMessagePopUp = null;
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:PopUpNotificationInfoVO = null;
         var _loc6_:Boolean = false;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         var _loc9_:int = 0;
         super.draw();
         if((this._arrangeLayout || this._isMessagesCountInvalid) && this._stageDimensions)
         {
            _loc4_ = 0;
            this._arrangeLayout = this._isMessagesCountInvalid = false;
            _loc6_ = true;
            _loc7_ = 0;
            while(this._pendingForDisplay.length > 0 && _loc6_)
            {
               _loc5_ = this._pendingForDisplay.pop();
               _loc1_ = new this._popupClass();
               this.updateTimeStampValue(_loc5_);
               _loc1_.data = _loc5_;
               _loc1_.validateNow();
               _loc2_ = _loc1_.height;
               _loc3_ = this._stageDimensions.y - _loc4_ - this._popupPadding * _loc7_ - this._padding.y - _loc2_ >> 0;
               if(_loc3_ > 0)
               {
                  this._smContainer.addChild(_loc1_);
                  this.setupPopUpPosition(_loc1_,_loc3_);
                  _loc1_.addEventListener(ServiceMessageEvent.MESSAGE_AREA_CLICKED,this.onPopUpMessageAreaClickedHandler,false,0,true);
                  _loc1_.addEventListener(ServiceMessageEvent.MESSAGE_BUTTON_CLICKED,this.onPopUpMessageButtonClickedHandler,false,0,true);
                  _loc1_.addEventListener(ServiceMessageEvent.MESSAGE_LINK_CLICKED,this.onPopUpMessageLinkClickedHandler,false,0,true);
                  _loc1_.addEventListener(ServiceMessagePopUp.HIDED,this.onPopUpHidedHandler,false,0,true);
                  _loc4_ += _loc2_;
                  this._displayingNowPopUps.splice(_loc7_,0,_loc1_);
                  _loc7_++;
               }
               else
               {
                  _loc1_.dispose();
               }
               _loc6_ = _loc3_ > 0 && _loc7_ < this._maxAvailableMessagesCount;
            }
            this.clearPendingList();
            if(_loc6_)
            {
               _loc8_ = this._displayingNowPopUps.length;
               _loc9_ = _loc7_;
               while(_loc9_ < _loc8_ && _loc6_)
               {
                  _loc1_ = this._displayingNowPopUps[_loc9_];
                  _loc2_ = _loc1_.height;
                  _loc3_ = this._stageDimensions.y - _loc4_ - this._popupPadding * _loc7_ - this._padding.y - _loc2_ >> 0;
                  if(_loc3_ > 0)
                  {
                     this.setupPopUpPosition(_loc1_,_loc3_);
                     _loc4_ += _loc2_;
                     _loc7_++;
                     _loc9_++;
                  }
                  _loc6_ = _loc3_ > 0 && _loc7_ < this._maxAvailableMessagesCount;
               }
            }
            while(this._displayingNowPopUps.length > _loc7_)
            {
               this.removePopupAt(this._displayingNowPopUps.length - 1,true);
            }
         }
      }
      
      override protected function appendMessage(param1:PopUpNotificationInfoVO) : void
      {
         this._pendingForDisplay.push(param1);
         this._isMessagesCountInvalid = true;
         invalidate();
      }
      
      override protected function updateMessage(param1:PopUpNotificationInfoVO) : void
      {
         var _loc2_:PopUpNotificationInfoVO = null;
         var _loc5_:ServiceMessagePopUp = null;
         var _loc3_:int = this.getPopUpDisplayingIndex(param1.typeID,param1.entityID);
         var _loc4_:int = this.getPopUpPendingIndex(param1.typeID,param1.entityID);
         if(_loc3_ > -1)
         {
            _loc5_ = this._displayingNowPopUps[_loc3_];
            _loc2_ = PopUpNotificationInfoVO(_loc5_.data);
            this.updateTimeStampValue(param1);
            _loc5_.data = param1;
            _loc5_.validateNow();
            if(!_baseDisposed)
            {
               invalidate();
            }
         }
         else if(_loc4_ > -1)
         {
            _loc2_ = this._pendingForDisplay[_loc4_];
            this._pendingForDisplay[_loc4_] = param1;
         }
         else
         {
            _loc2_ = param1;
         }
         _loc2_.dispose();
      }
      
      override protected function onDispose() : void
      {
         App.utils.scheduler.cancelTask(this.postponedPopupRemoving);
         while(this._displayingNowPopUps.length > 0)
         {
            this.removePopupAt(0,false,false);
         }
         this._displayingNowPopUps = null;
         this._smContainer.removeEventListener(MouseEvent.MOUSE_OVER,this.onSMContainerMouseOverHandler);
         this._smContainer.removeEventListener(MouseEvent.MOUSE_OUT,this.onSMContainerMouseOutHandler);
         this._smContainer.removeEventListener(NotificationLayoutEvent.UPDATE_LAYOUT,this.onSmContainerUpdateLayoutHandler);
         this._smContainer = null;
         this._containerMgr.removeEventListener(ContainerManagerEvent.VIEW_ADDED,this.onContainerMgrViewLoadingHandler);
         this._containerMgr = null;
         this._animationManager.dispose();
         this._animationManager = null;
         this._padding = null;
         this._stageDimensions = null;
         this._popupClass = null;
         this.clearPendingList();
         this._pendingForDisplay = null;
         super.onDispose();
      }
      
      public function as_hasPopUpIndex(param1:uint, param2:Number) : Boolean
      {
         return this.getPopUpDisplayingIndex(param1,param2) > -1 || this.getPopUpPendingIndex(param1,param2) > -1;
      }
      
      public function as_initInfo(param1:Number, param2:Number) : void
      {
         this._maxAvailableMessagesCount = param1;
         this._popupPadding = param2;
         this._isMessagesCountInvalid = true;
         invalidate();
      }
      
      public function as_removeAllMessages() : void
      {
         while(this._displayingNowPopUps.length > 0)
         {
            this.removePopupAt(0,false);
         }
      }
      
      public function as_removeMessage(param1:uint, param2:Number) : void
      {
         var _loc3_:int = this.getPopUpDisplayingIndex(param1,param2);
         var _loc4_:int = this.getPopUpPendingIndex(param1,param2);
         if(_loc3_ > -1)
         {
            this.removePopupAt(_loc3_,false,false);
         }
         else if(_loc4_ > -1)
         {
            this._pendingForDisplay[_loc4_].dispose();
            this._pendingForDisplay.splice(_loc4_,1);
         }
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         this._stageDimensions = new Point(param1,param2);
         this._arrangeLayout = true;
         invalidate();
      }
      
      private function updateTimeStampValue(param1:PopUpNotificationInfoVO) : void
      {
         var _loc2_:Number = param1.messageVO.timestamp;
         if(_loc2_ != Values.DEFAULT_INT)
         {
            param1.messageVO.timestampStr = getMessageActualTimeS(_loc2_);
         }
      }
      
      private function applyHiding(param1:Boolean) : void
      {
         var _loc4_:ServiceMessagePopUp = null;
         var _loc2_:uint = this._displayingNowPopUps.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this._displayingNowPopUps[_loc3_];
            _loc4_.allowHiding = param1;
            _loc3_++;
         }
      }
      
      private function setupPopUpPosition(param1:ServiceMessagePopUp, param2:int) : void
      {
         if(!param1.isLayoutInitialized)
         {
            param1.isLayoutInitialized = true;
            param1.y = param2;
            param1.x = this._stageDimensions.x;
            param1.alpha = 0;
         }
         this._animationManager.registerAndLaunch(TWEEN_DURATION,param1,{
            "y":param2,
            "alpha":1,
            "x":this._stageDimensions.x - param1.width - this._padding.x >> 0
         },this.getDefaultTweenSet());
      }
      
      private function getDefaultTweenSet() : Object
      {
         var _loc1_:Object = {};
         _loc1_.ease = Strong.easeOut;
         _loc1_.onComplete = this.onTweenComplete;
         return _loc1_;
      }
      
      private function onTweenComplete(param1:Tween) : void
      {
         this._animationManager.unregister(param1);
      }
      
      private function postponedPopupRemoving(param1:ServiceMessagePopUp, param2:Boolean, param3:Boolean = true) : void
      {
         var _loc4_:int = this._displayingNowPopUps.indexOf(param1);
         if(_loc4_ != -1)
         {
            this.removePopupAt(_loc4_,param2,param3);
         }
      }
      
      private function removePopupAt(param1:int, param2:Boolean, param3:Boolean = true) : void
      {
         var _loc5_:PopUpNotificationInfoVO = null;
         this.applyHiding(false);
         var _loc4_:ServiceMessagePopUp = this._displayingNowPopUps[param1];
         this._displayingNowPopUps.splice(param1,1);
         this._smContainer.removeChild(_loc4_);
         _loc4_.removeEventListener(ServiceMessagePopUp.HIDED,this.onPopUpHidedHandler);
         _loc4_.removeEventListener(ServiceMessageEvent.MESSAGE_AREA_CLICKED,this.onPopUpMessageAreaClickedHandler);
         _loc4_.removeEventListener(ServiceMessageEvent.MESSAGE_BUTTON_CLICKED,this.onPopUpMessageButtonClickedHandler);
         _loc4_.removeEventListener(ServiceMessageEvent.MESSAGE_LINK_CLICKED,this.onPopUpMessageLinkClickedHandler);
         if(param3)
         {
            _loc5_ = PopUpNotificationInfoVO(_loc4_.data);
            onMessageHiddenS(param2,_loc5_.notify,_loc5_.typeID,_loc5_.entityID);
         }
         _loc4_.dispose();
         if(this._displayingNowPopUps.length > 0)
         {
            this._arrangeLayout = true;
            if(!_baseDisposed)
            {
               invalidate();
            }
         }
         else
         {
            setListClearS();
            this._arrangeLayout = false;
         }
      }
      
      private function getPopUpDisplayingIndex(param1:uint, param2:Number) : int
      {
         var _loc3_:PopUpNotificationInfoVO = null;
         var _loc4_:int = this._displayingNowPopUps.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = this._displayingNowPopUps[_loc5_].data as PopUpNotificationInfoVO;
            if(_loc3_ && _loc3_.typeID == param1 && _loc3_.entityID == param2)
            {
               return _loc5_;
            }
            _loc5_++;
         }
         return -1;
      }
      
      private function getPopUpPendingIndex(param1:uint, param2:Number) : int
      {
         var _loc3_:PopUpNotificationInfoVO = null;
         var _loc4_:int = this._pendingForDisplay.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = this._pendingForDisplay[_loc5_];
            if(_loc3_.typeID == param1 && _loc3_.entityID == param2)
            {
               return _loc5_;
            }
            _loc5_++;
         }
         return -1;
      }
      
      private function clearPendingList() : void
      {
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this._pendingForDisplay)
         {
            _loc1_.dispose();
         }
         this._pendingForDisplay.splice(0,this._pendingForDisplay.length);
      }
      
      private function setPadding(param1:Point) : void
      {
         if(!this._padding.equals(param1))
         {
            this._padding = param1;
            this._arrangeLayout = true;
            invalidate();
         }
      }
      
      private function onSMContainerMouseOverHandler(param1:MouseEvent) : void
      {
         this.applyHiding(true);
      }
      
      private function onSMContainerMouseOutHandler(param1:MouseEvent) : void
      {
         this.applyHiding(false);
      }
      
      private function onPopUpMessageAreaClickedHandler(param1:Event) : void
      {
         param1.stopImmediatePropagation();
         App.utils.scheduler.scheduleTask(this.postponedPopupRemoving,DELAY,param1.target,false,true);
      }
      
      private function onPopUpMessageButtonClickedHandler(param1:ServiceMessageEvent) : void
      {
         param1.stopImmediatePropagation();
         onClickActionS(param1.typeID,param1.entityID,param1.action);
         this.onPopUpMessageAreaClickedHandler(param1);
      }
      
      private function onPopUpMessageLinkClickedHandler(param1:ServiceMessageEvent) : void
      {
         param1.stopImmediatePropagation();
         onClickActionS(param1.typeID,param1.entityID,param1.action);
      }
      
      private function onPopUpHidedHandler(param1:Event) : void
      {
         var _loc2_:ServiceMessagePopUp = ServiceMessagePopUp(param1.target);
         this.removePopupAt(this._displayingNowPopUps.indexOf(_loc2_),true);
      }
      
      private function onSmContainerUpdateLayoutHandler(param1:NotificationLayoutEvent) : void
      {
         this.setPadding(param1.padding);
      }
      
      private function onContainerMgrViewLoadingHandler(param1:ContainerManagerEvent) : void
      {
         var _loc2_:String = LAYER_NAMES.LAYER_ORDER[param1.layer];
         if(_loc2_ == LAYER_NAMES.SUBVIEW || _loc2_ == LAYER_NAMES.FULLSCREEN_WINDOWS)
         {
            this.setPadding(DEFAULT_PADDING);
         }
      }
   }
}
