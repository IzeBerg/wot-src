package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IIngameDetailsHelpWindowMeta extends IEventDispatcher
   {
       
      
      function requestPageDataS(param1:int) : void;
      
      function as_setPaginatorData(param1:Array) : void;
      
      function as_setPageData(param1:Object) : void;
   }
}
