package net.wg.gui.lobby.vehicleCustomization.events.propertiesSheet
{
   import flash.events.Event;
   
   public class ProjectionControlsEvent extends Event
   {
      
      public static const INTERACTION_STAUTS:String = "interactionStatusChange";
      
      public static const INTERACTION_TYPE:String = "interactionTypeChange";
       
      
      private var _status:Boolean = false;
      
      private var _interactionType:int = -1;
      
      public function ProjectionControlsEvent(param1:String, param2:Boolean, param3:int = -1)
      {
         this._status = param2;
         this._interactionType = param3;
         super(param1,true);
      }
      
      override public function clone() : Event
      {
         return new ProjectionControlsEvent(type,this._status,this._interactionType);
      }
      
      public function get status() : Boolean
      {
         return this._status;
      }
      
      public function get interactionType() : int
      {
         return this._interactionType;
      }
   }
}
