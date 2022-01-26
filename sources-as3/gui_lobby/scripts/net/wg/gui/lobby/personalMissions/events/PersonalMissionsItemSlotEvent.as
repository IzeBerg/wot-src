package net.wg.gui.lobby.personalMissions.events
{
   import flash.events.Event;
   
   public class PersonalMissionsItemSlotEvent extends Event
   {
      
      public static const UNLOCK:String = "PersonalMissionsItemSlotEvent_unlock";
      
      public static const CLICK:String = "PersonalMissionsItemSlotEvent_click";
       
      
      private var _vehicleType:String = "";
      
      public function PersonalMissionsItemSlotEvent(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._vehicleType = param2;
      }
      
      override public function clone() : Event
      {
         return new PersonalMissionsItemSlotEvent(type,this._vehicleType,bubbles,cancelable);
      }
      
      public function get vehicleType() : String
      {
         return this._vehicleType;
      }
   }
}
