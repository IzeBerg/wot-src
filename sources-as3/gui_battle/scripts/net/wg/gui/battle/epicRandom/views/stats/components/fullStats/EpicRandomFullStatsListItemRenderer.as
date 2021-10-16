package net.wg.gui.battle.epicRandom.views.stats.components.fullStats
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.PlayerStatus;
   import net.wg.data.constants.UserTags;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.battleloading.BattleLoadingHelper;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.components.PlayerStatusView;
   import net.wg.gui.battle.components.buttons.BattleButton;
   import net.wg.gui.battle.epicRandom.views.stats.events.EpicRandomFullStatsListItemRendererEvent;
   import net.wg.gui.battle.random.views.stats.components.fullStats.constants.RandomFullStatsValidationType;
   import net.wg.gui.battle.random.views.stats.components.fullStats.interfaces.ISquadHandler;
   import net.wg.gui.battle.random.views.stats.components.fullStats.tableItem.DynamicSquadCtrl;
   import net.wg.gui.battle.random.views.stats.constants.VehicleActions;
   import net.wg.gui.battle.views.stats.SpeakAnimation;
   import net.wg.gui.battle.views.stats.StatsUserProps;
   import net.wg.gui.battle.views.stats.constants.DynamicSquadState;
   import net.wg.gui.battle.views.stats.constants.FullStatsValidationType;
   import net.wg.gui.battle.views.stats.constants.PlayerStatusSchemeName;
   import net.wg.gui.battle.views.stats.fullStats.SquadInviteStatusView;
   import net.wg.gui.components.controls.BadgeComponent;
   import net.wg.gui.components.controls.VO.BadgeVisualVO;
   import net.wg.gui.components.dogtag.DogtagComponent;
   import net.wg.gui.components.dogtag.VO.DogTagVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IColorScheme;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.ListData;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.gfx.TextFieldEx;
   
   public class EpicRandomFullStatsListItemRenderer extends UIComponentEx implements IListItemRenderer
   {
      
      private static const RANKED_BADGE_OFFSET:int = 1;
      
      private static const FIELD_WIDTH_COMPENSATION:int = 2;
       
      
      public var noSound:BattleAtlasSprite = null;
      
      public var hit:Sprite = null;
      
      public var playerName:TextField = null;
      
      public var vehicleName:TextField = null;
      
      public var frags:TextField = null;
      
      public var playerStatus:PlayerStatusView = null;
      
      public var vehicleType:BattleAtlasSprite = null;
      
      public var vehicleLevel:BattleAtlasSprite = null;
      
      public var squadStatus:SquadInviteStatusView = null;
      
      public var squad:BattleAtlasSprite = null;
      
      public var icoIGR:BattleAtlasSprite = null;
      
      public var vehicleIcon:BattleAtlasSprite = null;
      
      public var vehicleActionMarker:BattleAtlasSprite = null;
      
      public var mute:BattleAtlasSprite = null;
      
      public var speakAnimation:SpeakAnimation = null;
      
      public var deadBg:BattleAtlasSprite = null;
      
      public var selfBg:BattleAtlasSprite = null;
      
      public var rankBadge:BadgeComponent = null;
      
      public var testerIcon:BattleAtlasSprite = null;
      
      public var testerBG:BattleAtlasSprite = null;
      
      private var _userProps:StatsUserProps = null;
      
      private var _isOffline:Boolean = false;
      
      private var _isDead:Boolean = false;
      
      private var _showDogTag:Boolean = false;
      
      private var _isInBattle:Boolean = false;
      
      private var _isCurrentPlayer:Boolean = false;
      
      private var _isSquadPersonal:Boolean = false;
      
      private var _isTeamKiller:Boolean = false;
      
      private var _isMute:Boolean = false;
      
      private var _isSpeaking:Boolean = false;
      
      private var _squadItem:DynamicSquadCtrl = null;
      
      private var _badgeVO:BadgeVisualVO;
      
      private var _data:DAAPIVehicleInfoVO = null;
      
      private var _activePlayerData:DAAPIVehicleInfoVO = null;
      
      private var _isEnemy:Boolean = false;
      
      private var _vehicleName:String = null;
      
      private var _vehicleType:String = null;
      
      private var _isSelected:Boolean = false;
      
      private var _frags:int = 0;
      
      private var _isIGR:Boolean = false;
      
      private var _vehicleLevel:int = -1;
      
      private var _vehicleAction:String = null;
      
      private var _isRenderingRequired:Boolean = false;
      
      private var _isRenderingAvailable:Boolean = false;
      
      private var _vehicleImage:String = null;
      
      private var _index:int = 0;
      
      private var _defaultUsernameTFXPosition:int;
      
      private var _defaultUsernameTFWidth:int;
      
      private var _hasBadge:Boolean = false;
      
      private var _dogTag:DogtagComponent;
      
      private var _dogTagData:DogTagVO;
      
      public function EpicRandomFullStatsListItemRenderer()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.testerIcon = null;
         this.testerBG = null;
         this.noSound = null;
         this.hit = null;
         this.playerName = null;
         this.vehicleName = null;
         this.frags = null;
         this.vehicleType = null;
         this.vehicleLevel = null;
         this.squad = null;
         this.icoIGR = null;
         this.vehicleIcon = null;
         this.vehicleActionMarker = null;
         this.mute = null;
         this.deadBg = null;
         this.selfBg = null;
         this.rankBadge.dispose();
         this.rankBadge = null;
         this.squadStatus.dispose();
         this.squadStatus = null;
         this.playerStatus.dispose();
         this.playerStatus = null;
         this.speakAnimation.dispose();
         this.speakAnimation = null;
         if(this._squadItem)
         {
            this._squadItem.dispose();
            this._squadItem = null;
         }
         if(this._userProps)
         {
            this._userProps.dispose();
            this._userProps = null;
         }
         if(this._data)
         {
            this._data.dispose();
            this._data = null;
         }
         this._badgeVO = null;
         this._activePlayerData = null;
         if(this._dogTag)
         {
            this._dogTag.dispose();
            this._dogTag = null;
         }
         if(this._dogTagData)
         {
            this._dogTagData.dispose();
            this._dogTagData = null;
         }
         this.removeEventListener(MouseEvent.ROLL_OVER,this.dogTagFadeIn);
         this.removeEventListener(MouseEvent.ROLL_OUT,this.dogTagFadeOut);
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.icoIGR.visible = false;
         this.icoIGR.imageName = BATTLEATLAS.ICO_IGR;
         this.mute.visible = false;
         this.mute.imageName = BATTLEATLAS.LEFT_STATS_MUTE;
         this.deadBg.visible = false;
         this.deadBg.imageName = BATTLEATLAS.EPIC_STATS_DEAD_BG;
         this.selfBg.visible = false;
         this.selfBg.imageName = BATTLEATLAS.EPIC_STATS_SELF_BG;
         TextFieldEx.setNoTranslate(this.playerName,true);
         TextFieldEx.setNoTranslate(this.vehicleName,true);
         TextFieldEx.setNoTranslate(this.frags,true);
         this.frags.visible = false;
         this.playerStatus.visible = false;
         this._defaultUsernameTFXPosition = this.playerName.x;
         this._defaultUsernameTFWidth = this.playerName.width;
         this.vehicleLevel.isCentralizeByX = true;
         this.testerIcon.visible = false;
         this.testerBG.visible = false;
      }
      
      override protected function draw() : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:String = null;
         var _loc4_:IColorScheme = null;
         super.draw();
         var _loc1_:Boolean = false;
         if(isInvalid(FullStatsValidationType.BADGE))
         {
            this.rankBadge.visible = this._hasBadge;
            if(this.rankBadge.visible)
            {
               if(this._isEnemy)
               {
                  this.playerName.x = this.rankBadge.x - (this._defaultUsernameTFWidth - this.rankBadge.width) >> 0;
               }
               else
               {
                  this.playerName.x = this.rankBadge.x + (this.rankBadge.width + RANKED_BADGE_OFFSET) >> 0;
               }
               this.playerName.width = this._defaultUsernameTFWidth - (this.rankBadge.width + RANKED_BADGE_OFFSET) >> 0;
            }
            else
            {
               this.playerName.x = this._defaultUsernameTFXPosition;
               this.playerName.width = this._defaultUsernameTFWidth;
            }
            _loc1_ = true;
         }
         if(isInvalid(FullStatsValidationType.USER_PROPS))
         {
            if(this._userProps)
            {
               this.playerName.visible = true;
               _loc2_ = this.isCurrentPlayer();
               App.utils.commons.formatPlayerName(this.playerName,this._userProps,!_loc2_,_loc2_);
               _loc1_ = true;
            }
            else
            {
               this.playerName.visible = false;
            }
         }
         if(isInvalid(FullStatsValidationType.FRAGS))
         {
            this.frags.visible = this._frags != 0;
            if(this._frags)
            {
               this.frags.text = this._frags.toString();
            }
         }
         if(isInvalid(FullStatsValidationType.COLORS))
         {
            _loc3_ = PlayerStatusSchemeName.getSchemeNameForPlayer(_loc2_,this._isSquadPersonal,this._isTeamKiller,this._isDead,this._isOffline);
            _loc4_ = App.colorSchemeMgr.getScheme(_loc3_);
            if(_loc4_)
            {
               this.applyTextColor(_loc4_.rgb);
               this.vehicleIcon.transform.colorTransform = _loc4_.colorTransform;
               this.vehicleLevel.transform.colorTransform = _loc4_.colorTransform;
            }
         }
         if(isInvalid(FullStatsValidationType.SELECTED))
         {
            this.deadBg.visible = this._isDead && !this._isSelected;
         }
         if(isInvalid(FullStatsValidationType.VEHICLE_NAME))
         {
            if(this._vehicleName)
            {
               this.vehicleName.visible = true;
               this.vehicleName.text = this._vehicleName;
            }
            else
            {
               this.vehicleName.visible = false;
            }
         }
         if(isInvalid(FullStatsValidationType.VEHICLE_TYPE))
         {
            if(this._vehicleType)
            {
               this.vehicleType.visible = true;
               this.vehicleType.imageName = this._vehicleType;
            }
            else
            {
               this.vehicleType.visible = false;
            }
         }
         if(isInvalid(FullStatsValidationType.IS_IGR))
         {
            this.icoIGR.visible = this._isIGR;
            if(this._isIGR)
            {
               this.icoIGR.imageName = BATTLEATLAS.ICO_IGR;
            }
         }
         if(isInvalid(RandomFullStatsValidationType.PLAYER_STATUS))
         {
            this.playerStatus.visible = this._isOffline || this._isDead || this._isInBattle || this._showDogTag;
            if(this._isOffline)
            {
               this.playerStatus.showOffline();
            }
            else if(this._showDogTag)
            {
               this.playerStatus.showDogTag();
            }
            else if(this._isDead)
            {
               this.playerStatus.showKilled();
            }
            else if(this._isInBattle)
            {
               this.playerStatus.showInBattle();
            }
            else
            {
               this.playerStatus.hide();
            }
         }
         if(isInvalid(RandomFullStatsValidationType.VEHICLE_LEVEL))
         {
            if(this._vehicleLevel <= 0)
            {
               this.vehicleLevel.visible = false;
            }
            else
            {
               this.vehicleLevel.visible = true;
               this.vehicleLevel.imageName = BATTLEATLAS.level(this._vehicleLevel.toString());
            }
         }
         if(isInvalid(RandomFullStatsValidationType.VEHICLE_ICON))
         {
            if(this.vehicleIcon)
            {
               this.vehicleIcon.visible = true;
               this.vehicleIcon.setImageNames(this._vehicleImage,BATTLEATLAS.UNKNOWN);
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
               this.vehicleActionMarker.visible = true;
               this.vehicleActionMarker.imageName = BATTLEATLAS.getVehicleActionMarker(this._vehicleAction);
            }
            else
            {
               this.vehicleActionMarker.visible = false;
            }
         }
         if(isInvalid(RandomFullStatsValidationType.MUTE))
         {
            this.mute.visible = this._isMute;
            if(this._isMute)
            {
               this.mute.imageName = BATTLEATLAS.LEFT_STATS_MUTE;
            }
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
         }
         if(isInvalid(RandomFullStatsValidationType.SPEAKING))
         {
            if(!this._isMute)
            {
               this.speakAnimation.speaking = this._isSpeaking;
            }
         }
         if(_loc1_ && this._data)
         {
            this.setSuffixBadge(this._data.suffixBadgeType,this._data.suffixBadgeStripType);
         }
      }
      
      public function addSquadHandler(param1:ISquadHandler) : void
      {
         this._squadItem.addActionHandler(param1);
      }
      
      public function getAccountId() : int
      {
         return Boolean(this._data) ? int(this._data.accountDBID) : int(-1);
      }
      
      public function getData() : Object
      {
         return this._data;
      }
      
      public function isCurrentPlayer() : Boolean
      {
         if(this._data)
         {
            return this._isCurrentPlayer;
         }
         return false;
      }
      
      public function setActivePlayerData(param1:DAAPIVehicleInfoVO) : void
      {
         this._activePlayerData = param1;
         if(this._isRenderingAvailable)
         {
            this.vehicleDataSync();
         }
         else
         {
            this._isRenderingRequired = true;
         }
      }
      
      public function setDAAPIVehicleInfoVO(param1:DAAPIVehicleInfoVO, param2:Boolean) : void
      {
         this._isEnemy = param2;
         this.setData(DAAPIVehicleInfoVO(param1));
      }
      
      public function setData(param1:Object) : void
      {
         if(param1)
         {
            this._data = param1 as DAAPIVehicleInfoVO;
            if(this._isRenderingAvailable)
            {
               this.vehicleDataSync();
            }
            else
            {
               this._isRenderingRequired = true;
            }
         }
      }
      
      public function setIsInteractive(param1:Boolean) : void
      {
         if(this._squadItem != null)
         {
            this._squadItem.setIsInteractive(param1);
         }
      }
      
      public function setIsInviteShown(param1:Boolean) : void
      {
         if(this._squadItem != null)
         {
            this._squadItem.setIsInviteShown(param1);
         }
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
      
      public function setListData(param1:ListData) : void
      {
      }
      
      public function setSquadControlButtons(param1:BattleButton, param2:BattleButton) : void
      {
         if(!this._squadItem)
         {
            this._squadItem = new DynamicSquadCtrl(this.squadStatus,this.squad,param1,param2,this.hit,this.noSound);
         }
      }
      
      public function setVehicleIcon(param1:String) : void
      {
         if(this._vehicleImage == param1)
         {
            return;
         }
         this._vehicleImage = param1;
         invalidate(RandomFullStatsValidationType.VEHICLE_ICON);
      }
      
      public function updateColorBlind() : void
      {
         invalidate(FullStatsValidationType.COLORS);
      }
      
      private function setSuffixBadge(param1:String, param2:String) : void
      {
         var _loc3_:Boolean = StringUtils.isNotEmpty(param1);
         this.testerIcon.visible = this.testerBG.visible = _loc3_;
         if(_loc3_)
         {
            this.testerIcon.imageName = param1;
            this.testerBG.imageName = param2;
            if(this._isEnemy)
            {
               this.testerIcon.x = -RANKED_BADGE_OFFSET - FIELD_WIDTH_COMPENSATION - this.testerIcon.width + (this.playerName.x + (this.playerName.width - this.playerName.textWidth)) >> 0;
               this.testerBG.x = (this.testerIcon.width >> 1) + this.testerIcon.x + this.testerBG.width >> 0;
            }
            else
            {
               this.testerIcon.x = this.playerName.x + this.playerName.textWidth + FIELD_WIDTH_COMPENSATION >> 0;
               this.testerBG.x = (this.testerIcon.width >> 1) + this.testerIcon.x - this.testerBG.width >> 0;
            }
         }
      }
      
      private function vehicleDataSync() : void
      {
         if(this._data)
         {
            if(this._dogTag)
            {
               this.parent.removeChild(this._dogTag);
            }
            dispatchEvent(new EpicRandomFullStatsListItemRendererEvent(EpicRandomFullStatsListItemRendererEvent.ON_DATA_SYNC,true));
            this.setVehicleName(this._data.vehicleName);
            this.setVehicleLevel(this._data.vehicleLevel);
            this.setVehicleIcon(this._data.vehicleIconName);
            this.setFrags(this._data.frags);
            this.setIsIGR(this._data.isIGR);
            this.setBadge(this._data.badgeVO,this._data.hasSelectedBadge);
            this.setVehicleAction(VehicleActions.getActionName(this._data.vehicleAction));
            this.setIsSpeaking(this._data.isSpeaking);
            this.updateVehicleType(this._data);
            this.setIsCurrentPlayer(UserTags.isCurrentPlayer(this._data.userTags));
            this.applyVehicleStatus(this._data);
            this.applyPlayerStatus(this._data);
            this.applyUserTags(this._data);
            this.updateUserProps(this._data);
            this.selfBg.visible = Boolean(this._data) ? Boolean(PlayerStatus.isSelected(this._data.playerStatus)) : Boolean(false);
            if(this._squadItem)
            {
               this._squadItem.setIsEnemy(this._isEnemy);
               this._squadItem.sessionID = this._data.sessionID;
               if(this._activePlayerData)
               {
                  this._squadItem.setActivePlayerData(this._activePlayerData);
               }
               if(this._isCurrentPlayer && this._data.isAnonymized)
               {
                  this._squadItem.setCurrentPlayerAnonymized();
                  this._squadItem.setIsCurrentPlayerInClan(this._data.clanAbbrev != Values.EMPTY_STR);
                  this._squadItem.setCurrentPlayerFakeName(this._data.playerFakeName);
               }
               this.updateDynamicSquadState(this._data);
            }
         }
         else if(this._squadItem)
         {
            this._squadItem.reset();
         }
      }
      
      private function applyUserTags(param1:DAAPIVehicleInfoVO) : void
      {
         var _loc2_:Array = param1.userTags;
         if(!_loc2_)
         {
            return;
         }
         this.setIsMute(UserTags.isMuted(_loc2_));
         if(this._squadItem && this._isCurrentPlayer)
         {
            this._squadItem.setState(DynamicSquadState.NONE);
         }
      }
      
      private function applyPlayerStatus(param1:DAAPIVehicleInfoVO) : void
      {
         var _loc2_:uint = param1.playerStatus;
         this.setIsTeamKiller(param1.isTeamKiller());
         this.setIsSquadPersonal(param1.isSquadPersonal());
         this.setIsSelected(PlayerStatus.isSelected(param1.playerStatus));
         if(this._squadItem)
         {
            this._squadItem.setSquadIndex(param1.squadIndex,param1.isSquadPersonal());
            this._squadItem.setNoSound(PlayerStatus.isVoipDisabled(_loc2_));
         }
      }
      
      private function applyVehicleStatus(param1:DAAPIVehicleInfoVO) : void
      {
         this.setIsDead(!param1.isAlive());
         this.setIsOffline(!param1.isReady());
      }
      
      private function setVehicleLevel(param1:int) : void
      {
         if(this._vehicleLevel == param1)
         {
            return;
         }
         this._vehicleLevel = param1;
         invalidate(RandomFullStatsValidationType.VEHICLE_LEVEL);
      }
      
      private function updateVehicleType(param1:DAAPIVehicleInfoVO) : void
      {
         var _loc3_:String = null;
         var _loc2_:String = BattleLoadingHelper.instance.getVehicleTypeIconId(param1);
         if(_loc2_)
         {
            _loc3_ = BATTLEATLAS.getFullStatsVehicleType(_loc2_);
            if(_loc3_ == this._vehicleType)
            {
               return;
            }
            this._vehicleType = _loc3_;
            invalidate(FullStatsValidationType.VEHICLE_TYPE);
         }
      }
      
      private function updateUserProps(param1:DAAPIVehicleInfoVO) : void
      {
         if(!this._userProps)
         {
            this._userProps = new StatsUserProps(param1.playerName,param1.playerFakeName,param1.clanAbbrev,param1.region,0,param1.userTags);
         }
         else
         {
            this._userProps.userName = param1.playerName;
            this._userProps.fakeName = param1.playerFakeName;
            this._userProps.clanAbbrev = param1.clanAbbrev;
            this._userProps.region = param1.region;
            this._userProps.tags = param1.userTags;
         }
         this._isInBattle = true;
         invalidate(FullStatsValidationType.USER_PROPS);
         invalidate(FullStatsValidationType.COLORS);
         invalidate(RandomFullStatsValidationType.PLAYER_STATUS);
      }
      
      private function setVehicleName(param1:String) : void
      {
         if(this._vehicleName == param1)
         {
            return;
         }
         this._vehicleName = param1;
         invalidate(FullStatsValidationType.VEHICLE_NAME);
      }
      
      private function setIsIGR(param1:Boolean) : void
      {
         if(this._isIGR == param1)
         {
            return;
         }
         this._isIGR = param1;
         invalidate(FullStatsValidationType.IS_IGR);
      }
      
      private function setBadge(param1:BadgeVisualVO, param2:Boolean) : void
      {
         if(this._badgeVO == null || !this._badgeVO.isEquals(param1))
         {
            this._badgeVO = param1;
            this._hasBadge = param1 != null && param2;
            this.rankBadge.setData(this._badgeVO);
            invalidate(FullStatsValidationType.BADGE);
         }
      }
      
      private function setVehicleAction(param1:String) : void
      {
         if(this._vehicleAction == param1)
         {
            return;
         }
         this._vehicleAction = param1;
         invalidate(RandomFullStatsValidationType.VEHICLE_ACTION);
      }
      
      private function setFrags(param1:int) : void
      {
         if(this._frags == param1)
         {
            return;
         }
         this._frags = param1;
         invalidate(FullStatsValidationType.FRAGS);
      }
      
      private function setIsSelected(param1:Boolean) : void
      {
         if(this._isSelected == param1)
         {
            return;
         }
         this._isSelected = param1;
         invalidate(FullStatsValidationType.SELECTED);
         invalidate(FullStatsValidationType.COLORS);
      }
      
      private function setIsDead(param1:Boolean) : void
      {
         if(this._isDead == param1)
         {
            return;
         }
         this._isDead = param1;
         this.deadBg.visible = param1 && !this._isSelected;
         invalidate(FullStatsValidationType.COLORS);
         invalidate(RandomFullStatsValidationType.PLAYER_STATUS);
      }
      
      public function showDogTag(param1:DogTagVO) : void
      {
         if(!this._dogTag && param1)
         {
            this.buildDogTag();
         }
         this._showDogTag = param1 != null;
         this._dogTagData = param1;
         invalidate(RandomFullStatsValidationType.PLAYER_STATUS);
         if(this._showDogTag)
         {
            this.addEventListener(MouseEvent.ROLL_OVER,this.dogTagFadeIn);
            this.addEventListener(MouseEvent.ROLL_OUT,this.dogTagFadeOut);
         }
         else
         {
            this.removeEventListener(MouseEvent.ROLL_OVER,this.dogTagFadeIn);
            this.removeEventListener(MouseEvent.ROLL_OUT,this.dogTagFadeOut);
         }
      }
      
      private function buildDogTag() : void
      {
         this._dogTag = App.utils.classFactory.getComponent(Linkages.DOGTAG,DogtagComponent);
         this._dogTag.hideNameAndClan();
         this._dogTag.x = this._dogTag.width >> 2;
         this._dogTag.goToLabel(DogtagComponent.DOGTAG_LABEL_END_FULL);
         this._dogTag.alpha = 0;
      }
      
      private function dogTagFadeIn(param1:MouseEvent) : void
      {
         this.parent.addChild(this._dogTag);
         this._dogTag.y = this.y - this._dogTag.height;
         this._dogTag.setDogTagInfo(this._dogTagData);
         this._dogTag.fadeIn();
      }
      
      private function dogTagFadeOut(param1:MouseEvent) : void
      {
         this._dogTag.fadeOut(this.onFadeOut);
      }
      
      private function onFadeOut() : void
      {
         this.parent.removeChild(this._dogTag);
      }
      
      private function setIsCurrentPlayer(param1:Boolean) : void
      {
         if(this._isCurrentPlayer == param1)
         {
            return;
         }
         this._isCurrentPlayer = param1;
         invalidate(FullStatsValidationType.COLORS);
      }
      
      private function setIsTeamKiller(param1:Boolean) : void
      {
         if(this._isTeamKiller == param1)
         {
            return;
         }
         this._isTeamKiller = param1;
         invalidate(FullStatsValidationType.COLORS);
      }
      
      private function setIsSquadPersonal(param1:Boolean) : void
      {
         if(this._isSquadPersonal == param1)
         {
            return;
         }
         this._isSquadPersonal = param1;
         invalidate(FullStatsValidationType.COLORS);
      }
      
      private function setIsOffline(param1:Boolean) : void
      {
         if(this._isOffline == param1)
         {
            return;
         }
         this._isOffline = param1;
         invalidate(FullStatsValidationType.COLORS);
         invalidate(RandomFullStatsValidationType.PLAYER_STATUS);
      }
      
      private function applyTextColor(param1:Number) : void
      {
         this.playerName.textColor = param1;
         this.vehicleName.textColor = param1;
         this.frags.textColor = param1;
      }
      
      private function updateDynamicSquadState(param1:DAAPIVehicleInfoVO) : void
      {
         var _loc2_:uint = DynamicSquadState.getState(param1);
         this._squadItem.setState(_loc2_);
      }
      
      public function get vehicleID() : Number
      {
         return this._data.vehicleID;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         visible = param1;
      }
      
      public function get index() : uint
      {
         return this._index;
      }
      
      public function set index(param1:uint) : void
      {
         this._index = param1;
      }
      
      public function get owner() : UIComponent
      {
         return null;
      }
      
      public function set owner(param1:UIComponent) : void
      {
      }
      
      public function get selectable() : Boolean
      {
         return false;
      }
      
      public function set selectable(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return false;
      }
      
      public function set selected(param1:Boolean) : void
      {
      }
      
      public function get squadItem() : DynamicSquadCtrl
      {
         return this._squadItem;
      }
      
      public function get isRenderingAvailable() : Boolean
      {
         return this._isRenderingAvailable;
      }
      
      public function set isRenderingAvailable(param1:Boolean) : void
      {
         this._isRenderingAvailable = param1;
         if(param1 && this._isRenderingRequired)
         {
            this._isRenderingRequired = false;
            this.vehicleDataSync();
         }
      }
      
      public function get isSelected() : Boolean
      {
         return this._isSelected;
      }
   }
}
