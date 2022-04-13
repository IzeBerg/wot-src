package net.wg.gui.battle.commander.views.vehicleSelection.events
{
   import flash.events.Event;
   
   public class RTSVehicleSelectionEvent extends Event
   {
      
      public static const VEHICLE_SELECTION_VISIBILITY_CHANGE:String = "vehicleSelectionVisibilityChange";
       
      
      private var _isSelectionActive:Boolean = false;
      
      public function RTSVehicleSelectionEvent(param1:String, param2:Boolean)
      {
         super(param1,true);
         this._isSelectionActive = param2;
      }
      
      public function get isSelectionActive() : Boolean
      {
         return this._isSelectionActive;
      }
   }
}
