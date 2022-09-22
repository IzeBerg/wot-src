package net.wg.gui.lobby.vehicleCompare.events
{
   import flash.events.Event;
   
   public class VehConfSkillDropDownEvent extends Event
   {
      
      public static const CREW_LEVEL_CHANGED:String = "crewLevelChanged";
       
      
      private var _crewLevel:int;
      
      public function VehConfSkillDropDownEvent(param1:String, param2:int, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._crewLevel = param2;
      }
      
      public function get crewLevel() : int
      {
         return this._crewLevel;
      }
   }
}
