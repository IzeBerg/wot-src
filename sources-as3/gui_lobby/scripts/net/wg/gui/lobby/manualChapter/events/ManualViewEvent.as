package net.wg.gui.lobby.manualChapter.events
{
   import flash.events.Event;
   
   public final class ManualViewEvent extends Event
   {
      
      public static const BOOTCAMP_CLICKED:String = "bootcampCompleted";
       
      
      public function ManualViewEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new ManualViewEvent(type,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("ManualViewEvent","type","bubbles","cancelable");
      }
   }
}
