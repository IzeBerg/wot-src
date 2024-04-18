package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IStorageCarouselEnvironmentMeta extends IEventDispatcher
   {
       
      
      function resetFilterS() : void;
      
      function showItemInfoS(param1:Number) : void;
      
      function changeSearchNameVehicleS(param1:String) : void;
      
      function as_updateSearch(param1:String, param2:String, param3:String, param4:int) : void;
      
      function as_updateCounter(param1:Boolean, param2:String, param3:Boolean) : void;
   }
}
