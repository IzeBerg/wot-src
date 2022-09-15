package net.wg.gui.lobby.storage.categories.storage.vehicleSelectPopover
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VehicleSelectPopoverItemVO extends DAAPIDataClass
   {
       
      
      public var shortUserName:String = "";
      
      public var typeIcon:String = "";
      
      public var level:int = -1;
      
      public var nationIcon:String = "";
      
      public var intCD:int = -1;
      
      public var smallIconPath:String = "";
      
      public var nationID:int = -1;
      
      public var type:String = "";
      
      public function VehicleSelectPopoverItemVO(param1:Object)
      {
         super(param1);
      }
   }
}
