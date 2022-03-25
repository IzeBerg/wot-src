package net.wg.gui.battle.views.vehicleMarkers
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.commander.views.common.Reloading;
   import net.wg.gui.battle.commander.views.common.ReloadingData;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.vehicleMarkers.VO.SupplyMarkerVO;
   import net.wg.gui.battle.views.vehicleMarkers.VO.VehicleMarkerFlags;
   import net.wg.gui.battle.views.vehicleMarkers.events.RTSMarkerEvent;
   import net.wg.gui.battle.views.vehicleMarkers.events.VehicleMarkersManagerEvent;
   import net.wg.gui.battle.views.vehicleMarkers.rtsMarkers.IRTSSelectableMarker;
   import net.wg.gui.components.common.markers.data.HPDisplayMode;
   
   public class CommanderSupplyMarker extends BattleUIComponent implements IMarkerManagerHandler, IRTSSelectableMarker
   {
      
      private static const VM_PREFIX:String = "vm_";
      
      private static const VM_DEAD_PREFIX:String = "vm_dead_";
      
      private static const INVALIDATE_MANAGER_READY:uint = 1 << 17;
      
      private static const STATE_DEFAULT:String = "default";
      
      private static const STATE_DEAD:String = "dead";
      
      private static const STATE_SPOTTED:String = "spotted";
      
      private static const HEALTH_LBL:String = "Hp";
      
      private static const HEALTH_BAR:String = "HpIndicator";
      
      private static const DAMAGE_PANEL:String = "Damage";
      
      private static const HITBOX_WIDTH_OFFSET:Number = 8;
      
      private static const MARKER_BASE_KEY_PREFIX:String = "markerBase";
      
      private static const MARKER_ALT_KEY_PREFIX:String = "markerAlt";
      
      private static const CHAR_PERCENT:String = "%";
      
      private static const CHAR_UNDERSCORE:String = "_";
      
      private static const CURRENT_MAX_HP_SEPARATOR:String = " / ";
      
      private static const EMPTY_STRING:String = "";
       
      
      public var hitMC:MovieClip = null;
      
      public var marker:MovieClip = null;
      
      public var supplyIconMarker:SupplyIconMarker = null;
      
      public var healthBar:SupplyHealthBar = null;
      
      public var actionMarker:VehicleActionMarker = null;
      
      public var hitExplosion:AnimateExplosion = null;
      
      public var hitLabel:HealthBarAnimatedLabel = null;
      
      public var criticalHitLabel:HealthBarAnimatedLabel = null;
      
      public var reloading:Reloading = null;
      
      public var hpField:TextField = null;
      
      protected var reloadingContext:ReloadingData = null;
      
      protected var isPopulated:Boolean = false;
      
      protected var vmManager:VehicleMarkersManager = null;
      
      protected var isManagerReady:Boolean = false;
      
      private var _model:SupplyMarkerVO = null;
      
      private var _markerColor:String = "red";
      
      private var _markerState:String = "default";
      
      private var _markerSchemeName:String = "";
      
      private var _vehicleDestroyed:Boolean = false;
      
      private var _vehicleId:Number = 0;
      
      private var _isActionMarkerShown:Boolean = false;
      
      private var _hitIconOffset:int = -1;
      
      private var _entityType:String = "ally";
      
      public function CommanderSupplyMarker()
      {
         super();
         this.vmManager = VehicleMarkersManager.getInstance();
         this.isManagerReady = this.vmManager.isAtlasInited;
         if(!this.isManagerReady)
         {
            this.vmManager.addReadyHandler(this);
         }
         else
         {
            this.vmManager.addVehicleMarker(this);
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.vmManager.addEventListener(VehicleMarkersManagerEvent.SHOW_EX_INFO,this.onShowExInfoHandler);
         this.vmManager.addEventListener(VehicleMarkersManagerEvent.UPDATE_SETTINGS,this.onUpdateSettingsHandler);
         this.vmManager.addEventListener(VehicleMarkersManagerEvent.UPDATE_COLORS,this.onUpdateColorsHandler);
         this.reloadingContext = this.reloading.makeContext();
      }
      
      private function onMouseRollOutHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new RTSMarkerEvent(RTSMarkerEvent.MARKER_MOUSE_OUT,this.vehicleID));
      }
      
      private function onMouseRollOverHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new RTSMarkerEvent(RTSMarkerEvent.MARKER_MOUSE_OVER,this.vehicleID));
      }
      
      private function getDamageColor(param1:int) : String
      {
         var _loc2_:String = VehicleMarkerFlags.DAMAGE_FROM[param1];
         return VehicleMarkerFlags.DAMAGE_COLOR[_loc2_][this._markerColor];
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this.isManagerReady && this._model != null && !this.isPopulated && isInvalid(InvalidationType.DATA))
         {
            this._markerColor = this.vmManager.getAliasColor(this._markerSchemeName);
            this.healthBar.maxHP = this._model.maxHealth;
            this.healthBar.currentHP = this._model.currHealth;
            this.updateMarkerSettings();
            this.isPopulated = true;
         }
      }
      
      public function setObserved() : void
      {
         if(this._vehicleDestroyed)
         {
            return;
         }
         this.setMarkerState(STATE_SPOTTED);
      }
      
      override protected function onDispose() : void
      {
         this.vmManager.removeEventListener(VehicleMarkersManagerEvent.SHOW_EX_INFO,this.onShowExInfoHandler);
         this.vmManager.removeEventListener(VehicleMarkersManagerEvent.UPDATE_SETTINGS,this.onUpdateSettingsHandler);
         this.vmManager.removeEventListener(VehicleMarkersManagerEvent.UPDATE_COLORS,this.onUpdateColorsHandler);
         removeEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
         if(this.supplyIconMarker != null)
         {
            this.supplyIconMarker.dispose();
         }
         this.supplyIconMarker = null;
         if(this.healthBar != null)
         {
            this.healthBar.dispose();
         }
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
         if(this.criticalHitLabel != null)
         {
            this.criticalHitLabel.dispose();
         }
         this.criticalHitLabel = null;
         this.reloading.dispose();
         this.reloading = null;
         this.healthBar = null;
         this.marker = null;
         this.hitMC = null;
         this.hpField = null;
         this.reloadingContext = null;
         this._model = null;
         this.vmManager = null;
         super.onDispose();
      }
      
      public function managerReadyHandler() : void
      {
         this.isManagerReady = true;
         if(!this.isPopulated)
         {
            invalidate(INVALIDATE_MANAGER_READY);
         }
         this.vmManager.addVehicleMarker(this);
      }
      
      public function get markerSettings() : Object
      {
         var _loc1_:Object = null;
         if(this._vehicleDestroyed)
         {
            _loc1_ = this.vmManager.markerSettings[STATE_DEAD];
         }
         else
         {
            _loc1_ = this.vmManager.markerSettings[this._model.entityName];
         }
         return _loc1_;
      }
      
      protected function getIsPartVisible(param1:String) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:String = (!!this.showExInfo() ? MARKER_ALT_KEY_PREFIX : MARKER_BASE_KEY_PREFIX) + param1;
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
      
      public function setHealth(param1:int, param2:int = 0) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         this.updateHitLabel(param1,param2);
         this._model.currHealth = param1;
         if(this.isPopulated)
         {
            this.healthBar.currentHP = param1;
            this.setHealthText();
         }
      }
      
      public function setSupplyInfo(param1:String, param2:String, param3:int, param4:int, param5:int, param6:String, param7:int) : void
      {
         this._model = new SupplyMarkerVO();
         this._model.sClass = param1;
         this._model.sName = param2;
         this._model.maxHealth = param4;
         this._model.currHealth = param5;
         this._model.entityName = param6;
         mouseChildren = false;
         mouseEnabled = true;
         hitArea = this.hitMC;
         removeEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
         addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
         if(this._model.entityName != Values.EMPTY_STR)
         {
            this.makeColorSchemeName();
         }
         this.isPopulated = false;
         this._vehicleId = param3;
         this.hitLabel.fakeDamage = this._model.maxHealth - this._model.currHealth;
         this.hitLabel.imitationFlag = this.getDamageColor(param7);
         this.hitLabel.imitation = false;
         this.updateMarkerSettings();
         invalidateData();
      }
      
      public function update() : void
      {
         this.updateMarkerSettings();
      }
      
      public function updateHealth(param1:int, param2:int = 0, param3:String = "") : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         this.updateHitLabel(param1,param2);
         this._model.currHealth = param1;
         if(VehicleMarkerFlags.checkAllowedDamages(param3) && this.hitExplosion.visible)
         {
            this.hitExplosion.setColorAndDamageType(this.getDamageColor(param2),param3);
            this.hitExplosion.playShowTween();
            this._hitIconOffset = VehicleMarker.EXPLOSION_HORIZONTAL_OFFSET;
         }
         this.updateHitLayout();
         if(this.isPopulated)
         {
            this.healthBar.currentHP = this._model.currHealth;
            this.setHealthText();
         }
      }
      
      public function updateState(param1:String, param2:String) : void
      {
         if(param2 != Values.EMPTY_STR || param1 != Values.EMPTY_STR)
         {
            this.hitExplosion.playShowTween();
            this.criticalHitLabel.setLabel(param1,VehicleMarker.WHITE_COLOR);
            this.hitExplosion.setAnimationType(param2);
            this._hitIconOffset = VehicleMarker.BLOCK_HORIZONTAL_OFFSET;
            this.updateHitLayout();
            this.criticalHitLabel.playShowTween();
         }
      }
      
      public function showActionMarker(param1:String) : void
      {
         if(this._isActionMarkerShown)
         {
            this.actionMarker.stopAction(false);
         }
         this._isActionMarkerShown = true;
         this.actionMarker.addEventListener(Event.COMPLETE,this.onActionAnimationHiddenCompleteHandler);
         this.actionMarker.showAction(param1);
         if(param1 != Values.EMPTY_STR)
         {
            this.updateMarkerSettings();
         }
      }
      
      public function hideStatusMarker(param1:int, param2:int, param3:Boolean = false) : void
      {
         this.updateMarkerSettings();
      }
      
      public function setActiveState(param1:int) : void
      {
         this.actionMarker.updateActionRenderer(param1);
      }
      
      public function setMarkerReplied(param1:Boolean) : void
      {
         this.actionMarker.setMarkerReplied(param1);
      }
      
      public function setReplyCount(param1:int) : void
      {
         this.actionMarker.setReplyCount(param1);
      }
      
      public function stopActionMarker() : void
      {
         this.actionMarker.stopAction();
      }
      
      public function triggerClickAnimation() : void
      {
         this.actionMarker.triggerClickAnimation();
      }
      
      private function onActionAnimationHiddenCompleteHandler(param1:Event) : void
      {
         this._isActionMarkerShown = false;
         this.actionMarker.removeEventListener(Event.COMPLETE,this.onActionAnimationHiddenCompleteHandler);
         this.updateMarkerSettings();
      }
      
      public function setState(param1:String) : void
      {
         this.setMarkerState(param1);
      }
      
      private function makeColorSchemeName() : void
      {
         this._markerSchemeName = (!!this._vehicleDestroyed ? VM_DEAD_PREFIX : VM_PREFIX) + this._model.entityName;
      }
      
      protected function updateMarkerSettings() : void
      {
         var _loc1_:Boolean = this.getIsPartVisible(HEALTH_BAR) || this.isAllyMarker();
         var _loc2_:Boolean = this.getIsPartVisible(HEALTH_LBL) || this.isAllyMarker();
         var _loc3_:Boolean = this.getIsPartVisible(DAMAGE_PANEL) || this.isAllyMarker();
         if(_loc1_)
         {
            this.healthBar.currentHP = this._model.currHealth;
         }
         this.healthBar.visible = _loc1_;
         this.healthBar.entityName = this._model.entityName;
         this.setHealthText();
         this.adjustHitMCPosition();
         this.supplyIconMarker.setSupplyType(this._model.sClass);
         this.supplyIconMarker.visible = true;
         this.hitLabel.visible = _loc3_;
         this.hitExplosion.visible = _loc3_;
         this.hpField.visible = _loc2_;
         this.criticalHitLabel.visible = true;
         this.setMarkerState(this._markerState);
      }
      
      private function adjustHitMCPosition() : void
      {
         var _loc1_:int = this.hitMC.x + this.hitMC.width / 2;
         var _loc2_:int = this.healthBar.width;
         _loc2_ += HITBOX_WIDTH_OFFSET;
         this.hitMC.x = _loc1_ - _loc2_ / 2;
         this.hitMC.width = _loc2_;
      }
      
      private function setMarkerState(param1:String) : void
      {
         if(param1 != this._markerState)
         {
            this._markerState = param1;
         }
         if(this._markerState == STATE_DEAD)
         {
            this._vehicleDestroyed = true;
            this.healthBar.isAlive = false;
         }
         if(initialized)
         {
            this.reloading.isAlive = !this._vehicleDestroyed;
            this.supplyIconMarker.setState(this._model.entityName + CHAR_UNDERSCORE + this._markerState);
         }
      }
      
      private function onUpdateSettingsHandler(param1:VehicleMarkersManagerEvent) : void
      {
         this.updateMarkerSettings();
      }
      
      private function onShowExInfoHandler(param1:VehicleMarkersManagerEvent) : void
      {
         this.updateMarkerSettings();
      }
      
      private function onUpdateColorsHandler(param1:VehicleMarkersManagerEvent) : void
      {
         this.updateMarkerSettings();
      }
      
      private function onSplashHideHandler(param1:Event) : void
      {
         if(this._vehicleDestroyed || this._model.currHealth <= 0)
         {
            this.updateMarkerSettings();
         }
      }
      
      private function updateHitLayout() : void
      {
         var _loc1_:Boolean = this.hitLabel.visible && this.hitLabel.isActive();
         var _loc2_:int = !!_loc1_ ? int(this.hitLabel.damageLabel.textWidth) : int(0);
         var _loc3_:int = !!_loc1_ ? int(this._hitIconOffset) : int(VehicleMarker.START_HORIZONTAL_OFFSET);
         this.hitExplosion.x = this.hitLabel.x + _loc2_ + _loc3_ | 0;
         this.criticalHitLabel.x = this.hitExplosion.x + VehicleMarker.EXPLOSION_SIZE | 0;
      }
      
      private function updateHitLabel(param1:int, param2:int) : void
      {
         var _loc3_:int = this._model.currHealth - param1;
         if(_loc3_ > 0 && this.hitLabel != null && this.hitLabel.visible)
         {
            this.hitLabel.damage(_loc3_,this.getDamageColor(param2));
            this.hitLabel.playShowTween();
         }
      }
      
      public function get vehicleID() : Number
      {
         return this._vehicleId;
      }
      
      public function setReloading(param1:Number, param2:Number, param3:Number) : void
      {
         if(this.reloadingContext)
         {
            this.reloading.setReloading(param1,param2,param3);
            this.updateMarkerSettings();
         }
      }
      
      private function setHealthText() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = (!!this.showExInfo() ? MARKER_ALT_KEY_PREFIX : MARKER_BASE_KEY_PREFIX) + HEALTH_LBL;
         var _loc3_:Number = this.markerSettings[_loc2_];
         if(this._model.entityName == VehicleMarkersConstants.ENTITY_NAME_ALLY)
         {
            this.hpField.text = this._model.currHealth.toString();
            return;
         }
         switch(_loc3_)
         {
            case HPDisplayMode.PERCENTS:
               _loc1_ = this.getHealthPercents() + CHAR_PERCENT;
               break;
            case HPDisplayMode.CURRENT_AND_MAXIMUM:
               _loc1_ = this._model.currHealth + CURRENT_MAX_HP_SEPARATOR + this._model.maxHealth;
               break;
            case HPDisplayMode.CURRENT:
               _loc1_ = this._model.currHealth.toString();
               break;
            default:
               _loc1_ = EMPTY_STRING;
         }
         this.hpField.text = _loc1_;
      }
      
      private function getHealthPercents() : Number
      {
         return Math.ceil(this._model.currHealth / this._model.maxHealth * 100);
      }
      
      private function isAllyMarker() : Boolean
      {
         return this._model.entityName == VehicleMarkersConstants.ENTITY_NAME_ALLY;
      }
      
      private function showExInfo() : Boolean
      {
         return this.vmManager.showExInfo && !this.isAllyMarker();
      }
   }
}
