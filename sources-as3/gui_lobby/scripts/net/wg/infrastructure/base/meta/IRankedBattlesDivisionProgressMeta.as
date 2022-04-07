package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IRankedBattlesDivisionProgressMeta extends IEventDispatcher
   {
       
      
      function as_setStatsData(param1:Object) : void;
      
      function as_setBonusBattlesLabel(param1:String) : void;
      
      function as_setRankedData(param1:Object) : void;
      
      function as_setDivisionStatus(param1:String, param2:String) : void;
   }
}
