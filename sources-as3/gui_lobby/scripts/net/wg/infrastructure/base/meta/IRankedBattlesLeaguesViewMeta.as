package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IRankedBattlesLeaguesViewMeta extends IEventDispatcher
   {
       
      
      function as_setData(param1:Object) : void;
      
      function as_setStatsData(param1:Object) : void;
      
      function as_setEfficiencyData(param1:Object) : void;
      
      function as_setRatingData(param1:Object) : void;
      
      function as_setBonusBattlesLabel(param1:String) : void;
   }
}
