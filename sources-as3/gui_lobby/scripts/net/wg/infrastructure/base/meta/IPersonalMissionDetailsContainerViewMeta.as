package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IPersonalMissionDetailsContainerViewMeta extends IEventDispatcher
   {
       
      
      function useSheetS(param1:String) : void;
      
      function startMissionS(param1:String) : void;
      
      function retryMissionS(param1:String) : void;
      
      function discardMissionS(param1:String) : void;
      
      function obtainAwardS(param1:String) : void;
      
      function onPauseClickS(param1:String) : void;
   }
}
