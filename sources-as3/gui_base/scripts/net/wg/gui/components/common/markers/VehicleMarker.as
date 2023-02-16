package net.wg.gui.components.common.markers
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.constants.MarkerState;
   import net.wg.gui.components.common.markers.data.HPDisplayMode;
   import net.wg.gui.components.common.markers.data.VehicleMarkerFlags;
   import net.wg.gui.components.common.markers.data.VehicleMarkerSettings;
   import net.wg.gui.components.common.markers.data.VehicleMarkerVO;
   import net.wg.gui.components.controls.TextFieldContainer;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IColorScheme;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.gfx.TextFieldEx;
   
   public class VehicleMarker extends UIComponentEx
   {
      
      public static var s_showExInfo:Boolean = false;
      
      public static var s_markerSettings:Object = {
         "ally":new VehicleMarkerSettings(),
         "enemy":new VehicleMarkerSettings(),
         "dead":new VehicleMarkerSettings()
      };
      
      private static var ICON:String = "Icon";
      
      private static var LEVEL:String = "Level";
      
      private static var HEALTH_LBL:String = "Hp";
      
      private static var HEALTH_BAR:String = "HpIndicator";
      
      private static var P_NAME_LBL:String = "PlayerName";
      
      private static var V_NAME_LBL:String = "VehicleName";
      
      private static var DAMAGE_PANEL:String = "Damage";
      
      private static var VEHICLE_DIST:String = "VehicleDist";
      
      private static var ACTION_Y:int = -93;
      
      private static var V_DIST_Y:int = -102;
      
      private static var V_DIST_Y_SHIFT:int = 12;
      
      private static var ICON_Y:int = -86;
      
      private static var LEVEL_Y:int = -74;
      
      private static var V_NAME_LBL_Y:int = -62;
      
      private static var P_NAME_LBL_Y:int = -49;
      
      private static var HEALTH_BAR_Y:int = -29;
      
      private static var V_DIST_OFFSET:int = 0;
      
      private static var ICON_OFFSET:int = 10;
      
      private static var LEVEL_OFFSET:int = 3;
      
      private static var V_NAME_LBL_OFFSET:int = 13;
      
      private static var P_NAME_LBL_OFFSET:int = 13;
      
      private static var HEALTH_BAR_OFFSET:int = 13;
      
      private static var OFFSETS:Array = [V_DIST_OFFSET,ICON_OFFSET,LEVEL_OFFSET,V_NAME_LBL_OFFSET,P_NAME_LBL_OFFSET,HEALTH_BAR_OFFSET];
      
      private static const ICON_HORIZONTAL_OFFSET:int = 6;
      
      private static const HP_FIELD_VERTICAL_OFFSET:int = -2;
      
      private static const SHADOW_TYPE_HBAR_OFFSET:int = 2;
      
      private static const EXPLOSION_HORIZONTAL_OFFSET:int = 15;
      
      private static const VEHICLE_DESTROY_COLOR:uint = 6710886;
       
      
      public var levelIcon:MovieClip;
      
      public var iconLoader:UILoaderAlt;
      
      public var hpFieldContainer:MovieClip;
      
      public var actionMarker:VehicleActionMarker;
      
      public var vehicleTypeMarker:MovieClip;
      
      public var hitLabel:HealthBarAnimatedLabel;
      
      public var hitExplosion:AnimateExplosion;
      
      public var vehicleNameField:TextField;
      
      public var playerNameField:TextField;
      
      public var healthBar:HealthBar;
      
      public var backgroundShadow:MovieClip;
      
      public var vehicleDist:TextFieldContainer;
      
      protected var model:VehicleMarkerVO;
      
      protected var _entityName:String = "enemy";
      
      protected var _markerColor:String = "red";
      
      protected var _markerState:String;
      
      private var _isPopulated:Boolean = false;
      
      private var _exInfoOverride:Boolean = false;
      
      private var _markerSettingsOverride:Object;
      
      public function VehicleMarker()
      {
         super();
         TextFieldEx.setNoTranslate(this.vehicleNameField,true);
         TextFieldEx.setNoTranslate(this.playerNameField,true);
         TextFieldEx.setNoTranslate(this.hpFieldContainer.hpField,true);
      }
      
      override protected function onDispose() : void
      {
         this.iconLoader.removeEventListener(UILoaderEvent.COMPLETE,this.onIconLoaded);
         this.healthBar.removeEventListener(HealthBarAnimatedPart.HIDE,this.onSplashHidden);
         this.model = null;
         if(this._markerSettingsOverride)
         {
            this._markerSettingsOverride = null;
         }
         this.vehicleDist.dispose();
         this.vehicleDist = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.healthBar.addEventListener(HealthBarAnimatedPart.HIDE,this.onSplashHidden);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this.model && !this._isPopulated && isInvalid(InvalidationType.DATA))
         {
            this.initMarkerColor();
            this.setupHealthBar();
            this.setupIconLoader();
            this.setupTexts();
            this.levelIcon.gotoAndStop(this.model.vLevel);
            if(this.model.vClass)
            {
               this.setVehicleClass();
            }
            this.setMarkerState(this._markerState);
            this.updateMarkerSettings();
            this._isPopulated = true;
         }
      }
      
      public function init(param1:VehicleMarkerVO) : void
      {
         this.model = param1;
         if(this.model.entityName)
         {
            this._entityName = this.model.entityName;
         }
         invalidateData();
      }
      
      public function updateHealth(param1:Number, param2:int, param3:String) : void
      {
         var _loc5_:String = null;
         var _loc4_:String = VehicleMarkerFlags.DAMAGE_FROM[param2];
         param3 = param1 < 0 ? VehicleMarkerFlags.DAMAGE_EXPLOSION : param3;
         param1 = Math.max(param1,0);
         this.model.curHealth = param1;
         if(this._isPopulated)
         {
            _loc5_ = VehicleMarkerFlags.DAMAGE_COLOR[_loc4_][this._markerColor];
            if(this.getIsPartVisible(HEALTH_BAR))
            {
               this.healthBar.updateHealth(param1,_loc5_);
            }
            if(this.getIsPartVisible(DAMAGE_PANEL))
            {
               this.hitLabel.damage(this.model.curHealth - param1,_loc5_);
               if(VehicleMarkerFlags.checkAllowedDamages(param3))
               {
                  this.hitExplosion.setColorAndDamageType(_loc5_,param3);
                  this.hitExplosion.x = Math.round(this.hitLabel.x + this.hitLabel.damageLabel.textWidth + EXPLOSION_HORIZONTAL_OFFSET);
                  this.hitExplosion.playShowTween();
               }
               this.hitLabel.playShowTween();
            }
            if(this.getIsPartVisible(HEALTH_LBL))
            {
               if(this.vehicleDestroyed)
               {
                  this.setDestroyedColorForHP();
               }
               this.setHealthText();
            }
         }
      }
      
      public function getMarkerState() : String
      {
         return this._markerState;
      }
      
      public function setMarkerState(param1:String) : void
      {
         var _loc2_:Number = NaN;
         this._markerState = param1;
         if(initialized)
         {
            if(this.model.speaking)
            {
               this.setVehicleClass();
            }
            _loc2_ = this.colorScheme.rgb;
            if(!isNaN(_loc2_))
            {
               this.playerNameField.textColor = _loc2_;
               this.vehicleNameField.textColor = _loc2_;
            }
            if(this._markerState)
            {
               if(this.vehicleDestroyed)
               {
                  this.actionMarker.stopAction();
                  this.updateIconColor();
                  this.setDestroyedColorForHP();
                  if(this._markerState == MarkerState.STATE_IMMEDIATE_DEAD)
                  {
                     this.hitLabel.transform.colorTransform = this.colorsManager.getTransform(this.colorSchemeName);
                  }
               }
               this.updateMarkerSettings();
               this.vehicleTypeMarker.gotoAndPlay(this._markerState);
            }
         }
      }
      
      public function updateState(param1:String, param2:Boolean) : void
      {
         if(this.vehicleDestroyed)
         {
            return;
         }
         if(param2 && param1 == MarkerState.STATE_DEAD)
         {
            param1 = MarkerState.STATE_IMMEDIATE_DEAD;
         }
         this.setMarkerState(param1);
      }
      
      public function isSpeaking() : Boolean
      {
         return this.model.speaking;
      }
      
      public function setSpeaking(param1:Boolean) : void
      {
         if(this.model.speaking == param1)
         {
            return;
         }
         this.model.speaking = param1;
         if(initialized)
         {
            this.setVehicleClass();
         }
      }
      
      public function showActionMarker(param1:String) : void
      {
         this.actionMarker.showAction(param1);
      }
      
      public function settingsUpdate(param1:Number) : void
      {
         this.setupIconLoader();
         this.update();
         var _loc2_:String = VehicleMarkerFlags.DAMAGE_FROM[param1];
         this.hitLabel.fakeDamage = this.model.maxHealth - this.model.curHealth;
         this.hitLabel.imitationFlag = VehicleMarkerFlags.DAMAGE_COLOR[_loc2_][this._markerColor];
         this.hitLabel.imitation = this.getIsPartVisible(DAMAGE_PANEL);
      }
      
      public function update() : void
      {
         this.updateMarkerColor();
         this.updateMarkerSettings();
      }
      
      public function updateMarkerSettings() : void
      {
         var _loc7_:Boolean = false;
         var _loc1_:Boolean = this.getIsPartVisible(ICON);
         var _loc2_:Boolean = this.getIsPartVisible(LEVEL);
         var _loc3_:Boolean = this.getIsPartVisible(P_NAME_LBL);
         var _loc4_:Boolean = this.getIsPartVisible(V_NAME_LBL);
         var _loc5_:Boolean = this.getIsPartVisible(HEALTH_BAR);
         var _loc6_:Boolean = this.getIsPartVisible(HEALTH_LBL);
         _loc7_ = this.getIsPartVisible(DAMAGE_PANEL);
         var _loc8_:Boolean = !this.vehicleDestroyed && this.getIsPartVisible(VEHICLE_DIST);
         this.vehicleDist.visible = _loc8_;
         this.playerNameField.visible = _loc3_;
         this.vehicleNameField.visible = _loc4_;
         if(_loc5_)
         {
            this.healthBar.curHealth = this.model.curHealth;
         }
         this.healthBar.visible = _loc5_;
         this.hpFieldContainer.visible = _loc6_;
         if(this.vehicleDestroyed)
         {
            this.setDestroyedColorForHP();
         }
         this.setHealthText();
         this.hitLabel.visible = _loc7_;
         this.hitExplosion.visible = _loc7_;
         this.levelIcon.visible = _loc2_;
         this.iconLoader.visible = _loc1_;
         var _loc9_:int = (!!_loc3_ ? 1 : 0) + (!!_loc4_ ? 1 : 0);
         if(!_loc5_)
         {
            _loc9_ += !!_loc6_ ? 1 : 0;
            if(_loc9_ > 0)
            {
               _loc9_ += SHADOW_TYPE_HBAR_OFFSET;
            }
         }
         if(_loc9_ > 0)
         {
            this.backgroundShadow.visible = true;
            this.backgroundShadow.gotoAndStop("shadow_" + _loc9_);
         }
         else
         {
            this.backgroundShadow.visible = false;
         }
         this.layoutParts([_loc8_,_loc1_,_loc2_,_loc4_,_loc3_,_loc5_ || _loc6_]);
      }
      
      public function setEntityName(param1:String) : void
      {
         if(param1 == this._entityName)
         {
            return;
         }
         this._entityName = param1;
         this.update();
      }
      
      public function showExInfo(param1:Boolean) : void
      {
         this.updateMarkerSettings();
      }
      
      public function get exInfo() : Boolean
      {
         return this._exInfoOverride || s_showExInfo;
      }
      
      public function set exInfo(param1:Boolean) : void
      {
         this._exInfoOverride = param1;
      }
      
      public function get markerSettings() : Object
      {
         var _loc1_:Object = null;
         if(this._markerSettingsOverride)
         {
            _loc1_ = this._markerSettingsOverride;
         }
         else if(this.vehicleDestroyed)
         {
            _loc1_ = s_markerSettings["dead"];
         }
         else
         {
            _loc1_ = s_markerSettings[this.model.entityType];
         }
         return _loc1_;
      }
      
      public function set markerSettings(param1:Object) : void
      {
         this._markerSettingsOverride = param1;
      }
      
      public function get isEnabledExInfo() : Boolean
      {
         var _loc1_:String = "marker" + (!!this.exInfo ? "Alt" : "Base") + "Dead";
         return this.markerSettings[_loc1_];
      }
      
      public function get colorsManager() : IColorSchemeManager
      {
         return App.colorSchemeMgr;
      }
      
      public function get colorSchemeName() : String
      {
         return (!!this.vehicleDestroyed ? "vm_dead_" : "vm_") + this._entityName;
      }
      
      public function get colorScheme() : IColorScheme
      {
         return this.colorsManager.getScheme(this.colorSchemeName);
      }
      
      public function get vehicleDestroyed() : Boolean
      {
         return this._markerState == MarkerState.STATE_DEAD || this._markerState == MarkerState.STATE_IMMEDIATE_DEAD;
      }
      
      private function initMarkerColor() : void
      {
         this._markerColor = this.colorsManager.getAliasColor(this.colorSchemeName);
         this.applyColor();
      }
      
      private function updateMarkerColor() : void
      {
         var _loc1_:String = this.colorsManager.getAliasColor(this.colorSchemeName);
         if(this._markerColor == _loc1_)
         {
            return;
         }
         this._markerColor = _loc1_;
         this.applyColor();
         if(this.model.vClass)
         {
            this.setVehicleClass();
         }
         this.setMarkerState(this._markerState);
         this.updateIconColor();
      }
      
      private function applyColor() : void
      {
         gotoAndStop(this._markerColor);
         this.healthBar.color = this._markerColor;
      }
      
      private function setupHealthBar() : void
      {
         if(this.getHealthPercents() >= 0)
         {
            this.healthBar.maxHealth = this.model.maxHealth;
            this.healthBar.curHealth = this.model.curHealth;
         }
      }
      
      private function setDestroyedColorForHP() : void
      {
         this.hpFieldContainer.hpField.textColor = VEHICLE_DESTROY_COLOR;
      }
      
      private function setHealthText() : void
      {
         var _loc1_:String = null;
         var _loc2_:Number = this.markerSettings["marker" + (!!this.exInfo ? "Alt" : "Base") + "Hp"];
         switch(_loc2_)
         {
            case HPDisplayMode.PERCENTS:
               _loc1_ = this.getHealthPercents() + "%";
               break;
            case HPDisplayMode.CURRENT_AND_MAXIMUM:
               _loc1_ = this.model.curHealth + " / " + this.model.maxHealth;
               break;
            case HPDisplayMode.CURRENT:
               _loc1_ = this.model.curHealth.toString();
               break;
            default:
               _loc1_ = "";
         }
         this.hpFieldContainer.hpField.text = _loc1_;
      }
      
      private function getHealthPercents() : Number
      {
         return Math.ceil(this.model.curHealth / this.model.maxHealth * 100);
      }
      
      private function setupIconLoader() : void
      {
         this.iconLoader.addEventListener(UILoaderEvent.COMPLETE,this.onIconLoaded);
         this.iconLoader.source = this.model.vIconSource;
         this.updateIconColor();
      }
      
      private function setupTexts() : void
      {
         this.vehicleDist.label = this.model.vDist;
         this.playerNameField.text = this.model.pFullName;
         this.vehicleNameField.text = this.model.vType;
      }
      
      private function updateIconColor() : void
      {
         this.iconLoader.transform.colorTransform = this.colorsManager.getTransform(this.colorSchemeName);
      }
      
      private function layoutParts(param1:Array) : void
      {
         var _loc5_:int = 0;
         var _loc6_:DisplayObject = null;
         var _loc7_:int = 0;
         this.actionMarker.y = ACTION_Y;
         this.iconLoader.y = ICON_Y;
         this.levelIcon.y = LEVEL_Y;
         this.vehicleNameField.y = V_NAME_LBL_Y;
         this.playerNameField.y = P_NAME_LBL_Y;
         this.healthBar.y = HEALTH_BAR_Y;
         this.hpFieldContainer.y = HEALTH_BAR_Y + HP_FIELD_VERTICAL_OFFSET;
         var _loc2_:Boolean = !(this.iconLoader.visible || this.levelIcon.visible);
         this.vehicleDist.y = !!_loc2_ ? Number(V_DIST_Y + V_DIST_Y_SHIFT) : Number(V_DIST_Y);
         var _loc3_:Array = [];
         var _loc4_:Array = [this.vehicleDist,this.iconLoader,this.levelIcon,this.vehicleNameField,this.playerNameField,this.healthBar];
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc3_.push(Boolean(param1[_loc5_]) ? 0 : OFFSETS[_loc5_]);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc6_ = _loc4_[_loc5_];
            _loc7_ = _loc5_ + 1;
            while(_loc7_ < _loc3_.length)
            {
               _loc6_.y += _loc3_[_loc7_];
               _loc7_++;
            }
            _loc5_++;
         }
      }
      
      private function getIsPartVisible(param1:String) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:String = "marker" + (!!this.exInfo ? "Alt" : "Base") + param1;
         if(param1 == HEALTH_LBL)
         {
            _loc2_ = this.markerSettings[_loc3_] != HPDisplayMode.HIDDEN;
         }
         else
         {
            _loc2_ = this.markerSettings[_loc3_];
         }
         return _loc2_;
      }
      
      private function setVehicleClass() : void
      {
         var _loc1_:String = this.model.speaking && !this.vehicleDestroyed ? "dynamic" : this.model.vClass;
         if(this.vehicleTypeMarker.marker.iconHunt != null)
         {
            this.vehicleTypeMarker.marker.icon.visible = !this.model.hunt;
            this.vehicleTypeMarker.marker.iconHunt.visible = this.model.hunt;
            if(this.model.hunt)
            {
               this.vehicleTypeMarker.marker.iconHunt.gotoAndStop(_loc1_);
            }
            else
            {
               this.vehicleTypeMarker.marker.icon.gotoAndStop(_loc1_);
            }
         }
         else
         {
            this.vehicleTypeMarker.marker.icon.gotoAndStop(_loc1_);
         }
      }
      
      private function onIconLoaded(param1:UILoaderEvent) : void
      {
         this.iconLoader.removeEventListener(UILoaderEvent.COMPLETE,this.onIconLoaded);
         this.iconLoader.x = -(this.iconLoader.width >> 1) + ICON_HORIZONTAL_OFFSET;
      }
      
      private function onSplashHidden(param1:Event) : void
      {
         if(this.vehicleDestroyed || this.model.curHealth <= 0)
         {
            this.updateMarkerSettings();
         }
      }
   }
}
