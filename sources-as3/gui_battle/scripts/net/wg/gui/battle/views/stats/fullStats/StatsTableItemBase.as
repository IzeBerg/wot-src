package net.wg.gui.battle.views.stats.fullStats
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormatAlign;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.components.BattleUIComponentsHolder;
   import net.wg.gui.battle.views.stats.constants.FullStatsValidationType;
   import net.wg.gui.battle.views.stats.constants.PlayerStatusSchemeName;
   import net.wg.gui.components.controls.BadgeComponent;
   import net.wg.gui.components.controls.VO.BadgeVisualVO;
   import net.wg.infrastructure.interfaces.IColorScheme;
   import net.wg.infrastructure.interfaces.IUserProps;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.gfx.TextFieldEx;
   
   public class StatsTableItemBase extends BattleUIComponentsHolder
   {
      
      private static const FIELD_WIDTH_COMPENSATION:int = 2;
      
      private static const SUFFIXBADGE_WIDTH:uint = 24;
      
      private static const BADGE_ALPHA:int = 1;
      
      private static const BADGE_ALPHA_NOT_ACTIVE:Number = 0.7;
      
      private static const NUM_ROWS:int = 15;
       
      
      protected var deadBg:BattleAtlasSprite = null;
      
      protected var isOffline:Boolean = false;
      
      protected var isDead:Boolean = false;
      
      protected var dogTag:Boolean = false;
      
      protected var isCurrentPlayer:Boolean = false;
      
      protected var isSquadPersonal:Boolean = false;
      
      protected var isTeamKiller:Boolean = false;
      
      protected var vehicleTypeIcon:BattleAtlasSprite = null;
      
      private var _playerNameTF:TextField = null;
      
      private var _fragsTF:TextField = null;
      
      private var _vehicleNameTF:TextField = null;
      
      private var _icoIGR:BattleAtlasSprite = null;
      
      private var _badge:BadgeComponent = null;
      
      private var _testerIcon:BattleAtlasSprite;
      
      private var _backTester:BattleAtlasSprite;
      
      private var _userProps:IUserProps = null;
      
      private var _vehicleName:String = null;
      
      private var _vehicleType:String = null;
      
      private var _isSelected:Boolean = false;
      
      private var _frags:int = 0;
      
      private var _isIGR:Boolean = false;
      
      private var _badgeVO:BadgeVisualVO = null;
      
      private var _hasBadge:Boolean = false;
      
      private var _suffixBadgeType:String;
      
      private var _suffixBadgeStripType:String;
      
      private var _defaultVehicleFieldXPosition:int;
      
      private var _defaultVehicleFieldWidth:int;
      
      private var _defaultUsernameTFWidth:int;
      
      private var _defaultUsernameTFXPosition:int;
      
      private var _isEnemy:Boolean;
      
      public function StatsTableItemBase(param1:MovieClip, param2:int, param3:int)
      {
         super();
         var _loc4_:int = param2 * this.numRows + param3;
         this._isEnemy = param2 == 1;
         this._playerNameTF = param1.playerNameCollection[_loc4_];
         this._vehicleNameTF = param1.vehicleNameCollection[_loc4_];
         this._fragsTF = param1.fragsCollection[_loc4_];
         this.vehicleTypeIcon = param1.vehicleTypeCollection[_loc4_];
         this.deadBg = param1.deadBgCollection[_loc4_];
         this._icoIGR = param1.icoIGRCollection[_loc4_];
         this._testerIcon = param1.icoTesterCollection[_loc4_];
         this._backTester = param1.testerBackCollection[_loc4_];
         this._badge = param1.rankBadgesCollection[_loc4_];
         this._defaultVehicleFieldXPosition = this._vehicleNameTF.x;
         this._defaultVehicleFieldWidth = this._vehicleNameTF.width;
         this._defaultUsernameTFXPosition = this._playerNameTF.x;
         this._defaultUsernameTFWidth = this._playerNameTF.width;
         this._playerNameTF.visible = false;
         this._vehicleNameTF.autoSize = TextFieldAutoSize.LEFT;
         this._vehicleNameTF.visible = false;
         this._fragsTF.visible = false;
         this.vehicleTypeIcon.visible = false;
         this.deadBg.visible = false;
         this._icoIGR.visible = false;
         this._testerIcon.visible = false;
         this._backTester.visible = false;
         TextFieldEx.setNoTranslate(this._playerNameTF,true);
         TextFieldEx.setNoTranslate(this._vehicleNameTF,true);
         TextFieldEx.setNoTranslate(this._fragsTF,true);
      }
      
      override protected function onDispose() : void
      {
         this._badge = null;
         this._badgeVO = null;
         this._playerNameTF = null;
         this._vehicleNameTF = null;
         this.vehicleTypeIcon = null;
         this._fragsTF = null;
         this.deadBg = null;
         this._userProps = null;
         this._icoIGR = null;
         this._testerIcon = null;
         this._backTester = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:IColorScheme = null;
         var _loc4_:Boolean = false;
         super.draw();
         if(isInvalid(FullStatsValidationType.BADGE))
         {
            this._badge.visible = this._hasBadge;
            if(this._hasBadge)
            {
               this._badge.setData(this._badgeVO);
               _loc1_ = !!StringUtils.isNotEmpty(this._suffixBadgeType) ? int(SUFFIXBADGE_WIDTH) : int(0);
               this._playerNameTF.width = this._defaultUsernameTFWidth - this._badge.width - _loc1_ | 0;
               if(this._isEnemy)
               {
                  this._playerNameTF.x = this._badge.x - this._playerNameTF.width | 0;
               }
               else
               {
                  this._playerNameTF.x = this._badge.x + this._badge.width | 0;
               }
            }
            else
            {
               this._playerNameTF.x = this._defaultUsernameTFXPosition;
               this._playerNameTF.width = this._defaultUsernameTFWidth;
            }
         }
         if(isInvalid(FullStatsValidationType.COLORS))
         {
            this._badge.alpha = this.isOffline || this.isDead ? Number(BADGE_ALPHA_NOT_ACTIVE) : Number(BADGE_ALPHA);
            _loc2_ = PlayerStatusSchemeName.getSchemeNameForPlayer(this.isCurrentPlayer,this.isSquadPersonal,this.isTeamKiller,this.isDead,this.isOffline);
            _loc3_ = App.colorSchemeMgr.getScheme(_loc2_);
            if(_loc3_)
            {
               this.applyTextColor(_loc3_.rgb);
            }
         }
         if(isInvalid(FullStatsValidationType.USER_PROPS))
         {
            if(this._userProps)
            {
               this._playerNameTF.visible = true;
               App.utils.commons.formatPlayerName(this._playerNameTF,this._userProps,!this.isCurrentPlayer,this.isCurrentPlayer);
            }
            else
            {
               this._playerNameTF.visible = false;
            }
         }
         if(isInvalid(FullStatsValidationType.SUFFIXBAGE))
         {
            _loc4_ = StringUtils.isNotEmpty(this._suffixBadgeType);
            this._testerIcon.visible = this._backTester.visible = _loc4_;
            if(_loc4_ && this._playerNameTF.visible)
            {
               this._testerIcon.imageName = this._suffixBadgeType;
               this._backTester.imageName = this._suffixBadgeStripType;
               if(this._isEnemy)
               {
                  this._testerIcon.x = this._playerNameTF.width - this._playerNameTF.textWidth + this._playerNameTF.x - this._testerIcon.width - FIELD_WIDTH_COMPENSATION | 0;
                  this._backTester.x = this._testerIcon.x + this._backTester.width + (this._testerIcon.width >> 1) | 0;
               }
               else
               {
                  this._testerIcon.x = this._playerNameTF.x + this._playerNameTF.textWidth + FIELD_WIDTH_COMPENSATION | 0;
                  this._backTester.x = (this._testerIcon.width >> 1) + this._testerIcon.x - this._backTester.width | 0;
               }
            }
         }
         if(isInvalid(FullStatsValidationType.FRAGS))
         {
            this._fragsTF.visible = this._frags != 0;
            if(this._frags)
            {
               this._fragsTF.text = this._frags.toString();
            }
         }
         if(isInvalid(FullStatsValidationType.SELECTED))
         {
            this.deadBg.visible = this.isDead && !this._isSelected;
         }
         if(isInvalid(FullStatsValidationType.VEHICLE_NAME))
         {
            if(this._vehicleName)
            {
               this._vehicleNameTF.visible = true;
               this._vehicleNameTF.text = this._vehicleName;
               if(this._vehicleNameTF.getTextFormat().align == TextFormatAlign.RIGHT)
               {
                  if(this._isIGR)
                  {
                     this._icoIGR.x = this._defaultVehicleFieldXPosition + this._defaultVehicleFieldWidth - this._icoIGR.width >> 0;
                     this._vehicleNameTF.x = this._icoIGR.x - this._vehicleNameTF.width >> 0;
                  }
                  else
                  {
                     this._vehicleNameTF.x = this._defaultVehicleFieldXPosition + this._defaultVehicleFieldWidth - this._vehicleNameTF.width >> 0;
                  }
               }
            }
            else
            {
               this._vehicleNameTF.visible = false;
            }
         }
         if(isInvalid(FullStatsValidationType.VEHICLE_TYPE))
         {
            if(this._vehicleType)
            {
               this.vehicleTypeIcon.visible = true;
               this.vehicleTypeIcon.imageName = this._vehicleType;
            }
            else
            {
               this.vehicleTypeIcon.visible = false;
            }
         }
         if(isInvalid(FullStatsValidationType.IS_IGR))
         {
            this._icoIGR.visible = this._isIGR;
            if(this._isIGR)
            {
               this._icoIGR.imageName = BATTLEATLAS.ICO_IGR;
               if(this._vehicleNameTF.getTextFormat().align == TextFormatAlign.RIGHT)
               {
                  this._icoIGR.x = this._defaultVehicleFieldXPosition + this._defaultVehicleFieldWidth - this._icoIGR.width >> 0;
                  this._vehicleNameTF.x = this._icoIGR.x - this._vehicleNameTF.width >> 0;
               }
               else
               {
                  this._icoIGR.x = this._defaultVehicleFieldXPosition;
                  this._vehicleNameTF.x = this._icoIGR.x + this._icoIGR.width + FIELD_WIDTH_COMPENSATION >> 0;
               }
            }
            else if(this._vehicleNameTF.getTextFormat().align == TextFormatAlign.RIGHT)
            {
               this._vehicleNameTF.x = this._defaultVehicleFieldXPosition + this._defaultVehicleFieldWidth - this._vehicleNameTF.width >> 0;
            }
            else
            {
               this._vehicleNameTF.x = this._defaultVehicleFieldXPosition;
            }
         }
      }
      
      public function reset() : void
      {
         this._frags = 0;
         this._isSelected = false;
         this._userProps = null;
         this.dogTag = false;
         this.isDead = false;
         this.isCurrentPlayer = false;
         this.isSquadPersonal = false;
         this.isOffline = false;
         this.isTeamKiller = false;
         this._vehicleName = null;
         this._vehicleType = null;
         this._isIGR = false;
         this._badgeVO = null;
         this._testerIcon = null;
         this._backTester = null;
         this._vehicleNameTF.text = Values.EMPTY_STR;
         this._playerNameTF.text = Values.EMPTY_STR;
         invalidate(InvalidationType.ALL);
      }
      
      public function setBadge(param1:BadgeVisualVO, param2:Boolean) : void
      {
         if(this._badgeVO == null || !this._badgeVO.isEquals(param1))
         {
            this._badgeVO = param1;
            this._hasBadge = param2;
            invalidate(FullStatsValidationType.BADGE);
         }
      }
      
      public function setFrags(param1:int) : void
      {
         if(this._frags == param1)
         {
            return;
         }
         this._frags = param1;
         invalidate(FullStatsValidationType.FRAGS);
      }
      
      public function setIsCurrentPlayer(param1:Boolean) : void
      {
         if(this.isCurrentPlayer == param1)
         {
            return;
         }
         this.isCurrentPlayer = param1;
         invalidate(FullStatsValidationType.COLORS);
      }
      
      public function setIsDead(param1:Boolean) : void
      {
         if(this.isDead == param1)
         {
            return;
         }
         this.isDead = param1;
         this.deadBg.visible = param1 && !this._isSelected;
         invalidate(FullStatsValidationType.COLORS);
      }
      
      public function setIsIGR(param1:Boolean) : void
      {
         if(this._isIGR == param1)
         {
            return;
         }
         this._isIGR = param1;
         invalidate(FullStatsValidationType.IS_IGR);
      }
      
      public function setIsOffline(param1:Boolean) : void
      {
         if(this.isOffline == param1)
         {
            return;
         }
         this.isOffline = param1;
         invalidate(FullStatsValidationType.COLORS);
      }
      
      public function setIsSelected(param1:Boolean) : void
      {
         if(this._isSelected == param1)
         {
            return;
         }
         this._isSelected = param1;
         invalidate(FullStatsValidationType.SELECTED | FullStatsValidationType.COLORS);
      }
      
      public function setIsSquadPersonal(param1:Boolean) : void
      {
         if(this.isSquadPersonal == param1)
         {
            return;
         }
         this.isSquadPersonal = param1;
         invalidate(FullStatsValidationType.COLORS);
      }
      
      public function setIsTeamKiller(param1:Boolean) : void
      {
         if(this.isTeamKiller == param1)
         {
            return;
         }
         this.isTeamKiller = param1;
         invalidate(FullStatsValidationType.COLORS);
      }
      
      public function setPlayerName(param1:IUserProps) : void
      {
         this._userProps = param1;
         invalidate(FullStatsValidationType.USER_PROPS | FullStatsValidationType.COLORS);
      }
      
      public function setShowDogTag(param1:Boolean) : void
      {
         if(this.dogTag == param1)
         {
            return;
         }
         this.dogTag = param1;
      }
      
      public function setSuffixBadge(param1:String) : void
      {
         if(this._suffixBadgeType == param1)
         {
            return;
         }
         this._suffixBadgeType = param1;
         invalidate(FullStatsValidationType.SUFFIXBAGE);
      }
      
      public function setSuffixBadgeStrip(param1:String) : void
      {
         if(this._suffixBadgeStripType == param1)
         {
            return;
         }
         this._suffixBadgeStripType = param1;
         invalidate(FullStatsValidationType.SUFFIXBAGE);
      }
      
      public function setVehicleName(param1:String) : void
      {
         if(this._vehicleName == param1)
         {
            return;
         }
         this._vehicleName = param1;
         invalidate(FullStatsValidationType.VEHICLE_NAME);
      }
      
      public function setVehicleType(param1:String) : void
      {
         var _loc2_:String = BATTLEATLAS.getFullStatsVehicleType(param1);
         if(_loc2_ == this._vehicleType)
         {
            return;
         }
         this._vehicleType = _loc2_;
         invalidate(FullStatsValidationType.VEHICLE_TYPE);
      }
      
      public function updateColorBlind() : void
      {
         invalidate(FullStatsValidationType.COLORS);
      }
      
      protected function applyTextColor(param1:uint) : void
      {
         this._playerNameTF.textColor = param1;
         this._vehicleNameTF.textColor = param1;
         this._fragsTF.textColor = param1;
      }
      
      public function get userProps() : IUserProps
      {
         return this._userProps;
      }
      
      protected function get numRows() : uint
      {
         return NUM_ROWS;
      }
      
      protected function get isEnemy() : Boolean
      {
         return this._isEnemy;
      }
   }
}
