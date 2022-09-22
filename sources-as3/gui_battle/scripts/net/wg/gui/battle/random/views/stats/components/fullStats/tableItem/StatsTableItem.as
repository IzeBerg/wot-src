package net.wg.gui.battle.random.views.stats.components.fullStats.tableItem
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
       
      
      protected var vehicleIcon:BattleAtlasSprite = null;
      
      protected var playerStatus:PlayerStatusView = null;
      
      private var _vehicleLevelIcon:BattleAtlasSprite = null;
      
      private var _vehicleActionIcon:BattleAtlasSprite = null;
      
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
      
      public function StatsTableItem(param1:MovieClip, param2:int, param3:int)
      {
         super(param1,param2,param3);
         var _loc4_:int = param2 * numRows + param3;
         this.vehicleIcon = param1.vehicleIconCollection[_loc4_];
         this._vehicleLevelIcon = param1.vehicleLevelCollection[_loc4_];
         this._vehicleActionIcon = param1.vehicleActionMarkerCollection[_loc4_];
         this.playerStatus = param1.playerStatusCollection[_loc4_];
         this._muteIcon = param1.muteCollection[_loc4_];
         this._disableCommunicationIcon = param1.disableCommunicationCollection[_loc4_];
         this._speakAnimation = param1.speakAnimationCollection[_loc4_];
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
      
      override public function setShowDogTag(param1:Boolean) : void
      {
         if(dogTag == param1)
         {
            return;
         }
         super.setShowDogTag(param1);
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
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         var _loc2_:IColorScheme = null;
         super.draw();
         if(isInvalid(RandomFullStatsValidationType.PLAYER_STATUS))
         {
            if(isOffline)
            {
               this.playerStatus.showOffline();
            }
            else if(dogTag)
            {
               this.playerStatus.showDogTag();
            }
            else if(isDead)
            {
               this.playerStatus.showKilled();
            }
            else if(this._inBattle)
            {
               this.playerStatus.showInBattle();
            }
            else
            {
               this.playerStatus.hide();
            }
         }
         if(isInvalid(FullStatsValidationType.COLORS))
         {
            _loc1_ = PlayerStatusSchemeName.getSchemeNameForVehicle(isCurrentPlayer,isSquadPersonal,isTeamKiller,isDead,isOffline);
            _loc2_ = App.colorSchemeMgr.getScheme(_loc1_);
            if(_loc2_ && _loc2_.colorTransform)
            {
               this.vehicleIcon.transform.colorTransform = _loc2_.colorTransform;
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
               this.vehicleIcon.visible = true;
               this.vehicleIcon.setImageNames(this._vehicleIconName,BATTLEATLAS.UNKNOWN);
            }
            else
            {
               this.vehicleIcon.visible = false;
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
         this.vehicleIcon = null;
         this._vehicleLevelIcon = null;
         this._vehicleActionIcon = null;
         this.playerStatus = null;
         this._disableCommunicationIcon = null;
         this._muteIcon = null;
         this._speakAnimation = null;
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
   }
}
