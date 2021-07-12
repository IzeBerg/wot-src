package net.wg.infrastructure.helpers.statisticsDataController.intarfaces
{
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   
   public interface IBattleComponentDataController
   {
       
      
      function setVehiclesData(param1:IDAAPIDataClass) : void;
      
      function addVehiclesInfo(param1:IDAAPIDataClass) : void;
      
      function updateVehiclesData(param1:IDAAPIDataClass) : void;
      
      function updateVehicleStatus(param1:IDAAPIDataClass) : void;
      
      function updatePersonalStatus(param1:uint, param2:uint) : void;
      
      function resetFrags() : void;
      
      function setFrags(param1:IDAAPIDataClass) : void;
      
      function updateVehiclesStat(param1:IDAAPIDataClass) : void;
      
      function updatePlayerStatus(param1:IDAAPIDataClass) : void;
      
      function setArenaInfo(param1:IDAAPIDataClass) : void;
      
      function setQuestStatus(param1:IDAAPIDataClass) : void;
      
      function setUserTags(param1:IDAAPIDataClass) : void;
      
      function updateUserTags(param1:IDAAPIDataClass) : void;
      
      function setPersonalStatus(param1:uint) : void;
      
      function updateInvitationsStatuses(param1:IDAAPIDataClass) : void;
      
      function updateTriggeredChatCommands(param1:IDAAPIDataClass) : void;
   }
}
