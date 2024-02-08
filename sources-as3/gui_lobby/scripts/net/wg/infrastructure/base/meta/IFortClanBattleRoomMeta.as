package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IFortClanBattleRoomMeta extends IEventDispatcher
   {
       
      
      function onTimerAlertS() : void;
      
      function openConfigureWindowS() : void;
      
      function toggleRoomStatusS() : void;
      
      function onFiltersChangeS(param1:int, param2:int) : void;
      
      function resetFiltersS(param1:int) : void;
      
      function onUnfrozenVehicleSlotClickS(param1:int) : void;
      
      function as_updateTeamHeaderText(param1:String) : void;
      
      function as_setBattleRoomData(param1:Object) : void;
      
      function as_updateReadyStatus(param1:Boolean, param2:Boolean) : void;
      
      function as_updateReadyDirections(param1:Boolean) : void;
      
      function as_setConfigureButtonState(param1:Object) : void;
      
      function as_setTimerDelta(param1:Object) : void;
      
      function as_setDirection(param1:String, param2:Boolean) : void;
      
      function as_setReservesEnabled(param1:Array) : void;
      
      function as_setReservesData(param1:Array) : void;
      
      function as_setOpened(param1:String, param2:String, param3:String) : void;
      
      function as_setTableHeader(param1:Array) : void;
      
      function as_setFiltersData(param1:Object) : void;
   }
}
