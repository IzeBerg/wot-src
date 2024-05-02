package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IStorageViewMeta extends IEventDispatcher
   {
       
      
      function navigateToHangarS() : void;
      
      function onCloseS() : void;
      
      function as_setData(param1:Object) : void;
      
      function as_selectSection(param1:int) : void;
      
      function as_setButtonCounter(param1:int, param2:int) : void;
   }
}
