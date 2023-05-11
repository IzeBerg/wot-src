package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IClanInvitesWindowAbstractTabViewMeta extends IEventDispatcher
   {
       
      
      function filterByS(param1:String) : void;
      
      function as_updateFilterState(param1:Object) : void;
   }
}
