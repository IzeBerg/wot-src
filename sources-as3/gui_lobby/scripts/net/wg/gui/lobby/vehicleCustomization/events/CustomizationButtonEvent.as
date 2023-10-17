package net.wg.gui.lobby.vehicleCustomization.events
{
   import flash.events.Event;
   
   public class CustomizationButtonEvent extends Event
   {
      
      public static const BUTTON_PRESSED:String = "buttonPressed";
       
      
      private var _name:String = "";
      
      public function CustomizationButtonEvent(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._name = param2;
      }
      
      public function get name() : String
      {
         return this._name;
      }
   }
}
