package net.wg.gui.lobby.manualChapter.events
{
   import flash.events.Event;
   
   public final class ManualViewEvent extends Event
   {
      
      public static const BUTTON_CLICKED:String = "buttonClicked";
      
      public static const BUTTON_HIGHLIGHTED:String = "buttonHighlighted";
      
      public static const PREVIEW_CLICKED:String = "previewClicked";
       
      
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
