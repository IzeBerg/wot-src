package net.wg.gui.lobby.vehicleCustomization.data.propertiesSheet
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class CustomizationPropertiesSheetButtonsBlockVO extends DAAPIDataClass
   {
       
      
      public var label:String = "";
      
      public var paletteIcon:String = "";
      
      public var selected:Boolean = false;
      
      public var enable:Boolean = true;
      
      public var value:Number = -1;
      
      public function CustomizationPropertiesSheetButtonsBlockVO(param1:Object)
      {
         super(param1);
      }
   }
}
