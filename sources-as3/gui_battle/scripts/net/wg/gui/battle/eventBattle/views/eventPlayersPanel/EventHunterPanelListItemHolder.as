package net.wg.gui.battle.eventBattle.views.eventPlayersPanel
{
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.constants.InvitationStatus;
   import net.wg.data.constants.PlayerStatus;
   import net.wg.gui.battle.components.stats.playersPanel.interfaces.IPlayersPanelListItem;
   import net.wg.gui.battle.components.stats.playersPanel.list.BasePlayersListItemHolder;
   import net.wg.gui.battle.eventBattle.VO.DAAPIHunterVehicleInfoVO;
   import net.wg.gui.battle.views.stats.constants.DynamicSquadState;
   
   public class EventHunterPanelListItemHolder extends BasePlayersListItemHolder
   {
       
      
      private var _isInviteReceived:Boolean = false;
      
      private var _hunterListItem:IHuntersEventPanelListItem = null;
      
      public function EventHunterPanelListItemHolder(param1:IPlayersPanelListItem)
      {
         super(param1);
         this._hunterListItem = IHuntersEventPanelListItem(param1);
      }
      
      override protected function onDispose() : void
      {
         this._hunterListItem = null;
         super.onDispose();
      }
      
      override public function setVehicleData(param1:DAAPIVehicleInfoVO) : void
      {
         super.setVehicleData(param1);
         var _loc2_:DAAPIHunterVehicleInfoVO = param1 as DAAPIHunterVehicleInfoVO;
         if(_loc2_ != null)
         {
            this.applyHunterVehicleData(_loc2_);
         }
      }
      
      override protected function updateInvitationValues() : void
      {
         this.updateInviteStatus();
         this.updateDynamicSquadState();
      }
      
      override protected function updatePlayerStatusValues() : void
      {
         this.updateDynamicSquadState();
      }
      
      override protected function updateUserTagsValues() : void
      {
         this.updateDynamicSquadState();
      }
      
      override protected function updateListItemVehicleDataValues() : void
      {
         this._hunterListItem.getDynamicSquad().setSessionID(vehicleData.sessionID);
      }
      
      override protected function updateVehicleDataValues() : void
      {
         this.updateInviteStatus();
         this.updateDynamicSquadState();
      }
      
      override protected function applyPlayerStatusValues() : void
      {
         this._hunterListItem.setSquad(vehicleData.isSquadPersonal(),vehicleData.squadIndex);
         this._hunterListItem.setSquadNoSound(PlayerStatus.isVoipDisabled(playerStatus));
      }
      
      private function applyHunterVehicleData(param1:DAAPIHunterVehicleInfoVO) : void
      {
         this._hunterListItem.setResurrect(param1.resurrectTimeLeft,param1.resurrectTimeTotal,param1.replaySpeed);
         this._hunterListItem.updateBombTimer(param1.bombIndex,param1.bombTimeLeft,param1.bombTimeTotal,param1.replaySpeed);
      }
      
      private function updateDynamicSquadState() : void
      {
         var _loc1_:int = DynamicSquadState.getState(vehicleData);
         this._hunterListItem.setSquadState(_loc1_);
      }
      
      private function updateInviteStatus() : void
      {
         this._isInviteReceived = InvitationStatus.isOnlyReceived(vehicleData.invitationStatus);
      }
      
      override public function get isInviteReceived() : Boolean
      {
         return this._isInviteReceived;
      }
   }
}
