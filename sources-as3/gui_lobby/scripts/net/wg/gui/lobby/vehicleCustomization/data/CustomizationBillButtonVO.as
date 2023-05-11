package net.wg.gui.lobby.vehicleCustomization.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class CustomizationBillButtonVO extends DAAPIDataClass
   {
       
      
      public var label:String = "";
      
      public var icon:String = "";
      
      public var event:String = "";
      
      public var enabled:Boolean = false;
      
      public function CustomizationBillButtonVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
