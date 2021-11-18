package net.wg.gui.lobby.missions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class MissionVehicleItemRendererVO extends DAAPIDataClass
   {
       
      
      public var nationIcon:String = "";
      
      public var typeIcon:String = "";
      
      public var levelIcon:String = "";
      
      public var vehicleIcon:String = "";
      
      public var vehicleName:String = "";
      
      public function MissionVehicleItemRendererVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
