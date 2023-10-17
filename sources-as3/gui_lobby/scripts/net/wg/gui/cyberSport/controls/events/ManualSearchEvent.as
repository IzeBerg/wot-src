package net.wg.gui.cyberSport.controls.events
{
   import flash.events.Event;
   
   public class ManualSearchEvent extends Event
   {
      
      public static const DATA_UPDATED:String = "dataUpdated";
       
      
      public function ManualSearchEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new ManualSearchEvent(type,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("ManualSearchEvent","type","bubbles","cancelable");
      }
   }
}
