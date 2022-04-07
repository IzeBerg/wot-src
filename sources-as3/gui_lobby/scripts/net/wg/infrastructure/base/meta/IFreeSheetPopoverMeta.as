package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IFreeSheetPopoverMeta extends IEventDispatcher
   {
       
      
      function onTaskClickS(param1:String) : void;
      
      function as_setData(param1:Object) : void;
      
      function as_setListDataProvider(param1:Array) : void;
   }
}
