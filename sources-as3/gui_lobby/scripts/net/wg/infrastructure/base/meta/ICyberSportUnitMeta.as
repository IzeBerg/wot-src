package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ICyberSportUnitMeta extends IEventDispatcher
   {
       
      
      function toggleFreezeRequestS() : void;
      
      function toggleStatusRequestS() : void;
      
      function showSettingsRosterS(param1:Object) : void;
      
      function resultRosterSlotsSettingsS(param1:Array) : void;
      
      function cancelRosterSlotsSettingsS() : void;
      
      function lockSlotRequestS(param1:int) : void;
      
      function as_updateSlotSettings(param1:Array) : void;
      
      function as_closeSlot(param1:uint, param2:uint, param3:String) : void;
      
      function as_openSlot(param1:uint, param2:Boolean, param3:String, param4:uint) : void;
      
      function as_lockUnit(param1:Boolean, param2:Array) : void;
      
      function as_setOpened(param1:Boolean, param2:String) : void;
      
      function as_setTotalLabel(param1:Boolean, param2:String, param3:int) : void;
      
      function as_setPlayerCountLbl(param1:String) : void;
   }
}
