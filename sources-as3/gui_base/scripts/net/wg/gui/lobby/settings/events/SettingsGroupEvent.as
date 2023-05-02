package net.wg.gui.lobby.settings.events
{
   import flash.events.Event;
   
   public class SettingsGroupEvent extends Event
   {
      
      public static var ON_GROUP_STATE_CHANGE:String = "on_group_state_changed";
       
      
      public function SettingsGroupEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
