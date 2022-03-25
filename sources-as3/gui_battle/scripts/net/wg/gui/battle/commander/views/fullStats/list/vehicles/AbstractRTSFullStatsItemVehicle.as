package net.wg.gui.battle.commander.views.fullStats.list.vehicles
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.UserTags;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.VehicleStatus;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.commander.VO.daapi.DAAPIVehicleCommanderDataVO;
   import net.wg.gui.battle.commander.views.common.VehicleTypeIcon;
   import net.wg.gui.battle.commander.views.fullStats.interfaces.IRTSFullStatsItemVehicle;
   import net.wg.gui.battle.commander.views.fullStats.list.base.AbstractRTSFullStatsItem;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.components.controls.BadgeComponent;
   import net.wg.gui.components.controls.VO.BadgeVisualVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   import net.wg.infrastructure.interfaces.IUserProps;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.gfx.TextFieldEx;
   
   public class AbstractRTSFullStatsItemVehicle extends AbstractRTSFullStatsItem implements IRTSFullStatsItemVehicle
   {
      
      protected static const INVALID_COMMANDER_DATA:uint = FLAGS_BORDER << 1;
      
      protected static const INVALID_VEHICLE_STATUS:uint = FLAGS_BORDER << 2;
      
      protected static const INVALID_PLAYER_NAME:uint = FLAGS_BORDER << 3;
      
      protected static const INVALID_VEHICLE_NAME:uint = FLAGS_BORDER << 4;
      
      protected static const INVALID_VEHICLE_ICON:uint = FLAGS_BORDER << 5;
      
      protected static const INVALID_VEHICLE_TYPE:uint = FLAGS_BORDER << 6;
      
      protected static const INVALID_USER_TAGS:uint = FLAGS_BORDER << 7;
      
      protected static const INVALID_HAS_COMMANDER_DATA:uint = FLAGS_BORDER << 8;
      
      protected static const INVALID_CURRENT_VEHICLE:uint = FLAGS_BORDER << 9;
      
      protected static const INVALID_SPOTTED:uint = FLAGS_BORDER << 10;
      
      protected static const INVALID_BADGE:uint = FLAGS_BORDER << 11;
      
      protected static const INVALID_SUFFIXBAGE:uint = FLAGS_BORDER << 12;
      
      protected static const TEXT_COLOR_DEFAULT:uint = 12763824;
      
      protected static const TEXT_COLOR_CURRENT:uint = 15775583;
      
      protected static const ALPHA_ALIVE:Number = 1;
      
      protected static const ALPHA_DEAD:Number = 0.5;
      
      protected static const BADGE_OFFSET:uint = 32;
      
      private static const FIELD_WIDTH_COMPENSATION:int = 2;
      
      private static const RANKED_BADGE_OFFSET:int = 1;
       
      
      public var badge:BadgeComponent = null;
      
      public var vehicleType:VehicleTypeIcon = null;
      
      public var vehicleName:TextField = null;
      
      public var icoTester:BattleAtlasSprite = null;
      
      public var testerBack:BattleAtlasSprite = null;
      
      public var playerName:TextField = null;
      
      public var frags:TextField = null;
      
      public var vehicleIcon:BattleAtlasSprite = null;
      
      public var bg:Sprite = null;
      
      public var selfBg:Sprite = null;
      
      public var deadBg:Sprite = null;
      
      protected var _badgeData:BadgeVisualVO = null;
      
      protected var _vehicleStatus:uint = 0;
      
      protected var _hasCommanderData:Boolean = false;
      
      protected var _isAttached:Boolean = false;
      
      protected var _health:Number = 0;
      
      protected var _maxHealth:Number = 0;
      
      protected var _playerName:String = "";
      
      protected var _vehicleName:String = "";
      
      protected var _vehicleIcon:String = "";
      
      protected var _vehicleType:String = "";
      
      protected var _userTags:Array = null;
      
      protected var _isReady:Boolean = false;
      
      protected var _isAlive:Boolean = false;
      
      protected var _isCurrentVehicle:Boolean = false;
      
      protected var _isSpotted:Boolean = false;
      
      private var _suffixBadgeType:String;
      
      private var _suffixBadgeStripType:String = null;
      
      private var _vehicleData:DAAPIVehicleInfoVO;
      
      private var _toolTipString:String;
      
      public function AbstractRTSFullStatsItemVehicle()
      {
         super();
         TextFieldEx.setNoTranslate(this.vehicleName,true);
         TextFieldEx.setNoTranslate(this.playerName,true);
         TextFieldEx.setNoTranslate(this.frags,true);
      }
      
      private static function onMouseRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      override public function setData(param1:IDAAPIDataClass) : void
      {
         this._vehicleData = DAAPIVehicleInfoVO(param1);
         if(this._badgeData != this._vehicleData.badgeVO)
         {
            this._badgeData = this._vehicleData.badgeVO;
            invalidate(INVALID_BADGE);
         }
         if(this._vehicleIcon != this._vehicleData.vehicleIconName)
         {
            this._vehicleIcon = this._vehicleData.vehicleIconName;
            invalidate(INVALID_VEHICLE_ICON);
         }
         if(this._vehicleName != this._vehicleData.vehicleName)
         {
            this._vehicleName = this._vehicleData.vehicleName;
            invalidate(INVALID_VEHICLE_NAME);
         }
         if(this._vehicleType != this._vehicleData.vehicleType)
         {
            this._vehicleType = this._vehicleData.vehicleType;
            invalidate(INVALID_VEHICLE_TYPE);
         }
         invalidate(INVALID_PLAYER_NAME);
         setFrags(this._vehicleData.frags);
         this.setUserTags(this._vehicleData.userTags);
         this.setVehicleStatus(this._vehicleData.vehicleStatus);
         this.setSuffixBadge(this._vehicleData.suffixBadgeType);
         this.setSuffixBadgeStrip(this._vehicleData.suffixBadgeStripType);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,onMouseRollOutHandler);
         this.badge.dispose();
         this.vehicleType.dispose();
         this._badgeData = null;
         this.badge = null;
         this.vehicleType = null;
         this.vehicleName = null;
         this.playerName = null;
         this.vehicleIcon = null;
         this.selfBg = null;
         this.deadBg = null;
         this.bg = null;
         this.testerBack = null;
         this.icoTester = null;
         this._vehicleData = null;
         this._toolTipString = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.vehicleType.isAlly = this.isAllyItem;
         this.icoTester.visible = false;
         this.testerBack.visible = false;
         addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler,false,0,true);
         addEventListener(MouseEvent.ROLL_OUT,onMouseRollOutHandler,false,0,true);
      }
      
      override protected function draw() : void
      {
         var _loc1_:IUserProps = null;
         var _loc2_:Boolean = false;
         super.draw();
         if(isInvalid(INVALID_VEHICLE_STATUS))
         {
            this._isReady = (this._vehicleStatus & VehicleStatus.IS_READY) > 0;
            this._isAlive = (this._vehicleStatus & VehicleStatus.IS_ALIVE) > 0;
            this.vehicleType.isAlive = this._isAlive;
            this.deadBg.visible = !this._isAlive;
            this.playerName.alpha = this.vehicleName.alpha = this.vehicleType.alpha = this.vehicleIcon.alpha = !!this._isAlive ? Number(ALPHA_ALIVE) : Number(ALPHA_DEAD);
         }
         if(isInvalid(INVALID_FRAGS))
         {
            this.frags.text = _frags != 0 ? _frags.toString() : Values.EMPTY_STR;
         }
         if(isInvalid(INVALID_PLAYER_NAME))
         {
            _loc1_ = App.utils.commons.getUserProps(this._vehicleData.playerName,this._vehicleData.clanAbbrev,this._vehicleData.region,Values.ZERO,this._vehicleData.userTags,this._vehicleData.playerFakeName);
            App.utils.commons.formatPlayerName(this.playerName,_loc1_,!this._vehicleData.isCurrentPlayer,this._vehicleData.isCurrentPlayer);
            if(this._vehicleData.isCurrentPlayer && StringUtils.isNotEmpty(_loc1_.fakeName))
            {
               this._toolTipString = _loc1_.clanAbbrev != Values.EMPTY_STR ? App.utils.locale.makeString(TOOLTIPS.ANONYMIZER_BATTLE_TEAMLIST_CLAN,{"fakeName":_loc1_.fakeName}) : App.utils.locale.makeString(TOOLTIPS.ANONYMIZER_BATTLE_TEAMLIST_NOCLAN,{"fakeName":_loc1_.fakeName});
            }
         }
         if(isInvalid(INVALID_VEHICLE_NAME))
         {
            this.vehicleName.text = this._vehicleName;
         }
         if(isInvalid(INVALID_VEHICLE_ICON))
         {
            this.vehicleIcon.setImageNames(this._vehicleIcon,BATTLEATLAS.UNKNOWN);
         }
         if(isInvalid(INVALID_HAS_COMMANDER_DATA) && this._hasCommanderData)
         {
            this.playerName.visible = false;
         }
         if(isInvalid(INVALID_CURRENT_VEHICLE))
         {
            this.selfBg.visible = this._isCurrentVehicle;
            this.vehicleName.textColor = !!this._isCurrentVehicle ? uint(TEXT_COLOR_CURRENT) : uint(TEXT_COLOR_DEFAULT);
         }
         if(isInvalid(INVALID_VEHICLE_TYPE))
         {
            this.vehicleType.vehicleType = this._vehicleType;
         }
         if(isInvalid(INVALID_SPOTTED))
         {
            this.vehicleType.isSpotted = this._isSpotted;
         }
         if(isInvalid(INVALID_BADGE | INVALID_HAS_COMMANDER_DATA))
         {
            _loc2_ = this.badge.visible = !this._hasCommanderData && this._badgeData;
            if(_loc2_)
            {
               this.badge.setData(this._badgeData);
               this.playerName.x += !!this.isAllyItem ? BADGE_OFFSET : -BADGE_OFFSET;
            }
         }
         if(isInvalid(INVALID_SUFFIXBAGE))
         {
            this.icoTester.visible = this.testerBack.visible = Boolean(this._suffixBadgeType);
            if(this.icoTester.visible && this.playerName.visible)
            {
               this.icoTester.imageName = this._suffixBadgeType;
               this.testerBack.imageName = this._suffixBadgeStripType;
               if(this.isAllyItem)
               {
                  this.icoTester.x = this.playerName.x + this.playerName.textWidth + RANKED_BADGE_OFFSET >> 0;
                  this.testerBack.x = -FIELD_WIDTH_COMPENSATION + ((this.icoTester.width >> 1) + this.icoTester.x - this.testerBack.width) >> 0;
               }
               else
               {
                  this.icoTester.x = -FIELD_WIDTH_COMPENSATION + (this.playerName.width - this.playerName.textWidth + this.playerName.x - this.icoTester.width) >> 0;
                  this.testerBack.scaleX = -1;
                  this.testerBack.x = this.icoTester.x + this.testerBack.width + (this.icoTester.width >> 1) >> 0;
               }
            }
         }
      }
      
      public function setChatCommand(param1:String, param2:uint) : void
      {
      }
      
      public function setInvitationStatus(param1:uint) : void
      {
      }
      
      public function setIsSpotted(param1:Boolean) : void
      {
         if(this._isSpotted != param1)
         {
            this._isSpotted = param1;
            invalidate(INVALID_SPOTTED);
         }
      }
      
      public function setRTSIsMove(param1:Boolean) : void
      {
      }
      
      public function setRTSCommanderData(param1:DAAPIVehicleCommanderDataVO) : void
      {
         if(this._hasCommanderData != param1.hasCommanderData)
         {
            this._hasCommanderData = param1.hasCommanderData;
            invalidate(INVALID_HAS_COMMANDER_DATA);
         }
         if(this._health != param1.health || this._maxHealth != param1.maxHealth || this._isAttached != param1.isAttached)
         {
            this._health = param1.health;
            this._maxHealth = param1.maxHealth;
            this._isAttached = param1.isAttached;
            this.updateCurrentVehicle();
            invalidate(INVALID_COMMANDER_DATA);
         }
      }
      
      public function setUserTags(param1:Array) : void
      {
         if(this._userTags != param1)
         {
            this._userTags = param1;
            this.updateCurrentVehicle();
         }
      }
      
      public function setVehicleStatus(param1:uint) : void
      {
         if(param1 != this._vehicleStatus)
         {
            this._vehicleStatus = param1;
            invalidate(INVALID_VEHICLE_STATUS);
         }
      }
      
      public function triggerChatCommand(param1:String) : void
      {
      }
      
      protected function setCurrentVehicle(param1:Boolean) : void
      {
         if(param1 != this._isCurrentVehicle)
         {
            this._isCurrentVehicle = param1;
            invalidate(INVALID_CURRENT_VEHICLE);
         }
      }
      
      protected function updateCurrentVehicle() : void
      {
         this.setCurrentVehicle(this._isAttached || UserTags.isCurrentPlayer(this._userTags));
      }
      
      protected function get isAllyItem() : Boolean
      {
         throw new AbstractException(Errors.ABSTRACT_INVOKE);
      }
      
      private function onMouseRollOverHandler(param1:MouseEvent) : void
      {
         if(this._toolTipString)
         {
            App.toolTipMgr.show(this._toolTipString);
         }
      }
      
      private function setSuffixBadge(param1:String) : void
      {
         if(this._suffixBadgeType == param1)
         {
            return;
         }
         this._suffixBadgeType = param1;
         invalidate(INVALID_SUFFIXBAGE);
      }
      
      private function setSuffixBadgeStrip(param1:String) : void
      {
         if(this._suffixBadgeStripType == param1)
         {
            return;
         }
         this._suffixBadgeStripType = param1;
         invalidate(INVALID_SUFFIXBAGE);
      }
   }
}
