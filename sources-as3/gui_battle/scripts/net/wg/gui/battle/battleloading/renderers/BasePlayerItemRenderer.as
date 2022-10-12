package net.wg.gui.battle.battleloading.renderers
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.battleloading.BattleLoadingHelper;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.components.BattleUIComponentsHolder;
   import net.wg.gui.battle.views.stats.constants.PlayerStatusSchemeName;
   import net.wg.gui.components.controls.BadgeComponent;
   import net.wg.gui.components.icons.PlayerActionMarker;
   import net.wg.infrastructure.interfaces.IColorScheme;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.gfx.TextFieldEx;
   
   public class BasePlayerItemRenderer extends BattleUIComponentsHolder implements IBattleLoadingRenderer
   {
      
      private static const LIVE_ICON_ALPHA:Number = 1;
      
      private static const DIE_ICON_ALPHA:Number = 0.7;
      
      private static const AVAILABLE_TEXT_COLOR:int = 16777215;
      
      private static const NOT_AVAILABLE_TEXT_COLOR:int = 5130300;
      
      private static const ACTION_MARKER_MYTEAM:String = "myteam";
      
      private static const ACTION_MARKER_ENEMY:String = "enemy";
      
      private static const DEF_PLAYER_ACTION:int = 0;
      
      private static const FIELD_WIDTH_COMPENSATION:int = 2;
      
      private static const RANKED_BADGE_OFFSET:int = 1;
      
      private static const SUFFIX_BADGE_OFFSET:int = 4;
      
      private static const BADGE_SIZE:int = 24;
       
      
      protected var model:DAAPIVehicleInfoVO;
      
      protected var selfBg:BattleAtlasSprite;
      
      private var _vehicleField:TextField;
      
      private var _textField:TextField;
      
      private var _vehicleIcon:BattleAtlasSprite;
      
      private var _vehicleTypeIcon:BattleAtlasSprite;
      
      private var _vehicleLevelIcon:BattleAtlasSprite;
      
      private var _badge:BadgeComponent;
      
      private var _playerActionMarker:PlayerActionMarker;
      
      private var _icoIGR:BattleAtlasSprite;
      
      private var _icoTester:BattleAtlasSprite;
      
      private var _backTester:BattleAtlasSprite;
      
      private var _isEnemy:Boolean;
      
      private var _defaultVehicleFieldXPosition:int;
      
      private var _defaultVehicleFieldWidth:int;
      
      private var _defaultUsernameTFXPosition:int;
      
      private var _defaultUsernameTFWidth:int;
      
      private var _colorMgr:IColorSchemeManager = null;
      
      public function BasePlayerItemRenderer(param1:BaseRendererContainer, param2:int, param3:Boolean)
      {
         super();
         this._colorMgr = App.colorSchemeMgr;
         if(param3)
         {
            this._textField = param1.textFieldsEnemy[param2];
            this._playerActionMarker = param1.playerActionMarkersEnemy[param2];
            this._icoTester = param1.icoTestersEnemy[param2];
            this._backTester = param1.backTestersEnemy[param2];
            this._badge = param1.badgesEnemy[param2];
            if(param1.vehicleFieldsEnemy)
            {
               this._vehicleField = param1.vehicleFieldsEnemy[param2];
            }
            if(param1.vehicleIconsEnemy)
            {
               this._vehicleIcon = param1.vehicleIconsEnemy[param2];
            }
            if(param1.vehicleTypeIconsEnemy)
            {
               this._vehicleTypeIcon = param1.vehicleTypeIconsEnemy[param2];
            }
            if(param1.vehicleLevelIconsEnemy)
            {
               this._vehicleLevelIcon = param1.vehicleLevelIconsEnemy[param2];
            }
            if(param1.icoIGRsEnemy)
            {
               this._icoIGR = param1.icoIGRsEnemy[param2];
            }
         }
         else
         {
            this._textField = param1.textFieldsAlly[param2];
            this._playerActionMarker = param1.playerActionMarkersAlly[param2];
            this._icoTester = param1.icoTestersAlly[param2];
            this._backTester = param1.backTestersAlly[param2];
            this.selfBg = param1.selfBgs[param2];
            this._badge = param1.badgesAlly[param2];
            if(param1.vehicleFieldsAlly)
            {
               this._vehicleField = param1.vehicleFieldsAlly[param2];
            }
            if(param1.vehicleIconsAlly)
            {
               this._vehicleIcon = param1.vehicleIconsAlly[param2];
            }
            if(param1.vehicleTypeIconsAlly)
            {
               this._vehicleTypeIcon = param1.vehicleTypeIconsAlly[param2];
            }
            if(param1.vehicleLevelIconsAlly)
            {
               this._vehicleLevelIcon = param1.vehicleLevelIconsAlly[param2];
            }
            if(param1.icoIGRsAlly)
            {
               this._icoIGR = param1.icoIGRsAlly[param2];
            }
         }
         this._defaultUsernameTFXPosition = this._textField.x;
         this._defaultUsernameTFWidth = this._textField.width;
         this._isEnemy = param3;
         this._backTester.visible = false;
         TextFieldEx.setNoTranslate(this._textField,true);
         if(this._vehicleField)
         {
            this._defaultVehicleFieldXPosition = this._vehicleField.x;
            this._defaultVehicleFieldWidth = this._vehicleField.width;
            this._vehicleField.autoSize = TextFieldAutoSize.LEFT;
            TextFieldEx.setNoTranslate(this._vehicleField,true);
         }
         if(this._vehicleLevelIcon)
         {
            this._vehicleLevelIcon.isCentralizeByX = true;
         }
      }
      
      override protected function onDispose() : void
      {
         this._backTester = null;
         this._colorMgr = null;
         this.selfBg = null;
         this._vehicleField = null;
         this._textField = null;
         this._vehicleTypeIcon = null;
         this._vehicleLevelIcon = null;
         this._vehicleIcon = null;
         this._badge = null;
         this._playerActionMarker = null;
         this._icoIGR = null;
         this._icoTester = null;
         this.model = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         if(this.model != null)
         {
            this._textField.width = this._defaultUsernameTFWidth;
            this.setSelfBG();
            this.setBadge();
            this._textField.visible = true;
            App.utils.commons.formatPlayerName(this._textField,App.utils.commons.getUserProps(this.model.playerName,this.model.clanAbbrev,this.model.region,Values.ZERO,this.model.userTags,this.model.playerFakeName),!this.model.isCurrentPlayer,this.model.isCurrentPlayer);
            this.setVehicleField();
            this.setVehicleIcon();
            this.setVehicleType();
            this.setVehicleLevel();
            this.setPlayerActionMarkerState();
            this.updateState();
            this.setSuffixBadge();
         }
         else
         {
            if(this.selfBg)
            {
               this.selfBg.visible = false;
            }
            this._badge.visible = false;
            this._textField.visible = false;
            if(this._playerActionMarker)
            {
               this._playerActionMarker.action = DEF_PLAYER_ACTION;
            }
            if(this._vehicleField)
            {
               this._vehicleField.visible = false;
            }
            if(this._vehicleIcon)
            {
               this._vehicleIcon.visible = false;
            }
            if(this._vehicleTypeIcon)
            {
               this._vehicleTypeIcon.visible = false;
            }
            if(this._vehicleLevelIcon)
            {
               this._vehicleLevelIcon.visible = false;
            }
            if(this._icoIGR)
            {
               this._icoIGR.visible = false;
            }
         }
         super.draw();
      }
      
      public function setData(param1:Object) : void
      {
         this.model = DAAPIVehicleInfoVO(param1);
         invalidate();
      }
      
      protected function setSelfBG() : void
      {
      }
      
      private function setSuffixBadge() : void
      {
         this._icoTester.visible = StringUtils.isNotEmpty(this.model.suffixBadgeType);
         this._icoTester.imageName = this.model.suffixBadgeType;
         this._backTester.imageName = this.model.suffixBadgeStripType;
         this._backTester.visible = this._icoTester.visible;
         if(this._icoTester.visible)
         {
            if(this._isEnemy)
            {
               this._icoTester.x = -FIELD_WIDTH_COMPENSATION - RANKED_BADGE_OFFSET + this._textField.width - this._textField.textWidth + this._textField.x - this._icoTester.width >> 0;
               this._backTester.x = this._icoTester.x + this._backTester.width + (this._icoTester.width >> 1) >> 0;
            }
            else
            {
               this._icoTester.x = FIELD_WIDTH_COMPENSATION + RANKED_BADGE_OFFSET + this._textField.x + this._textField.textWidth >> 0;
               this._backTester.x = -RANKED_BADGE_OFFSET + this._icoTester.x - RANKED_BADGE_OFFSET + (this._icoTester.width >> 1) - this._backTester.width >> 0;
            }
         }
      }
      
      private function setBadge() : void
      {
         this._badge.alpha = this.model.isReady() && this.model.isAlive() ? Number(LIVE_ICON_ALPHA) : Number(DIE_ICON_ALPHA);
         this._badge.visible = this.model.hasSelectedBadge;
         if(this.model.hasSelectedBadge)
         {
            this._badge.setData(this.model.badgeVO);
         }
         var _loc1_:int = !!StringUtils.isNotEmpty(this.model.suffixBadgeType) ? int(BADGE_SIZE - SUFFIX_BADGE_OFFSET) : int(0);
         if(this._badge.visible)
         {
            this._textField.width = this._defaultUsernameTFWidth - (this._badge.width + RANKED_BADGE_OFFSET) - _loc1_;
            if(this._isEnemy)
            {
               this._textField.x = this._badge.x - (this._defaultUsernameTFWidth - this._badge.width) + _loc1_;
            }
            else
            {
               this._textField.x = this._badge.x + (this._badge.width + RANKED_BADGE_OFFSET);
            }
         }
         else
         {
            if(this._isEnemy)
            {
               this._textField.x = this._defaultUsernameTFXPosition + _loc1_;
            }
            else
            {
               this._textField.x = this._defaultUsernameTFXPosition;
            }
            this._textField.width = this._defaultUsernameTFWidth - _loc1_;
         }
      }
      
      private function setPlayerActionMarkerState() : void
      {
         if(this._playerActionMarker && this.model.vehicleAction)
         {
            this._playerActionMarker.action = this.model.vehicleAction;
            this._playerActionMarker.team = !!this._isEnemy ? ACTION_MARKER_ENEMY : ACTION_MARKER_MYTEAM;
         }
      }
      
      private function setVehicleField() : void
      {
         if(!this._vehicleField)
         {
            return;
         }
         this._vehicleField.visible = true;
         this._vehicleField.text = this.model.vehicleName;
         var _loc1_:Boolean = false;
         if(this._icoIGR)
         {
            _loc1_ = this.model.isIGR;
            this._icoIGR.visible = _loc1_;
         }
         if(_loc1_)
         {
            this._icoIGR.imageName = BATTLEATLAS.ICO_IGR;
            if(this._isEnemy)
            {
               this._icoIGR.x = this._defaultVehicleFieldXPosition;
               this._vehicleField.x = this._icoIGR.x + this._icoIGR.width + FIELD_WIDTH_COMPENSATION >> 0;
            }
            else
            {
               this._icoIGR.x = this._defaultVehicleFieldXPosition + this._defaultVehicleFieldWidth - this._icoIGR.width >> 0;
               this._vehicleField.x = this._icoIGR.x - this._vehicleField.width - FIELD_WIDTH_COMPENSATION >> 0;
            }
         }
         else
         {
            this._vehicleField.x = this._defaultVehicleFieldXPosition;
            if(!this._isEnemy)
            {
               this._vehicleField.x += this._defaultVehicleFieldWidth - this._vehicleField.width >> 0;
            }
         }
      }
      
      private function setVehicleLevel() : void
      {
         if(this._vehicleLevelIcon)
         {
            this._vehicleLevelIcon.visible = this.model.vehicleLevel > 0;
            if(this._vehicleLevelIcon.visible)
            {
               this._vehicleLevelIcon.imageName = BATTLEATLAS.level(this.model.vehicleLevel.toString());
            }
         }
      }
      
      private function setVehicleType() : void
      {
         var _loc1_:String = null;
         if(this._vehicleTypeIcon)
         {
            _loc1_ = BattleLoadingHelper.instance.getVehicleTypeIconId(this.model);
            if(_loc1_)
            {
               this._vehicleTypeIcon.imageName = BATTLEATLAS.getFullStatsVehicleType(_loc1_);
               this._vehicleTypeIcon.visible = true;
            }
            else
            {
               this._vehicleTypeIcon.visible = false;
            }
         }
      }
      
      private function setVehicleIcon() : void
      {
         if(this._vehicleIcon)
         {
            this._vehicleIcon.visible = true;
            this._vehicleIcon.setImageNames(this.model.vehicleIconName,BATTLEATLAS.UNKNOWN);
         }
      }
      
      private function updateState() : void
      {
         var _loc4_:Boolean = false;
         var _loc5_:Number = NaN;
         var _loc1_:Boolean = this.model.isAlive();
         var _loc2_:String = PlayerStatusSchemeName.getSchemeNameForVehicle(this.model.isCurrentPlayer,this.model.isSquadPersonal(),this.model.isTeamKiller(),!_loc1_,!this.model.isReady());
         var _loc3_:IColorScheme = this._colorMgr.getScheme(_loc2_);
         if(_loc3_ && this._vehicleIcon)
         {
            this._vehicleIcon.transform.colorTransform = _loc3_.colorTransform;
         }
         _loc2_ = PlayerStatusSchemeName.getSchemeForVehicleLevel(!_loc1_);
         _loc3_ = this._colorMgr.getScheme(_loc2_);
         if(_loc3_ && this._vehicleLevelIcon)
         {
            this._vehicleLevelIcon.transform.colorTransform = _loc3_.colorTransform;
         }
         _loc2_ = PlayerStatusSchemeName.getSchemeNameForPlayer(this.model.isCurrentPlayer,this.model.isSquadPersonal(),this.model.isTeamKiller(),!_loc1_,!this.model.isReady());
         _loc3_ = this._colorMgr.getScheme(_loc2_);
         if(_loc3_)
         {
            this._textField.textColor = _loc3_.rgb;
            if(this._vehicleField)
            {
               this._vehicleField.textColor = _loc3_.rgb;
            }
         }
         else
         {
            DebugUtils.LOG_ERROR(Errors.CANT_NULL,this.model);
            _loc4_ = true;
            if(!this.model.isNotAvailable())
            {
               _loc4_ = _loc1_ && this.model.isReady();
            }
            _loc5_ = !!_loc4_ ? Number(AVAILABLE_TEXT_COLOR) : Number(NOT_AVAILABLE_TEXT_COLOR);
            this._textField.textColor = _loc5_;
            if(this._vehicleField)
            {
               this._vehicleField.textColor = _loc5_;
            }
         }
      }
   }
}
