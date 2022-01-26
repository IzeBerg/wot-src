package net.wg.gui.lobby.vehicleCustomization
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.IScheduler;
   import scaleform.clik.motion.Tween;
   import scaleform.gfx.TextFieldEx;
   
   public class CustomizationNotification extends Sprite implements IDisposable
   {
      
      private static const HIDE_NOTIFICATION_DELAY:int = 3000;
      
      private static const NOTIFICATION_SHOW_TWEEN_DURATION:int = 300;
      
      private static const NOTIFICATION_HIDE_TWEEN_DURATION:int = 200;
      
      private static const X_OFFSET:uint = 25;
      
      private static const Y_OFFSET:uint = 45;
      
      private static const ANCHOR_OFFSET_Y:uint = 54;
      
      private static const TILES_AMOUNT_HOR:uint = 6;
       
      
      public var notificationTF:TextField = null;
      
      private var _tween:Tween;
      
      private var _scheduler:IScheduler;
      
      private var _halfW:uint;
      
      private var _currentContainer:CustomizationEndPointIcon;
      
      private var _hidden:Boolean = false;
      
      public function CustomizationNotification()
      {
         this._scheduler = App.utils.scheduler;
         super();
         this._halfW = width >> 1 ^ 0;
         buttonMode = true;
         visible = false;
      }
      
      public function addToAnchor(param1:CustomizationEndPointIcon) : void
      {
         this._currentContainer = param1;
         this.notificationTF.text = VEHICLE_CUSTOMIZATION.NOTIFICATION_SLOTISFILLED_TITLE;
         this.notificationTF.text = this.notificationTF.text.toUpperCase();
         TextFieldEx.setVerticalAlign(this.notificationTF,TextFieldEx.VALIGN_CENTER);
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
      
      public function hide() : void
      {
         if(!this._hidden)
         {
            this.removeTween();
            this._tween = new Tween(NOTIFICATION_HIDE_TWEEN_DURATION,this,{"alpha":0},{"onComplete":this.onNotificationHideComplete});
         }
      }
      
      public function show() : void
      {
         this._hidden = false;
         alpha = 0;
         visible = true;
         this._scheduler.cancelTask(this.hide);
         this.removeTween();
         this._tween = new Tween(NOTIFICATION_SHOW_TWEEN_DURATION,this,{"alpha":1},{"onComplete":this.onNotificationShowComplete});
         addEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
         this.updatePosition();
      }
      
      protected function onDispose() : void
      {
         removeEventListener(MouseEvent.CLICK,this.onNotificationMouseClickHandler);
         removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
         this.removeTween();
         this.notificationTF = null;
         this._scheduler.cancelTask(this.hide);
         this._scheduler = null;
         this._currentContainer = null;
      }
      
      private function updatePosition() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         if(this._currentContainer)
         {
            _loc1_ = App.appWidth / TILES_AMOUNT_HOR;
            _loc2_ = App.appHeight >> 1;
            _loc3_ = this._currentContainer.x / _loc1_;
            _loc4_ = this._currentContainer.y / _loc2_;
            x = this._currentContainer.x;
            y = this._currentContainer.y - ANCHOR_OFFSET_Y;
            if(_loc3_ == 0)
            {
               x += this._halfW + X_OFFSET;
            }
            else if(_loc3_ == TILES_AMOUNT_HOR - 1)
            {
               x -= this._halfW + X_OFFSET;
            }
            else if(_loc4_ == 0)
            {
               y += Y_OFFSET;
            }
            else
            {
               y -= Y_OFFSET;
            }
         }
      }
      
      private function removeTween() : void
      {
         if(this._tween)
         {
            this._tween.paused = true;
            this._tween.dispose();
            this._tween = null;
         }
      }
      
      private function onNotificationShowComplete() : void
      {
         this._scheduler.scheduleTask(this.hide,HIDE_NOTIFICATION_DELAY);
      }
      
      private function onNotificationHideComplete() : void
      {
         this._hidden = true;
         visible = false;
         this._currentContainer = null;
         removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
      }
      
      private function onNotificationMouseClickHandler(param1:MouseEvent) : void
      {
         this._scheduler.cancelTask(this.hide);
         this.hide();
      }
      
      private function onEnterFrameHandler(param1:Event) : void
      {
         this.updatePosition();
      }
   }
}
