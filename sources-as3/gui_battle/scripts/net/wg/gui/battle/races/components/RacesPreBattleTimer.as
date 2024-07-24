package net.wg.gui.battle.races.components
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.components.preBattleTimer.PreBattleTimerEvent;
   import net.wg.infrastructure.base.meta.impl.RacesPrebattleTimerMeta;
   
   public class RacesPreBattleTimer extends RacesPrebattleTimerMeta
   {
      
      private static const TOTAL_LIGHTS:int = 4;
      
      private static const LIGHTS_FRAME_SHIFT:int = 2;
      
      private static const BLUE_LIGHTS:String = "blueLights";
      
      private static const RED_LIGHTS:String = "redLights";
      
      private static const HIDE_ANIM_LABEL:String = "startHiding";
      
      private static const GREEN_LIGHTS_LABEL:String = "greenLights";
       
      
      public var trafficLight:MovieClip = null;
      
      private var _blueLights:MovieClip = null;
      
      private var _redLights:MovieClip = null;
      
      private var _isTimerFinished:Boolean = false;
      
      private var _startHiding:Boolean;
      
      public function RacesPreBattleTimer()
      {
         super();
         this._blueLights = MovieClip(this.trafficLight.getChildByName(BLUE_LIGHTS));
         this._blueLights.visible = false;
         this._redLights = MovieClip(this.trafficLight.getChildByName(RED_LIGHTS));
         isNeedWinChangePosition = false;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         timer.addEventListener(PreBattleTimerEvent.SHOWN,this.onTimerUpdated);
         timer.addEventListener(PreBattleTimerEvent.HIDDEN,this.onTimerDigitHidden);
      }
      
      override protected function doResetHideAnim() : void
      {
         super.doResetHideAnim();
         this.trafficLight.gotoAndStop(1);
         this._blueLights.gotoAndStop(1);
         this._redLights.gotoAndStop(1);
         this._startHiding = false;
      }
      
      private function onTimerUpdated(param1:PreBattleTimerEvent) : void
      {
         this.updateTrafficLight(param1.digitID);
      }
      
      private function onTimerDigitHidden(param1:PreBattleTimerEvent) : void
      {
         if(totalTime == 0)
         {
            this.updateTrafficLight(totalTime);
         }
      }
      
      override public function as_setTimer(param1:int) : void
      {
         super.as_setTimer(param1);
         if(param1 == 0 && !_isCompVisible)
         {
            this._isTimerFinished = true;
         }
      }
      
      private function updateTrafficLight(param1:int) : void
      {
         if(this._startHiding)
         {
            return;
         }
         if(!_isCompVisible)
         {
            return;
         }
         if(totalTime > TOTAL_LIGHTS)
         {
            this.trafficLight.gotoAndStop(1);
            return;
         }
         var _loc2_:int = TOTAL_LIGHTS - param1 + LIGHTS_FRAME_SHIFT;
         this._blueLights.gotoAndStop(_loc2_);
         this._redLights.gotoAndStop(_loc2_);
         onFirstLightS();
         if(param1 == 0)
         {
            if(this._isTimerFinished)
            {
               this.trafficLight.gotoAndStop(GREEN_LIGHTS_LABEL);
            }
            else
            {
               this.trafficLight.gotoAndStop(HIDE_ANIM_LABEL);
            }
         }
      }
      
      override protected function hideComponent(param1:Boolean) : void
      {
         super.hideComponent(param1);
         this.trafficLight.gotoAndPlay(GREEN_LIGHTS_LABEL);
         this._startHiding = true;
         onLastLightsS();
      }
      
      override protected function doComponentVisibility(param1:Boolean) : void
      {
         super.doComponentVisibility(param1);
         this.trafficLight.visible = param1;
      }
      
      public function as_setColorBlind(param1:Boolean) : void
      {
         this._blueLights.visible = param1;
         this._redLights.visible = !param1;
      }
      
      override protected function onDispose() : void
      {
         timer.removeEventListener(PreBattleTimerEvent.SHOWN,this.onTimerUpdated);
         timer.removeEventListener(PreBattleTimerEvent.HIDDEN,this.onTimerDigitHidden);
         this.trafficLight = null;
         this._blueLights = null;
         this._redLights = null;
         super.onDispose();
      }
   }
}
