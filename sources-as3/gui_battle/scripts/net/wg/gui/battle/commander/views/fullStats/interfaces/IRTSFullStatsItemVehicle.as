package net.wg.gui.battle.commander.views.fullStats.interfaces
{
   import net.wg.gui.battle.commander.VO.daapi.DAAPIVehicleCommanderDataVO;
   
   public interface IRTSFullStatsItemVehicle extends IRTSFullStatsItem
   {
       
      
      function triggerChatCommand(param1:String) : void;
      
      function setVehicleStatus(param1:uint) : void;
      
      function setRTSCommanderData(param1:DAAPIVehicleCommanderDataVO) : void;
      
      function setUserTags(param1:Array) : void;
      
      function setInvitationStatus(param1:uint) : void;
      
      function setChatCommand(param1:String, param2:uint) : void;
      
      function setIsSpotted(param1:Boolean) : void;
      
      function setRTSIsMove(param1:Boolean) : void;
   }
}
