package net.wg.gui.lobby.fortifications.events
{
   import flash.events.Event;
   import net.wg.gui.lobby.fortifications.cmp.battleRoom.SortieSlot;
   
   public class ClanBattleSlotEvent extends Event
   {
      
      public static const CHOOSE_VEHICLE:String = "ClanBattleSlotEvent.chooseVehicle";
      
      public static const FILTERS_CHANGED:String = "ClanBattleSlotEvent.filtersChanged";
      
      public static const RESET_FILTERS:String = "ClanBattleSlotEvent.resetFilters";
       
      
      private var _filtersValue:int;
      
      public function ClanBattleSlotEvent(param1:String, param2:int = 0, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._filtersValue = param2;
      }
      
      public function get slot() : SortieSlot
      {
         return SortieSlot(target);
      }
      
      public function get filtersValue() : int
      {
         return this._filtersValue;
      }
   }
}
