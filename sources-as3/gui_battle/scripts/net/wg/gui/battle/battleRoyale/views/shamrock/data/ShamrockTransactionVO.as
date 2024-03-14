package net.wg.gui.battle.battleRoyale.views.shamrock.data
{
   public class ShamrockTransactionVO
   {
       
      
      public var amount:int = -1;
      
      public var newTotal:int = -1;
      
      public var fromTeammate:Boolean = false;
      
      public function ShamrockTransactionVO(param1:int, param2:int, param3:Boolean)
      {
         super();
         this.amount = param1;
         this.newTotal = param2;
         this.fromTeammate = param3;
      }
   }
}
