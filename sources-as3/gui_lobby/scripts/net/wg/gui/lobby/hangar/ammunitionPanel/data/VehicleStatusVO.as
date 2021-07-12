package net.wg.gui.lobby.hangar.ammunitionPanel.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VehicleStatusVO extends DAAPIDataClass
   {
       
      
      public var isElite:Boolean = false;
      
      public var tankType:String = "";
      
      public var vehicleLevel:String = "";
      
      public var vehicleName:String = "";
      
      public var message:String = "";
      
      public var rentAvailable:Boolean = false;
      
      public var roleId:int = -1;
      
      public var roleMessage:String = "";
      
      public function VehicleStatusVO(param1:Object)
      {
         super(param1);
      }
   }
}
