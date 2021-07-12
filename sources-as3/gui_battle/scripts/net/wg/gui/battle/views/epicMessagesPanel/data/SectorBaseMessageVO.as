package net.wg.gui.battle.views.epicMessagesPanel.data
{
   import net.wg.gui.battle.views.gameMessagesPanel.data.BaseGameMessageVO;
   
   public class SectorBaseMessageVO extends BaseGameMessageVO
   {
       
      
      public var baseID:int = -1;
      
      public var timerText:String = "";
      
      public function SectorBaseMessageVO(param1:Object)
      {
         super(param1);
      }
   }
}
