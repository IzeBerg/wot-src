package net.wg.gui.battle.commander.views.spawnMenu.map.VO
{
   public class VehicleEntryVO extends BaseEntryVO
   {
       
      
      public var vehicleID:int = 0;
      
      public var vehicleName:String = "";
      
      public var vehicleType:String = "";
      
      public var isSelected:Boolean = false;
      
      public var visionRadius:int = 0;
      
      public var engagementRadius:int = 0;
      
      public var yawLeftLimit:Number = 0.0;
      
      public var yawRightLimit:Number = 0.0;
      
      public function VehicleEntryVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
