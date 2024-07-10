package net.wg.gui.components.common.markers
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import net.wg.gui.events.TimelineEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.IScheduler;
   
   public class HealthBarAnimatedPart extends UIComponentEx
   {
      
      public static const SHOW:String = "show";
      
      public static const HIDE:String = "hide";
      
      public static const SPLASH_DURATION:uint = 1000;
      
      public static const SHOW_STATE:String = "show";
      
      public static const ACTIVE_STATE:String = "active";
      
      public static const HIDE_STATE:String = "hide";
      
      public static const INACTIVE_STATE:String = "inactive";
      
      public static const IMITATION_STATE:String = "imitationDamage";
       
      
      public var animate_mc:MovieClip;
      
      protected var tweenState:String = "inactive";
      
      private var _scheduler:IScheduler;
      
      public function HealthBarAnimatedPart()
      {
         this._scheduler = App.utils.scheduler;
         super();
         stop();
         visible = false;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(TimelineEvent.TWEEN_COMPLETE,this.onTimelineTweenComplete);
      }
      
      override protected function onDispose() : void
      {
         this._scheduler.cancelTask(this.playHideTween);
         this.animate_mc = null;
         this._scheduler = null;
         super.onDispose();
      }
      
      public function onTweenComplete(param1:Boolean) : void
      {
         if(param1)
         {
            this.tweenState = ACTIVE_STATE;
            this._scheduler.scheduleTask(this.playHideTween,SPLASH_DURATION);
            dispatchEvent(new Event(SHOW));
         }
         else
         {
            this.tweenState = INACTIVE_STATE;
            visible = false;
            dispatchEvent(new Event(HIDE));
         }
      }
      
      public function playHideTween() : void
      {
         this.tweenState = HIDE_STATE;
         gotoAndPlay(this.tweenState);
      }
      
      public function playShowTween() : void
      {
         var _loc1_:String = this.tweenState;
         switch(this.tweenState)
         {
            case INACTIVE_STATE:
               visible = true;
               this.tweenState = SHOW_STATE;
               break;
            case ACTIVE_STATE:
               this.onTweenComplete(true);
               break;
            case HIDE_STATE:
               this.tweenState = SHOW_STATE;
         }
         if(_loc1_ != this.tweenState)
         {
            this.setState();
         }
      }
      
      public function setAnimationType(param1:String) : void
      {
         if(this.animate_mc)
         {
            this.animate_mc.gotoAndStop(param1);
         }
      }
      
      protected function setState() : void
      {
         gotoAndPlay(this.tweenState);
      }
      
      private function onTimelineTweenComplete(param1:TimelineEvent) : void
      {
         this.onTweenComplete(param1.isShow);
      }
   }
}
