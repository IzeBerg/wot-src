package net.wg.gui.battle.views.staticMarkers.commander.teamBase
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.components.BattleUIComponent;
   import scaleform.gfx.Extensions;
   
   public class TeamBaseProgressCircle extends BattleUIComponent
   {
      
      public static const SEMI_LAST_FRAME:int = 180;
      
      public static const ALLY_STATE:String = "ally";
      
      public static const ENEMY_STATE:String = "enemy";
      
      public static const NEUTRAL_STATE:String = "neutral";
       
      
      public var progressCircle:MovieClip = null;
      
      private var _capturingActive:Boolean = false;
      
      private var _state:String = "";
      
      public function TeamBaseProgressCircle()
      {
         super();
         Extensions.setEdgeAAMode(this.progressCircle,Extensions.EDGEAA_ON);
         this.setState(NEUTRAL_STATE);
      }
      
      override protected function onDispose() : void
      {
         this.progressCircle = null;
         super.onDispose();
      }
      
      public function setState(param1:String) : void
      {
         this._state = param1;
         gotoAndStop(this._state);
         this._capturingActive = false;
         this.progressCircle.gotoAndStop(SEMI_LAST_FRAME);
      }
      
      public function updateProgress(param1:String, param2:Number) : void
      {
         var _loc3_:int = param2 * SEMI_LAST_FRAME;
         this._capturingActive = _loc3_ > 0;
         if(this._capturingActive)
         {
            if(currentFrameLabel != param1)
            {
               gotoAndStop(param1);
            }
            this.progressCircle.gotoAndStop(_loc3_);
         }
         else
         {
            gotoAndStop(this._state);
            this.progressCircle.gotoAndStop(SEMI_LAST_FRAME);
         }
      }
   }
}
