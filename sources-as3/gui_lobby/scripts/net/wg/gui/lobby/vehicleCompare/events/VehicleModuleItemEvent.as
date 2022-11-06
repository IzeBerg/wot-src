package net.wg.gui.lobby.vehicleCompare.events
{
   import flash.events.Event;
   
   public class VehicleModuleItemEvent extends Event
   {
      
      public static const MODULE_ITEM_HOVERED:String = "ModuleItemHoveredEvent";
      
      public static const MODULE_ITEM_CLICKED:String = "ModuleItemClickedEvent";
       
      
      private var _id:Number = 0;
      
      public function VehicleModuleItemEvent(param1:String, param2:Number)
      {
         super(param1);
         this._id = param2;
      }
      
      public function get id() : Number
      {
         return this._id;
      }
   }
}
