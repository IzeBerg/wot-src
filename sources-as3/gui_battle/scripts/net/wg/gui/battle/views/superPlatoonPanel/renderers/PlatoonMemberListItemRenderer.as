package net.wg.gui.battle.views.superPlatoonPanel.renderers
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.components.stats.playersPanel.ChatCommandItemComponent;
   import net.wg.gui.battle.components.stats.playersPanel.list.HPBarPlayersPanelListItem;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.constants.PlayersPanelInvalidationType;
   import net.wg.gui.battle.random.views.stats.constants.VehicleActions;
   import net.wg.gui.battle.views.stats.SpeakAnimation;
   import net.wg.gui.battle.views.stats.constants.PlayerStatusSchemeName;
   import net.wg.gui.battle.views.stats.constants.SquadInvalidationType;
   import net.wg.infrastructure.interfaces.IColorScheme;
   import net.wg.infrastructure.interfaces.IUserProps;
   import scaleform.gfx.TextFieldEx;
   
   public class PlatoonMemberListItemRenderer extends BattleUIComponent
   {
      
      private static const UNKNOWN_VEHICLE_LEVEL:int = -1;
      
      private static const CHAT_COMMAND_OFFSET:int = 206;
      
      private static const ALT_TEXT_COLOR:uint = 16777215;
       
      
      public var hit:Sprite = null;
      
      public var ranks:MovieClip = null;
      
      public var fragsTF:TextField = null;
      
      public var playerNameTF:TextField = null;
      
      public var disableCommunication:BattleAtlasSprite = null;
      
      public var icoIGR:BattleAtlasSprite = null;
      
      public var vehicleLevel:BattleAtlasSprite = null;
      
      public var vehicleIcon:BattleAtlasSprite = null;
      
      public var actionMarker:BattleAtlasSprite = null;
      
      public var mute:BattleAtlasSprite = null;
      
      public var speakAnimation:SpeakAnimation = null;
      
      public var selfBg:MovieClip = null;
      
      public var bg:MovieClip = null;
      
      public var deadBg:MovieClip = null;
      
      public var noSound:BattleAtlasSprite = null;
      
      public var chatCommandState:ChatCommandItemComponent = null;
      
      public var holderItemID:Number = -1;
      
      public var hpBarPlayersPanelListItem:HPBarPlayersPanelListItem = null;
      
      private var _frags:int = 0;
      
      private var _rank:int = 0;
      
      private var _noSound:Boolean = false;
      
      private var _isMute:Boolean = false;
      
      private var _isSpeaking:Boolean = false;
      
      private var _isAlive:Boolean = true;
      
      private var _isOffline:Boolean = false;
      
      private var _isTeamKiller:Boolean = false;
      
      private var _isIGR:Boolean = false;
      
      private var _vehicleImage:String = null;
      
      private var _vehicleLevel:int = 0;
      
      private var _isSelected:Boolean = false;
      
      private var _isCurrentPlayer:Boolean = false;
      
      private var _isIgnoredTmp:Boolean = false;
      
      private var _percentHP:int = 0;
      
      public function PlatoonMemberListItemRenderer()
      {
         super();
         this.fragsTF.mouseEnabled = false;
         this.icoIGR.mouseEnabled = false;
         this.vehicleLevel.mouseEnabled = false;
         this.vehicleLevel.isCentralize = true;
         this.vehicleIcon.mouseEnabled = false;
         this.mute.mouseEnabled = false;
         this.speakAnimation.mouseEnabled = false;
         this.speakAnimation.mouseChildren = false;
         this.actionMarker.mouseEnabled = false;
         this.chatCommandState.mouseEnabled = false;
         TextFieldEx.setNoTranslate(this.fragsTF,true);
         this.hitArea = this.hit;
      }
      
      override protected function onDispose() : void
      {
         this.speakAnimation.dispose();
         this.disableCommunication = null;
         this.chatCommandState.dispose();
         this.chatCommandState = null;
         this.fragsTF = null;
         this.icoIGR = null;
         this.vehicleLevel = null;
         this.vehicleIcon = null;
         this.mute = null;
         this.noSound = null;
         this.speakAnimation = null;
         this.selfBg = null;
         this.bg = null;
         this.deadBg = null;
         this.actionMarker = null;
         this.hit = null;
         this.ranks = null;
         this.playerNameTF = null;
         this.hpBarPlayersPanelListItem.dispose();
         this.hpBarPlayersPanelListItem = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.icoIGR.visible = false;
         this.icoIGR.imageName = BATTLEATLAS.ICO_IGR;
         this.mute.visible = false;
         this.mute.imageName = BATTLEATLAS.STATS_MUTE;
         this.noSound.visible = false;
         this.noSound.imageName = BATTLEATLAS.SQUAD_NO_SOUND;
         if(this.disableCommunication)
         {
            this.disableCommunication.visible = false;
            this.disableCommunication.imageName = BATTLEATLAS.ICON_TOXIC_CHAT_OFF;
         }
         this.selfBg.visible = false;
         this.deadBg.visible = false;
         this.chatCommandState.iconOffset(CHAT_COMMAND_OFFSET);
         this.hpBarPlayersPanelListItem.setParentX(this.x);
         this.hpBarPlayersPanelListItem.setVehicleIconX(this.vehicleIcon.x);
         this.hpBarPlayersPanelListItem.updateBarColor(false,true);
         this.hpBarPlayersPanelListItem.updateHP(this._percentHP);
         this.hpBarPlayersPanelListItem.visible = true;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(PlayersPanelInvalidationType.FRAGS))
         {
            this.fragsTF.text = Boolean(this._frags) ? this._frags.toString() : Values.EMPTY_STR;
         }
         if(isInvalid(PlayersPanelInvalidationType.MUTE))
         {
            this.mute.visible = this._isMute;
            this.speakAnimation.mute = this._isMute;
            if(!this._isMute && this._isSpeaking)
            {
               this.speakAnimation.speaking = true;
            }
            if(this.disableCommunication)
            {
               this.disableCommunication.visible = this._isIgnoredTmp;
            }
         }
         if(isInvalid(PlayersPanelInvalidationType.IS_SPEAKING))
         {
            this.speakAnimation.speaking = this._isSpeaking;
         }
         if(isInvalid(PlayersPanelInvalidationType.SELECTED))
         {
            this.selfBg.visible = false;
         }
         if(isInvalid(PlayersPanelInvalidationType.ALIVE))
         {
            this.bg.visible = this._isAlive;
            this.deadBg.visible = !this._isAlive;
         }
         if(isInvalid(PlayersPanelInvalidationType.PLAYER_SCHEME))
         {
            this.updateColors();
         }
         if(isInvalid(PlayersPanelInvalidationType.IGR_CHANGED))
         {
            this.icoIGR.visible = this._isIGR;
         }
         if(isInvalid(SquadInvalidationType.SQUAD_NO_SOUND))
         {
            this.noSound.visible = this._noSound;
         }
         if(isInvalid(PlayersPanelInvalidationType.RANK_CHANGED))
         {
            this.ranks.visible = true;
            this.ranks.gotoAndStop(this._rank);
         }
         if(isInvalid(PlayersPanelInvalidationType.HP_BAR_VISIBILITY))
         {
            this.hpBarPlayersPanelListItem.visible = this._isAlive;
         }
      }
      
      public function isIgnoredTmp(param1:Boolean) : void
      {
         if(this._isIgnoredTmp == param1 || this.disableCommunication == null)
         {
            return;
         }
         this._isIgnoredTmp = param1;
         invalidate(PlayersPanelInvalidationType.MUTE);
      }
      
      public function setFrags(param1:int) : void
      {
         if(this._frags == param1)
         {
            return;
         }
         this._frags = param1;
         invalidate(PlayersPanelInvalidationType.FRAGS);
      }
      
      public function setIsAlive(param1:Boolean) : void
      {
         if(this._isAlive == param1)
         {
            return;
         }
         this._isAlive = param1;
         invalidate(PlayersPanelInvalidationType.ALIVE | PlayersPanelInvalidationType.PLAYER_SCHEME | PlayersPanelInvalidationType.HP_BAR_VISIBILITY);
      }
      
      public function setIsCurrentPlayer(param1:Boolean) : void
      {
         if(this._isCurrentPlayer == param1)
         {
            return;
         }
         this._isCurrentPlayer = param1;
         invalidate(PlayersPanelInvalidationType.PLAYER_SCHEME);
      }
      
      public function setIsIGR(param1:Boolean) : void
      {
         if(this._isIGR == param1)
         {
            return;
         }
         this._isIGR = param1;
         invalidate(PlayersPanelInvalidationType.IGR_CHANGED);
      }
      
      public function setIsMute(param1:Boolean) : void
      {
         if(this._isMute == param1)
         {
            return;
         }
         this._isMute = param1;
         invalidate(PlayersPanelInvalidationType.MUTE);
      }
      
      public function setIsOffline(param1:Boolean) : void
      {
         if(this._isOffline == param1)
         {
            return;
         }
         this._isOffline = param1;
         invalidate(PlayersPanelInvalidationType.PLAYER_SCHEME);
      }
      
      public function setIsSelected(param1:Boolean) : void
      {
         if(this._isSelected == param1)
         {
            return;
         }
         this._isSelected = param1;
         invalidate(PlayersPanelInvalidationType.SELECTED);
      }
      
      public function setIsSpeaking(param1:Boolean) : void
      {
         if(this._isSpeaking == param1)
         {
            return;
         }
         this._isSpeaking = param1;
         invalidate(PlayersPanelInvalidationType.IS_SPEAKING);
      }
      
      public function setIsTeamKiller(param1:Boolean) : void
      {
         if(this._isTeamKiller == param1)
         {
            return;
         }
         this._isTeamKiller = param1;
         invalidate(PlayersPanelInvalidationType.PLAYER_SCHEME);
      }
      
      public function setPlayerNameProps(param1:IUserProps) : void
      {
         App.utils.commons.truncateTextFieldText(this.playerNameTF,param1.userName);
      }
      
      public function setRank(param1:int) : void
      {
         if(this._rank == param1)
         {
            return;
         }
         this._rank = param1;
         invalidate(PlayersPanelInvalidationType.RANK_CHANGED);
      }
      
      public function setSquadNoSound(param1:Boolean) : void
      {
         if(param1 == this._noSound)
         {
            return;
         }
         this._noSound = param1;
         invalidate(SquadInvalidationType.SQUAD_NO_SOUND);
      }
      
      public function setVehicleAction(param1:int) : void
      {
         this.actionMarker.imageName = BATTLEATLAS.getVehicleActionMarker(VehicleActions.getActionName(param1));
         this.actionMarker.visible = true;
      }
      
      public function setVehicleIcon(param1:String) : void
      {
         if(this._vehicleImage == param1)
         {
            return;
         }
         this._vehicleImage = param1;
         this.vehicleIcon.setImageNames(param1,BATTLEATLAS.UNKNOWN);
      }
      
      public function setVehicleLevel(param1:int) : void
      {
         if(this._vehicleLevel == param1 || param1 == UNKNOWN_VEHICLE_LEVEL)
         {
            return;
         }
         this._vehicleLevel = param1;
         this.vehicleLevel.isCentralize = true;
         this.vehicleLevel.imageName = BATTLEATLAS.level(this._vehicleLevel.toString());
      }
      
      public function updateColorBlind() : void
      {
         invalidate(PlayersPanelInvalidationType.PLAYER_SCHEME);
      }
      
      public function setChatCommand(param1:String, param2:uint) : void
      {
         this.chatCommandState.setActiveChatCommand(param1,param2);
      }
      
      public function triggerChatCommand(param1:String) : void
      {
         this.chatCommandState.playCommandAnimation(param1);
      }
      
      public function setChatCommandsVisibility(param1:Boolean) : void
      {
         this.chatCommandState.setChatCommandVisibility(param1);
      }
      
      public function setPanelHPBarVisibilityState(param1:uint) : void
      {
      }
      
      public function setPlayerHP(param1:int) : void
      {
         this._percentHP = param1;
         this.hpBarPlayersPanelListItem.updateHP(param1);
      }
      
      public function setOverrideExInfo(param1:Boolean) : void
      {
      }
      
      private function updateColors() : void
      {
         var _loc1_:String = PlayerStatusSchemeName.getSchemeNameForVehicle(this._isCurrentPlayer,true,this._isTeamKiller,!this._isAlive,this._isOffline);
         var _loc2_:IColorScheme = App.colorSchemeMgr.getScheme(_loc1_);
         if(_loc2_)
         {
            this.vehicleIcon.transform.colorTransform = _loc2_.colorTransform;
         }
         _loc1_ = PlayerStatusSchemeName.getSchemeForVehicleLevel(!this._isAlive);
         _loc2_ = App.colorSchemeMgr.getScheme(_loc1_);
         if(_loc2_)
         {
            this.vehicleLevel.transform.colorTransform = _loc2_.colorTransform;
         }
         if(this.fragsTF.textColor != ALT_TEXT_COLOR)
         {
            this.fragsTF.textColor = ALT_TEXT_COLOR;
         }
         if(this.playerNameTF.textColor != ALT_TEXT_COLOR)
         {
            this.playerNameTF.textColor = ALT_TEXT_COLOR;
         }
         this.chatCommandState.updateColors(App.colorSchemeMgr.getIsColorBlindS());
      }
   }
}
