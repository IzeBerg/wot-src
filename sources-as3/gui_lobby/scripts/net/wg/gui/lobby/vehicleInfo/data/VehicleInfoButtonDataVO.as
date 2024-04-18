package net.wg.gui.lobby.vehicleInfo.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VehicleInfoButtonDataVO extends DAAPIDataClass
   {
       
      
      public var label:String = "";
      
      public var tooltip:String = "";
      
      public var visible:Boolean = false;
      
      public var enabled:Boolean = false;
      
      public var isNew:Boolean = false;
      
      public function VehicleInfoButtonDataVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
