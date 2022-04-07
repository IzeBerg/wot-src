package net.wg.gui.battle.commander.views.vehiclesPanel
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.VehicleStatus;
   import net.wg.gui.battle.commander.VO.daapi.DAAPIVehicleCommanderDataVO;
   import net.wg.gui.battle.commander.views.common.Clips;
   import net.wg.gui.battle.commander.views.common.EventIcon;
   import net.wg.gui.battle.commander.views.common.GroupIcon;
   import net.wg.gui.battle.commander.views.common.HealthBar;
   import net.wg.gui.battle.commander.views.common.OrderIcon;
   import net.wg.gui.battle.commander.views.common.Reloading;
   import net.wg.gui.battle.commander.views.common.ReloadingData;
   import net.wg.gui.battle.commander.views.common.VehicleTypeIcon;
   import net.wg.gui.components.controls.UILoaderCut;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class VehiclesPanelItem extends UIComponentEx
   {
      
      private static const OPACITY_ALIVE:Number = 1;
      
      private static const OPACITY_DEAD:Number = 0.5;
      
      private static const FRAME_BIG:String = "big";
      
      private static const FRAME_SMALL:String = "small";
      
      private static const FRAME_DISABLED_POSTFIX:String = "_disabled";
      
      private static const VEHICLE_DEATH_CONDITON:String = "OnDeadCondition";
      
      private static const VEHICLE_IMAGE_CUT_BIG:Object = {
         "x":0,
         "y":0,
         "width":159,
         "height":98
      };
      
      private static const VEHICLE_IMAGE_CUT_SMALL:Object = {
         "x":32,
         "y":0,
         "width":98,
         "height":98
      };
      
      private static const SMALL_WIDTH:Number = 98 + 11;
      
      private static const BIG_WIDTH:Number = 160 + 21;
      
      private static const INVALIDATE_GROUP:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      private static const INVALIDATE_ALIVE:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
      
      private static const INVALIDATE_FOCUSED:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 3;
      
      private static const INVALIDATE_SELECTED:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 5;
      
      private static const INVALIDATE_HEALTH:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 8;
      
      private static const INVALIDATE_SPEAKING:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 9;
      
      private static const INVALIDATE_CLIP:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 10;
       
      
      public var bg:VehiclesPanelItemBG = null;
      
      public var bgVehicle:UILoaderCut = null;
      
      public var bgVehicleLight:UILoaderCut = null;
      
      public var speakingMC:MovieClip = null;
      
      public var eventIcon:EventIcon = null;
      
      public var groupIcon:GroupIcon = null;
      
      public var clips:Clips = null;
      
      public var vehicleType:VehicleTypeIcon = null;
      
      public var vehicleName:TextField = null;
      
      public var reloading:Reloading = null;
      
      public var healthBar:HealthBar = null;
      
      public var order:OrderIcon = null;
      
      public var moduleIcons:VehicleDamagedModules = null;
      
      private var _isBig:Boolean = true;
      
      private var _reloadingContext:ReloadingData = null;
      
      private var _isSpeaking:Boolean;
      
      private var _isFocused:Boolean;
      
      private var _groupID:Number;
      
      private var _isAlive:Boolean;
      
      private var _vehicleID:Number;
      
      private var _isSelected:Boolean;
      
      private var _isDisabled:Boolean;
      
      private var _health:Number;
      
      private var _maxHealth:Number;
      
      private var _vehicleName:String;
      
      private var _vehicleType:String;
      
      private var _iconPath:String;
      
      private var _clipMaxCount:int;
      
      private var _clipCurrentCount:int;
      
      private var _isAutoload:Boolean;
      
      private var _isDualgun:Boolean;
      
      public function VehiclesPanelItem()
      {
         super();
      }
      
      public static function getWidth(param1:Boolean) : Number
      {
         return !!param1 ? Number(BIG_WIDTH) : Number(SMALL_WIDTH);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         doubleClickEnabled = true;
         mouseChildren = false;
         visible = false;
         this._reloadingContext = this.reloading.makeContext();
      }
      
      override protected function onDispose() : void
      {
         this._reloadingContext = null;
         this.speakingMC = null;
         this.vehicleName = null;
         this.bg.dispose();
         this.bg = null;
         this.bgVehicleLight.dispose();
         this.bgVehicleLight = null;
         this.bgVehicle.dispose();
         this.bgVehicle = null;
         this.groupIcon.dispose();
         this.groupIcon = null;
         this.vehicleType.dispose();
         this.vehicleType = null;
         this.reloading.dispose();
         this.reloading = null;
         this.healthBar.dispose();
         this.healthBar = null;
         this.eventIcon.dispose();
         this.eventIcon = null;
         this.clips.dispose();
         this.clips = null;
         this.order.dispose();
         this.order = null;
         this.moduleIcons.clear();
         this.moduleIcons.dispose();
         this.moduleIcons = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc3_:String = null;
         super.draw();
         var _loc1_:Boolean = isInvalid(InvalidationType.SIZE);
         var _loc2_:Boolean = isInvalid(INVALIDATE_ALIVE);
         if(_loc1_)
         {
            _loc3_ = !!this.isBig ? FRAME_BIG : FRAME_SMALL;
            _loc3_ = !!this.isDisabled ? _loc3_ + FRAME_DISABLED_POSTFIX : _loc3_;
            if(_loc3_ != currentFrameLabel)
            {
               gotoAndStop(_loc3_);
               this.reloading.setContext(this._reloadingContext);
            }
            this.bgVehicleLight.cutRect = this.bgVehicle.cutRect = !!this.isBig ? VEHICLE_IMAGE_CUT_BIG : VEHICLE_IMAGE_CUT_SMALL;
            this.moduleIcons.isBig = this.isBig;
         }
         if(_loc1_ || isInvalid(INVALIDATE_GROUP))
         {
            this.groupIcon.groupID = this.groupID;
         }
         if(_loc1_ || _loc2_)
         {
            this.vehicleType.isAlive = this.bg.isAlive = this.eventIcon.isAlive = this.healthBar.isAlive = this.reloading.isAlive = this.vehicleType.isAlive = this.order.isAlive = this.groupIcon.isAlive = this.clips.isAlive = this.isAlive;
            this.vehicleType.alpha = this.vehicleName.alpha = this.bgVehicle.alpha = !!this.isAlive ? Number(OPACITY_ALIVE) : Number(OPACITY_DEAD);
            this.bgVehicleLight.visible = this.isAlive;
         }
         if(_loc1_ || isInvalid(INVALIDATE_FOCUSED))
         {
            this.bg.isFocus = this.isFocused && !this.isDisabled;
         }
         if(_loc1_ || isInvalid(INVALIDATE_SELECTED))
         {
            this.groupIcon.isSelected = this.bg.isSelected = this.isSelected && !this.isDisabled;
         }
         if(_loc1_ || isInvalid(INVALIDATE_HEALTH))
         {
            this.healthBar.currentHP = this._health;
            this.healthBar.maxHP = this._maxHealth;
         }
         if(_loc1_ || isInvalid(INVALIDATE_SPEAKING))
         {
            this.speakingMC.visible = this.isSpeaking;
         }
         if(_loc1_ || isInvalid(INVALIDATE_CLIP))
         {
            this.clips.maxCount = this._clipMaxCount;
            this.clips.currentCount = this._clipCurrentCount;
            this.clips.isAutoload = this._isAutoload;
            this.clips.isDualgun = this._isDualgun;
         }
         if(_loc1_ || isInvalid(InvalidationType.DATA))
         {
            this.vehicleName.text = this._vehicleName;
            this.vehicleType.isAlly = true;
            this.vehicleType.vehicleType = this._vehicleType;
            this.bgVehicleLight.source = this.bgVehicle.source = "../maps/icons/vehicle/" + this._iconPath + ".png";
         }
      }
      
      public function setClipData(param1:int, param2:int, param3:Boolean, param4:Boolean) : void
      {
         if(this._clipMaxCount != param1)
         {
            this._clipMaxCount = param1;
            invalidate(INVALIDATE_CLIP);
         }
         if(this._clipCurrentCount != param2)
         {
            this._clipCurrentCount = param2;
            invalidate(INVALIDATE_CLIP);
         }
         if(this._isAutoload != param3)
         {
            this._isAutoload = param3;
            invalidate(INVALIDATE_CLIP);
         }
         if(this._isDualgun != param4)
         {
            this._isDualgun = param4;
            invalidate(INVALIDATE_CLIP);
         }
      }
      
      public function setCommanderData(param1:DAAPIVehicleCommanderDataVO) : void
      {
         if(this._health != param1.health || this._maxHealth != param1.maxHealth)
         {
            this._health = param1.health;
            this._maxHealth = param1.maxHealth;
            invalidate(INVALIDATE_HEALTH);
         }
         visible = param1.hasCommanderData;
      }
      
      public function setData(param1:DAAPIVehicleInfoVO) : void
      {
         if(this._vehicleType != param1.vehicleType || this._vehicleName != param1.vehicleName || this._iconPath != param1.vehicleIconName)
         {
            this._vehicleType = param1.vehicleType;
            this._vehicleName = param1.vehicleName;
            this._iconPath = param1.vehicleIconName;
            invalidateData();
         }
         this._vehicleID = param1.vehicleID;
         this.isAlive = param1.isAlive();
      }
      
      public function setPosition(param1:Number) : void
      {
         x = param1 * getWidth(this.isBig);
      }
      
      public function setReloading(param1:Number, param2:Number, param3:Number) : void
      {
         this.reloading.setReloading(param1,param2,param3,this.visible);
      }
      
      public function setOrderIconState(param1:Number, param2:Boolean) : void
      {
         if(this.order.orderID != param1 || this.order.isShown != param2)
         {
            this.order.orderID = param1;
            this.order.isShown = this.order.visible = param2;
         }
      }
      
      public function setStatus(param1:uint) : void
      {
         this.isAlive = (param1 & VehicleStatus.IS_ALIVE) > 0;
      }
      
      public function get isBig() : Boolean
      {
         return this._isBig;
      }
      
      public function set isBig(param1:Boolean) : void
      {
         if(this._isBig != param1)
         {
            this._isBig = param1;
            invalidate(InvalidationType.SIZE);
         }
      }
      
      public function get vehicleID() : Number
      {
         return this._vehicleID;
      }
      
      public function get isAlive() : Boolean
      {
         return this._isAlive;
      }
      
      public function set isAlive(param1:Boolean) : void
      {
         if(this._isAlive != param1)
         {
            this._isAlive = param1;
            invalidate(INVALIDATE_ALIVE);
         }
      }
      
      public function get groupID() : int
      {
         return this._groupID;
      }
      
      public function set groupID(param1:int) : void
      {
         if(this._groupID != param1)
         {
            this._groupID = param1;
            invalidate(INVALIDATE_GROUP);
         }
      }
      
      public function get isFocused() : Boolean
      {
         return this._isFocused;
      }
      
      public function set isFocused(param1:Boolean) : void
      {
         if(this._isFocused != param1)
         {
            this._isFocused = param1;
            invalidate(INVALIDATE_FOCUSED);
         }
      }
      
      public function get isSelected() : Boolean
      {
         return this._isSelected;
      }
      
      public function set isSelected(param1:Boolean) : void
      {
         if(this._isSelected != param1)
         {
            this._isSelected = param1;
            invalidate(INVALIDATE_SELECTED);
         }
      }
      
      public function get isDisabled() : Boolean
      {
         return this._isDisabled;
      }
      
      public function set isDisabled(param1:Boolean) : void
      {
         if(this._isDisabled != param1)
         {
            this._isDisabled = param1;
            invalidate(InvalidationType.SIZE);
         }
      }
      
      public function get isSpeaking() : Boolean
      {
         return this._isSpeaking;
      }
      
      public function set isSpeaking(param1:Boolean) : void
      {
         if(this._isSpeaking != param1)
         {
            this._isSpeaking = param1;
            invalidate(INVALIDATE_SPEAKING);
         }
      }
      
      public function setCondition(param1:String) : void
      {
         this.eventIcon.setCondition(param1);
         if(param1 == VEHICLE_DEATH_CONDITON)
         {
            this.moduleIcons.removeAllIcons();
         }
      }
      
      public function setDamagedModule(param1:String) : void
      {
         this.moduleIcons.addIcon(param1);
      }
      
      public function setRepairedModule(param1:String) : void
      {
         this.moduleIcons.removeIcon(param1);
      }
      
      public function setCompVisible(param1:Boolean) : void
      {
         this.visible = param1;
         if(param1)
         {
            this.reloading.invalidateData();
         }
      }
   }
}
