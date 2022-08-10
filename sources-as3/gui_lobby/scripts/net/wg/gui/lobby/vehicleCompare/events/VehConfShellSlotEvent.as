package net.wg.gui.lobby.vehicleCompare.events
{
   import flash.events.Event;
   
   public class VehConfShellSlotEvent extends Event
   {
      
      public static const SHELL_SLOT_CLICK:String = "shellSlotClick";
       
      
      private var _shellId:String;
      
      private var _slotIndex:int;
      
      public function VehConfShellSlotEvent(param1:String, param2:String, param3:int, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this._shellId = param2;
         this._slotIndex = param3;
      }
      
      public function get shellId() : String
      {
         return this._shellId;
      }
      
      public function get slotIndex() : int
      {
         return this._slotIndex;
      }
   }
}
