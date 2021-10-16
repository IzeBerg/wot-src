package net.wg.gui.battle.random.views.stats.components.playersPanel.events
{
   import flash.events.Event;
   
   public class PlayersPanelSwitchEvent extends Event
   {
      
      public static const STATE_REQUESTED:String = "stateChanged";
       
      
      public var state:int = 0;
      
      public function PlayersPanelSwitchEvent(param1:String, param2:int, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.state = param2;
      }
      
      override public function clone() : Event
      {
         return new PlayersPanelSwitchEvent(type,this.state,bubbles,cancelable);
      }
   }
}
