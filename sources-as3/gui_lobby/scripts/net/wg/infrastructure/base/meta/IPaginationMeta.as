package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IPaginationMeta extends IEventDispatcher
   {
       
      
      function showPageS(param1:int) : void;
      
      function as_setPage(param1:String) : void;
      
      function as_setEnabled(param1:Boolean, param2:Boolean) : void;
   }
}
