package net.wg.gui.lobby.epicBattles.components.afterBattle
{
   import flash.display.MovieClip;
   import net.wg.gui.lobby.components.IconTextWrapper;
   
   public class EpicBattlesFamePointsCounter extends MovieClip
   {
      
      private static const HIDDEN_STATE:String = "hidden";
      
      private static const SHOW_STATE:String = "showPoints";
      
      private static const VISIBLE_STATE:String = "visible";
       
      
      public var famePointsElement:IconTextWrapper = null;
      
      private var _state:String = "";
      
      public function EpicBattlesFamePointsCounter()
      {
         super();
      }
      
      public function animate() : void
      {
         this.setState(SHOW_STATE);
      }
      
      public final function dispose() : void
      {
         stop();
         this.famePointsElement.dispose();
         this.famePointsElement = null;
      }
      
      public function hide() : void
      {
         this.setState(HIDDEN_STATE);
      }
      
      public function setFamePoints(param1:String) : void
      {
         this.famePointsElement.setHtmlText(param1);
         this.famePointsElement.validateNow();
      }
      
      public function show() : void
      {
         this.setState(VISIBLE_STATE);
      }
      
      private function setState(param1:String) : void
      {
         if(param1 == this._state)
         {
            return;
         }
         this._state = param1;
         gotoAndPlay(param1);
      }
   }
}
