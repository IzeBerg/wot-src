package net.wg.gui.components.advanced.events
{
   import flash.events.Event;
   
   public class TutorialHelpBtnEvent extends Event
   {
      
      public static const HELP_CLICK:String = "helpClick";
       
      
      public function TutorialHelpBtnEvent(param1:String)
      {
         super(param1,true,true);
      }
   }
}
