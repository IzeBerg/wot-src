package net.wg.gui.cyberSport.vo
{
   import net.wg.gui.rally.vo.VehicleAlertVO;
   
   public class VehicleSelectorItemVO extends VehicleAlertVO
   {
       
      
      public var nationOrderIdx:int = -1;
      
      public var selected:Boolean;
      
      public var oldPriceText:String = "";
      
      public var priceText:String = "";
      
      public var discountText:String = "";
      
      public var price:int = -1;
      
      public function VehicleSelectorItemVO(param1:Object)
      {
         super(param1);
      }
   }
}
