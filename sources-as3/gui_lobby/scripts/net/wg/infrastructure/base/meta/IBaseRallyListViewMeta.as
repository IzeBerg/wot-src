package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBaseRallyListViewMeta extends IEventDispatcher
   {
       
      
      function getRallyDetailsS(param1:int) : Object;
      
      function as_selectByIndex(param1:int) : void;
      
      function as_selectByID(param1:Number) : void;
      
      function as_getSearchDP() : Object;
      
      function as_setDetails(param1:Object) : void;
      
      function as_setVehiclesTitle(param1:String) : void;
   }
}
