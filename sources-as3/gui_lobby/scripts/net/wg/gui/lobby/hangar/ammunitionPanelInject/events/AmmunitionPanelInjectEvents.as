package net.wg.gui.lobby.hangar.ammunitionPanelInject.events
{
   import flash.events.Event;
   
   public class AmmunitionPanelInjectEvents extends Event
   {
      
      public static const HELP_LAYOUT_CHANGED:String = "helpLayoutChanged";
       
      
      public function AmmunitionPanelInjectEvents(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
