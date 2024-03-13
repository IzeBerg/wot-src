package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IStrongholdBattlesListViewMeta extends IEventDispatcher
   {
       
      
      function onFocusChangeS(param1:Boolean) : void;
      
      function updateBrowserS() : void;
   }
}
