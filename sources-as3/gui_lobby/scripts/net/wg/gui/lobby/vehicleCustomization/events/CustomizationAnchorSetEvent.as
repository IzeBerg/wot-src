package net.wg.gui.lobby.vehicleCustomization.events
{
   import flash.events.Event;
   
   public class CustomizationAnchorSetEvent extends Event
   {
      
      public static var ANCHORS_FILLED:String = "anchorsFilled";
       
      
      private var _anchors:Array = null;
      
      public function CustomizationAnchorSetEvent(param1:String, param2:Array)
      {
         super(param1,bubbles,cancelable);
         this._anchors = param2;
      }
      
      override public function clone() : Event
      {
         return new CustomizationAnchorSetEvent(type,this._anchors);
      }
      
      public function get anchors() : Array
      {
         return this._anchors;
      }
   }
}
