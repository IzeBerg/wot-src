package net.wg.gui.battle.components.stats.playersPanel.interfaces
{
   import net.wg.gui.battle.components.interfaces.IBattleUIComponent;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.list.PlayersPanelDynamicSquad;
   import net.wg.gui.components.controls.VO.BadgeVisualVO;
   import net.wg.infrastructure.interfaces.IUserProps;
   
   public interface IPlayersPanelListItem extends IBattleUIComponent
   {
       
      
      function setVehicleLevelVisible(param1:Boolean) : void;
      
      function updateColorBlind() : void;
      
      function setIsSpeaking(param1:Boolean) : void;
      
      function setIsRightAligned(param1:Boolean) : void;
      
      function setState(param1:uint) : void;
      
      function setPlayerNameFullWidth(param1:uint) : void;
      
      function getPlayerNameFullWidth() : uint;
      
      function setIsInviteShown(param1:Boolean) : void;
      
      function setIsInteractive(param1:Boolean) : void;
      
      function isSquadPersonal() : Boolean;
      
      function setPlayerNameProps(param1:IUserProps) : void;
      
      function setIsAlive(param1:Boolean) : void;
      
      function setIsOffline(param1:Boolean) : void;
      
      function setIsSelected(param1:Boolean) : void;
      
      function setIsTeamKiller(param1:Boolean) : void;
      
      function setFrags(param1:int) : void;
      
      function setChatCommand(param1:String, param2:uint) : void;
      
      function triggerChatCommand(param1:String) : void;
      
      function setIsCurrentPlayer(param1:Boolean) : void;
      
      function isIgnoredTmp(param1:Boolean) : void;
      
      function setIsMute(param1:Boolean) : void;
      
      function setVehicleAction(param1:uint) : void;
      
      function setBadge(param1:BadgeVisualVO, param2:Boolean) : void;
      
      function setVehicleName(param1:String) : void;
      
      function setVehicleIcon(param1:String) : void;
      
      function setVehicleLevel(param1:int) : void;
      
      function setVehicleHealth(param1:int) : void;
      
      function setOverrideExInfo(param1:Boolean) : void;
      
      function setIsIGR(param1:Boolean) : void;
      
      function get holderItemID() : uint;
      
      function set holderItemID(param1:uint) : void;
      
      function getDynamicSquad() : PlayersPanelDynamicSquad;
      
      function showDogTag() : void;
      
      function setChatCommandVisibility(param1:Boolean) : void;
      
      function setPanelHPBarVisibilityState(param1:uint) : void;
      
      function setSpottedStatus(param1:uint) : void;
   }
}
