package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEpicMissionsPanelMeta extends IEventDispatcher
   {
       
      
      function as_setPrimaryMission(param1:Object) : void;
      
      function as_setNearestHQ(param1:int) : void;
      
      function as_setMissionDescriptionValue(param1:String) : void;
   }
}
