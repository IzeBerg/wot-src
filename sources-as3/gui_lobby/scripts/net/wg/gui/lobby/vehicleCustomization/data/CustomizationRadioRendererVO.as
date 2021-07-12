package net.wg.gui.lobby.vehicleCustomization.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class CustomizationRadioRendererVO extends DAAPIDataClass
   {
       
      
      public var label:String = "";
      
      public var tooltip:String = "";
      
      public var tooltipDisabled:String = "";
      
      public var enabled:Boolean = true;
      
      public function CustomizationRadioRendererVO(param1:Object)
      {
         super(param1);
      }
   }
}
