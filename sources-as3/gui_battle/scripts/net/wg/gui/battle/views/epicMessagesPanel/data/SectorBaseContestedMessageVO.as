package net.wg.gui.battle.views.epicMessagesPanel.data
{
   import net.wg.gui.battle.views.gameMessagesPanel.data.BaseGameMessageVO;
   
   public class SectorBaseContestedMessageVO extends BaseGameMessageVO
   {
       
      
      public var baseID:int = -1;
      
      public var progress:Number = 0;
      
      public function SectorBaseContestedMessageVO(param1:Object)
      {
         super(param1);
      }
   }
}
