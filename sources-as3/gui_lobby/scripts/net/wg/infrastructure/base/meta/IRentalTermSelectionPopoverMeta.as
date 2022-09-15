package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IRentalTermSelectionPopoverMeta extends IEventDispatcher
   {
       
      
      function selectTermS(param1:int) : void;
      
      function as_setInitData(param1:Object) : void;
   }
}
