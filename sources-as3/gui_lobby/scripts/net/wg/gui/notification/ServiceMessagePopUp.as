package net.wg.gui.notification
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.notification.events.ServiceMessageEvent;
   import net.wg.gui.notification.vo.MessageInfoVO;
   import net.wg.gui.notification.vo.NotificationInfoVO;
   import net.wg.gui.notification.vo.PopUpNotificationInfoVO;
   import net.wg.gui.utils.ExcludeTweenManager;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.motion.Tween;
   
   public class ServiceMessagePopUp extends ServiceMessage
   {
      
      public static const HIDING_INVALID:String = "hidingInv";
      
      public static const HIDED:String = "hided";
      
      private static const HIDE:int = 0;
      
      private static const SHOW:int = 1;
      
      private static const SHOW_ANIMATION_SPEED:uint = 150;
      
      private static const ICON_HIDE_ANIMATION_SPEED:uint = 150;
      
      private static const ICON_ALPHA_ANIMATION_SPEED:uint = 100;
      
      private static const ICON_SCALE_ANIMATION_SPEED:uint = 75;
      
      private static const ICON_SCALE:Number = 1.05;
      
      private static const ICON_DELTA_COEF:Number = (ICON_SCALE - 1) / 2;
      
      private static const LUNAR_NY_BTN_PUDDING:uint = 24;
      
      private static const LUNAR_NY_COUNTER_Y:uint = 112;
      
      private static const LUNAR_NY_COUNTER_X:uint = 200;
      
      private static const LUNAR_NY_TEXT_Y:uint = 150;
       
      
      public var isLayoutInitialized:Boolean;
      
      private var _lunarNYHit:MovieClip = null;
      
      private var _livingTime:Number = NaN;
      
      private var _hidingAnimationSpeed:Number = NaN;
      
      private var _tweenManager:ExcludeTweenManager;
      
      private var _allowHiding:int = -1;
      
      private var _hideTween:Tween;
      
      private var _alphaTween:Tween;
      
      private var _scaleTween:Tween;
      
      private var _livingTimeComplete:Boolean;
      
      private var _isNotEmptyIcon:Boolean = false;
      
      public function ServiceMessagePopUp()
      {
         this._tweenManager = new ExcludeTweenManager();
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         textField.selectable = false;
         if(!isNaN(this._livingTime))
         {
            _utils.scheduler.scheduleTask(this.hideTask,this._livingTime);
         }
         _lunarNYSettings.bgLinkage = Linkages.LUNAR_NY_NOTIFICATION_BG_UI;
         _lunarNYSettings.btnPadding = LUNAR_NY_BTN_PUDDING;
         _lunarNYSettings.counterY = LUNAR_NY_COUNTER_Y;
         _lunarNYSettings.counterX = LUNAR_NY_COUNTER_X;
         _lunarNYSettings.textY = LUNAR_NY_TEXT_Y;
         addEventListener(MouseEvent.CLICK,this.componentClickHandler,false,0,true);
      }
      
      override protected function getNyBgLinkage(param1:Boolean) : String
      {
         return !!param1 ? Linkages.NY_LB_SPECIAL_NOTIFICATION_BG_UI : Linkages.NY_LB_NOTIFICATION_BG_UI;
      }
      
      override protected function getWinterOfferBgLinkage() : String
      {
         return Linkages.WINTER_OFFER_BORDER_NOTIFICATION_BG_UI;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(HIDING_INVALID))
         {
            if(this._allowHiding == SHOW)
            {
               this._hideTween = this._tweenManager.registerAndLaunch(SHOW_ANIMATION_SPEED,this,{"alpha":1},{"onComplete":this.onShowTweenComplete});
               this._hideTween.fastTransform = false;
            }
            else if(this._allowHiding == HIDE && this._livingTimeComplete)
            {
               this.launchHideAnimation();
            }
         }
      }
      
      override protected function updateLayout() : void
      {
         super.updateLayout();
         if(_isLunarNYMessage && !this._lunarNYHit)
         {
            _lunarNYBg.mouseEnabled = _lunarNYBg.mouseChildren = false;
            this._lunarNYHit = _classFactory.getComponent(lunarNYSettings.hitLinkage,MovieClip);
            this._lunarNYHit.y = bgIcon.y - lunarNYSettings.bgIconOffset;
            addChildAt(this._lunarNYHit,getChildIndex(buttonsGroup) - 1);
            hitArea = this._lunarNYHit;
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         _utils.scheduler.cancelTask(this.hideTask);
         removeEventListener(MouseEvent.CLICK,this.componentClickHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         if(this._tweenManager)
         {
            this._tweenManager.dispose();
            this._tweenManager = null;
         }
         if(this._hideTween)
         {
            this._hideTween.dispose();
            this._hideTween = null;
         }
         if(this._alphaTween)
         {
            this._alphaTween.dispose();
            this._alphaTween = null;
         }
         if(this._scaleTween)
         {
            this._scaleTween.dispose();
            this._scaleTween = null;
         }
         this._lunarNYHit = null;
         super.onDispose();
      }
      
      override protected function updateIcon(param1:String) : void
      {
         if(!_isLunarNYMessage)
         {
            super.updateIcon(param1);
            return;
         }
         var _loc2_:Boolean = icon.source == param1;
         icon.visible = _loc2_;
         if(StringUtils.isNotEmpty(param1))
         {
            if(_loc2_)
            {
               this.showIconUpdateAnim();
            }
            else
            {
               this._isNotEmptyIcon = StringUtils.isNotEmpty(icon.source);
               if(this._isNotEmptyIcon)
               {
                  this.showIconHideAnim(param1);
               }
               else
               {
                  icon.source = param1;
               }
            }
         }
      }
      
      override protected function iconComplete(param1:DisplayObject) : void
      {
         super.iconComplete(param1);
         if(_isLunarNYMessage && this._isNotEmptyIcon)
         {
            this.showIconUpdateAnim();
         }
      }
      
      private function showIconHideAnim(param1:String) : void
      {
         var iconSrc:String = param1;
         this._alphaTween = this._tweenManager.registerAndLaunch(ICON_HIDE_ANIMATION_SPEED,icon,{"alpha":0},{"onComplete":function():void
         {
            icon.source = iconSrc;
         }});
      }
      
      private function showIconUpdateAnim() : void
      {
         var oldX:int = 0;
         var oldY:int = 0;
         oldX = icon.x;
         oldY = icon.y;
         var newX:Number = oldX - icon.width * ICON_DELTA_COEF;
         var newY:Number = oldY - icon.height * ICON_DELTA_COEF;
         this._alphaTween = this._tweenManager.registerAndLaunch(ICON_ALPHA_ANIMATION_SPEED,icon,{
            "alpha":1,
            "scaleX":ICON_SCALE,
            "scaleY":ICON_SCALE,
            "x":newX,
            "y":newY
         },{"onComplete":function():void
         {
            _scaleTween = _tweenManager.registerAndLaunch(ICON_SCALE_ANIMATION_SPEED,icon,{
               "scaleX":1,
               "scaleY":1,
               "x":oldX,
               "y":oldY
            },{});
         }});
      }
      
      private function fireAreaClickEvent() : void
      {
         dispatchEvent(new ServiceMessageEvent(ServiceMessageEvent.MESSAGE_AREA_CLICKED,data.typeID,data.entityID,true));
      }
      
      private function hideTask() : void
      {
         this._livingTimeComplete = true;
         if(!isNaN(this._hidingAnimationSpeed))
         {
            if(this._allowHiding != SHOW)
            {
               this.launchHideAnimation();
            }
         }
         else
         {
            dispatchEvent(new Event(HIDED));
         }
      }
      
      private function launchHideAnimation() : void
      {
         this._hideTween = this._tweenManager.registerAndLaunch(this._hidingAnimationSpeed,this,{"alpha":0},{"onComplete":this.onHideTweenComplete});
         this._hideTween.fastTransform = false;
      }
      
      private function onHideTweenComplete(param1:Tween) : void
      {
         this._tweenManager.unregister(param1);
         dispatchEvent(new Event(HIDED));
      }
      
      private function onShowTweenComplete(param1:Tween) : void
      {
         this._tweenManager.unregister(param1);
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:Boolean = data == null;
         super.data = param1;
         var _loc3_:PopUpNotificationInfoVO = PopUpNotificationInfoVO(param1);
         this.livingTime = _loc3_.lifeTime;
         this.hidingAnimationSpeed = _loc3_.hidingAnimationSpeed;
         if(!_loc2_)
         {
            alpha = 1;
            if(this._hideTween)
            {
               this._hideTween.paused = true;
               this._hideTween.dispose();
               this._tweenManager.unregister(this._hideTween);
            }
            _utils.scheduler.cancelTask(this.hideTask);
            _utils.scheduler.scheduleTask(this.hideTask,this._livingTime);
         }
      }
      
      public function get livingTime() : Number
      {
         return this._livingTime;
      }
      
      public function set livingTime(param1:Number) : void
      {
         this._livingTime = param1;
      }
      
      public function get hidingAnimationSpeed() : Number
      {
         return this._hidingAnimationSpeed;
      }
      
      public function set hidingAnimationSpeed(param1:Number) : void
      {
         this._hidingAnimationSpeed = param1;
      }
      
      public function set allowHiding(param1:Boolean) : void
      {
         this._allowHiding = !!param1 ? int(SHOW) : int(HIDE);
         invalidate(HIDING_INVALID);
      }
      
      private function get parentData() : NotificationInfoVO
      {
         return NotificationInfoVO(data);
      }
      
      protected function componentClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:MessageInfoVO = null;
         if(_utils.commons.isLeftButton(param1))
         {
            _loc2_ = NotificationInfoVO(data).messageVO;
            if(_loc2_.areButtonsVisible())
            {
               if(_loc2_.buttonsLayout.length < 2)
               {
                  this.fireAreaClickEvent();
               }
            }
            else
            {
               this.fireAreaClickEvent();
            }
         }
         else
         {
            this.fireAreaClickEvent();
         }
      }
   }
}
