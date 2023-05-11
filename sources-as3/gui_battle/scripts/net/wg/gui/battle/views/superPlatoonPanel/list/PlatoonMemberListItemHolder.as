package net.wg.gui.battle.views.superPlatoonPanel.list
{
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.constants.PlayerStatus;
   import net.wg.data.constants.UserTags;
   import net.wg.gui.battle.views.stats.StatsUserProps;
   import net.wg.gui.battle.views.superPlatoonPanel.renderers.PlatoonMemberListItemRenderer;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class PlatoonMemberListItemHolder implements IDisposable
   {
       
      
      private var _frags:int = 0;
      
      private var _rank:int = 1;
      
      private var _userProps:StatsUserProps = null;
      
      private var _vehicleData:DAAPIVehicleInfoVO = null;
      
      private var _listItem:PlatoonMemberListItemRenderer = null;
      
      private var _isCurrPlayer:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      public function PlatoonMemberListItemHolder(param1:PlatoonMemberListItemRenderer)
      {
         super();
         this._listItem = param1;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         if(this._listItem)
         {
            this._listItem.dispose();
            this._listItem = null;
         }
         if(this._userProps)
         {
            this._userProps.dispose();
            this._userProps = null;
         }
         if(this._vehicleData)
         {
            this._vehicleData.dispose();
            this._vehicleData = null;
         }
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
      
      public function setPlayerStatus(param1:int) : void
      {
         if(!this._vehicleData || this._vehicleData.playerStatus == param1)
         {
            return;
         }
         this._vehicleData.playerStatus = param1;
         this.applyPlayerStatus();
      }
      
      public function setPlayerHP(param1:int) : void
      {
         this._listItem.setPlayerHP(param1);
      }
      
      public function setOverrideExInfo(param1:Boolean) : void
      {
         this._listItem.setOverrideExInfo(param1);
      }
      
      public function setRank(param1:int) : void
      {
         if(this._rank == param1)
         {
            return;
         }
         this._rank = param1;
         this.applyRankData();
      }
      
      public function setUserTags(param1:Array) : void
      {
         if(!this._vehicleData || this._vehicleData.userTags == param1)
         {
            return;
         }
         this._vehicleData.userTags = param1;
         this.applyUserTags();
         this.updateUserProps();
      }
      
      public function setVehicleData(param1:DAAPIVehicleInfoVO) : void
      {
         this._vehicleData = param1.clone();
         this.applyVehicleData();
      }
      
      public function setVehicleStatus(param1:int) : void
      {
         if(!this._vehicleData || this._vehicleData.vehicleStatus == param1)
         {
            return;
         }
         this._vehicleData.vehicleStatus = param1;
         this.applyVehicleStatus();
      }
      
      public function setChatCommand(param1:String, param2:uint) : void
      {
         this._listItem.setChatCommand(param1,param2);
      }
      
      public function triggerChatCommand(param1:String) : void
      {
         this._listItem.triggerChatCommand(param1);
      }
      
      public function setChatCommandsVisibility(param1:Boolean) : void
      {
         this._listItem.setChatCommandsVisibility(param1);
      }
      
      public function setPanelHPBarVisibilityState(param1:uint) : void
      {
         this._listItem.setPanelHPBarVisibilityState(param1);
      }
      
      private function applyVehicleData() : void
      {
         this._listItem.setIsIGR(this._vehicleData.isIGR);
         this._listItem.setVehicleLevel(this._vehicleData.vehicleLevel);
         this._listItem.setVehicleIcon(this._vehicleData.vehicleIconName);
         if(this._vehicleData.vehicleAction)
         {
            this._listItem.setVehicleAction(this._vehicleData.vehicleAction);
         }
         this.applyVehicleStatus();
         this.applyPlayerStatus();
         this.applyUserTags();
         this.updateUserProps();
         if(this._isCurrPlayer && this._vehicleData.isAlive())
         {
            this._listItem.setIsSelected(true);
         }
      }
      
      private function applyUserTags() : void
      {
         var _loc1_:Array = this._vehicleData.userTags;
         if(!_loc1_)
         {
            return;
         }
         this._listItem.setIsMute(UserTags.isMuted(_loc1_));
         this._listItem.isIgnoredTmp(UserTags.isIgnored(_loc1_));
         this._isCurrPlayer = UserTags.isCurrentPlayer(_loc1_);
         this._listItem.setIsCurrentPlayer(this._isCurrPlayer);
      }
      
      private function applyPlayerStatusValues() : void
      {
         this._listItem.setSquadNoSound(PlayerStatus.isVoipDisabled(this.playerStatus));
      }
      
      private function applyRankData() : void
      {
         this._listItem.setRank(this._rank);
      }
      
      private function applyPlayerStatus() : void
      {
         var _loc1_:uint = this._vehicleData.playerStatus;
         this._listItem.setIsTeamKiller(this._vehicleData.isTeamKiller());
         this._listItem.setIsSelected(PlayerStatus.isSelected(_loc1_));
         this.applyPlayerStatusValues();
      }
      
      private function applyVehicleStatus() : void
      {
         this._listItem.setIsAlive(this._vehicleData.isAlive());
         this._listItem.setIsOffline(!this._vehicleData.isReady());
      }
      
      private function updateUserProps() : void
      {
         if(!this._userProps)
         {
            this._userProps = new StatsUserProps(this._vehicleData.playerName,this._vehicleData.playerFakeName,this._vehicleData.clanAbbrev,this._vehicleData.region,0,this._vehicleData.userTags);
         }
         else
         {
            this._userProps.userName = this._vehicleData.playerName;
            this._userProps.fakeName = this._vehicleData.playerFakeName;
            this._userProps.clanAbbrev = this._vehicleData.clanAbbrev;
            this._userProps.region = this._vehicleData.region;
            this._userProps.tags = this._vehicleData.userTags;
         }
         if(this._userProps.isChanged)
         {
            this._userProps.applyChanges();
            this._listItem.setPlayerNameProps(this._userProps);
         }
      }
      
      public function get listItem() : PlatoonMemberListItemRenderer
      {
         return this._listItem;
      }
      
      public function get playerStatus() : uint
      {
         return this._vehicleData.playerStatus;
      }
      
      public function get vehicleID() : Number
      {
         return Boolean(this._vehicleData) ? Number(this._vehicleData.vehicleID) : Number(NaN);
      }
      
      public function get accountDBID() : Number
      {
         return Boolean(this._vehicleData) ? Number(this._vehicleData.accountDBID) : Number(NaN);
      }
      
      public function get isCurrentPlayer() : Boolean
      {
         return this._isCurrPlayer;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
