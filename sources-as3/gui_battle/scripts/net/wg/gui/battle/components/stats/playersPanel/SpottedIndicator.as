package net.wg.gui.battle.components.stats.playersPanel
{
   import flash.display.MovieClip;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class SpottedIndicator extends BattleUIComponent
   {
      
      private static const SPOTTED_TIMELINE_STATE:String = "spotted";
      
      private static const UNSPOTTED_TIMELINE_STATE:String = "unspotted";
      
      private static const SPOTTED_STATUS:uint = 1;
      
      private static const UNSPOTTED_STATUS:uint = 2;
       
      
      public var spottedState:MovieClip = null;
      
      public var animation:MovieClip = null;
      
      private var _spotState:String = "";
      
      private var _animationAlreadyPlayed:Boolean = false;
      
      private var _shouldBeShown:Boolean = true;
      
      public function SpottedIndicator()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         visible = false;
      }
      
      override protected function onDispose() : void
      {
         this.animation.stop();
         this.animation = null;
         this.spottedState = null;
         super.onDispose();
      }
      
      public function updateSpottedStatus(param1:uint) : void
      {
         var _loc2_:String = this.getTimeLineStateForSpottingStatus(param1);
         if(_loc2_ == this._spotState)
         {
            return;
         }
         this._spotState = _loc2_;
         this.updateVisibility();
         if(!this._animationAlreadyPlayed && (param1 & SPOTTED_STATUS) > 0)
         {
            this.animation.play();
            this._animationAlreadyPlayed = true;
         }
         if(this._spotState != Values.EMPTY_STR)
         {
            this.spottedState.gotoAndStop(this._spotState);
         }
      }
      
      private function getTimeLineStateForSpottingStatus(param1:uint) : String
      {
         if((param1 & SPOTTED_STATUS) > 0)
         {
            return SPOTTED_TIMELINE_STATE;
         }
         if((param1 & UNSPOTTED_STATUS) > 0)
         {
            return UNSPOTTED_TIMELINE_STATE;
         }
         return Values.EMPTY_STR;
      }
      
      private function updateVisibility() : void
      {
         var _loc1_:Boolean = this._shouldBeShown && this._spotState != Values.EMPTY_STR;
         if(_loc1_ && !visible)
         {
            visible = true;
         }
         else if(!_loc1_)
         {
            visible = false;
         }
      }
      
      public function set shouldBeShown(param1:Boolean) : void
      {
         if(param1 == this._shouldBeShown)
         {
            return;
         }
         this._shouldBeShown = param1;
         this.updateVisibility();
      }
   }
}
