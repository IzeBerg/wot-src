package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IHBConsumablesPanelMeta extends IEventDispatcher
   {
       
      
      function as_setShellInfinity(param1:int, param2:Boolean) : void;
      
      function as_addAbilitySlot(param1:int, param2:Number, param3:Number, param4:int, param5:Number, param6:Number, param7:String, param8:String) : void;
      
      function as_updateAbility(param1:int, param2:int, param3:Number, param4:Number) : void;
      
      function as_addPassiveAbilitySlot(param1:int, param2:String, param3:String, param4:String) : void;
      
      function as_updatePassiveAbility(param1:int, param2:String, param3:String) : void;
      
      function as_resetPassiveAbilities(param1:Array) : void;
      
      function as_addRoleAbilitySlot(param1:int, param2:Number, param3:Number, param4:int, param5:Number, param6:Number, param7:String, param8:String) : void;
      
      function as_setRoleAbilityProgress(param1:int, param2:Number) : void;
      
      function as_setRoleAbilityTooltip(param1:int, param2:String) : void;
   }
}
