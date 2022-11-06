package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IVehModulesConfiguratorCmpMeta extends IEventDispatcher
   {
       
      
      function onClickS(param1:int, param2:int, param3:int) : void;
      
      function as_setItems(param1:Array) : void;
      
      function as_updateItems(param1:Array) : void;
   }
}
