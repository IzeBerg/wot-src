package net.wg.gui.lobby.components.data
{
   import net.wg.gui.components.controls.VO.SlotVO;
   
   public class BoosterSlotVO extends SlotVO
   {
       
      
      public var boosterId:Number = -1;
      
      public var qualityIconSrc:String = "";
      
      public var showLeftTime:Boolean = false;
      
      public var leftTimeText:String = "";
      
      public var isEmpty:Boolean = true;
      
      public var countText:String = "";
      
      public var showCount:Boolean = false;
      
      public var slotLinkage:String = "";
      
      public function BoosterSlotVO(param1:Object)
      {
         super(param1);
      }
   }
}
