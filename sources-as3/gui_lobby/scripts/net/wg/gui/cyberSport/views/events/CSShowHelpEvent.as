package net.wg.gui.cyberSport.views.events
{
   import flash.events.Event;
   
   public class CSShowHelpEvent extends Event
   {
      
      public static const SHOW_HELP:String = "CSShowHelpEvent";
       
      
      public var helpId:String;
      
      public function CSShowHelpEvent(param1:String)
      {
         super(SHOW_HELP,true);
         this.helpId = param1;
      }
   }
}
