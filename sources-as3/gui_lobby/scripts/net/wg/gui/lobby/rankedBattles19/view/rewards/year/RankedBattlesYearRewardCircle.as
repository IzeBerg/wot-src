package net.wg.gui.lobby.rankedBattles19.view.rewards.year
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class RankedBattlesYearRewardCircle extends MovieClip implements IDisposable
   {
      
      private static const LABEL_SHOW:String = "show";
      
      private static const LABEL_HIDE:String = "hide";
       
      
      public var hitMc:Sprite = null;
      
      private var _state:String = "";
      
      public function RankedBattlesYearRewardCircle()
      {
         super();
         hitArea = this.hitMc;
         mouseChildren = false;
      }
      
      public final function dispose() : void
      {
         stop();
         hitArea = null;
         this.hitMc = null;
      }
      
      public function hide() : void
      {
         this.stateChange(LABEL_HIDE);
      }
      
      public function show() : void
      {
         this.stateChange(LABEL_SHOW);
      }
      
      private function stateChange(param1:String) : void
      {
         if(this._state == param1)
         {
            return;
         }
         this._state = param1;
         gotoAndPlay(param1);
      }
   }
}
