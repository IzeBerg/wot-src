package net.wg.gui.lobby.shop.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VehicleSellConfirmationPopoverVO extends DAAPIDataClass
   {
       
      
      public var titleLabel:String = "";
      
      public var priceLabel:String = "";
      
      public var priceValue:int = -1;
      
      public function VehicleSellConfirmationPopoverVO(param1:Object)
      {
         super(param1);
      }
   }
}
