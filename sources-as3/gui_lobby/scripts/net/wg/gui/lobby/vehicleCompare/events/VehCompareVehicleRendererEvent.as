package net.wg.gui.lobby.vehicleCompare.events
{
   import flash.events.Event;
   
   public class VehCompareVehicleRendererEvent extends Event
   {
      
      public static const GO_TO_PREVIEW_CLICK:String = "GoToPreviewClick";
      
      public static const GO_TO_HANGAR_CLICK:String = "GoToHangarClick";
      
      public static const MODULES_CLICK:String = "ModulesClick";
      
      public static const REMOVE_CLICK:String = "RemoveClick";
      
      public static const REVERT_CLICK:String = "RevertClick";
      
      public static const RIGHT_CLICK:String = "RRightClick";
      
      public static const CREW_LEVEL_CHANGED:String = "CrewLevelChanged";
       
      
      public var vehId:int = -1;
      
      public var crewLevelId:int = -1;
      
      public var index:int = -1;
      
      public function VehCompareVehicleRendererEvent(param1:int, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         super(param2,param3,param4);
         this.vehId = param1;
      }
   }
}
