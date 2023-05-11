package net.wg.gui.battle.mapsTraining.views.prebattleTimer
{
   import net.wg.gui.battle.views.prebattleTimer.PrebattleTimerBg;
   import net.wg.utils.StageSizeBoundaries;
   
   public class MapsTrainingPrebattleTimerBg extends PrebattleTimerBg
   {
      
      private static const SCALE:int = 1;
      
      private static const SCALE_SMALL:Number = 0.6;
       
      
      public function MapsTrainingPrebattleTimerBg()
      {
         super();
      }
      
      override public function updateSize(param1:int, param2:int) : void
      {
         shadow.scaleX = shadow.scaleY = param2 <= StageSizeBoundaries.HEIGHT_800 ? Number(SCALE_SMALL) : Number(SCALE);
      }
   }
}
