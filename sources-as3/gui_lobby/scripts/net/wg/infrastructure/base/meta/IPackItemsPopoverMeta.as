package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IPackItemsPopoverMeta extends IEventDispatcher
   {
       
      
      function showTooltipS(param1:String, param2:String) : void;
      
      function as_setItems(param1:String, param2:Array) : void;
   }
}
