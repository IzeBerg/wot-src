package net.wg.gui.battle.commander.views.fullStats.interfaces
{
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.gui.battle.commander.VO.daapi.DAAPIVehicleCommanderDataVO;
   
   public interface IRTSFullStatsListVehicles extends IRTSFullStatsList
   {
       
      
      function setRTSCommanderInfo(param1:DAAPIVehicleInfoVO) : void;
      
      function setRTSCommanderData(param1:Vector.<DAAPIVehicleCommanderDataVO>) : void;
      
      function setVehicleStatus(param1:Number, param2:uint) : void;
      
      function setIsSpotted(param1:Number, param2:Boolean) : void;
      
      function setRTSIsMove(param1:Number, param2:Boolean) : void;
      
      function setUserTags(param1:Number, param2:Array) : void;
      
      function setInvitationStatus(param1:Number, param2:uint) : void;
      
      function triggerChatCommand(param1:Number, param2:String) : void;
      
      function setChatCommand(param1:Number, param2:String, param3:uint) : void;
      
      function getHeight() : Number;
   }
}
