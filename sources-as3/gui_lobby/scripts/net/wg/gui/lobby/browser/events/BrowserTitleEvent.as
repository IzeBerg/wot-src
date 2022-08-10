package net.wg.gui.lobby.browser.events
{
   import flash.events.Event;
   
   public class BrowserTitleEvent extends Event
   {
      
      public static const TITLE_CHANGE:String = "titleChange";
       
      
      public var title:String;
      
      public function BrowserTitleEvent(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.title = param2;
      }
   }
}
