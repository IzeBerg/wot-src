package net.wg.gui.notification
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.gui.notification.events.ServiceMessageEvent;
   import net.wg.gui.notification.vo.MessageInfoVO;
   import net.wg.gui.notification.vo.NotificationInfoVO;
   import net.wg.gui.notification.vo.PopUpNotificationInfoVO;
   import net.wg.gui.utils.ExcludeTweenManager;
   import net.wg.utils.IScheduler;
   import scaleform.clik.motion.Tween;
   
   public class ServiceMessagePopUp extends ServiceMessageBase
   {
      
      public static const EVENT_HIDED:String = "hided";
      
      private static const HIDE:int = 0;
      
      private static const SHOW:int = 1;
      
      private static const SHOW_ANIMATION_SPEED:uint = 150;
      
      private static const HIDING_INVALID:String = "hidingInv";
      
      private static const CONTENT_LINKAGE_POSTFIX:String = "PopUp_UI";
       
      
      public var isLayoutInitialized:Boolean = false;
      
      private var _allowHiding:int = -1;
      
      private var _livingTime:Number = NaN;
      
      private var _hidingAnimationSpeed:Number = NaN;
      
      private var _tweenManager:ExcludeTweenManager;
      
      private var _livingTimeComplete:Boolean = false;
      
      private var _hideTween:Tween = null;
      
      private var _scheduler:IScheduler;
      
      public function ServiceMessagePopUp()
      {
         this._tweenManager = new ExcludeTweenManager();
         this._scheduler = App.utils.scheduler;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(!isNaN(this._livingTime))
         {
            this._scheduler.scheduleTask(this.hideTask,this._livingTime);
         }
         this.addEventListener(MouseEvent.CLICK,this.onComponentClickHandler);
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
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.CLICK,this.onComponentClickHandler);
         this._scheduler.cancelTask(this.hideTask);
         this._scheduler = null;
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
         super.onDispose();
      }
      
      public function set allowHiding(param1:Boolean) : void
      {
         if(this._allowHiding != SHOW || this._allowHiding != HIDE)
         {
            this._allowHiding = !!param1 ? int(SHOW) : int(HIDE);
            invalidate(HIDING_INVALID);
         }
      }
      
      override public function set data(param1:NotificationInfoVO) : void
      {
         super.data = param1;
         var _loc2_:PopUpNotificationInfoVO = PopUpNotificationInfoVO(param1);
         this._livingTime = _loc2_.lifeTime;
         this._hidingAnimationSpeed = _loc2_.hidingAnimationSpeed;
      }
      
      override protected function get contentLinkage() : String
      {
         return super.contentLinkage + CONTENT_LINKAGE_POSTFIX;
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
            dispatchEvent(new Event(EVENT_HIDED));
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
         dispatchEvent(new Event(EVENT_HIDED));
      }
      
      private function onShowTweenComplete(param1:Tween) : void
      {
         this._tweenManager.unregister(param1);
      }
      
      private function onComponentClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:MessageInfoVO = data.messageVO;
         if(_loc2_.areButtonsVisible && _loc2_.buttonsLayout.length > 1 && App.utils.commons.isLeftButton(param1))
         {
            return;
         }
         dispatchEvent(new ServiceMessageEvent(ServiceMessageEvent.MESSAGE_AREA_CLICKED,data.typeID,data.entityID,true));
      }
   }
}
