package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IVehicleModulesViewMeta extends IEventDispatcher
   {
       
      
      function onModuleHoverS(param1:Number) : void;
      
      function onModuleClickS(param1:Number) : void;
      
      function as_setItem(param1:String, param2:Object) : void;
      
      function as_setNodesStates(param1:Array) : void;
   }
}
