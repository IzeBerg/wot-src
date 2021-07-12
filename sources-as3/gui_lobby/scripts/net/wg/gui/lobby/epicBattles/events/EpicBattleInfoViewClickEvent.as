package net.wg.gui.lobby.epicBattles.events
{
   import flash.events.Event;
   
   public class EpicBattleInfoViewClickEvent extends Event
   {
      
      public static const INFO_BUTTON_CLICK:String = "infoButtonClick";
      
      public static const PRESTIGE_BUTTON_CLICK:String = "prestigeButtonClick";
      
      public static const COMBAT_CONSUMABLES_CLICK:String = "combatConsumablesClick";
       
      
      public function EpicBattleInfoViewClickEvent(param1:String, param2:Boolean = true, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new EpicBattleInfoViewClickEvent(type,bubbles,cancelable);
      }
   }
}
