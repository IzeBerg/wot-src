package net.wg.gui.battle.views.vehicleMarkers
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.views.actionMarkers.BaseActionMarker;
   import net.wg.gui.battle.views.vehicleMarkers.VO.CrossOffset;
   import net.wg.gui.battle.views.vehicleMarkers.VO.HPDisplayMode;
   import net.wg.gui.battle.views.vehicleMarkers.VO.VehicleMarkerFlags;
   import net.wg.gui.battle.views.vehicleMarkers.VO.VehicleMarkerPart;
   import net.wg.gui.battle.views.vehicleMarkers.VO.VehicleMarkerVO;
   import net.wg.gui.battle.views.vehicleMarkers.events.VehicleMarkersManagerEvent;
   import scaleform.gfx.TextFieldEx;
   
   public class BranderVehicle2dMarker extends BaseActionMarker implements IMarkerManagerHandler, IVehicleMarkerInvokable
   {
      
      private static const SHADOW_POSITION:Point = new Point(-94,-22);
      
      private static const SHADOW_TYPE:int = 1;
      
      private static const HEALTH_LBL:String = "Hp";
      
      private static const HEALTH_BAR:String = "HpIndicator";
      
      private static const DAMAGE_PANEL:String = "Damage";
      
      private static const VEHICLE_DIST:String = "VehicleDist";
      
      private static const MARKER:String = "marker";
      
      private static const ALT:String = "Alt";
      
      private static const BASE:String = "Base";
      
      private static const DEAD:String = "Dead";
      
      private static const START_HORIZONTAL_OFFSET:int = 15;
      
      private static const EXPLOSION_HORIZONTAL_OFFSET:int = 15;
      
      private static const BLOCK_HORIZONTAL_OFFSET:int = 25;
      
      private static const EXPLOSION_SIZE:int = 18;
      
      private static const STATE_DEAD:String = "dead";
      
      private static const STATE_IMMEDIATE_DEAD:String = "immediate_dead";
      
      private static const PERCENT_STRING:String = "%";
      
      private static const SLASH_STRING:String = " / ";
      
      private static const VM_PREFIX:String = "vm_";
      
      private static const VM_DEAD_PREFIX:String = "vm_dead_";
      
      private static const VM_STUN_PREFIX:String = "vm_stun_";
      
      private static const VM_STUN_POSTFIX:String = "_schema";
      
      private static const MAX_HEALTH_PERCENT:int = 100;
      
      private static const VEHICLE_DESTROY_COLOR:Number = 6710886;
      
      private static const INVALIDATE_MANAGER_READY:uint = 1 << 17;
      
      private static const WHITE_COLOR:String = "white";
      
      private static const OBSERVER_SCHEME_NAME:String = "team";
      
      private static const DEFAULT_DAMAGE_COLOR:String = "red";
       
      
      public var marker:MovieClip = null;
      
      public var actionMarker:VehicleActionMarker = null;
      
      public var statusContainer:VehicleStatusContainerMarker = null;
      
      public var hitLabel:HealthBarAnimatedLabel = null;
      
      public var criticalHitLabel:HealthBarAnimatedLabel = null;
      
      public var hitExplosion:AnimateExplosion = null;
      
      public var hpField:TextField = null;
      
      public var healthBar:HealthBar = null;
      
      public var bgShadow:MovieClip = null;
      
      public var squadIcon:MovieClip = null;
      
      public var vehicleDist:VehicleDistance = null;
      
      private var _model:VehicleMarkerVO = null;
      
      private var _entityType:String = "enemy";
      
      private var _entityName:String = "enemy";
      
      private var _markerColor:String = "red";
      
      private var _markerState:String = "";
      
      private var _vehicleDestroyed:Boolean = false;
      
      private var _vehicleDestroyedAlready:Boolean = false;
      
      private var _isPopulated:Boolean = false;
      
      private var _exInfoOverride:Boolean = false;
      
      private var _vmManager:VehicleMarkersManager = null;
      
      private var _maxHealthMult:Number = NaN;
      
      private var _markerSchemeName:String = "";
      
      private var _stunSchemeName:String = "";
      
      private var _isManagerReady:Boolean = false;
      
      private var _canUseCachedVisibility:Boolean = false;
      
      private var _hitIconOffset:int = -1;
      
      private var _markerParts:Vector.<VehicleMarkerPart> = null;
      
      private var _isVehicleDistVisible:Boolean = true;
      
      public function BranderVehicle2dMarker()
      {
         super();
         this.marker.visible = false;
         this._vmManager = VehicleMarkersManager.getInstance();
         this._isManagerReady = this._vmManager.isAtlasInited;
         if(!this._isManagerReady)
         {
            this._vmManager.addReadyHandler(this);
         }
         TextFieldEx.setNoTranslate(this.hpField,true);
         this.prepareLayout();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.statusContainer.addEventListener(Event.COMPLETE,this.onStatusAnimationHiddenCompleteHandler);
         this.healthBar.hitSplash.addEventListener(HealthBarAnimatedPart.HIDE,this.onSplashHideHandler);
         this._vmManager.addEventListener(VehicleMarkersManagerEvent.SHOW_EX_INFO,this.onShowExInfoHandler);
         this._vmManager.addEventListener(VehicleMarkersManagerEvent.UPDATE_SETTINGS,this.onUpdateSettingsHandler);
         this._vmManager.addEventListener(VehicleMarkersManagerEvent.UPDATE_COLORS,this.onUpdateColorsHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._isManagerReady && this._model != null && !this._isPopulated && isInvalid(InvalidationType.DATA))
         {
            this._markerColor = this._vmManager.getAliasColor(this._markerSchemeName);
            this.applyColor();
            if(this.getHealthPercents() >= 0)
            {
               this.healthBar.maxHealth = this._model.maxHealth;
               this.healthBar.currHealth = this._model.currHealth;
            }
            this.setupSquadIcon();
            this.setMarkerState(this._markerState);
            this._canUseCachedVisibility = false;
            this.updateMarkerSettings();
            this._isPopulated = true;
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:VehicleMarkerPart = null;
         this.statusContainer.removeEventListener(Event.COMPLETE,this.onStatusAnimationHiddenCompleteHandler);
         this.healthBar.hitSplash.removeEventListener(HealthBarAnimatedPart.HIDE,this.onSplashHideHandler);
         this._vmManager.removeEventListener(VehicleMarkersManagerEvent.SHOW_EX_INFO,this.onShowExInfoHandler);
         this._vmManager.removeEventListener(VehicleMarkersManagerEvent.UPDATE_SETTINGS,this.onUpdateSettingsHandler);
         this._vmManager.removeEventListener(VehicleMarkersManagerEvent.UPDATE_COLORS,this.onUpdateColorsHandler);
         this.hpField = null;
         if(this.actionMarker != null)
         {
            this.actionMarker.dispose();
         }
         this.actionMarker = null;
         if(this.hitLabel != null)
         {
            this.hitLabel.dispose();
         }
         this.hitLabel = null;
         if(this.hitExplosion != null)
         {
            this.hitExplosion.dispose();
         }
         this.hitExplosion = null;
         if(this.healthBar != null)
         {
            this.healthBar.dispose();
         }
         this.healthBar = null;
         if(this.vehicleDist != null)
         {
            this.vehicleDist.dispose();
         }
         this.vehicleDist = null;
         this.bgShadow = null;
         this.squadIcon = null;
         if(this.criticalHitLabel != null)
         {
            this.criticalHitLabel.dispose();
         }
         this.criticalHitLabel = null;
         if(this.statusContainer != null)
         {
            this.statusContainer.dispose();
         }
         this.statusContainer = null;
         this.marker = null;
         this._model = null;
         this._vmManager = null;
         if(this._markerParts)
         {
            for each(_loc1_ in this._markerParts)
            {
               _loc1_.dispose();
            }
            this._markerParts.splice(0,this._markerParts.length);
            this._markerParts = null;
         }
         super.onDispose();
      }
      
      public function hideArtyMarker() : void
      {
      }
      
      public function hideStatusMarker(param1:int, param2:int, param3:Boolean = false, param4:Boolean = false) : void
      {
         this.statusContainer.hideMarker(param1,param2,param3,param4);
         this.updateMarkerSettings();
      }
      
      public function hideSeparateMarker(param1:int, param2:Boolean = false) : void
      {
         this.statusContainer.hideAbilityMarker(param1,param2);
         this.updateMarkerSettings();
      }
      
      public function isSpeaking() : Boolean
      {
         return this._model.speaking;
      }
      
      public function managerReadyHandler() : void
      {
         this._isManagerReady = true;
         if(!this._isPopulated)
         {
            invalidate(INVALIDATE_MANAGER_READY);
         }
      }
      
      public function setDistance(param1:String) : void
      {
         this.vehicleDist.label = param1;
      }
      
      public function setDistanceVisibility(param1:Boolean) : void
      {
         if(this._isVehicleDistVisible == param1)
         {
            return;
         }
         this._isVehicleDistVisible = param1;
         this.updateMarkerSettings();
      }
      
      public function setEntityName(param1:String) : void
      {
         if(param1 == this._entityName)
         {
            return;
         }
         this.entityName = param1;
         this.update();
      }
      
      public function setHealth(param1:int) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         this._model.currHealth = param1;
         if(this._isPopulated)
         {
            if(this.getIsPartVisible(HEALTH_BAR))
            {
               this.healthBar.currHealth = param1;
            }
            if(this.getIsPartVisible(HEALTH_LBL))
            {
               if(this._vehicleDestroyed)
               {
                  this.setDestroyedColorForHP();
               }
               this.setHealthText();
            }
         }
      }
      
      public function setSpeaking(param1:Boolean) : void
      {
         if(this._model.speaking == param1)
         {
            return;
         }
         this._model.speaking = param1;
      }
      
      public function setStatusTimerSnapshot(param1:int) : void
      {
         this.statusContainer.updateEffectTimer(0,param1);
         this.updateMarkerSettings();
      }
      
      public function setVehicleInfo(param1:String, param2:String, param3:String, param4:int, param5:String, param6:String, param7:String, param8:String, param9:int, param10:String, param11:Boolean, param12:int, param13:String, param14:String = "", param15:int = 0) : void
      {
         var _loc16_:int = 0;
         if(this._model)
         {
            _loc16_ = this._model.currHealth;
         }
         this._model = new VehicleMarkerVO();
         this._model.vClass = param1;
         this._model.vIconSource = param2;
         this._model.vType = param3;
         this._model.vLevel = param4;
         this._model.pFullName = param5;
         this._model.pName = param6;
         this._model.pClan = param7;
         this._model.pRegion = param8;
         this._model.maxHealth = param9;
         this._model.entityName = param10;
         this._model.hunt = param11;
         this._model.squadIndex = param12;
         this._model.currHealth = _loc16_;
         this._model.locSecString = param13;
         this._maxHealthMult = MAX_HEALTH_PERCENT / this._model.maxHealth;
         this.statusContainer.setSecondString(this._model.locSecString);
         if(this._model.entityName != Values.EMPTY_STR)
         {
            this._entityName = this._model.entityName;
            this.actionMarker.entityName = this._entityName;
            this.makeColorSchemeName();
            this.statusContainer.setEffectColor(this._vmManager.getAliasColor(this._stunSchemeName),this._vmManager.getRGB(this._stunSchemeName));
            if(this._entityName == VehicleMarkersConstants.ENTITY_NAME_ENEMY)
            {
               this._entityType = VehicleMarkersConstants.ENTITY_TYPE_ENEMY;
            }
            else
            {
               this._entityType = VehicleMarkersConstants.ENTITY_TYPE_ALLY;
            }
         }
         this._isPopulated = false;
         invalidateData();
      }
      
      public function showActionMarker(param1:String) : void
      {
         this.actionMarker.showAction(param1);
         if(param1 != Values.EMPTY_STR)
         {
            this.updateMarkerSettings();
         }
      }
      
      public function showExInfo() : void
      {
         this.updateMarkerSettings();
      }
      
      public function showStatusMarker(param1:int, param2:int, param3:Boolean, param4:Number, param5:int, param6:int, param7:Boolean = true, param8:Boolean = true) : void
      {
         this.statusContainer.showMarker(param1,param2,param3,param4,param5,param6,param7,param8);
         this.updateMarkerSettings();
      }
      
      public function showSeparateMarker(param1:int, param2:Boolean, param3:Number, param4:Boolean = true, param5:Boolean = true) : void
      {
         this.statusContainer.showAbilityMarker(param1,param2,param3,param4,param5);
         this.updateMarkerSettings();
      }
      
      public function stopActionMarker() : void
      {
         this.actionMarker.stopAction();
      }
      
      public function update() : void
      {
         this.updateMarkerColor();
         this.updateMarkerSettings();
      }
      
      public function updateHealth(param1:int, param2:int, param3:String) : void
      {
         if(param1 < 0)
         {
            param3 = VehicleMarkerFlags.DAMAGE_EXPLOSION;
            param1 = 0;
         }
         var _loc4_:int = this._model.currHealth - param1;
         this._model.currHealth = param1;
         if(this._isPopulated)
         {
            if(this.getIsPartVisible(HEALTH_BAR))
            {
               this.healthBar.updateHealth(param1,this.getDamageColor(param2));
            }
            if(this.getIsPartVisible(DAMAGE_PANEL))
            {
               if(_loc4_ > 0)
               {
                  this.hitLabel.damage(_loc4_,this.getDamageColor(param2));
                  this.hitLabel.playShowTween();
               }
               if(VehicleMarkerFlags.checkAllowedDamages(param3))
               {
                  this.hitExplosion.setColorAndDamageType(this.getDamageColor(param2),param3);
                  this.hitExplosion.playShowTween();
                  this._hitIconOffset = EXPLOSION_HORIZONTAL_OFFSET;
               }
               this.updateHitLayout();
            }
            if(this.getIsPartVisible(HEALTH_LBL))
            {
               if(this._vehicleDestroyed)
               {
                  this.setDestroyedColorForHP();
               }
               this.setHealthText();
            }
         }
      }
      
      public function updateState(param1:String, param2:Boolean, param3:String = "", param4:String = "") : void
      {
         if(this._vehicleDestroyed)
         {
            return;
         }
         if(param2 && param1 == STATE_DEAD)
         {
            param1 = STATE_IMMEDIATE_DEAD;
         }
         if((param4 != Values.EMPTY_STR || param3 != Values.EMPTY_STR) && this.getIsPartVisible(DAMAGE_PANEL))
         {
            this.hitExplosion.playShowTween();
            this.criticalHitLabel.setLabel(param3,WHITE_COLOR);
            this.hitExplosion.setAnimationType(param4);
            this._hitIconOffset = BLOCK_HORIZONTAL_OFFSET;
            this.updateHitLayout();
            this.criticalHitLabel.playShowTween();
         }
         this.setMarkerState(param1);
      }
      
      public function updateStatusEffectTimer(param1:int, param2:Number, param3:Boolean = false) : void
      {
         this.statusContainer.updateEffectTimer(param1,param2,param3);
         this.updateMarkerSettings();
      }
      
      public function updateTimer(param1:String) : void
      {
      }
      
      private function updateHitLayout() : void
      {
         var _loc1_:Boolean = this.hitLabel.visible && this.hitLabel.isActive();
         var _loc2_:int = !!_loc1_ ? int(this.hitLabel.damageLabel.textWidth) : int(0);
         var _loc3_:int = !!_loc1_ ? int(this._hitIconOffset) : int(START_HORIZONTAL_OFFSET);
         this.hitExplosion.x = this.hitLabel.x + _loc2_ + _loc3_ | 0;
         this.criticalHitLabel.x = this.hitExplosion.x + EXPLOSION_SIZE | 0;
      }
      
      private function makeColorSchemeName() : void
      {
         this._markerSchemeName = (!!this._vehicleDestroyed ? VM_DEAD_PREFIX : VM_PREFIX) + this._entityName;
         this._stunSchemeName = VM_STUN_PREFIX + this._entityName + VM_STUN_POSTFIX;
      }
      
      private function updateMarkerSettings() : void
      {
         var _loc1_:Boolean = this.getIsPartVisible(HEALTH_BAR);
         var _loc2_:Boolean = this.getIsPartVisible(HEALTH_LBL);
         var _loc3_:Boolean = this.getIsPartVisible(DAMAGE_PANEL);
         var _loc4_:Boolean = this._isVehicleDistVisible && this.getIsPartVisible(VEHICLE_DIST);
         this.vehicleDist.visible = _loc4_;
         if(_loc1_)
         {
            this.healthBar.currHealth = this._model.currHealth;
         }
         this.healthBar.visible = _loc1_;
         this.hpField.visible = _loc2_;
         if(this._vehicleDestroyed)
         {
            this.setDestroyedColorForHP();
         }
         this.setHealthText();
         this.hitLabel.visible = _loc3_;
         this.hitExplosion.visible = _loc3_;
         if(_loc2_ && !_loc1_)
         {
            this._vmManager.drawGraphics(VMAtlasItemName.getShadowName(SHADOW_TYPE),this.bgShadow.graphics,SHADOW_POSITION);
            this.bgShadow.visible = true;
         }
         else
         {
            this.bgShadow.visible = false;
         }
         this.layoutParts(new <Boolean>[_loc1_ || _loc2_,_loc4_,this._model.squadIndex != 0,this.statusContainer.isVisible(),this.actionMarker.isVisible()]);
      }
      
      private function updateMarkerColor() : void
      {
         var _loc1_:String = this._vmManager.getAliasColor(this._markerSchemeName);
         if(this._markerColor == _loc1_)
         {
            return;
         }
         this._markerColor = _loc1_;
         this.applyColor();
         this.setMarkerState(this._markerState);
      }
      
      private function applyColor() : void
      {
         this.healthBar.color = this._markerColor;
         this.healthBar.transform.colorTransform = this._vmManager.getTransform(this._markerSchemeName);
      }
      
      private function layoutParts(param1:Vector.<Boolean>) : void
      {
         var _loc4_:VehicleMarkerPart = null;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = this._markerParts.length;
         var _loc5_:VehicleMarkerPart = null;
         var _loc7_:Boolean = this._canUseCachedVisibility;
         var _loc8_:Boolean = false;
         var _loc9_:int = 0;
         while(_loc9_ < _loc3_)
         {
            _loc4_ = this._markerParts[_loc9_];
            _loc8_ = param1[_loc9_];
            if(_loc7_ && _loc8_ && _loc4_.cachedVisibility == _loc8_)
            {
               _loc2_ = _loc4_.y;
               _loc5_ = _loc4_;
            }
            else
            {
               _loc7_ = false;
               if(_loc8_)
               {
                  _loc6_ = _loc4_.offsetFromPart(_loc5_);
                  _loc4_.y = _loc2_ - _loc6_ - _loc4_.height | 0;
                  _loc5_ = _loc4_;
                  _loc2_ = _loc4_.y;
               }
            }
            _loc4_.cachedVisibility = _loc8_;
            _loc9_++;
         }
         this._canUseCachedVisibility = true;
      }
      
      private function prepareLayout() : void
      {
         var _loc1_:Array = null;
         var _loc4_:VehicleMarkerPart = null;
         this._markerParts = new Vector.<VehicleMarkerPart>();
         _loc1_ = [this.hpField,this.vehicleDist,this.squadIcon,this.statusContainer,this.actionMarker];
         var _loc2_:Array = [-5,0,1,0,0];
         var _loc3_:Array = [null,new CrossOffset(this.hpField,-20),null,null,new CrossOffset(this.statusContainer,-25)];
         var _loc5_:int = _loc1_.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = new VehicleMarkerPart(_loc1_[_loc6_],_loc2_[_loc6_],_loc3_[_loc6_]);
            this._markerParts.push(_loc4_);
            _loc6_++;
         }
      }
      
      private function setMarkerState(param1:String) : void
      {
         this._markerState = param1;
         this._vehicleDestroyed = this._markerState == STATE_DEAD || this._markerState == STATE_IMMEDIATE_DEAD;
         this.makeColorSchemeName();
         if(initialized)
         {
            if(this._markerState != Values.EMPTY_STR)
            {
               this._canUseCachedVisibility = false;
               if(this._vehicleDestroyed)
               {
                  this.actionMarker.stopAction();
                  this.setDestroyedColorForHP();
                  if(this._markerState == STATE_IMMEDIATE_DEAD)
                  {
                     this.hitLabel.transform.colorTransform = this._vmManager.getTransform(this._markerSchemeName);
                  }
               }
               this.updateMarkerSettings();
            }
            if(!this._vehicleDestroyed)
            {
               this.statusContainer.setEffectColor(this._vmManager.getAliasColor(this._stunSchemeName),this._vmManager.getRGB(this._stunSchemeName));
            }
            this._vehicleDestroyedAlready = this._vehicleDestroyedAlready || this._vehicleDestroyed;
         }
      }
      
      private function getIsPartVisible(param1:String) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:String = MARKER + (!!this.exInfo ? ALT : BASE) + param1;
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
      
      private function getDamageColor(param1:int) : String
      {
         var _loc2_:String = VehicleMarkerFlags.DAMAGE_FROM[param1];
         if(this.isObserver)
         {
            return VehicleMarkerFlags.DAMAGE_COLOR[_loc2_][DEFAULT_DAMAGE_COLOR];
         }
         return VehicleMarkerFlags.DAMAGE_COLOR[_loc2_][this._markerColor];
      }
      
      private function setDestroyedColorForHP() : void
      {
         this.hpField.textColor = VEHICLE_DESTROY_COLOR;
      }
      
      private function setHealthText() : void
      {
         var _loc1_:String = null;
         var _loc2_:int = this.markerSettings[MARKER + (!!this.exInfo ? ALT : BASE) + HEALTH_LBL];
         switch(_loc2_)
         {
            case HPDisplayMode.PERCENTS:
               _loc1_ = this.getHealthPercents() + PERCENT_STRING;
               break;
            case HPDisplayMode.CURRENT_AND_MAXIMUM:
               _loc1_ = this._model.currHealth + SLASH_STRING + this._model.maxHealth;
               break;
            case HPDisplayMode.CURRENT:
               _loc1_ = this._model.currHealth.toString();
               break;
            default:
               _loc1_ = Values.EMPTY_STR;
         }
         this.hpField.text = _loc1_;
         var _loc3_:Boolean = this.getIsPartVisible(HEALTH_BAR);
         var _loc4_:Boolean = this.getIsPartVisible(HEALTH_LBL);
         if(_loc4_ && !_loc3_)
         {
            this.hpField.x = -(this.hpField.width >> 1);
         }
      }
      
      private function setupSquadIcon() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         if(this._model.squadIndex)
         {
            _loc1_ = this._vmManager.getAliasColor(this._markerSchemeName);
            _loc2_ = VMAtlasItemName.getSquadIconName(_loc1_,this._model.squadIndex);
            this._vmManager.drawWithCenterAlign(_loc2_,this.squadIcon.graphics,true,false);
         }
      }
      
      private function getHealthPercents() : int
      {
         var _loc1_:int = Math.ceil(this._model.currHealth * this._maxHealthMult);
         return _loc1_ <= MAX_HEALTH_PERCENT ? int(_loc1_) : int(MAX_HEALTH_PERCENT);
      }
      
      public function get markerSettings() : Object
      {
         var _loc1_:String = !!this._vehicleDestroyed ? STATE_DEAD : this.entityType;
         return this._vmManager.markerSettings[_loc1_];
      }
      
      public function get exInfo() : Boolean
      {
         return this._exInfoOverride || this._vmManager.showExInfo;
      }
      
      public function set exInfo(param1:Boolean) : void
      {
         this._exInfoOverride = param1;
      }
      
      public function get entityName() : String
      {
         return this._entityName;
      }
      
      public function set entityName(param1:String) : void
      {
         this._entityName = param1;
         this._model.entityName = this._entityName;
         this.actionMarker.entityName = this._entityName;
         this.makeColorSchemeName();
      }
      
      public function get entityType() : String
      {
         return this._entityType;
      }
      
      public function set entityType(param1:String) : void
      {
         this._entityType = param1;
      }
      
      private function get isObserver() : Boolean
      {
         return this._markerSchemeName.indexOf(OBSERVER_SCHEME_NAME) != -1;
      }
      
      private function onShowExInfoHandler(param1:VehicleMarkersManagerEvent) : void
      {
         this.updateMarkerSettings();
      }
      
      private function onUpdateSettingsHandler(param1:VehicleMarkersManagerEvent) : void
      {
         this.updateMarkerSettings();
      }
      
      private function onUpdateColorsHandler(param1:VehicleMarkersManagerEvent) : void
      {
         this.updateMarkerColor();
         this.setupSquadIcon();
         this.updateMarkerSettings();
      }
      
      private function onSplashHideHandler(param1:Event) : void
      {
         if(this._vehicleDestroyed || this._model.currHealth <= 0)
         {
            this.updateMarkerSettings();
         }
      }
      
      private function onStatusAnimationHiddenCompleteHandler(param1:Event) : void
      {
         if(this.actionMarker.isVisible() || this.statusContainer.isVisible())
         {
            this.updateMarkerSettings();
         }
      }
   }
}
