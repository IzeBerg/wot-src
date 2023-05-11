package net.wg.gui.battle.epicRandom.views.stats.components.playersPanel.list
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.data.constants.generated.PLAYERS_PANEL_STATE;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.components.stats.playersPanel.ChatCommandItemComponent;
   import net.wg.gui.battle.components.stats.playersPanel.SpottedIndicator;
   import net.wg.gui.battle.components.stats.playersPanel.list.HPBarPlayersPanelListItem;
   import net.wg.gui.battle.epicRandom.views.stats.components.playersPanel.events.PlayersPanelItemEvent;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.constants.PlayersPanelInvalidationType;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.list.PlayersPanelDynamicSquad;
   import net.wg.gui.battle.views.stats.SpeakAnimation;
   import net.wg.gui.battle.views.stats.constants.PlayerStatusSchemeName;
   import net.wg.gui.components.controls.BadgeComponent;
   import net.wg.gui.components.controls.VO.BadgeVisualVO;
   import net.wg.gui.components.dogtag.VO.DogTagVO;
   import net.wg.infrastructure.interfaces.IColorScheme;
   import net.wg.infrastructure.interfaces.IUserProps;
   import net.wg.utils.ICommons;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.gfx.TextFieldEx;
   
   public class PlayersPanelListItem extends BattleUIComponent
   {
      
      private static const BADGE_OFFSET:int = 2;
      
      private static const BADGE_ICON_AREA_WIDTH:int = 24;
      
      private static const LEFT_SITE_SHORT_TF_OFFSET:int = 49;
      
      private static const SHORT_TF_EXTENDED_WIDTH:int = 60;
      
      private static const SHORT_TF_SHORT_WIDTH:int = 36;
      
      private static const ALPHA_MULTIPLIER_SEMI_VISIBLE:Number = 0.8;
      
      private static const ALPHA_MULTIPLIER_FULLY_VISIBLE:Number = 1;
      
      private static const TOXIC_CHAT_ICON_WIDTH:int = 16;
      
      private static const MUTE_ICON_WIDTH:int = 128;
      
      private static const DOG_TAG_ICON_OFFSET:int = 33;
      
      private static const SPOTTED_INDICATOR_VEH_ICON_Y_OFFSET:int = 3;
      
      private static const SPOTTED_INDICATOR_VEH_ICON_X_OFFSET:int = -11;
      
      private static const HP_BAR_HEIGHT_EPIC_RANDOM:int = 31;
      
      private static const HP_BAR_Y_OFFSET_EPIC_RANDOM:int = 1;
       
      
      public var dynamicSquad:PlayersPanelDynamicSquad;
      
      public var hit:Sprite = null;
      
      public var shortTitleTF:TextField = null;
      
      public var fragsTF:TextField = null;
      
      public var disableCommunication:BattleAtlasSprite = null;
      
      public var vehicleIcon:BattleAtlasSprite = null;
      
      public var mute:BattleAtlasSprite = null;
      
      public var speakAnimation:SpeakAnimation = null;
      
      public var badge:BadgeComponent = null;
      
      public var deadBg:MovieClip = null;
      
      public var chatCommandState:ChatCommandItemComponent = null;
      
      public var spottedIndicator:SpottedIndicator = null;
      
      public var holderItemID:int = -1;
      
      public var dogTagIcon:BattleAtlasSprite = null;
      
      public var hpBarPlayersPanelListItem:HPBarPlayersPanelListItem = null;
      
      private var _state:uint = 0;
      
      private var _isCurrentPlayer:Boolean = false;
      
      private var _vehicleName:String = null;
      
      private var _frags:int = 0;
      
      private var _badgeVO:BadgeVisualVO = null;
      
      private var _isMute:Boolean = false;
      
      private var _isSpeaking:Boolean = false;
      
      private var _isAlive:Boolean = true;
      
      private var _isOffline:Boolean = false;
      
      private var _isSquadPersonal:Boolean = false;
      
      private var _isTeamKiller:Boolean = false;
      
      private var _isIGR:Boolean = false;
      
      private var _vehicleImage:String = null;
      
      private var _isIgnoredTmp:Boolean = false;
      
      private var _isSelected:Boolean = false;
      
      private var _isRightAligned:Boolean = false;
      
      private var _columnNumberChanged:Boolean = false;
      
      private var _isVisibleState:Boolean = false;
      
      private var _columnNumber:int = 0;
      
      private var _rendererSettings:PlayersPanelListItemSettings = null;
      
      private var _hasBadge:Boolean = false;
      
      private var _commons:ICommons = null;
      
      private var _userProps:IUserProps = null;
      
      private var _showDogTag:Boolean = false;
      
      private var _dogTag:DogTagVO = null;
      
      private var _hpBarsVisible:Boolean = false;
      
      private var _hpSettingValue:uint = 0;
      
      public function PlayersPanelListItem()
      {
         super();
         this._commons = App.utils.commons;
         this.fragsTF.mouseEnabled = false;
         this.shortTitleTF.mouseEnabled = false;
         this.vehicleIcon.visible = false;
         this.vehicleIcon.mouseEnabled = false;
         this.vehicleIcon.isSmoothingEnabled = true;
         this.mute.mouseEnabled = false;
         this.speakAnimation.mouseEnabled = false;
         this.speakAnimation.mouseChildren = false;
         this.badge.mouseEnabled = this.badge.mouseChildren = false;
         this.chatCommandState.mouseEnabled = false;
         TextFieldEx.setNoTranslate(this.shortTitleTF,true);
         this.hitArea = this.hit;
         addEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
         removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         this.dynamicSquad.dispose();
         this.speakAnimation.dispose();
         this.chatCommandState.dispose();
         this.spottedIndicator.dispose();
         this.disableCommunication = null;
         this.dogTagIcon = null;
         this.fragsTF = null;
         this.shortTitleTF = null;
         this.dynamicSquad = null;
         this.vehicleIcon = null;
         this.mute = null;
         this.speakAnimation = null;
         this.deadBg = null;
         this.hit = null;
         this.spottedIndicator = null;
         this.chatCommandState = null;
         this._rendererSettings = null;
         this.badge.dispose();
         this.badge = null;
         this.hpBarPlayersPanelListItem.dispose();
         this.hpBarPlayersPanelListItem = null;
         this._badgeVO = null;
         this._userProps = null;
         this._commons = null;
         this._dogTag = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.mute.visible = false;
         this.mute.imageName = !!this._isRightAligned ? BATTLEATLAS.RIGHT_STATS_MUTE : BATTLEATLAS.LEFT_STATS_MUTE;
         if(this.dogTagIcon)
         {
            this.dogTagIcon.visible = false;
            this.dogTagIcon.imageName = BATTLEATLAS.DOG_TAG_MEDAL;
            this.dogTagIcon.mouseEnabled = false;
            this.dogTagIcon.mouseChildren = false;
         }
         if(this.disableCommunication)
         {
            this.disableCommunication.visible = false;
            this.disableCommunication.imageName = BATTLEATLAS.ICON_TOXIC_CHAT_OFF;
         }
         this.deadBg.visible = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(PlayersPanelInvalidationType.BADGE_CHANGED))
         {
            this.badge.visible = this._hasBadge && (this._state == PlayersPanelListItemState.MEDIUM_PLAYER_RENDERER_STATE || this._state == PlayersPanelListItemState.MEDIUM_TANK_RENDERER_STATE);
         }
         if(isInvalid(PlayersPanelInvalidationType.DOG_TAG_CHANGED))
         {
            if(this.dogTagIcon)
            {
               this.dogTagIcon.visible = this._showDogTag && this._isVisibleState;
               this.applyListItemState(this._state);
            }
         }
         if(isInvalid(PlayersPanelInvalidationType.FRAGS))
         {
            this.fragsTF.text = Boolean(this._frags) ? this._frags.toString() : Values.EMPTY_STR;
         }
         if(isInvalid(PlayersPanelInvalidationType.MUTE))
         {
            this.mute.visible = this._isMute && this._isVisibleState;
            if(this._isSpeaking)
            {
               if(this._isMute)
               {
                  this.speakAnimation.reset();
               }
               else
               {
                  this.speakAnimation.speaking = true;
               }
            }
            if(this.disableCommunication)
            {
               this.disableCommunication.visible = this._isIgnoredTmp && this._isVisibleState;
            }
         }
         if(isInvalid(PlayersPanelInvalidationType.IS_SPEAKING))
         {
            if(!this._isMute)
            {
               this.speakAnimation.speaking = this._isSpeaking;
            }
         }
         if(isInvalid(PlayersPanelInvalidationType.ALIVE))
         {
            this.badge.alpha = !!this._isAlive ? Number(1) : Number(0.7);
            this.deadBg.visible = !this._isAlive;
         }
         if(isInvalid(PlayersPanelInvalidationType.PLAYER_SCHEME))
         {
            this.updateColors();
         }
         if(isInvalid(InvalidationType.STATE))
         {
            this.applyListItemState(this._state);
         }
         if(isInvalid(PlayersPanelInvalidationType.HP_BAR_VISIBILITY))
         {
            this.hpBarPlayersPanelListItem.visible = this._hpBarsVisible && this._isAlive && this._isVisibleState;
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
      
      public function setBadge(param1:BadgeVisualVO, param2:Boolean) : void
      {
         if(this._badgeVO == null || !this._badgeVO.isEquals(param1))
         {
            this._badgeVO = param1;
            this._hasBadge = param1 != null && param2;
            this.badge.setData(param1);
            invalidate(PlayersPanelInvalidationType.BADGE_CHANGED);
         }
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
      
      public function setCharCommand(param1:String, param2:uint) : void
      {
         this.chatCommandState.setActiveChatCommand(param1,param2);
      }
      
      public function triggerChatCommand(param1:String) : void
      {
         this.chatCommandState.playCommandAnimation(param1);
      }
      
      public function setChatCommandVisibility(param1:Boolean) : void
      {
         this.chatCommandState.setChatCommandVisibility(param1);
      }
      
      public function setPanelHPBarVisibilityState(param1:uint) : void
      {
         this._hpSettingValue = param1;
         this._hpBarsVisible = param1 == PLAYERS_PANEL_STATE.ALWAYS_SHOW_HP;
         invalidate(PlayersPanelInvalidationType.HP_BAR_VISIBILITY | PlayersPanelInvalidationType.ALIVE | PlayersPanelInvalidationType.PLAYER_SCHEME);
      }
      
      public function setVehicleHealth(param1:int) : void
      {
         this.hpBarPlayersPanelListItem.updateHP(param1);
      }
      
      public function setOverrideExInfo(param1:Boolean) : void
      {
         this._hpBarsVisible = this._hpSettingValue == PLAYERS_PANEL_STATE.ALWAYS_SHOW_HP || param1 && this._hpSettingValue == PLAYERS_PANEL_STATE.SHOW_HP_ON_ALT;
         invalidate(PlayersPanelInvalidationType.HP_BAR_VISIBILITY | PlayersPanelInvalidationType.ALIVE | PlayersPanelInvalidationType.PLAYER_SCHEME);
      }
      
      public function setSpottedStatus(param1:uint) : void
      {
         this.spottedIndicator.updateSpottedStatus(param1);
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
      
      public function setIsInteractive(param1:Boolean) : void
      {
         this.dynamicSquad.setIsInteractive(param1);
      }
      
      public function setIsInviteShown(param1:Boolean) : void
      {
         this.dynamicSquad.setIsInviteShown(param1);
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
      
      public function setIsRightAligned(param1:Boolean) : void
      {
         if(this._isRightAligned == param1)
         {
            return;
         }
         this._isRightAligned = param1;
         this.dynamicSquad.setIsEnemy(param1);
         this.hpBarPlayersPanelListItem.setRightAligned(param1);
         invalidateState();
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
         this._userProps = param1;
         invalidateState();
      }
      
      public function setSquad(param1:Boolean, param2:int) : void
      {
         this.dynamicSquad.setCurrentSquad(param1,param2);
         if(this._isSquadPersonal != param1)
         {
            this._isSquadPersonal = param1;
            invalidate(PlayersPanelInvalidationType.PLAYER_SCHEME);
         }
      }
      
      public function setSquadNoSound(param1:Boolean) : void
      {
         this.dynamicSquad.setNoSound(param1);
      }
      
      public function setSquadState(param1:int) : void
      {
         this.dynamicSquad.setState(param1);
      }
      
      public function setState(param1:uint) : void
      {
         if(this._state == param1 && !this._columnNumberChanged)
         {
            return;
         }
         this._state = param1;
         this._columnNumberChanged = false;
         this.applyListItemState(param1);
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
      
      public function setVehicleName(param1:String) : void
      {
         if(this._vehicleName == param1)
         {
            return;
         }
         this._vehicleName = param1;
      }
      
      public function updateColorBlind() : void
      {
         invalidate(PlayersPanelInvalidationType.PLAYER_SCHEME);
      }
      
      private function invalidateVariableElements() : void
      {
         invalidate(PlayersPanelInvalidationType.IS_SPEAKING);
         invalidate(PlayersPanelInvalidationType.MUTE);
      }
      
      public function showDogTag(param1:DogTagVO) : void
      {
         this._showDogTag = true;
         this._dogTag = param1;
         invalidate(PlayersPanelInvalidationType.DOG_TAG_CHANGED);
      }
      
      public function get dogTag() : DogTagVO
      {
         return this._dogTag;
      }
      
      private function applyListItemState(param1:int) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         if(param1 == PlayersPanelListItemState.HIDDEN_RENDERER_STATE)
         {
            visible = false;
         }
         else
         {
            _loc2_ = param1 == PlayersPanelListItemState.MEDIUM_TANK_RENDERER_STATE || param1 == PlayersPanelListItemState.SECOND_COLUMN_MEDIUM_TANK_RENDERER_STATE || param1 == PlayersPanelListItemState.THIRD_COLUMN_MEDIUM_TANK_RENDERER_STATE;
            _loc3_ = param1 == PlayersPanelListItemState.MEDIUM_PLAYER_RENDERER_STATE || param1 == PlayersPanelListItemState.SECOND_COLUMN_MEDIUM_PLAYER_RENDERER_STATE || param1 == PlayersPanelListItemState.THIRD_COLUMN_MEDIUM_PLAYER_RENDERER_STATE;
            if(!this.vehicleIcon.visible)
            {
               this.vehicleIcon.visible = true;
            }
            this.shortTitleTF.visible = _loc2_ || _loc3_;
            this.badge.visible = this._hasBadge && (_loc2_ || _loc3_);
            this._isVisibleState = param1 == PlayersPanelListItemState.SHORT_RENDERER_STATE || _loc2_ || _loc3_ || param1 == PlayersPanelListItemState.SECOND_COLUMN_SHORT_RENDERER_STATE || param1 == PlayersPanelListItemState.THIRD_COLUMN_SHORT_RENDERER_STATE;
            this.fragsTF.visible = this._isVisibleState;
            this.dynamicSquad.visible = this._isVisibleState && !this._showDogTag;
            if(this.dogTagIcon)
            {
               this.dogTagIcon.visible = this._showDogTag && this._isVisibleState;
            }
            this.chatCommandState.visible = this._isVisibleState;
            this.spottedIndicator.shouldBeShown = this._isVisibleState;
            this.hpBarPlayersPanelListItem.visible = this._hpBarsVisible && this._isAlive && this._isVisibleState;
            this.invalidateVariableElements();
            if(this._hasBadge && (_loc2_ || _loc3_))
            {
               _loc4_ = !!this._isRightAligned ? int(-LEFT_SITE_SHORT_TF_OFFSET - (BADGE_ICON_AREA_WIDTH + BADGE_OFFSET) - SHORT_TF_SHORT_WIDTH) : int(BADGE_ICON_AREA_WIDTH + BADGE_OFFSET + LEFT_SITE_SHORT_TF_OFFSET);
               this.shortTitleTF.x = _loc4_;
               this.shortTitleTF.width = SHORT_TF_SHORT_WIDTH;
            }
            else
            {
               this.shortTitleTF.x = !!this._isRightAligned ? Number(-LEFT_SITE_SHORT_TF_OFFSET - SHORT_TF_EXTENDED_WIDTH) : Number(LEFT_SITE_SHORT_TF_OFFSET);
               this.shortTitleTF.width = SHORT_TF_EXTENDED_WIDTH;
            }
            if(_loc2_)
            {
               if(StringUtils.isNotEmpty(this._vehicleName))
               {
                  this._commons.truncateTextFieldText(this.shortTitleTF,this._vehicleName);
               }
            }
            else if(_loc3_)
            {
               if(this._userProps)
               {
                  this._commons.truncateTextFieldText(this.shortTitleTF,this._userProps.userName);
                  this._commons.formatPlayerName(this.shortTitleTF,this._userProps,!this._isCurrentPlayer,this._isCurrentPlayer);
               }
            }
            visible = true;
            this.invalidateVariableElements();
            this._rendererSettings = PlayersPanelListItemState.generateStateSettings(param1,this._columnNumber);
            this.updatePositions();
         }
      }
      
      private function updatePositions() : void
      {
         this.hit.x = 0;
         this.vehicleIcon.y = this._rendererSettings.vehicleIconYOffset;
         this.vehicleIcon.scaleX = this.vehicleIcon.scaleY = this._rendererSettings.vehicleIconScale / 100;
         this.speakAnimation.x = this._rendererSettings.speakAnimationX;
         this.speakAnimation.y = this._rendererSettings.speakAnimationY;
         this.deadBg.width = this._rendererSettings.deadBgWidth;
         this.hit.width = this._rendererSettings.hitWidth;
         this.chatCommandState.y = this._rendererSettings.chatCommunicationIconYOffset;
         this.spottedIndicator.y = this._rendererSettings.vehicleIconYOffset + SPOTTED_INDICATOR_VEH_ICON_Y_OFFSET;
         if(this._isRightAligned)
         {
            this.deadBg.x = -this._rendererSettings.deadBgX;
            this.mute.x = -MUTE_ICON_WIDTH - this._rendererSettings.muteX;
            this.disableCommunication.x = -TOXIC_CHAT_ICON_WIDTH - this._rendererSettings.disableCommX;
            this.vehicleIcon.x = -this._rendererSettings.vehicleIconXOffset;
            this.chatCommandState.iconOffset(-this._rendererSettings.chatCommunicationIconXOffset);
            this.spottedIndicator.x = -this._rendererSettings.vehicleIconXOffset + SPOTTED_INDICATOR_VEH_ICON_X_OFFSET;
            x = -this._rendererSettings.xPosition;
         }
         else
         {
            this.deadBg.x = this._rendererSettings.deadBgX;
            this.mute.x = this._rendererSettings.muteX;
            this.disableCommunication.x = this._rendererSettings.disableCommX;
            this.vehicleIcon.x = this._rendererSettings.vehicleIconXOffset;
            this.chatCommandState.iconOffset(this._rendererSettings.chatCommunicationIconXOffset);
            x = this._rendererSettings.xPosition;
         }
         if(this.dogTagIcon)
         {
            this.dogTagIcon.x = -DOG_TAG_ICON_OFFSET;
         }
         this.chatCommandState.x = this.dynamicSquad.x;
         this.hpBarPlayersPanelListItem.setHPBarHeight(HP_BAR_HEIGHT_EPIC_RANDOM);
         this.hpBarPlayersPanelListItem.setParentX(this.dynamicSquad.x);
         this.hpBarPlayersPanelListItem.setOffsetY(HP_BAR_Y_OFFSET_EPIC_RANDOM);
         this.hpBarPlayersPanelListItem.setVehicleIconX(this.vehicleIcon.x);
      }
      
      private function updateColors() : void
      {
         var _loc4_:uint = 0;
         var _loc1_:String = PlayerStatusSchemeName.getSchemeNameForVehicle(this._isCurrentPlayer,this._isSquadPersonal,this._isTeamKiller,!this._isAlive,this._isOffline);
         var _loc2_:IColorScheme = App.colorSchemeMgr.getScheme(_loc1_);
         if(_loc2_)
         {
            _loc2_.colorTransform.alphaMultiplier = !this._isAlive ? Number(ALPHA_MULTIPLIER_SEMI_VISIBLE) : Number(ALPHA_MULTIPLIER_FULLY_VISIBLE);
            this.vehicleIcon.transform.colorTransform = _loc2_.colorTransform;
         }
         _loc1_ = PlayerStatusSchemeName.getSchemeNameForPlayer(this._isCurrentPlayer,this._isSquadPersonal,this._isTeamKiller,!this._isAlive,this._isOffline);
         _loc2_ = App.colorSchemeMgr.getScheme(_loc1_);
         if(_loc2_)
         {
            _loc4_ = _loc2_.rgb;
            if(this.fragsTF.textColor != _loc4_)
            {
               this.fragsTF.textColor = _loc4_;
            }
            if(this.shortTitleTF.textColor != _loc4_)
            {
               this.shortTitleTF.textColor = _loc4_;
            }
         }
         var _loc3_:Boolean = App.colorSchemeMgr.getIsColorBlindS();
         this.chatCommandState.updateColors(_loc3_);
         this.hpBarPlayersPanelListItem.updateBarColor(App.colorSchemeMgr.getIsColorBlindS());
      }
      
      public function get columnNumber() : int
      {
         return this._columnNumber;
      }
      
      public function set columnNumber(param1:int) : void
      {
         if(param1 != this._columnNumber)
         {
            this._columnNumberChanged = true;
         }
         this._columnNumber = param1;
      }
      
      private function onMouseOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:PlayersPanelItemEvent = new PlayersPanelItemEvent(PlayersPanelItemEvent.ON_ITEM_OVER,this,this.holderItemID,param1);
         dispatchEvent(_loc2_);
         this.dynamicSquad.onItemOver();
      }
      
      private function onMouseOutHandler(param1:MouseEvent) : void
      {
         var _loc2_:PlayersPanelItemEvent = new PlayersPanelItemEvent(PlayersPanelItemEvent.ON_ITEM_OUT,this,this.holderItemID,param1);
         dispatchEvent(_loc2_);
         this.dynamicSquad.onItemOut();
      }
      
      private function onMouseClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:PlayersPanelItemEvent = new PlayersPanelItemEvent(PlayersPanelItemEvent.ON_ITEM_CLICK,this,this.holderItemID,param1);
         dispatchEvent(_loc2_);
      }
   }
}
