package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IRankedBattlesUnreachableViewMeta extends IEventDispatcher
   {
       
      
      function onCloseBtnClickS() : void;
      
      function onEscapePressS() : void;
      
      function as_setData(param1:Object) : void;
   }
}
