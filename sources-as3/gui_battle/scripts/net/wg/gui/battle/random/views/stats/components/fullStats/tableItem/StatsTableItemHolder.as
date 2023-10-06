package net.wg.gui.battle.random.views.stats.components.fullStats.tableItem
{
   import net.wg.data.constants.PlayerStatus;
   import net.wg.data.constants.UserTags;
   import net.wg.gui.battle.random.views.stats.constants.VehicleActions;
   import net.wg.gui.battle.views.stats.constants.DynamicSquadState;
   import net.wg.gui.battle.views.stats.fullStats.StatsTableItemHolderBase;
   import net.wg.gui.components.dogtag.VO.DogTagVO;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class StatsTableItemHolder extends StatsTableItemHolderBase
   {
       
      
      private var _squadItem:DynamicSquadCtrl = null;
      
      private var _isEnemy:Boolean = false;
      
      public function StatsTableItemHolder(param1:StatsTableItem, param2:DynamicSquadCtrl, param3:Boolean)
      {
         super(param1);
         this._squadItem = param2;
         this._isEnemy = param3;
      }
      
      public function get squadItem() : DynamicSquadCtrl
      {
         return this._squadItem;
      }
      
      public function get isEnemy() : Boolean
      {
         return this._isEnemy;
      }
      
      public function setIsInviteShown(param1:Boolean) : void
      {
         this._squadItem.setIsInviteShown(param1);
      }
      
      public function setIsInteractive(param1:Boolean) : void
      {
         this._squadItem.setIsInteractive(param1);
      }
      
      override protected function onDispose() : void
      {
         this._squadItem.dispose();
         this._squadItem = null;
         super.onDispose();
      }
      
      override public function showDogTag(param1:DogTagVO) : void
      {
         super.showDogTag(param1);
         this._squadItem.setDogTag(param1);
      }
      
      override protected function vehicleDataSync() : void
      {
         var _loc1_:StatsTableItem = null;
         var _loc2_:uint = 0;
         super.vehicleDataSync();
         if(data)
         {
            _loc1_ = this.getStatsItem;
            _loc1_.setVehicleLevel(data.vehicleLevel);
            _loc1_.setVehicleIcon(data.vehicleIconName);
            _loc1_.setPrestige(data.prestigeMarkId,data.prestigeLevel);
            _loc1_.setIsSpeaking(data.isSpeaking);
            _loc2_ = data.vehicleAction;
            if(!_loc2_)
            {
               _loc1_.clearVehicleAction();
            }
            else
            {
               _loc1_.setVehicleAction(VehicleActions.getActionName(data.vehicleAction));
            }
            this._squadItem.setIsEnemy(this._isEnemy);
            this._squadItem.sessionID = data.sessionID;
            if(activePlayerData)
            {
               this._squadItem.setActivePlayerData(activePlayerData);
            }
            if(UserTags.isCurrentPlayer(data.userTags) && data.isAnonymized)
            {
               this._squadItem.setCurrentPlayerAnonymized();
               this._squadItem.setIsCurrentPlayerInClan(StringUtils.isNotEmpty(data.clanAbbrev));
               this._squadItem.setCurrentPlayerFakeName(data.playerFakeName);
            }
            this.updateDynamicSquadState();
         }
         else
         {
            this._squadItem.reset();
         }
      }
      
      override protected function applyUserTags() : void
      {
         super.applyUserTags();
         var _loc1_:Array = data.userTags;
         if(!_loc1_)
         {
            return;
         }
         var _loc2_:StatsTableItem = this.getStatsItem;
         _loc2_.setIsMute(UserTags.isMuted(_loc1_));
         _loc2_.setDisableCommunication(UserTags.isIgnored(_loc1_));
         if(isCurrPlayer)
         {
            this._squadItem.setState(DynamicSquadState.NONE);
         }
      }
      
      override protected function applyPlayerStatus() : void
      {
         super.applyPlayerStatus();
         var _loc1_:uint = data.playerStatus;
         this._squadItem.setSquadIndex(data.squadIndex,data.isSquadPersonal());
         this._squadItem.setNoSound(PlayerStatus.isVoipDisabled(_loc1_));
      }
      
      private function updateDynamicSquadState() : void
      {
         var _loc1_:uint = DynamicSquadState.getState(data);
         this._squadItem.setState(_loc1_);
      }
      
      private function get getStatsItem() : StatsTableItem
      {
         return StatsTableItem(statsItem);
      }
   }
}
