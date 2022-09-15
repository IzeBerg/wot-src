package net.wg.gui.battle.components
{
   import flash.display.MovieClip;
   import scaleform.gfx.Extensions;
   
   public class BaseProgressCircle extends BattleUIComponent
   {
      
      public static const SEMI_LAST_FRAME:int = 180;
      
      public static const ALLY_STATE:String = "ally";
      
      public static const ENEMY_STATE:String = "enemy";
      
      public static const COLORBLIND_STATE:String = "colorblind";
       
      
      public var progressCircle:MovieClip = null;
      
      protected var curFrame:int = 180;
      
      protected var state:String = "";
      
      protected var colorblindMode:Boolean = false;
      
      public function BaseProgressCircle()
      {
         super();
         Extensions.setEdgeAAMode(this.progressCircle,Extensions.EDGEAA_ON);
         this.state = this.getCorrectState(ENEMY_STATE);
         gotoAndStop(this.state);
         this.progressCircle.gotoAndStop(SEMI_LAST_FRAME);
      }
      
      override protected function onDispose() : void
      {
         this.progressCircle = null;
         super.onDispose();
      }
      
      public function updateProgress(param1:Number) : void
      {
         var _loc2_:int = param1 * SEMI_LAST_FRAME >> 0;
         gotoAndStop(this.state);
         this.progressCircle.gotoAndStop(_loc2_);
      }
      
      protected function getCorrectState(param1:String) : String
      {
         if(param1 == ENEMY_STATE)
         {
            return !!this.colorblindMode ? COLORBLIND_STATE : ENEMY_STATE;
         }
         return ALLY_STATE;
      }
      
      public function set circleState(param1:String) : void
      {
         this.state = param1;
      }
      
      public function set currentProgressFrame(param1:int) : void
      {
         this.curFrame = param1;
      }
   }
}
