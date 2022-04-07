package net.wg.gui.battle.views.minimap.components.entries.vehicle
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.components.BaseProgressCircle;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.components.HpProgressCircle;
   import net.wg.gui.battle.views.minimap.MinimapEntryController;
   import net.wg.gui.battle.views.minimap.components.entries.constants.AbsorptionFlagEntryConst;
   import net.wg.gui.battle.views.minimap.components.entries.constants.VehicleMinimapEntryConst;
   import net.wg.gui.battle.views.minimap.components.entries.interfaces.IVehicleMinimapEntry;
   import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersConstants;
   import net.wg.infrastructure.events.ColorSchemeEvent;
   import net.wg.infrastructure.interfaces.IColorScheme;
   import scaleform.gfx.TextFieldEx;
   
   public class VehicleMinimapEntry extends BattleUIComponent implements IVehicleMinimapEntry
   {
      
      public static const INVALID_VEHICLE_LABEL:int = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      public static const INVALID_VEHICLE_ACTION_ANIMATION:int = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
      
      public static const INVALID_CHANGE_VEHICLE_ANIMATION_TYPE:int = InvalidationType.SYSTEM_FLAGS_BORDER << 3;
      
      public static const INVALID_BEARER_STATE:int = InvalidationType.SYSTEM_FLAGS_BORDER << 4;
      
      public static const INVALID_HP:int = InvalidationType.SYSTEM_FLAGS_BORDER << 5;
      
      public static const INVALID_MT_STATE:int = InvalidationType.SYSTEM_FLAGS_BORDER << 6;
      
      private static const ENEMY_BEARER_LABEL:String = "enemyBearer";
      
      private static const ENEMY_BEARER_BLIND_LABEL:String = "enemyBearerBlind";
      
      private static const ALLY_BEARER_LABEL:String = "allyBearer";
      
      private static const LABEL_TEAM_KILLER:String = "teamKiller";
      
      private static const LABEL_SQUADMAN:String = "squadman";
      
      protected static const ATLAS_NAME_DELIMITER:String = "_";
      
      private static const HP_OFFSET_X:int = 8;
      
      private static const HP_OFFSET_Y:int = -2;
       
      
      public var mcTopAnimation:MarkerTopAnimation = null;
      
      public var hpCircle:HpProgressCircle = null;
      
      public var enemyRedAnimation:VehicleAnimationMinimapEntry = null;
      
      public var enemyPurpleAnimation:VehicleAnimationMinimapEntry = null;
      
      public var deadAnimation:VehicleAnimationMinimapEntry = null;
      
      public var deadPermanentAnimation:VehicleAnimationMinimapEntry = null;
      
      public var squadmanYellowAnimation:VehicleAnimationMinimapEntry = null;
      
      public var squadmanGoldAnimation:VehicleAnimationMinimapEntry = null;
      
      public var teamKillerBlueAnimation:VehicleAnimationMinimapEntry = null;
      
      public var allyGreenAnimation:VehicleAnimationMinimapEntry = null;
      
      public var vehicleNameTextFieldAlt:TextField = null;
      
      public var vehicleNameTextFieldClassic:TextField = null;
      
      public var mcBearerAnimation:MovieClip = null;
      
      public var mcBearerAnimationContainer:MovieClip = null;
      
      private var _classTagName:String = "";
      
      private var _vehicleID:Number = -1;
      
      private var _guiLabel:String = "";
      
      private var _currentBearerLabel:String = "";
      
      private var _vehicleName:String = "";
      
      private var _actionAnimationType:String = "";
      
      private var _isSetVehicleInfo:Boolean = false;
      
      private var _aliasColor:String = "";
      
      private var _deadState:String = "";
      
      private var _isDeadPermanent:Boolean = false;
      
      private var _vehicleAnimationFrameLabel:String = "";
      
      private var _currVehicleAnimation:VehicleAnimationMinimapEntry = null;
      
      private var _currentTextField:TextField = null;
      
      private var _vehicleAnimations:Object;
      
      private var _isFlagBearer:Boolean = false;
      
      private var _isColorBlind:Boolean = false;
      
      private var _atlasItemName:String = "";
      
      private var _isVehicleLabelVisible:Boolean = false;
      
      private var _isInAoI:Boolean = false;
      
      private var _percentHP:int = 100;
      
      private var _prevTextPosX:int = 0;
      
      private var _prevTextPosY:int = 0;
      
      private var _showVehicleHp:Boolean = false;
      
      private var _hpTypeMap:Object;
      
      public function VehicleMinimapEntry()
      {
         this._vehicleAnimations = {};
         this._hpTypeMap = {};
         super();
         mouseEnabled = mouseChildren = false;
         this._vehicleAnimations[VehicleMinimapEntryConst.ALLY_GREEN_ANIMATION] = this.allyGreenAnimation;
         this._vehicleAnimations[VehicleMinimapEntryConst.ENEMY_RED_ANIMATION] = this.enemyRedAnimation;
         this._vehicleAnimations[VehicleMinimapEntryConst.ENEMY_PURPLE_ANIMATION] = this.enemyPurpleAnimation;
         this._vehicleAnimations[VehicleMinimapEntryConst.SQUADMAN_YELLOW_ANIMATION] = this.squadmanYellowAnimation;
         this._vehicleAnimations[VehicleMinimapEntryConst.SQUADMAN_GOLD_ANIMATION] = this.squadmanGoldAnimation;
         this._vehicleAnimations[VehicleMinimapEntryConst.TEAMKILLER_BLUE_ANIMATION] = this.teamKillerBlueAnimation;
         this._hpTypeMap[VehicleMarkersConstants.ENTITY_NAME_ENEMY] = BaseProgressCircle.ENEMY_STATE;
         this._hpTypeMap[VehicleMarkersConstants.ENTITY_NAME_ALLY] = BaseProgressCircle.ALLY_STATE;
         this._hpTypeMap[LABEL_TEAM_KILLER] = HpProgressCircle.TEAM_KILLER_STATE;
         this._hpTypeMap[LABEL_SQUADMAN] = HpProgressCircle.PLATOON_STATE;
         this.allyGreenAnimation.visible = this.enemyRedAnimation.visible = this.enemyPurpleAnimation.visible = this.squadmanYellowAnimation.visible = this.squadmanGoldAnimation.visible = this.teamKillerBlueAnimation.visible = this.mcBearerAnimationContainer.visible = this.deadAnimation.visible = this.deadPermanentAnimation.visible = false;
         this.vehicleNameTextFieldAlt.visible = false;
         this._currentTextField = this.vehicleNameTextFieldClassic;
         this._prevTextPosX = this._currentTextField.x;
         this._prevTextPosY = this._currentTextField.y;
         TextFieldEx.setNoTranslate(this.vehicleNameTextFieldAlt,true);
         TextFieldEx.setNoTranslate(this.vehicleNameTextFieldClassic,true);
         MinimapEntryController.instance.registerScalableEntry(this);
         this._isColorBlind = App.colorSchemeMgr.getIsColorBlindS();
      }
      
      override protected function draw() : void
      {
         var _loc1_:TextFormat = null;
         var _loc2_:String = null;
         var _loc3_:IColorScheme = null;
         var _loc4_:String = null;
         if(isInvalid(INVALID_VEHICLE_LABEL))
         {
            if(this._isVehicleLabelVisible)
            {
               this._currentTextField.htmlText = this._vehicleName;
               this._currentTextField.autoSize = TextFieldAutoSize.LEFT;
               _loc1_ = this._currentTextField.getTextFormat();
               _loc1_.color = App.colorSchemeMgr.getRGB(this.getTextColorSchema());
               this._currentTextField.setTextFormat(_loc1_);
               this._currentTextField.height = this._currentTextField.textHeight;
               this._currentTextField.visible = true;
            }
            else
            {
               this._currentTextField.visible = false;
            }
            if(this._isFlagBearer)
            {
               this.mcBearerAnimation.visible = false;
            }
         }
         if(isInvalid(INVALID_VEHICLE_ACTION_ANIMATION))
         {
            if(this._actionAnimationType != Values.EMPTY_STR)
            {
               this.mcTopAnimation.playAnim(this._actionAnimationType);
            }
            else
            {
               this.mcTopAnimation.gotoAndStop(1);
            }
         }
         if(this._guiLabel != Values.EMPTY_STR && isInvalid(INVALID_CHANGE_VEHICLE_ANIMATION_TYPE))
         {
            _loc2_ = VehicleMinimapEntryConst.COLOR_SCHEME_PREFIX + this._deadState + this._guiLabel;
            _loc3_ = App.colorSchemeMgr.getScheme(_loc2_);
            this._aliasColor = _loc3_.aliasColor;
            if(this._currVehicleAnimation)
            {
               _loc4_ = this._currVehicleAnimation.currentFrameLabel;
               this._currVehicleAnimation.stop();
               this._currVehicleAnimation.visible = false;
            }
            this._atlasItemName = this.getAtlasItemName();
            if(this._deadState == VehicleMinimapEntryConst.DEAD)
            {
               if(this._isDeadPermanent)
               {
                  this._currVehicleAnimation = this.deadPermanentAnimation;
               }
               else
               {
                  this._currVehicleAnimation = this.deadAnimation;
               }
               this._currVehicleAnimation.drawEntry(this._atlasItemName);
               if(_loc4_ != VehicleMinimapEntryConst.DESTROYED_FRAME_LABEL)
               {
                  this._vehicleAnimationFrameLabel = VehicleMinimapEntryConst.DESTROY_FRAME;
               }
               else
               {
                  this._vehicleAnimationFrameLabel = VehicleMinimapEntryConst.DESTROYED_FRAME_LABEL;
               }
               this._currVehicleAnimation.visible = true;
               this._currVehicleAnimation.gotoAndPlay(this._vehicleAnimationFrameLabel);
               this.hpCircle.visible = false;
            }
            else
            {
               this._currVehicleAnimation = this._vehicleAnimations[this._guiLabel + ATLAS_NAME_DELIMITER + this._deadState + this._aliasColor];
               this._currVehicleAnimation.drawEntry(this._atlasItemName);
               if(_loc4_ == VehicleMinimapEntryConst.HIGHLIGHT_ANIMATION_FRAME || _loc4_ == VehicleMinimapEntryConst.HIGHLIGHTED_FRAME)
               {
                  this._vehicleAnimationFrameLabel = VehicleMinimapEntryConst.HIGHLIGHTED_FRAME;
               }
               else
               {
                  this._vehicleAnimationFrameLabel = VehicleMinimapEntryConst.UNHIGHLIGHTED_FRAME;
               }
               this._currVehicleAnimation.visible = true;
               this._currVehicleAnimation.gotoAndStop(this._vehicleAnimationFrameLabel);
            }
         }
         if(this.mcBearerAnimation && isInvalid(INVALID_BEARER_STATE))
         {
            this._currentBearerLabel = this._guiLabel == VehicleMarkersConstants.ENTITY_NAME_ENEMY ? (!!this._isColorBlind ? ENEMY_BEARER_BLIND_LABEL : ENEMY_BEARER_LABEL) : ALLY_BEARER_LABEL;
            this.mcBearerAnimation.gotoAndStop(this._currentBearerLabel);
         }
         if(isInvalid(INVALID_HP))
         {
            this.hpCircle.visible = this._showVehicleHp && this._deadState != VehicleMinimapEntryConst.DEAD;
            this.hpCircle.setColorBlindMode(this._isColorBlind);
            this.hpCircle.setIsAoI(this._isInAoI);
            this.hpCircle.setType(this._hpTypeMap[this._guiLabel]);
            if(this.hpCircle.visible)
            {
               this._currentTextField.x = this._prevTextPosX + HP_OFFSET_X;
               this._currentTextField.y = this._prevTextPosY + HP_OFFSET_Y;
            }
            else
            {
               this._currentTextField.x = this._prevTextPosX;
               this._currentTextField.y = this._prevTextPosY;
            }
            if(this._showVehicleHp)
            {
               this.hpCircle.updateProgress(Math.max(0,this._percentHP * 0.01));
            }
         }
      }
      
      public function getClassTagName() : String
      {
         return this._classTagName;
      }
      
      public function getDeadState() : String
      {
         return this._deadState;
      }
      
      protected function getAtlasItemName() : String
      {
         var _loc1_:String = null;
         if(this._isInAoI)
         {
            _loc1_ = this._classTagName + ATLAS_NAME_DELIMITER + this._guiLabel + ATLAS_NAME_DELIMITER + this._deadState + this._aliasColor;
         }
         else
         {
            _loc1_ = VehicleMinimapEntryConst.LAST_LIT_ICON_NAME + ATLAS_NAME_DELIMITER + this._guiLabel + ATLAS_NAME_DELIMITER + this._deadState + this._aliasColor;
         }
         return _loc1_;
      }
      
      protected function getTextColorSchema() : String
      {
         return VehicleMinimapEntryConst.TEXT_COLOR_SCHEME_PREFIX + this._guiLabel + VehicleMinimapEntryConst.TEXT_COLOR_SCHEME_POSTFIX;
      }
      
      override protected function onDispose() : void
      {
         MinimapEntryController.instance.unregisterScalableEntry(this);
         MinimapEntryController.instance.unregisterVehicleLabelEntry(this);
         MinimapEntryController.instance.unregisterVehicleEntry(this);
         this.mcTopAnimation.dispose();
         this.mcTopAnimation = null;
         App.utils.data.cleanupDynamicObject(this._vehicleAnimations);
         this._vehicleAnimations = null;
         this.enemyRedAnimation.dispose();
         this.enemyRedAnimation = null;
         this.enemyPurpleAnimation.dispose();
         this.enemyPurpleAnimation = null;
         this.deadAnimation.dispose();
         this.deadAnimation = null;
         this.deadPermanentAnimation.dispose();
         this.deadPermanentAnimation = null;
         this.squadmanYellowAnimation.dispose();
         this.squadmanYellowAnimation = null;
         this.squadmanGoldAnimation.dispose();
         this.squadmanGoldAnimation = null;
         this.teamKillerBlueAnimation.dispose();
         this.teamKillerBlueAnimation = null;
         this.allyGreenAnimation.dispose();
         this.allyGreenAnimation = null;
         this.hpCircle.dispose();
         this.hpCircle = null;
         this.mcBearerAnimation = null;
         this.mcBearerAnimationContainer = null;
         this._currVehicleAnimation = null;
         this._currentTextField = null;
         this.vehicleNameTextFieldAlt = null;
         this.vehicleNameTextFieldClassic = null;
         this._hpTypeMap = null;
         App.colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
         super.onDispose();
      }
      
      public function hideVehicleName() : void
      {
         this._isVehicleLabelVisible = false;
         invalidate(INVALID_VEHICLE_LABEL);
      }
      
      public function highlight() : void
      {
         if(this._currVehicleAnimation.currentFrameLabel != VehicleMinimapEntryConst.HIGHLIGHTED_FRAME)
         {
            this._currVehicleAnimation.gotoAndPlay(VehicleMinimapEntryConst.HIGHLIGHT_ANIMATION_FRAME);
         }
      }
      
      public function setAlive() : void
      {
         this._currentTextField.visible = this._isVehicleLabelVisible;
         this._deadState = Values.EMPTY_STR;
         invalidate(INVALID_CHANGE_VEHICLE_ANIMATION_TYPE);
      }
      
      public function setAnimation(param1:String) : void
      {
         this._actionAnimationType = param1;
         invalidate(INVALID_VEHICLE_ACTION_ANIMATION);
      }
      
      public function setDead(param1:Boolean) : void
      {
         this._currentTextField.visible = false;
         this._deadState = VehicleMinimapEntryConst.DEAD;
         this._isDeadPermanent = param1;
         invalidate(INVALID_CHANGE_VEHICLE_ANIMATION_TYPE);
      }
      
      public function setFlagBearer(param1:Boolean) : void
      {
         if(this._isFlagBearer != param1)
         {
            this._isFlagBearer = param1;
            if(this._isFlagBearer)
            {
               if(!this.mcBearerAnimation)
               {
                  this.mcBearerAnimation = App.utils.classFactory.getComponent(Linkages.VEHICLE_MINIMAP_BEARER_ANIMATION,MovieClip);
               }
               invalidate(INVALID_BEARER_STATE);
            }
            this.mcBearerAnimationContainer.visible = this._isFlagBearer;
         }
      }
      
      public function setGUILabel(param1:String) : void
      {
         if(this._guiLabel != param1)
         {
            this._guiLabel = param1;
            invalidate(INVALID_CHANGE_VEHICLE_ANIMATION_TYPE | INVALID_VEHICLE_LABEL | INVALID_HP);
         }
         else
         {
            invalidate(INVALID_CHANGE_VEHICLE_ANIMATION_TYPE);
         }
      }
      
      public function setInAoI(param1:Boolean) : void
      {
         this._currentTextField.visible = false;
         if(param1)
         {
            this._currentTextField = this.vehicleNameTextFieldClassic;
            MinimapEntryController.instance.registerVehicleEntry(this);
         }
         else
         {
            MinimapEntryController.instance.unregisterVehicleEntry(this);
            this._actionAnimationType = Values.EMPTY_STR;
            this._currentTextField = this.vehicleNameTextFieldAlt;
         }
         this._isInAoI = param1;
         invalidate(INVALID_VEHICLE_LABEL | INVALID_CHANGE_VEHICLE_ANIMATION_TYPE | INVALID_HP);
      }
      
      public function setVehicleHealth(param1:int) : void
      {
         this._percentHP = param1;
         invalidate(INVALID_HP);
      }
      
      public function setVehicleInfo(param1:Number, param2:String, param3:String, param4:String, param5:String) : void
      {
         this._vehicleID = param1;
         var _loc6_:uint = 0;
         if(this._classTagName != param2)
         {
            this._classTagName = param2;
            _loc6_ |= INVALID_CHANGE_VEHICLE_ANIMATION_TYPE;
         }
         if(this._guiLabel != param4)
         {
            this._guiLabel = param4;
            _loc6_ |= INVALID_VEHICLE_LABEL | INVALID_CHANGE_VEHICLE_ANIMATION_TYPE | INVALID_HP;
         }
         if(this._vehicleName != param3)
         {
            this._vehicleName = param3;
            _loc6_ |= INVALID_VEHICLE_LABEL;
         }
         if(param5 != Values.EMPTY_STR)
         {
            this._actionAnimationType = param5;
            _loc6_ |= INVALID_VEHICLE_ACTION_ANIMATION;
         }
         if(!this._isSetVehicleInfo)
         {
            App.colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
            this._isSetVehicleInfo = true;
         }
         MinimapEntryController.instance.registerVehicleLabelEntry(this);
         if(_loc6_ != 0)
         {
            invalidate(_loc6_);
         }
      }
      
      public function showVehicleHp(param1:Boolean) : void
      {
         this._showVehicleHp = param1;
         invalidate(INVALID_HP);
      }
      
      public function showVehicleName() : void
      {
         this._isVehicleLabelVisible = true;
         invalidate(INVALID_VEHICLE_LABEL);
      }
      
      public function unhighlight() : void
      {
         if(this._currVehicleAnimation.currentFrameLabel != VehicleMinimapEntryConst.UNHIGHLIGHTED_FRAME)
         {
            this._currVehicleAnimation.gotoAndPlay(VehicleMinimapEntryConst.UNHIGHLIGHT_ANIMATION_FRAME);
         }
      }
      
      private function updateBearer() : void
      {
         if(this._isFlagBearer)
         {
            this.mcBearerAnimation.visible = false;
         }
      }
      
      public function get vehicleID() : Number
      {
         return this._vehicleID;
      }
      
      private function onColorSchemasUpdatedHandler(param1:ColorSchemeEvent) : void
      {
         var _loc2_:Boolean = App.colorSchemeMgr.getScheme(AbsorptionFlagEntryConst.COLOR_SCHEME_NAME).aliasColor == AbsorptionFlagEntryConst.ENEMY_CAPTURE_BLIND;
         if(this._isColorBlind != _loc2_)
         {
            this._isColorBlind = _loc2_;
            if(this._isFlagBearer)
            {
               invalidate(INVALID_BEARER_STATE);
            }
         }
         invalidate(INVALID_VEHICLE_LABEL | INVALID_CHANGE_VEHICLE_ANIMATION_TYPE | INVALID_HP);
      }
   }
}
