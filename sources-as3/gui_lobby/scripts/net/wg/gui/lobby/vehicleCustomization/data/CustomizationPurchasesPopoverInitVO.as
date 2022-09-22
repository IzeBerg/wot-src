package net.wg.gui.lobby.vehicleCustomization.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class CustomizationPurchasesPopoverInitVO extends DAAPIDataClass
   {
       
      
      public var removeItemIcon:String = "";
      
      public var closeButtonTooltip:String = "";
      
      public var closeBtnLabel:String = "";
      
      public function CustomizationPurchasesPopoverInitVO(param1:Object)
      {
         super(param1);
      }
   }
}
