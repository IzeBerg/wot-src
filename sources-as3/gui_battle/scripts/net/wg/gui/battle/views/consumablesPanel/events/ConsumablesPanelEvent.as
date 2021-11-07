package net.wg.gui.battle.views.consumablesPanel.events
{
   import flash.events.Event;
   
   public class ConsumablesPanelEvent extends Event
   {
      
      public static const UPDATE_POSITION:String = "updatePosition";
      
      public static const SWITCH_POPUP:String = "switchPopup";
       
      
      public function ConsumablesPanelEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
