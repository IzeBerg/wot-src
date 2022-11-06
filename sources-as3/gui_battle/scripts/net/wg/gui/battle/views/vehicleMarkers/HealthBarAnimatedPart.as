package net.wg.gui.battle.views.vehicleMarkers
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.vehicleMarkers.events.TimelineEvent;
   import net.wg.gui.utils.RootSWFAtlasManager;
   
   public class HealthBarAnimatedPart extends BattleUIComponent
   {
      
      public static const SHOW:String = "show";
      
      public static const HIDE:String = "hide";
      
      private static const SHOW_STATE:String = "show";
      
      private static const ACTIVE_STATE:String = "active";
      
      private static const HIDE_STATE:String = "hide";
      
      private static const DMG_BAR_XY:Point = new Point(0,-19);
      
      private static const EXPLOSION_XY:Point = new Point(-43,-43);
       
      
      public var animateMc:MovieClip = null;
      
      private var _tweenState:String = "inactive";
      
      private var _partType:String = "splash";
      
      private var _splashTimer:Timer = null;
      
      private var _vmManager:VehicleMarkersManager = null;
      
      public function HealthBarAnimatedPart()
      {
         super();
         stop();
         visible = false;
         this._vmManager = VehicleMarkersManager.getInstance();
         this.addDispatchers();
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(TimelineEvent.TWEEN_COMPLETE,this.onTimelineTweenCompleteHandler);
         if(this._splashTimer)
         {
            this._splashTimer.stop();
            this._splashTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onSplashTimerCompleteHandler);
            this._splashTimer = null;
         }
         this.animateMc = null;
         this._vmManager = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(TimelineEvent.TWEEN_COMPLETE,this.onTimelineTweenCompleteHandler);
      }
      
      public function playShowTween() : void
      {
         var _loc1_:String = this._tweenState;
         switch(this._tweenState)
         {
            case VehicleMarkersConstants.HB_ANIMATED_INACTIVE_STATE:
               visible = true;
               this._tweenState = SHOW_STATE;
               break;
            case ACTIVE_STATE:
               this.onTweenComplete(true);
               break;
            case HIDE_STATE:
               this._tweenState = SHOW_STATE;
         }
         if(_loc1_ != this._tweenState)
         {
            this.setState();
         }
      }
      
      public function setAnimationType(param1:String) : void
      {
         if(this.animateMc == null)
         {
            return;
         }
         var _loc2_:String = this._partType == VehicleMarkersConstants.HB_ANIMATED_PART_SPLASH ? VMAtlasItemName.getDamageBarName(param1) : VMAtlasItemName.getHitAnimationName(param1);
         var _loc3_:Point = this._partType == VehicleMarkersConstants.HB_ANIMATED_PART_SPLASH ? DMG_BAR_XY : EXPLOSION_XY;
         var _loc4_:Point = new Point(_loc3_.x,_loc3_.y);
         RootSWFAtlasManager.instance.drawGraphics(ATLAS_CONSTANTS.VEHICLE_MARKER_ATLAS,_loc2_,this.animateMc.graphics,_loc4_);
      }
      
      public function isActive() : Boolean
      {
         return this._tweenState != HIDE_STATE && this._tweenState != VehicleMarkersConstants.HB_ANIMATED_INACTIVE_STATE;
      }
      
      protected function setState() : void
      {
         gotoAndPlay(this._tweenState);
      }
      
      private function addDispatchers() : void
      {
         var _loc1_:int = currentScene.labels[1].frame;
         addFrameScript(_loc1_,this.tweenCompleteDispatchTrue);
         _loc1_ = currentScene.labels[3].frame;
         addFrameScript(_loc1_,this.tweenCompleteDispatchFalse);
      }
      
      private function tweenCompleteDispatchTrue() : void
      {
         stop();
         dispatchEvent(new TimelineEvent(TimelineEvent.TWEEN_COMPLETE,true));
      }
      
      private function tweenCompleteDispatchFalse() : void
      {
         stop();
         dispatchEvent(new TimelineEvent(TimelineEvent.TWEEN_COMPLETE,false));
      }
      
      private function onTweenComplete(param1:Boolean) : void
      {
         if(param1)
         {
            this._tweenState = ACTIVE_STATE;
            if(this._splashTimer)
            {
               this._splashTimer.reset();
            }
            else
            {
               this._splashTimer = new Timer(this._vmManager.splashDuration,1);
               this._splashTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onSplashTimerCompleteHandler,false,0,true);
            }
            this._splashTimer.start();
            dispatchEvent(new Event(SHOW));
         }
         else
         {
            this._tweenState = VehicleMarkersConstants.HB_ANIMATED_INACTIVE_STATE;
            visible = false;
            dispatchEvent(new Event(HIDE));
         }
      }
      
      public function get tweenState() : String
      {
         return this._tweenState;
      }
      
      public function set tweenState(param1:String) : void
      {
         this._tweenState = param1;
      }
      
      public function get partType() : String
      {
         return this._partType;
      }
      
      public function set partType(param1:String) : void
      {
         this._partType = param1;
      }
      
      private function onTimelineTweenCompleteHandler(param1:TimelineEvent) : void
      {
         this.onTweenComplete(param1.isShow);
      }
      
      private function onSplashTimerCompleteHandler(param1:TimerEvent) : void
      {
         this._splashTimer.stop();
         this._splashTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onSplashTimerCompleteHandler);
         this._splashTimer = null;
         this._tweenState = HIDE_STATE;
         gotoAndPlay(this._tweenState);
      }
   }
}
