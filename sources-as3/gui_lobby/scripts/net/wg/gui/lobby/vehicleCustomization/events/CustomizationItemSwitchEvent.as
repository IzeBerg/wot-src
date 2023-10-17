package net.wg.gui.lobby.vehicleCustomization.events
{
   import flash.events.Event;
   
   public class CustomizationItemSwitchEvent extends Event
   {
      
      public static const SELECT_NEXT_ITEM:String = "selectNextItem";
       
      
      private var _reverse:Boolean;
      
      public function CustomizationItemSwitchEvent(param1:String, param2:Boolean = false, param3:Boolean = true, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._reverse = param2;
      }
      
      override public function clone() : Event
      {
         return new CustomizationItemSwitchEvent(type,this._reverse,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("CustomizationItemSwitchEvent","eventType","bubbles","cancelable");
      }
      
      public function get reverse() : Boolean
      {
         return this._reverse;
      }
   }
}
