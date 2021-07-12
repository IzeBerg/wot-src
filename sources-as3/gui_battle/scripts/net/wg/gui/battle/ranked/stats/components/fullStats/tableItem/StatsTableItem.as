package net.wg.gui.battle.ranked.stats.components.fullStats.tableItem
{
   import flash.display.MovieClip;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.components.PlayerStatusView;
   import net.wg.gui.battle.random.views.stats.components.fullStats.constants.RandomFullStatsValidationType;
   import net.wg.gui.battle.views.stats.SpeakAnimation;
   import net.wg.gui.battle.views.stats.constants.FullStatsValidationType;
   import net.wg.gui.battle.views.stats.constants.PlayerStatusSchemeName;
   import net.wg.gui.battle.views.stats.fullStats.StatsTableItemBase;
   import net.wg.infrastructure.interfaces.IColorScheme;
   import net.wg.infrastructure.interfaces.IUserProps;
   
   public class StatsTableItem extends StatsTableItemBase
   {
      
      private static const NUM_ROWS:int = 10;
       
      
      private var _vehicleIcon:BattleAtlasSprite = null;
      
      private var _vehicleLevelIcon:BattleAtlasSprite = null;
      
      private var _vehicleActionIcon:BattleAtlasSprite = null;
      
      private var _playerStatus:PlayerStatusView = null;
      
      private var _muteIcon:BattleAtlasSprite = null;
      
      private var _disableCommunicationIcon:BattleAtlasSprite = null;
      
      private var _speakAnimation:SpeakAnimation = null;
      
      private var _vehicleLevel:int = 0;
      
      private var _vehicleIconName:String = null;
      
      private var _vehicleAction:String = null;
      
      private var _inBattle:Boolean = false;
      
      private var _isMute:Boolean = false;
      
      private var _disableCommunication:Boolean = false;
      
      private var _isSpeaking:Boolean = false;
      
      private var _rankIcon:BattleAtlasSprite;
      
      private var _level:int;
      
      private var _division:int;
      
      private var _isGroup:Boolean;
      
      public function StatsTableItem(param1:MovieClip, param2:int, param3:int)
      {
         super(param1,param2,param3);
         var _loc4_:int = param2 * this.numRows + param3;
         this._vehicleIcon = param1.vehicleIconCollection[_loc4_];
         this._vehicleLevelIcon = param1.vehicleLevelCollection[_loc4_];
         this._vehicleActionIcon = param1.vehicleActionMarkerCollection[_loc4_];
         this._playerStatus = param1.playerStatusCollection[_loc4_];
         this._muteIcon = param1.muteCollection[_loc4_];
         this._disableCommunicationIcon = param1.disableCommunicationCollection[_loc4_];
         this._speakAnimation = param1.speakAnimationCollection[_loc4_];
         this._rankIcon = param1.rankIconsCollection[_loc4_];
         invalidate(RandomFullStatsValidationType.VEHICLE_LEVEL | RandomFullStatsValidationType.VEHICLE_ICON | RandomFullStatsValidationType.VEHICLE_ACTION);
         deadBg.imageName = BATTLEATLAS.FULL_STATS_DEAD_BG;
         this._vehicleLevelIcon.isCentralizeByX = true;
      }
      
      override public function reset() : void
      {
         this._vehicleLevel = 0;
         this._vehicleIconName = null;
         this._vehicleAction = null;
         this._inBattle = false;
         this._disableCommunication = false;
         this._isMute = false;
         this._isSpeaking = false;
         this._level = 0;
         super.reset();
      }
      
      override public function setIsDead(param1:Boolean) : void
      {
         if(isDead == param1)
         {
            return;
         }
         super.setIsDead(param1);
         invalidate(RandomFullStatsValidationType.PLAYER_STATUS);
      }
      
      override public function setIsOffline(param1:Boolean) : void
      {
         if(isOffline == param1)
         {
            return;
         }
         super.setIsOffline(param1);
         invalidate(RandomFullStatsValidationType.PLAYER_STATUS);
      }
      
      override public function setPlayerName(param1:IUserProps) : void
      {
         super.setPlayerName(param1);
         this._inBattle = true;
         invalidate(RandomFullStatsValidationType.PLAYER_STATUS);
      }
      
      override public function setShowDogTag(param1:Boolean) : void
      {
         if(dogTag == param1)
         {
            return;
         }
         super.setShowDogTag(param1);
         invalidate(RandomFullStatsValidationType.PLAYER_STATUS);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Function = null;
         var _loc2_:String = null;
         var _loc3_:IColorScheme = null;
         super.draw();
         if(isInvalid(FullStatsValidationType.RANK))
         {
            this._rankIcon.visible = this._level > -1 || this._division > -1;
            if(this._rankIcon.visible)
            {
               _loc1_ = !!this._isGroup ? BATTLEATLAS.getRanksGroupIcon : BATTLEATLAS.getRankIcon;
               this._rankIcon.imageName = _loc1_(this._division.toString(),this._level.toString());
            }
         }
         if(isInvalid(RandomFullStatsValidationType.PLAYER_STATUS))
         {
            if(isOffline)
            {
               this._playerStatus.showOffline();
            }
            else if(dogTag)
            {
               this._playerStatus.showDogTag();
            }
            else if(isDead)
            {
               this._playerStatus.showKilled();
            }
            else if(this._inBattle)
            {
               this._playerStatus.showInBattle();
            }
            else
            {
               this._playerStatus.hide();
            }
         }
         if(isInvalid(FullStatsValidationType.COLORS))
         {
            _loc2_ = PlayerStatusSchemeName.getSchemeNameForVehicle(isCurrentPlayer,isSquadPersonal,isTeamKiller,isDead,isOffline);
            _loc3_ = App.colorSchemeMgr.getScheme(_loc2_);
            if(_loc3_ && _loc3_.colorTransform)
            {
               this._vehicleIcon.transform.colorTransform = _loc3_.colorTransform;
            }
         }
         if(isInvalid(RandomFullStatsValidationType.VEHICLE_LEVEL))
         {
            if(this._vehicleLevel <= 0)
            {
               this._vehicleLevelIcon.visible = false;
            }
            else
            {
               this._vehicleLevelIcon.visible = true;
               this._vehicleLevelIcon.imageName = BATTLEATLAS.level(this._vehicleLevel.toString());
            }
         }
         if(isInvalid(RandomFullStatsValidationType.VEHICLE_ICON))
         {
            if(this._vehicleIconName)
            {
               this._vehicleIcon.visible = true;
               this._vehicleIcon.setImageNames(this._vehicleIconName,BATTLEATLAS.UNKNOWN);
            }
            else
            {
               this._vehicleIcon.visible = false;
            }
         }
         if(isInvalid(RandomFullStatsValidationType.VEHICLE_ACTION))
         {
            if(this._vehicleAction)
            {
               this._vehicleActionIcon.visible = true;
               this._vehicleActionIcon.imageName = BATTLEATLAS.getVehicleActionMarker(this._vehicleAction);
            }
            else
            {
               this._vehicleActionIcon.visible = false;
            }
         }
         if(isInvalid(RandomFullStatsValidationType.MUTE))
         {
            this._muteIcon.visible = this._isMute;
            if(this._isMute)
            {
               this._muteIcon.imageName = BATTLEATLAS.LEFT_STATS_MUTE;
            }
            if(this._isSpeaking)
            {
               if(this._isMute)
               {
                  this._speakAnimation.reset();
               }
               else
               {
                  this._speakAnimation.speaking = true;
               }
            }
         }
         if(isInvalid(RandomFullStatsValidationType.DISABLE_COMMUNICATION))
         {
            this._disableCommunicationIcon.visible = this._disableCommunication;
            if(this._disableCommunication)
            {
               this._disableCommunicationIcon.imageName = BATTLEATLAS.ICON_TOXIC_CHAT_OFF;
            }
         }
         if(isInvalid(RandomFullStatsValidationType.SPEAKING))
         {
            if(!this._isMute)
            {
               this._speakAnimation.speaking = this._isSpeaking;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this._vehicleIcon = null;
         this._vehicleLevelIcon = null;
         this._vehicleActionIcon = null;
         this._playerStatus = null;
         this._disableCommunicationIcon = null;
         this._muteIcon = null;
         this._speakAnimation = null;
         this._rankIcon = null;
         super.onDispose();
      }
      
      public function clearVehicleAction() : void
      {
         if(!this._vehicleAction)
         {
            return;
         }
         this._vehicleAction = null;
         invalidate(RandomFullStatsValidationType.VEHICLE_ACTION);
      }
      
      public function setDisableCommunication(param1:Boolean) : void
      {
         if(this._disableCommunication == param1)
         {
            return;
         }
         this._disableCommunication = param1;
         invalidate(RandomFullStatsValidationType.DISABLE_COMMUNICATION);
      }
      
      public function setIsMute(param1:Boolean) : void
      {
         if(this._isMute == param1)
         {
            return;
         }
         this._isMute = param1;
         invalidate(RandomFullStatsValidationType.MUTE);
      }
      
      public function setIsSpeaking(param1:Boolean) : void
      {
         if(this._isSpeaking == param1)
         {
            return;
         }
         this._isSpeaking = param1;
         invalidate(RandomFullStatsValidationType.SPEAKING);
      }
      
      public function setRank(param1:int, param2:int, param3:Boolean) : void
      {
         if(this._level == param2 && this._division == param1 && this._isGroup == param3)
         {
            return;
         }
         this._level = param2;
         this._division = param1;
         this._isGroup = param3;
         invalidate(FullStatsValidationType.RANK);
      }
      
      public function setVehicleAction(param1:String) : void
      {
         if(this._vehicleAction == param1)
         {
            return;
         }
         this._vehicleAction = param1;
         invalidate(RandomFullStatsValidationType.VEHICLE_ACTION);
      }
      
      public function setVehicleIcon(param1:String) : void
      {
         if(this._vehicleIconName == param1)
         {
            return;
         }
         this._vehicleIconName = param1;
         invalidate(RandomFullStatsValidationType.VEHICLE_ICON);
      }
      
      public function setVehicleLevel(param1:int) : void
      {
         if(this._vehicleLevel == param1)
         {
            return;
         }
         this._vehicleLevel = param1;
         invalidate(RandomFullStatsValidationType.VEHICLE_LEVEL);
      }
      
      override protected function get numRows() : uint
      {
         return NUM_ROWS;
      }
   }
}
