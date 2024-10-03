package net.wg.white_tiger.gui.lobby.battleQueue.data
{
   public class BossQuickStartPanelVO extends QuickStartPanelVO
   {
       
      
      public var ticketsToDraw:uint = 0;
      
      public var vehName:String = "";
      
      public var vehID:int = -1;
      
      public function BossQuickStartPanelVO(param1:Object = null)
      {
         super(param1);
      }
      
      public function get isBonus() : Boolean
      {
         return this.ticketsToDraw == 0;
      }
   }
}
