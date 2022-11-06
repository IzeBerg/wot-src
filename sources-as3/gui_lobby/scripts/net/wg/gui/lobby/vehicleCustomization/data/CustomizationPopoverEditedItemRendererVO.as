package net.wg.gui.lobby.vehicleCustomization.data
{
   public class CustomizationPopoverEditedItemRendererVO extends CustomizationPopoverItemRendererVO
   {
       
      
      public var seasonType:int = -1;
      
      public var isDisabled:Boolean = false;
      
      public var isRemovable:Boolean = false;
      
      public var disabledLabel:String = "";
      
      public var titleLabel:String = "";
      
      public function CustomizationPopoverEditedItemRendererVO(param1:Object)
      {
         super(param1);
      }
   }
}
