package net.wg.gui.battle.historicalBattles.playersPanel
{
   import flash.display.BlendMode;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.UserTags;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.components.stats.playersPanel.ChatCommandItemComponent;
   import net.wg.gui.battle.historicalBattles.components.HBPlayerRole;
   import net.wg.gui.battle.historicalBattles.components.HBVehicleType;
   import net.wg.gui.battle.historicalBattles.playersPanel.VO.HBPlayerInfoVO;
   import net.wg.gui.battle.historicalBattles.playersPanel.components.HBDynamicSquad;
   import net.wg.gui.battle.historicalBattles.playersPanel.components.HBLiveCounter;
   import net.wg.gui.battle.historicalBattles.playersPanel.components.HBPlayerName;
   import net.wg.gui.battle.historicalBattles.playersPanel.components.HBRespawnTimer;
   import net.wg.gui.battle.historicalBattles.playersPanel.components.healthBar.HBHealthBar;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.constants.PlayersPanelInvalidationType;
   import net.wg.gui.battle.views.stats.SpeakAnimation;
   import net.wg.utils.ICommons;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class HBPlayerRenderer extends BattleUIComponent
   {
      
      private static const COLOR_CURRENT:int = 16761699;
      
      private static const COLOR_ALLY:int = 16777215;
      
      private static const ALPHA_DISABLE:Number = 0.5;
      
      private static const ALPHA_AVAILABLE:Number = 1;
      
      private static const CHAT_COMM_MARGIN_X:int = 17;
      
      private static const VEHICLE_DESCR_ROLE_X:int = 228;
      
      private static const VEHICLE_DESCR_X:int = 208;
      
      private static const VEHICLE_TYPE_ROLE_X:int = 212;
      
      private static const VEHICLE_TYPE_X:int = 192;
      
      private static const RESPAWN_TIMER_MARGIN_X:int = 5;
       
      
      public var playerName:HBPlayerName = null;
      
      public var hitMc:MovieClip;
      
      public var dynamicSquad:HBDynamicSquad = null;
      
      public var chatMuteIcon:BattleAtlasSprite = null;
      
      public var voiceMuteIcon:BattleAtlasSprite = null;
      
      public var liveCounter:HBLiveCounter = null;
      
      public var vehicleType:HBVehicleType = null;
      
      public var vehicleDescTF:TextField = null;
      
      public var chatCommandState:ChatCommandItemComponent = null;
      
      public var speakAnimation:SpeakAnimation = null;
      
      public var voiceMuteBg:BattleAtlasSprite = null;
      
      public var healthBar:HBHealthBar = null;
      
      public var playerRole:HBPlayerRole = null;
      
      public var respawnTimer:HBRespawnTimer = null;
      
      private var _data:HBPlayerInfoVO = null;
      
      private var _isSquadPersonal:Boolean = false;
      
      private var _isCurrentPlayer:Boolean = false;
      
      private var _isAlive:Boolean = false;
      
      private var _isReady:Boolean = false;
      
      private var _isMuted:Boolean = false;
      
      private var _isIgnored:Boolean = false;
      
      private var _state:String = "up";
      
      private var _isSpeaking:Boolean = false;
      
      private var _isChatCommVisibilityEnabled:Boolean = false;
      
      private var _isPlayerSwitchingAllowed:Boolean = false;
      
      private var _commons:ICommons;
      
      public function HBPlayerRenderer()
      {
         this._commons = App.utils.commons;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.vehicleDescTF.blendMode = BlendMode.SCREEN;
         if(this.hitMc != null)
         {
            this.hitArea = this.hitMc;
         }
         this.dynamicSquad.visible = false;
         this.respawnTimer.visible = false;
         this.voiceMuteIcon.imageName = BATTLEATLAS.HB_VOICE_MUTE_ICON;
         this.voiceMuteBg.imageName = BATTLEATLAS.HB_VOICE_MUTE_BG;
         this.chatMuteIcon.imageName = BATTLEATLAS.HB_CHAT_MUTE_ICON;
         this.voiceMuteIcon.visible = this.voiceMuteBg.visible = this.chatMuteIcon.visible = true;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(!this._data)
         {
            return;
         }
         if(isInvalid(InvalidationType.DATA))
         {
            this.validateData();
            this.validateColors();
            this.validatePosition();
            this.validateMute();
         }
         if(!this._isMuted && isInvalid(PlayersPanelInvalidationType.IS_SPEAKING))
         {
            this.speakAnimation.speaking = this._isSpeaking;
         }
         if(isInvalid(InvalidationType.STATE))
         {
            gotoAndPlay(this._state);
         }
      }
      
      override protected function onDispose() : void
      {
         this.dynamicSquad.dispose();
         this.dynamicSquad = null;
         this.playerName.dispose();
         this.playerName = null;
         this.liveCounter.dispose();
         this.liveCounter = null;
         this.vehicleType.dispose();
         this.vehicleType = null;
         this.chatCommandState.dispose();
         this.chatCommandState = null;
         this.speakAnimation.dispose();
         this.speakAnimation = null;
         this.healthBar.dispose();
         this.healthBar = null;
         this.playerRole.dispose();
         this.playerRole = null;
         this.respawnTimer.dispose();
         this.respawnTimer = null;
         if(this._data)
         {
            this._data.removeEventListener(Event.CHANGE,this.onDataChangeHandler);
            this._data = null;
         }
         this.hitMc = null;
         this.vehicleDescTF = null;
         this.voiceMuteIcon = null;
         this.voiceMuteBg = null;
         this.chatMuteIcon = null;
         this._commons = null;
         super.onDispose();
      }
      
      public function setChatCommand(param1:String, param2:uint) : void
      {
         this.chatCommandState.setActiveChatCommand(param1,param2);
      }
      
      public function setCountLives(param1:uint) : void
      {
         if(!this._data)
         {
            return;
         }
         this._data.countLives = param1;
         this.liveCounter.lives = param1;
      }
      
      public function updateHp(param1:int, param2:int, param3:Boolean) : void
      {
         if(!this._data)
         {
            return;
         }
         this._data.hpCurrent = param2;
         this._data.hpMax = param1;
         this.healthBar.updateHp(param1,param2,param3);
      }
      
      protected function triggerChatCommand(param1:String) : void
      {
         this.chatCommandState.playCommandAnimation(param1);
      }
      
      protected function validateColors() : void
      {
         var _loc2_:Boolean = false;
         var _loc1_:Boolean = this._isSquadPersonal || this._isCurrentPlayer;
         this.vehicleDescTF.textColor = this.playerName.textColor = !!_loc1_ ? int(COLOR_CURRENT) : int(COLOR_ALLY);
         this.playerRole.color = this.vehicleType.color = !!_loc1_ ? HBVehicleType.ORANGE : HBVehicleType.GREEN;
         this.healthBar.isOffline = this._isReady;
         this.healthBar.isCurrentPlayer = this._isCurrentPlayer;
         _loc2_ = this._isAlive && this._isReady;
         var _loc3_:Number = !!_loc2_ ? Number(ALPHA_AVAILABLE) : Number(ALPHA_DISABLE);
         this.liveCounter.isAvailable = _loc2_;
         this.playerRole.alpha = this.dynamicSquad.alpha = this.playerName.alpha = this.vehicleType.alpha = this.vehicleDescTF.alpha = _loc3_;
      }
      
      protected function validateMute() : void
      {
         this.voiceMuteIcon.visible = this.voiceMuteBg.visible = this._isMuted;
         if(this._isSpeaking)
         {
            if(this._isMuted)
            {
               this.speakAnimation.reset();
            }
            else
            {
               this.speakAnimation.speaking = true;
            }
         }
         this.chatMuteIcon.visible = this._isIgnored;
      }
      
      protected function validatePosition() : void
      {
         this.respawnTimer.x = this.vehicleDescTF.x + this.vehicleDescTF.textWidth + RESPAWN_TIMER_MARGIN_X >> 0;
         this.chatCommandState.iconOffset(this.respawnTimer.x + CHAT_COMM_MARGIN_X);
      }
      
      protected function validateData() : void
      {
         var _loc1_:Array = this._data.userTags;
         this._isCurrentPlayer = UserTags.isCurrentPlayer(_loc1_);
         this._isMuted = UserTags.isMuted(_loc1_);
         this._isIgnored = UserTags.isIgnored(_loc1_);
         this._isSquadPersonal = this._data.isSquadPersonal();
         this._isAlive = this._data.isAlive();
         this._isReady = this._data.isReady();
         this.playerName.setData(this._data);
         this.liveCounter.lives = this._data.countLives;
         this.vehicleType.vehicleType = this._data.vehicleType;
         var _loc2_:Boolean = this._data.playerRole != HBPlayerInfoVO.STATE_NONE && StringUtils.isNotEmpty(this._data.playerRole);
         this.playerRole.visible = _loc2_;
         if(_loc2_)
         {
            this.playerRole.role = this._data.playerRole;
         }
         this.vehicleDescTF.x = !!_loc2_ ? Number(VEHICLE_DESCR_ROLE_X) : Number(VEHICLE_DESCR_X);
         this.vehicleType.x = !!_loc2_ ? Number(VEHICLE_TYPE_ROLE_X) : Number(VEHICLE_TYPE_X);
         this._commons.truncateTextFieldText(this.vehicleDescTF,this._data.vehicleName,true,false,Values.THREE_DOTS);
         this.healthBar.setHp(this._data.hpMax,this._data.hpCurrent);
         this.updateSquad();
         this.updateRespawnTimer();
      }
      
      protected function updateSquad() : void
      {
         this.dynamicSquad.setData(this._data.squadIndex,this._isSquadPersonal || this._isCurrentPlayer);
         this.dynamicSquad.visible = this._data.squadIndex > 0;
      }
      
      protected function updateRespawnTimer() : void
      {
         var _loc1_:int = 0;
         _loc1_ = this._data.secondsToRespawn;
         this.respawnTimer.secondsToRespawn = _loc1_;
         var _loc2_:Boolean = _loc1_ > 0;
         this.respawnTimer.visible = _loc2_;
         this.chatCommandState.visible = this._isChatCommVisibilityEnabled && !_loc2_;
      }
      
      public function get accountDBID() : Number
      {
         return Boolean(this._data) ? Number(this._data.accountDBID) : Number(NaN);
      }
      
      public function set isSpeaking(param1:Boolean) : void
      {
         if(this._isSpeaking == param1)
         {
            return;
         }
         this._isSpeaking = param1;
         invalidate(PlayersPanelInvalidationType.IS_SPEAKING);
      }
      
      public function set state(param1:String) : void
      {
         if(this._state == param1)
         {
            return;
         }
         this._state = param1;
         invalidateState();
      }
      
      public function set isPlayerSwitchingAllowed(param1:Boolean) : void
      {
         if(this._isPlayerSwitchingAllowed == param1)
         {
            return;
         }
         this._isPlayerSwitchingAllowed = param1;
         invalidateData();
      }
      
      public function set isChatCommVisibilityEnabled(param1:Boolean) : void
      {
         if(this._isChatCommVisibilityEnabled == param1)
         {
            return;
         }
         this._isChatCommVisibilityEnabled = param1;
         this.updateRespawnTimer();
      }
      
      public function get vehicleID() : int
      {
         return Boolean(this._data) ? int(this._data.vehicleID) : int(0);
      }
      
      public function set data(param1:Object) : void
      {
         if(this._data == param1)
         {
            return;
         }
         if(this._data)
         {
            this._data.removeEventListener(Event.CHANGE,this.onDataChangeHandler);
         }
         this._data = HBPlayerInfoVO(param1);
         if(this._data)
         {
            this._data.addEventListener(Event.CHANGE,this.onDataChangeHandler);
         }
         invalidate();
      }
      
      private function onDataChangeHandler(param1:Event) : void
      {
         invalidate();
      }
   }
}
