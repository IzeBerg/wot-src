package net.wg.gui.battle.components.stats.playersPanel.list
{
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.PlayerStatus;
   import net.wg.data.constants.UserTags;
   import net.wg.gui.battle.components.stats.playersPanel.interfaces.IPlayersPanelListItem;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.interfaces.IPlayersPanelListItemHolder;
   import net.wg.gui.battle.views.stats.StatsUserProps;
   import net.wg.gui.components.dogtag.VO.DogTagVO;
   
   public class BasePlayersListItemHolder implements IPlayersPanelListItemHolder
   {
       
      
      protected var vehicleData:DAAPIVehicleInfoVO = null;
      
      private var _listItem:IPlayersPanelListItem = null;
      
      private var _frags:int = 0;
      
      private var _userProps:StatsUserProps = null;
      
      private var _isDisposed:Boolean = false;
      
      private var _dogTag:DogTagVO = null;
      
      public function BasePlayersListItemHolder(param1:IPlayersPanelListItem)
      {
         super();
         this._listItem = param1;
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
      
      public function getDogTag() : DogTagVO
      {
         return this._dogTag;
      }
      
      public function getListItem() : IPlayersPanelListItem
      {
         return this._listItem;
      }
      
      public function setChatCommand(param1:String, param2:uint) : void
      {
         this._listItem.setChatCommand(param1,param2);
      }
      
      public function setDogTag(param1:DogTagVO) : void
      {
         this._dogTag = param1;
      }
      
      public function setFrags(param1:int) : void
      {
         if(this._frags == param1)
         {
            return;
         }
         this._frags = param1;
         this._listItem.setFrags(this._frags);
      }
      
      public function setInvitationStatus(param1:uint) : void
      {
         if(!this.vehicleData || this.vehicleData.invitationStatus == param1)
         {
            return;
         }
         this.vehicleData.invitationStatus = param1;
         this.updateInvitationValues();
      }
      
      public function setOverrideExInfo(param1:Boolean) : void
      {
         this._listItem.setOverrideExInfo(param1);
      }
      
      public function setPlayerHP(param1:int) : void
      {
         this._listItem.setVehicleHealth(param1);
      }
      
      public function setPlayerStatus(param1:int) : void
      {
         if(!this.vehicleData || this.vehicleData.playerStatus == param1)
         {
            return;
         }
         this.vehicleData.playerStatus = param1;
         this.applyPlayerStatus();
         this.updatePlayerStatusValues();
      }
      
      public function setSpottedStatus(param1:uint) : void
      {
         this._listItem.setSpottedStatus(param1);
      }
      
      public function setUserTags(param1:Array) : void
      {
         if(!this.vehicleData || this.vehicleData.userTags == param1)
         {
            return;
         }
         this.vehicleData.userTags = param1;
         this.applyUserTags();
         this.updateUserProps();
         this.updateUserTagsValues();
      }
      
      public function setVehicleData(param1:DAAPIVehicleInfoVO) : void
      {
         this.vehicleData = param1.clone();
         this.applyVehicleData();
      }
      
      public function setVehicleStatus(param1:int) : void
      {
         if(!this.vehicleData || this.vehicleData.vehicleStatus == param1)
         {
            return;
         }
         this.vehicleData.vehicleStatus = param1;
         this.applyVehicleStatus();
      }
      
      public function triggerChatCommand(param1:String) : void
      {
         this._listItem.triggerChatCommand(param1);
      }
      
      protected function onDispose() : void
      {
         if(App.instance)
         {
            App.utils.asserter.assert(!this._isDisposed,Errors.ALREADY_DISPOSED);
         }
         this._isDisposed = true;
         if(this._listItem)
         {
            this._listItem = null;
         }
         if(this._userProps)
         {
            this._userProps.dispose();
            this._userProps = null;
         }
         if(this.vehicleData)
         {
            this.vehicleData.dispose();
            this.vehicleData = null;
         }
         this._dogTag = null;
      }
      
      protected function updateInvitationValues() : void
      {
      }
      
      protected function updatePlayerStatusValues() : void
      {
      }
      
      protected function updateUserTagsValues() : void
      {
      }
      
      protected function updateListItemVehicleDataValues() : void
      {
      }
      
      protected function updateVehicleDataValues() : void
      {
      }
      
      protected function applyPlayerStatusValues() : void
      {
      }
      
      private function applyVehicleData() : void
      {
         this._listItem.setIsIGR(this.vehicleData.isIGR);
         this._listItem.setVehicleLevel(this.vehicleData.vehicleLevel);
         this._listItem.setVehicleIcon(this.vehicleData.vehicleIconName);
         this._listItem.setVehicleName(this.vehicleData.vehicleName);
         this._listItem.setBadge(this.vehicleData.badgeVO,this.vehicleData.hasSelectedBadge);
         this._listItem.setPrestige(this.vehicleData.prestigeMarkId,this.vehicleData.prestigeLevel);
         this.updateListItemVehicleDataValues();
         if(this.vehicleData.vehicleAction)
         {
            this._listItem.setVehicleAction(this.vehicleData.vehicleAction);
         }
         this.applyVehicleStatus();
         this.applyPlayerStatus();
         this.applyUserTags();
         this.updateVehicleDataValues();
         this.updateUserProps();
         if(this.vehicleData.isCurrentPlayer && this.vehicleData.isAlive())
         {
            this._listItem.setIsSelected(true);
         }
      }
      
      private function applyUserTags() : void
      {
         var _loc1_:Array = this.vehicleData.userTags;
         if(!_loc1_)
         {
            return;
         }
         this._listItem.setIsMute(UserTags.isMuted(_loc1_));
         this._listItem.isIgnoredTmp(UserTags.isIgnored(_loc1_));
         this._listItem.setIsCurrentPlayer(this.vehicleData.isCurrentPlayer);
      }
      
      private function applyPlayerStatus() : void
      {
         this._listItem.setIsTeamKiller(this.vehicleData.isTeamKiller());
         this._listItem.setIsSelected(PlayerStatus.isSelected(this.vehicleData.playerStatus));
         this.applyPlayerStatusValues();
      }
      
      private function applyVehicleStatus() : void
      {
         this._listItem.setIsAlive(this.vehicleData.isAlive());
         this._listItem.setIsOffline(!this.vehicleData.isReady());
      }
      
      private function updateUserProps() : void
      {
         if(this._userProps)
         {
            this._userProps.userName = this.vehicleData.playerName;
            this._userProps.fakeName = this.vehicleData.playerFakeName;
            this._userProps.clanAbbrev = this.vehicleData.clanAbbrev;
            this._userProps.region = this.vehicleData.region;
            this._userProps.tags = this.vehicleData.userTags;
         }
         else
         {
            this._userProps = new StatsUserProps(this.vehicleData.playerName,this.vehicleData.playerFakeName,this.vehicleData.clanAbbrev,this.vehicleData.region,0,this.vehicleData.userTags);
         }
         if(this._userProps.isChanged)
         {
            this._userProps.applyChanges();
            this._listItem.setPlayerNameProps(this._userProps);
         }
      }
      
      public function get playerStatus() : uint
      {
         return this.vehicleData.playerStatus;
      }
      
      public function get vehicleID() : Number
      {
         return Boolean(this.vehicleData) ? Number(this.vehicleData.vehicleID) : Number(NaN);
      }
      
      public function get accountDBID() : Number
      {
         return Boolean(this.vehicleData) ? Number(this.vehicleData.accountDBID) : Number(NaN);
      }
      
      public function get isInviteReceived() : Boolean
      {
         return false;
      }
      
      public function get isCurrentPlayer() : Boolean
      {
         return this.vehicleData && this.vehicleData.isCurrentPlayer;
      }
      
      public function isDisposed() : Boolean
      {
         return this._isDisposed;
      }
      
      public function getVehicleData() : DAAPIVehicleInfoVO
      {
         return this.vehicleData;
      }
   }
}
