package net.wg.gui.lobby.eventBattleResult.components
{
   import flash.display.MovieClip;
   
   public class ResultAppearMovieClip extends MovieClip
   {
      
      public static const APPEAR:String = "appear";
      
      public static const IDLE:String = "idle";
       
      
      public function ResultAppearMovieClip()
      {
         super();
      }
      
      public function appear() : void
      {
         gotoAndPlay(APPEAR);
      }
      
      public function immediateAppear() : void
      {
         gotoAndStop(IDLE);
      }
   }
}
