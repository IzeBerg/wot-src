package net.wg.gui.lobby.vehicleCustomization.data
{
   import net.wg.gui.lobby.window.ConfirmItemWindowVO;
   
   public class ConfirmCustomizationItemDialogVO extends ConfirmItemWindowVO
   {
      
      private static const SMALL_SLOT_VO:String = "smallSlotVO";
       
      
      public var smallSlotVO:SmallSlotVO = null;
      
      public var countLabel:String = "";
      
      public function ConfirmCustomizationItemDialogVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == SMALL_SLOT_VO && param2 != null)
         {
            this.smallSlotVO = new SmallSlotVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.smallSlotVO != null)
         {
            this.smallSlotVO.dispose();
            this.smallSlotVO = null;
         }
         super.onDispose();
      }
   }
}
