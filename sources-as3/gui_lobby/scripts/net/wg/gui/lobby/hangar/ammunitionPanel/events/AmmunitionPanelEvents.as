package net.wg.gui.lobby.hangar.ammunitionPanel.events
{
   import flash.events.Event;
   
   public class AmmunitionPanelEvents extends Event
   {
      
      public static const VEHICLE_STATE_MSG_RESIZE:String = "vehicleStateMsgResize";
      
      public static const NY_BONUS_PANEL_CLICKED:String = "nyBonusPanelCLicked";
       
      
      public function AmmunitionPanelEvents(param1:String)
      {
         super(param1,true,true);
      }
   }
}
