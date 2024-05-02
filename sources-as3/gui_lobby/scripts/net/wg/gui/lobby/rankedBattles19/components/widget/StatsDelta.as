package net.wg.gui.lobby.rankedBattles19.components.widget
{
   import net.wg.gui.lobby.rankedBattles19.components.stats.RankedBattleStatsDelta;
   
   public class StatsDelta extends RankedBattleStatsDelta
   {
       
      
      public function StatsDelta()
      {
         super();
      }
      
      override public function layoutDelta() : void
      {
         deltaTf.x = -(deltaTf.width >> 1);
         deltaTf.y = valueTf.y + valueTf.height + labelYOffset | 0;
      }
   }
}
