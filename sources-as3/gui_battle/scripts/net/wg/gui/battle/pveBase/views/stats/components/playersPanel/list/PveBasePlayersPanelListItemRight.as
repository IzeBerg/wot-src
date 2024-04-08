package net.wg.gui.battle.pveBase.views.stats.components.playersPanel.list
{
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.pveBase.views.stats.components.playersPanel.interfaces.IPvePlayersPanelListItem;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.list.PlayersPanelDynamicSquad;
   import net.wg.gui.components.controls.VO.BadgeVisualVO;
   import net.wg.infrastructure.interfaces.IUserProps;
   
   public class PveBasePlayersPanelListItemRight extends BattleUIComponent implements IPvePlayersPanelListItem
   {
       
      
      public function PveBasePlayersPanelListItemRight()
      {
         super();
      }
      
      public function setVehicleLevelVisible(param1:Boolean) : void
      {
      }
      
      public function updateColorBlind() : void
      {
      }
      
      public function setIsSpeaking(param1:Boolean) : void
      {
      }
      
      public function setIsRightAligned(param1:Boolean) : void
      {
      }
      
      public function setState(param1:uint) : void
      {
      }
      
      public function setPlayerNameFullWidth(param1:uint) : void
      {
      }
      
      public function getPlayerNameFullWidth() : uint
      {
         return 0;
      }
      
      public function setIsInviteShown(param1:Boolean) : void
      {
      }
      
      public function setIsInteractive(param1:Boolean) : void
      {
      }
      
      public function isSquadPersonal() : Boolean
      {
         return false;
      }
      
      public function setPlayerNameProps(param1:IUserProps) : void
      {
      }
      
      public function setIsAlive(param1:Boolean) : void
      {
      }
      
      public function setIsOffline(param1:Boolean) : void
      {
      }
      
      public function setIsSelected(param1:Boolean) : void
      {
      }
      
      public function setIsTeamKiller(param1:Boolean) : void
      {
      }
      
      public function setFrags(param1:int) : void
      {
      }
      
      public function setChatCommand(param1:String, param2:uint) : void
      {
      }
      
      public function triggerChatCommand(param1:String) : void
      {
      }
      
      public function setIsCurrentPlayer(param1:Boolean) : void
      {
      }
      
      public function isIgnoredTmp(param1:Boolean) : void
      {
      }
      
      public function setIsMute(param1:Boolean) : void
      {
      }
      
      public function setVehicleAction(param1:uint) : void
      {
      }
      
      public function setBadge(param1:BadgeVisualVO, param2:Boolean) : void
      {
      }
      
      public function setVehicleName(param1:String) : void
      {
      }
      
      public function setVehicleIcon(param1:String) : void
      {
      }
      
      public function setVehicleLevel(param1:int) : void
      {
      }
      
      public function setVehicleHealth(param1:int) : void
      {
      }
      
      public function setOverrideExInfo(param1:Boolean) : void
      {
      }
      
      public function setShowWithHP() : void
      {
      }
      
      public function setIsIGR(param1:Boolean) : void
      {
      }
      
      public function get holderItemID() : uint
      {
         return 0;
      }
      
      public function set holderItemID(param1:uint) : void
      {
      }
      
      public function getDynamicSquad() : PlayersPanelDynamicSquad
      {
         return undefined;
      }
      
      public function showDogTag() : void
      {
      }
      
      public function setChatCommandVisibility(param1:Boolean) : void
      {
      }
      
      public function setPanelHPBarVisibilityState(param1:uint) : void
      {
      }
      
      public function setSpottedStatus(param1:uint) : void
      {
      }
      
      public function setPrestige(param1:int, param2:int) : void
      {
      }
      
      public function setVehicleType(param1:String) : void
      {
      }
      
      public function setHighlighted(param1:Boolean) : void
      {
      }
      
      public function setShowFrags(param1:Boolean) : void
      {
      }
      
      public function setShowVehicleTypeIcon(param1:Boolean) : void
      {
      }
      
      public function setSquadNoSound(param1:Boolean) : void
      {
      }
      
      public function setSquadState(param1:int) : void
      {
      }
      
      public function setSquad(param1:Boolean, param2:int) : void
      {
      }
      
      public function setCountLivesVisibility(param1:Boolean) : void
      {
      }
      
      public function setCountLives(param1:int) : void
      {
      }
      
      public function setTeamColor(param1:String) : void
      {
      }
   }
}
