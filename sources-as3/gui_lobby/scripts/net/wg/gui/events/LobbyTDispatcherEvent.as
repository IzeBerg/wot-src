package net.wg.gui.events
{
   import flash.events.Event;
   
   public class LobbyTDispatcherEvent extends Event
   {
      
      public static const TUTORIAL_DISPATCHER_RESTART:String = "tutorialRestart";
      
      public static const TUTORIAL_DISPATCHER_REFUSE:String = "tutorialRefuse";
       
      
      public function LobbyTDispatcherEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
