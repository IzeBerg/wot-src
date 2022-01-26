package net.wg.gui.lobby.vehicleCustomization.events
{
   import flash.events.Event;
   
   public class CustomizationStyleInfoEvent extends Event
   {
      
      public static const SHOW_STYLE_INFO:String = "showStyleInfo";
      
      public static const HIDE_STYLE_INFO:String = "hideStyleInfo";
      
      public static const CLOSE_STYLE_INFO:String = "closeStyleInfo";
      
      public static const APPLY_STYLE:String = "applyStyle";
       
      
      public function CustomizationStyleInfoEvent(param1:String, param2:Boolean = true, param3:Boolean = true)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new CustomizationStyleInfoEvent(type,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("CustomizationStyleInfoEvent","type","bubbles","cancelable");
      }
   }
}
