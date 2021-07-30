package net.wg.gui.lobby.vehicleCustomization.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class CustomizationItemIconRendererVO extends DAAPIDataClass
   {
       
      
      public var id:int = -1;
      
      public var icon:String = "";
      
      public var isWide:Boolean = false;
      
      public var customizationDisplayType:int = 0;
      
      public function CustomizationItemIconRendererVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
