package net.wg.gui.lobby.vehicleCustomization.data.customizationPanel
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class CustomizationItemVO extends DAAPIDataClass
   {
       
      
      public var id:int = -1;
      
      public var icon:String = "";
      
      public var bonusType:String = "";
      
      public function CustomizationItemVO(param1:Object)
      {
         super(param1);
      }
   }
}
