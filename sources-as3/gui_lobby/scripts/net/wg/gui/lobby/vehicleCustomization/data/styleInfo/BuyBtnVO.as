package net.wg.gui.lobby.vehicleCustomization.data.styleInfo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BuyBtnVO extends DAAPIDataClass
   {
       
      
      public var enabled:Boolean = true;
      
      public var label:String = "";
      
      public var disabledTooltip:String = "";
      
      public var visible:Boolean = false;
      
      public function BuyBtnVO(param1:Object)
      {
         super(param1);
      }
   }
}
