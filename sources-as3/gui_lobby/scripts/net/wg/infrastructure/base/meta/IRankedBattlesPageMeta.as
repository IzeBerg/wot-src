package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IRankedBattlesPageMeta extends IEventDispatcher
   {
       
      
      function onCloseS() : void;
      
      function onPageChangedS(param1:String) : void;
      
      function as_setData(param1:Object) : void;
      
      function as_setHeaderData(param1:Object) : void;
      
      function as_setCounters(param1:Array) : void;
   }
}
