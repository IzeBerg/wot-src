package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEpicBattleConsumablesPanelMeta extends IEventDispatcher
   {
       
      
      function as_addEpicBattleEquipmentSlot(param1:int, param2:Number, param3:Number, param4:int, param5:Number, param6:Number, param7:String, param8:Boolean, param9:String, param10:int) : void;
      
      function as_updateLockedInformation(param1:int, param2:int, param3:String, param4:Boolean) : void;
      
      function as_updateLevelInformation(param1:int, param2:int) : void;
      
      function as_showPossibleStacks(param1:int, param2:int) : void;
      
      function as_updateStacks(param1:int, param2:int) : void;
   }
}
