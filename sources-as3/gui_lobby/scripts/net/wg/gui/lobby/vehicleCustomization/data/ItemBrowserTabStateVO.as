package net.wg.gui.lobby.vehicleCustomization.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ItemBrowserTabStateVO extends DAAPIDataClass
   {
       
      
      public var tabIndex:int = -1;
      
      public var tooltip:String = "";
      
      public function ItemBrowserTabStateVO(param1:Object)
      {
         super(param1);
      }
   }
}
