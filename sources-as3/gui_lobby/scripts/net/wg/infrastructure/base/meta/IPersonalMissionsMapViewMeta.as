package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IPersonalMissionsMapViewMeta extends IEventDispatcher
   {
       
      
      function onRegionClickS(param1:Number) : void;
      
      function as_setPlanData(param1:Object) : void;
      
      function as_getPmType() : int;
   }
}
