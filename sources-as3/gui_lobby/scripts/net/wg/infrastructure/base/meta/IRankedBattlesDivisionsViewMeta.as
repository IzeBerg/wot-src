package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IRankedBattlesDivisionsViewMeta extends IEventDispatcher
   {
       
      
      function onDivisionChangedS(param1:int) : void;
      
      function as_setData(param1:Object) : void;
   }
}
