package net.wg.gui.bootcamp.battleResult.containers.stats
{
   import net.wg.gui.bootcamp.battleResult.containers.base.BattleResultGroupLayout;
   
   public class StatsGroupLayout extends BattleResultGroupLayout
   {
       
      
      public function StatsGroupLayout(param1:int = 0, param2:int = 0)
      {
         super(param1,param2);
      }
      
      override protected function startPos() : int
      {
         return 0;
      }
      
      override protected function shift() : int
      {
         return gap;
      }
   }
}
