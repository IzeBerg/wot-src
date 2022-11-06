package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBCPrebattleHintsMeta extends IEventDispatcher
   {
       
      
      function as_setHintsVisibility(param1:Array, param2:Array) : void;
      
      function as_setCrewCount(param1:int) : void;
   }
}
