package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBattleStatisticDataControllerMeta extends IEventDispatcher
   {
       
      
      function onRefreshCompleteS() : void;
      
      function as_refresh() : void;
      
      function as_resetFrags() : void;
      
      function as_setVehiclesData(param1:Object) : void;
      
      function as_addVehiclesInfo(param1:Object) : void;
      
      function as_updateVehiclesInfo(param1:Object) : void;
      
      function as_updateVehicleStatus(param1:Object) : void;
      
      function as_setFrags(param1:Object) : void;
      
      function as_updateVehiclesStats(param1:Object) : void;
      
      function as_updatePlayerStatus(param1:Object) : void;
      
      function as_setArenaInfo(param1:Object) : void;
      
      function as_setQuestStatus(param1:Object) : void;
      
      function as_setUserTags(param1:Object) : void;
      
      function as_updateUserTags(param1:Object) : void;
      
      function as_updateInvitationsStatuses(param1:Object) : void;
      
      function as_setPersonalStatus(param1:uint) : void;
      
      function as_updatePersonalStatus(param1:uint, param2:uint) : void;
      
      function as_setQuestsInfo(param1:Object, param2:Boolean) : void;
      
      function as_updateQuestProgress(param1:String, param2:Object) : void;
      
      function as_updateQuestHeaderProgress(param1:Array) : void;
      
      function as_updateTriggeredChatCommands(param1:Object) : void;
   }
}
