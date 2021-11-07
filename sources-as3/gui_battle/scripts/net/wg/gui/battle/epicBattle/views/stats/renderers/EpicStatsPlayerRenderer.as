package net.wg.gui.battle.epicBattle.views.stats.renderers
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.constants.PlayerStatus;
   import net.wg.data.constants.UserTags;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.battleloading.BattleLoadingHelper;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.components.PlayerStatusView;
   import net.wg.gui.battle.epicBattle.VO.daapi.EpicVehicleStatsVO;
   import net.wg.gui.battle.epicBattle.views.stats.events.EpicFullStatsRendererEvent;
   import net.wg.gui.battle.random.views.stats.components.fullStats.constants.RandomFullStatsValidationType;
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
   import net.wg.infrastructure.interfaces.IColorScheme;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.ListData;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.gfx.TextFieldEx;
   
   public class EpicStatsPlayerRenderer extends BattleUIComponent implements IListItemRenderer
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
      
      public var rankBadge:BadgeComponent = null;
      
      public var squad:BattleAtlasSprite = null;
      
      public var icoIGR:BattleAtlasSprite = null;
      
      public var vehicleIcon:BattleAtlasSprite = null;
      
      public var vehicleActionMarker:BattleAtlasSprite = null;
      
      public var ranks:MovieClip = null;
      
      public var mute:BattleAtlasSprite = null;
      
      public var disableCommunicationIcon:BattleAtlasSprite = null;
      
      public var speakAnimation:SpeakAnimation = null;
      
      public var deadBg:BattleAtlasSprite = null;
      
      public var selfBg:BattleAtlasSprite = null;
      
      public var noLivesBg:MovieClip = null;
      
      public var testerIcon:BattleAtlasSprite = null;
      
      public var testerBG:BattleAtlasSprite = null;
      
      private var _userProps:StatsUserProps = null;
      
      private var _isOffline:Boolean = false;
      
      private var _isDead:Boolean = false;
      
      private var _isInBattle:Boolean = false;
      
      private var _isCurrentPlayer:Boolean = false;
      
      private var _isSquadPersonal:Boolean = false;
      
      private var _isTeamKiller:Boolean = false;
      
      private var _isMute:Boolean = false;
      
      private var _isSpeaking:Boolean = false;
      
      private var _squadItem:DynamicSquadCtrl = null;
      
      private var _rank:int = -1;
      
      private var _data:DAAPIVehicleInfoVO = null;
      
      private var _activePlayerData:DAAPIVehicleInfoVO = null;
      
      private var _epicData:EpicVehicleStatsVO = null;
      
      private var _badgeVO:BadgeVisualVO = null;
      
      private var _vehicleName:String = null;
      
      private var _vehicleType:String = null;
      
      private var _isSelected:Boolean = false;
      
      private var _frags:int = 0;
      
      private var _disableCommunication:Boolean = false;
      
      private var _hasRespawns:Boolean = true;
      
      private var _isIGR:Boolean = false;
      
      private var _vehicleLevel:int = -1;
      
      private var _vehicleAction:String = "";
      
      private var _isRightSide:Boolean = false;
      
      private var _defaultUsernameTFXPosition:int;
      
      private var _defaultUsernameTFWidth:int;
      
      private var _isRenderingRequired:Boolean = false;
      
      private var _isRenderingAvailable:Boolean = false;
      
      private var _index:int = 0;
      
      private var _hasBadge:Boolean = false;
      
      public function EpicStatsPlayerRenderer()
      {
         super();
         this.vehicleLevel.isCentralize = true;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.testerIcon.visible = false;
         this.testerBG.visible = false;
         this.ranks.visible = false;
         this.frags.visible = false;
         this.playerStatus.visible = false;
         this.rankBadge.visible = false;
         this.icoIGR.visible = false;
         this.icoIGR.imageName = BATTLEATLAS.ICO_IGR;
         this.mute.visible = false;
         this.mute.imageName = BATTLEATLAS.LEFT_STATS_MUTE;
         this.disableCommunicationIcon.visible = false;
         this.deadBg.visible = false;
         this.deadBg.imageName = BATTLEATLAS.EPIC_STATS_DEAD_BG;
         this.selfBg.visible = false;
         this.selfBg.imageName = BATTLEATLAS.EPIC_STATS_SELF_BG;
         this.noLivesBg.visible = false;
         TextFieldEx.setNoTranslate(this.playerName,true);
         TextFieldEx.setNoTranslate(this.vehicleName,true);
         TextFieldEx.setNoTranslate(this.frags,true);
         this._defaultUsernameTFXPosition = this.playerName.x;
         this._defaultUsernameTFWidth = this.playerName.width;
         addEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
         scaleX = scaleY = 1;
      }
      
      override protected function draw() : void
      {
         var _loc2_:String = null;
         var _loc3_:IColorScheme = null;
         var _loc1_:Boolean = false;
         if(isInvalid(FullStatsValidationType.USER_PROPS))
         {
            if(this._userProps)
            {
               this.playerName.visible = true;
               App.utils.commons.formatPlayerName(this.playerName,this._userProps,!this._isCurrentPlayer,this._isCurrentPlayer);
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
            _loc2_ = PlayerStatusSchemeName.getSchemeNameForPlayer(this._isCurrentPlayer,this._isSquadPersonal,this._isTeamKiller,this._isDead,this._isOffline);
            _loc3_ = App.colorSchemeMgr.getScheme(_loc2_);
            if(_loc3_)
            {
               this.applyTextColor(_loc3_.rgb);
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
               this.vehicleName.visible = this._hasRespawns;
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
               this.vehicleType.visible = this._hasRespawns;
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
            this.playerStatus.visible = this._isOffline || this._isDead || this._isInBattle;
            if(this._isOffline)
            {
               this.playerStatus.showOffline();
            }
            else if(!this._isDead)
            {
               if(this._isInBattle)
               {
                  this.playerStatus.hide();
               }
               else
               {
                  this.playerStatus.hide();
               }
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
               this.vehicleLevel.visible = this._hasRespawns;
               this.vehicleLevel.imageName = BATTLEATLAS.level(this._vehicleLevel.toString());
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
         if(isInvalid(RandomFullStatsValidationType.DISABLE_COMMUNICATION))
         {
            this.disableCommunicationIcon.visible = this._disableCommunication;
            if(this._disableCommunication)
            {
               this.disableCommunicationIcon.imageName = BATTLEATLAS.ICON_TOXIC_CHAT_OFF;
            }
         }
         if(isInvalid(FullStatsValidationType.BADGE))
         {
            this.rankBadge.visible = this._hasBadge;
            if(this._hasBadge)
            {
               this.rankBadge.setData(this._badgeVO);
            }
            if(this.rankBadge.visible)
            {
               if(this._isRightSide)
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
         if(isInvalid(FullStatsValidationType.RANK))
         {
            this.ranks.visible = this._rank >= 0;
            if(this._rank >= 0)
            {
               this.ranks.gotoAndStop(this._rank + 1);
            }
         }
         if(isInvalid(RandomFullStatsValidationType.PLAYER_STATUS))
         {
            this.noLivesBg.visible = !this._hasRespawns;
            this.vehicleIcon.visible = this._hasRespawns;
            this.vehicleName.visible = this._hasRespawns;
            this.vehicleType.visible = this._hasRespawns;
            this.vehicleLevel.visible = this._hasRespawns;
            this.playerStatus.visible = this._hasRespawns;
         }
         if(_loc1_ && this._data)
         {
            this.setSuffixBadge();
         }
         super.draw();
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
         this.testerBG = null;
         this.testerIcon = null;
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
         this.ranks = null;
         this.noLivesBg = null;
         this.squadStatus.dispose();
         this.squadStatus = null;
         this.playerStatus.dispose();
         this.playerStatus = null;
         this.speakAnimation.dispose();
         this.speakAnimation = null;
         this.rankBadge.dispose();
         this.rankBadge = null;
         this.disableCommunicationIcon = null;
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
            this._data = null;
         }
         if(this._epicData)
         {
            this._epicData = null;
         }
         this._badgeVO = null;
         this._activePlayerData = null;
         super.onDispose();
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
      
      public function setDAAPIVehicleInfoVO(param1:DAAPIVehicleInfoVO) : void
      {
         this._data = param1;
         if(this._isRenderingAvailable)
         {
            this.vehicleDataSync();
         }
         else
         {
            this._isRenderingRequired = true;
         }
      }
      
      public function setData(param1:Object) : void
      {
         var _loc2_:Boolean = false;
         if(param1 != null)
         {
            this._data = param1 as DAAPIVehicleInfoVO;
            if(this._squadItem)
            {
               this._squadItem.sessionID = this._data.sessionID;
            }
            if(this._data)
            {
               _loc2_ = true;
            }
         }
         if(_loc2_ && this._isRenderingAvailable)
         {
            this.vehicleDataSync();
         }
         else
         {
            this._isRenderingRequired = true;
         }
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
      
      public function setEpicData(param1:EpicVehicleStatsVO) : void
      {
         var _loc2_:Boolean = false;
         if(param1)
         {
            this._epicData = param1;
            _loc2_ = true;
         }
         if(_loc2_ && this._isRenderingAvailable)
         {
            this.vehicleEpicDataSync();
         }
         else
         {
            this._isRenderingRequired = true;
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
      
      public function setupDynamicSquadCtrl(param1:DynamicSquadCtrl) : void
      {
         this._squadItem = param1;
      }
      
      public function updateColorBlind() : void
      {
         invalidate(FullStatsValidationType.COLORS);
      }
      
      private function setSuffixBadge() : void
      {
         var _loc1_:Boolean = StringUtils.isNotEmpty(this._data.suffixBadgeType);
         this.testerIcon.visible = this.testerBG.visible = _loc1_;
         if(_loc1_)
         {
            this.testerIcon.imageName = this._data.suffixBadgeType;
            this.testerBG.imageName = this._data.suffixBadgeStripType;
            if(this._isRightSide)
            {
               this.testerIcon.x = -FIELD_WIDTH_COMPENSATION - RANKED_BADGE_OFFSET - this.testerIcon.width + (this.playerName.x + (this.playerName.width - this.playerName.textWidth)) >> 0;
               this.testerBG.x = (this.testerIcon.width >> 1) + this.testerIcon.x + this.testerBG.width >> 0;
            }
            else
            {
               this.testerIcon.x = this.playerName.x + this.playerName.textWidth + FIELD_WIDTH_COMPENSATION >> 0;
               this.testerBG.x = (this.testerIcon.width >> 1) + this.testerIcon.x - this.testerBG.width >> 0;
            }
         }
      }
      
      private function setBadge(param1:BadgeVisualVO, param2:Boolean) : void
      {
         if(this._badgeVO == null || !this._badgeVO.isEquals(param1))
         {
            this._badgeVO = param1;
            this._hasBadge = param1 != null && param2;
            invalidate(FullStatsValidationType.BADGE);
         }
      }
      
      private function vehicleDataSync() : void
      {
         if(this._data)
         {
            this.setVehicleName(this._data.vehicleName);
            this.setVehicleLevel(this._data.vehicleLevel);
            this.setIsIGR(this._data.isIGR);
            this.setBadge(this._data.badgeVO,this._data.hasSelectedBadge);
            this.setVehicleAction(VehicleActions.getActionName(this._data.vehicleAction));
            this.setIsSpeaking(this._data.isSpeaking);
            this.updateVehicleType(this._data);
            this.setIsCurrentPlayer(UserTags.isCurrentPlayer(this._data.userTags));
            this.applyVehicleStatus(this._data);
            this.applyUserTags(this._data);
            this.applyPlayerStatus(this._data);
            this.updateUserProps(this._data);
            this.selfBg.visible = Boolean(this._data) ? Boolean(PlayerStatus.isSelected(this._data.playerStatus)) : Boolean(false);
            if(this._squadItem)
            {
               this._squadItem.setIsEnemy(this._isRightSide);
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
      
      private function vehicleEpicDataSync() : void
      {
         if(this._epicData)
         {
            this.setFrags(this._epicData.frags);
            this.setRank(this._epicData.rank);
            this.setHasRespawns(this._epicData.hasRespawns);
         }
      }
      
      private function setHasRespawns(param1:Boolean) : void
      {
         if(this._hasRespawns == param1)
         {
            return;
         }
         this._hasRespawns = param1;
         invalidate(RandomFullStatsValidationType.PLAYER_STATUS);
      }
      
      private function applyUserTags(param1:DAAPIVehicleInfoVO) : void
      {
         var _loc2_:Array = param1.userTags;
         if(!_loc2_)
         {
            return;
         }
         this.setIsMute(UserTags.isMuted(_loc2_));
         this.setDisableCommunication(UserTags.isIgnored(_loc2_));
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
            this._squadItem.setIsEnemy(this._isRightSide);
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
         var _loc2_:String = BattleLoadingHelper.instance.getVehicleTypeIconId(param1 as DAAPIVehicleInfoVO);
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
      
      private function setRank(param1:int) : void
      {
         if(this._rank == param1)
         {
            return;
         }
         this._rank = param1;
         invalidate(FullStatsValidationType.RANK);
      }
      
      private function updateDynamicSquadState(param1:DAAPIVehicleInfoVO) : void
      {
         var _loc2_:uint = DynamicSquadState.getState(param1);
         this._squadItem.setState(_loc2_);
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         visible = param1;
      }
      
      public function get displayFocus() : Boolean
      {
         return false;
      }
      
      public function set displayFocus(param1:Boolean) : void
      {
      }
      
      public function get focusTarget() : UIComponent
      {
         return null;
      }
      
      public function set focusTarget(param1:UIComponent) : void
      {
      }
      
      public function get UIID() : uint
      {
         return 0;
      }
      
      public function set UIID(param1:uint) : void
      {
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
      
      public function set isRenderingAvailable(param1:Boolean) : void
      {
         this._isRenderingAvailable = param1;
         if(param1 && this._isRenderingRequired)
         {
            this._isRenderingRequired = false;
            this.vehicleDataSync();
            this.vehicleEpicDataSync();
         }
      }
      
      public function get squadItem() : DynamicSquadCtrl
      {
         return this._squadItem;
      }
      
      public function set isRightSide(param1:Boolean) : void
      {
         this._isRightSide = param1;
      }
      
      public function handleInput(param1:InputEvent) : void
      {
      }
      
      private function onMouseClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:EpicFullStatsRendererEvent = new EpicFullStatsRendererEvent(EpicFullStatsRendererEvent.RENDERER_CLICKED,this._data.vehicleID,param1);
         dispatchEvent(_loc2_);
      }
   }
}
