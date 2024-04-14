package net.wg.gui.lobby.browser.events
{
   import flash.events.Event;
   
   public class BrowserEvent extends Event
   {
      
      public static const LOADING_STARTED:String = "loadingStarted";
      
      public static const LOADING_STOPPED:String = "loadingStopped";
      
      public static const SERVICE_VIEW_SHOWED:String = "serviceViewShowed";
      
      public static const SERVICE_VIEW_HIDDEN:String = "serviceViewHidden";
       
      
      public function BrowserEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
