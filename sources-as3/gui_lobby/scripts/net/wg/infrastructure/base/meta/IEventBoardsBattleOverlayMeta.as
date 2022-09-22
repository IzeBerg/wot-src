package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEventBoardsBattleOverlayMeta extends IEventDispatcher
   {
       
      
      function as_setData(param1:Object) : void;
      
      function as_setExperienceData(param1:Object) : void;
      
      function as_setStatisticsData(param1:Object) : void;
      
      function as_setTableHeaderData(param1:Object) : void;
      
      function as_setTableData(param1:Object) : void;
   }
}
