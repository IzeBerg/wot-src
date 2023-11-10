package net.wg.gui.lobby.browser.events
{
   import flash.events.Event;
   
   public class BrowserActionBtnEvent extends Event
   {
      
      public static const ON_ACTION:String = "onBrowserActionBtnClick";
       
      
      public function BrowserActionBtnEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
