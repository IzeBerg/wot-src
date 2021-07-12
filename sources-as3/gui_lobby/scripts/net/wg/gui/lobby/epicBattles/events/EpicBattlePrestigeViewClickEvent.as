package net.wg.gui.lobby.epicBattles.events
{
   import flash.events.Event;
   
   public class EpicBattlePrestigeViewClickEvent extends Event
   {
      
      public static const CANCEL_BUTTON_CLICKED:String = "cancelButtonClicked";
      
      public static const RESET_BUTTON_CLICKED:String = "resetButtonClicked";
       
      
      public function EpicBattlePrestigeViewClickEvent(param1:String, param2:Boolean = true, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new EpicBattlePrestigeViewClickEvent(type,bubbles,cancelable);
      }
   }
}
