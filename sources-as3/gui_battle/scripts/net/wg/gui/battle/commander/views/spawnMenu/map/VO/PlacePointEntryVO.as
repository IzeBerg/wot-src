package net.wg.gui.battle.commander.views.spawnMenu.map.VO
{
   public class PlacePointEntryVO extends BaseEntryVO
   {
       
      
      public var vehicleType:String = "";
      
      public var visionRadius:int = 0;
      
      public var engagementRadius:int = 0;
      
      public var yawLeftLimit:Number = 0.0;
      
      public var yawRightLimit:Number = 0.0;
      
      public function PlacePointEntryVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
