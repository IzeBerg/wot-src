package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IRankedBattlesSeasonGapViewMeta extends IEventDispatcher
   {
       
      
      function onBtnClickS() : void;
      
      function as_setData(param1:Object) : void;
      
      function as_setEfficiencyData(param1:Object) : void;
      
      function as_setRatingData(param1:Object) : void;
   }
}
