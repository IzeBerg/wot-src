package net.wg.gui.battle.components
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.generated.BATTLE_NOTIFICATIONS_TIMER_TYPES;
   import net.wg.gui.battle.components.interfaces.IStatusNotification;
   import net.wg.gui.battle.components.interfaces.IStatusNotificationCallback;
   import net.wg.gui.battle.views.destroyTimers.SecondaryTimer;
   import net.wg.gui.battle.views.destroyTimers.data.NotificationTimerSettingVO;
   import net.wg.gui.battle.views.destroyTimers.data.StatusNotificationVO;
   import net.wg.gui.battle.views.destroyTimers.data.StatusNotificationsPanelInitVO;
   import net.wg.infrastructure.base.meta.IStatusNotificationsPanelMeta;
   import net.wg.infrastructure.base.meta.impl.StatusNotificationsPanelMeta;
   
   public class StatusNotificationsPanel extends StatusNotificationsPanelMeta implements IStatusNotificationsPanelMeta
   {
      
      private static const INVALID_STATE:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      private static const TOP_OFFSET_Y:int = 114;
      
      private static const NOTIFICATION_TIMERS_OFFSET_X:uint = 25;
      
      private static const MAX_TIMERS_COUNT_EXTRA_SMALL:uint = 2;
      
      private static const MAX_TIMERS_COUNT_SMALL:uint = 3;
      
      private static const MAX_TIMERS_COUNT_MEDIUM:uint = 4;
      
      private static const MAX_TIMERS_COUNT_BIG:uint = 5;
      
      private static const STAGE_SIZE_WIDTH_1730:uint = 1730;
      
      private static const STAGE_SIZE_WIDTH_1495:uint = 1495;
      
      private static const STAGE_SIZE_WIDTH_1220:uint = 1220;
      
      public static const ZONE_DAMAGE_EVENT_TYPE:String = "zoneDamageEvent";
       
      
      public var notificationsContainer:Sprite = null;
      
      private var _stageWidth:int = 0;
      
      private var _stageHeight:int = 0;
      
      private var _notificationTimers:Object = null;
      
      private var _data:Vector.<StatusNotificationVO> = null;
      
      private var _additionalTopOffset:int = 0;
      
      private var _callbacksByType:Dictionary;
      
      public function StatusNotificationsPanel()
      {
         this._callbacksByType = new Dictionary();
         super();
         this._notificationTimers = {};
         this._data = new Vector.<StatusNotificationVO>(0);
      }
      
      private static function getStatusNotificationDataHash(param1:Vector.<StatusNotificationVO>) : Object
      {
         var _loc3_:StatusNotificationVO = null;
         var _loc2_:Object = {};
         for each(_loc3_ in param1)
         {
            _loc2_[_loc3_.typeID] = _loc3_;
         }
         return _loc2_;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALID_STATE))
         {
            x = this._stageWidth >> 1;
            y = (this._stageHeight >> 1) + TOP_OFFSET_Y + this._additionalTopOffset;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:FrameAnimationTimer = null;
         var _loc2_:* = null;
         var _loc3_:Vector.<IStatusNotificationCallback> = null;
         for each(_loc1_ in this._notificationTimers)
         {
            _loc1_.stop();
            _loc1_.dispose();
            this.notificationsContainer.removeChild(_loc1_);
         }
         this.notificationsContainer = null;
         this._notificationTimers = null;
         this._data = null;
         for(_loc2_ in this._callbacksByType)
         {
            _loc3_ = this._callbacksByType[_loc2_];
            if(_loc3_)
            {
               _loc3_.length = 0;
               this._callbacksByType[_loc2_] = null;
            }
         }
         this._callbacksByType = null;
         super.onDispose();
      }
      
      override protected function setData(param1:Vector.<StatusNotificationVO>) : void
      {
         if(!param1.length)
         {
            this.updateData(param1);
            App.utils.scheduler.cancelTask(this.updateData);
         }
         else
         {
            App.utils.scheduler.scheduleTask(this.updateData,20,param1);
         }
      }
      
      override protected function setInitData(param1:StatusNotificationsPanelInitVO) : void
      {
         var _loc6_:NotificationTimerSettingVO = null;
         var _loc7_:IStatusNotificationCallback = null;
         var _loc8_:String = null;
         var _loc2_:Vector.<NotificationTimerSettingVO> = param1.settings;
         var _loc3_:IStatusNotification = null;
         var _loc4_:Vector.<String> = null;
         var _loc5_:Vector.<IStatusNotificationCallback> = null;
         for each(_loc6_ in _loc2_)
         {
            _loc3_ = App.utils.classFactory.getComponent(_loc6_.linkage,IStatusNotification);
            _loc3_.setSettings(_loc6_);
            _loc3_.visible = false;
            this.notificationsContainer.addChild(DisplayObject(_loc3_));
            this._notificationTimers[_loc6_.typeId] = _loc3_;
            _loc7_ = _loc3_.getStatusCallback();
            if(_loc7_)
            {
               _loc4_ = _loc7_.getCallbackTypes();
               for each(_loc8_ in _loc4_)
               {
                  _loc5_ = this._callbacksByType[_loc8_] = this._callbacksByType[_loc8_] || new Vector.<IStatusNotificationCallback>(0);
                  _loc5_.push(_loc7_);
               }
            }
         }
         invalidateState();
      }
      
      public function as_setSpeed(param1:Number) : void
      {
         var _loc2_:IStatusNotification = null;
         for each(_loc2_ in this._notificationTimers)
         {
            _loc2_.setSpeed(param1);
         }
      }
      
      public function as_setVerticalOffset(param1:int) : void
      {
         if(this._additionalTopOffset != param1)
         {
            this._additionalTopOffset = param1;
            invalidate(INVALID_STATE);
         }
      }
      
      public function updateStage(param1:int, param2:int) : void
      {
         this._stageWidth = param1;
         this._stageHeight = param2;
         invalidate(INVALID_STATE);
         this.updtateNotificationsVisible();
      }
      
      private function updateData(param1:Vector.<StatusNotificationVO>) : void
      {
         var _loc6_:StatusNotificationVO = null;
         var _loc7_:IStatusNotification = null;
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         var _loc4_:Object = getStatusNotificationDataHash(param1);
         var _loc5_:Object = getStatusNotificationDataHash(this._data);
         this._data = param1.slice();
         for each(_loc6_ in _loc4_)
         {
            _loc2_.push(this._notificationTimers[_loc6_.typeID]);
            if(!Boolean(_loc5_[_loc6_.typeID]))
            {
               _loc3_.push(this.showNotification(_loc6_));
            }
            else
            {
               this.updateNotification(_loc6_);
            }
         }
         for each(_loc6_ in _loc5_)
         {
            if(!Boolean(_loc4_[_loc6_.typeID]))
            {
               this.hideNotification(_loc6_);
            }
         }
         if(_loc2_.length == 1)
         {
            _loc7_ = _loc2_[0];
            _loc7_.x = 0;
            _loc7_.fullSize();
            return;
         }
         var _loc8_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         for each(_loc7_ in _loc2_)
         {
            if(_loc7_.isShowing)
            {
               if(_loc11_ > 0)
               {
                  _loc8_ = _loc7_.cropSize();
                  if(_loc8_ && !_loc9_)
                  {
                     _loc10_ -= NOTIFICATION_TIMERS_OFFSET_X;
                  }
                  _loc9_ = _loc8_;
               }
               else if(!_loc7_ is SecondaryTimer || _loc7_.typeId == BATTLE_NOTIFICATIONS_TIMER_TYPES.ORANGE_ZONE || _loc7_.typeId == BATTLE_NOTIFICATIONS_TIMER_TYPES.DAMAGING_ZONE)
               {
                  _loc7_.fullSize();
               }
               else
               {
                  _loc7_.cropSize();
                  _loc9_ = true;
               }
               _loc11_++;
               if(_loc3_.indexOf(_loc7_) == -1)
               {
                  if(_loc7_.x != _loc10_)
                  {
                     _loc7_.tweenToX(_loc10_);
                  }
               }
               else
               {
                  _loc7_.x = _loc10_;
               }
               _loc10_ += _loc7_.actualWidth;
            }
         }
         this.updtateNotificationsVisible();
      }
      
      private function updtateNotificationsVisible() : void
      {
         var _loc2_:IStatusNotification = null;
         var _loc5_:StatusNotificationVO = null;
         var _loc1_:Object = getStatusNotificationDataHash(this._data);
         var _loc3_:uint = 1;
         var _loc4_:uint = MAX_TIMERS_COUNT_BIG;
         if(this._stageWidth <= STAGE_SIZE_WIDTH_1730 && this._stageWidth >= STAGE_SIZE_WIDTH_1495)
         {
            _loc4_ = MAX_TIMERS_COUNT_MEDIUM;
         }
         else if(this._stageWidth <= STAGE_SIZE_WIDTH_1495 && this._stageWidth >= STAGE_SIZE_WIDTH_1220)
         {
            _loc4_ = MAX_TIMERS_COUNT_SMALL;
         }
         else if(this._stageWidth <= STAGE_SIZE_WIDTH_1220)
         {
            _loc4_ = MAX_TIMERS_COUNT_EXTRA_SMALL;
         }
         for each(_loc5_ in _loc1_)
         {
            _loc2_ = this._notificationTimers[_loc5_.typeID];
            _loc2_.visible = !Boolean(_loc3_ > _loc4_);
            _loc3_++;
         }
      }
      
      private function showNotification(param1:StatusNotificationVO) : IStatusNotification
      {
         var _loc2_:IStatusNotification = this._notificationTimers[param1.typeID];
         _loc2_.isActive = true;
         this.updateNotification(param1);
         _loc2_.showTimer(true);
         _loc2_.visible = true;
         invalidate(INVALID_STATE);
         return _loc2_;
      }
      
      private function updateNotification(param1:StatusNotificationVO) : void
      {
         var _loc2_:IStatusNotification = this._notificationTimers[param1.typeID];
         _loc2_.setStaticText(param1.title,param1.description);
         _loc2_.updateViewID(param1.viewSubType,false);
         _loc2_.updateRadialTimer(param1.totalTime,param1.currentTime);
      }
      
      private function hideNotification(param1:StatusNotificationVO) : void
      {
         var _loc2_:IStatusNotification = this._notificationTimers[param1.typeID];
         if(!_loc2_)
         {
            return;
         }
         _loc2_.resetTimer();
         _loc2_.isActive = false;
         _loc2_.hideTimer();
         invalidate(INVALID_STATE);
      }
      
      public function notifyZoneDamage() : void
      {
         this.invokeStatusCallbacks(ZONE_DAMAGE_EVENT_TYPE);
      }
      
      private function invokeStatusCallbacks(param1:String) : void
      {
         var _loc3_:IStatusNotificationCallback = null;
         var _loc2_:Vector.<IStatusNotificationCallback> = this._callbacksByType[param1];
         if(_loc2_)
         {
            for each(_loc3_ in _loc2_)
            {
               _loc3_.invoke(param1);
            }
         }
      }
   }
}
