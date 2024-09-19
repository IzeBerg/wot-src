package net.wg.gui.battle.views.vehicleMarkers
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.vehicleMarkers.VO.CrossOffset;
   import net.wg.gui.battle.views.vehicleMarkers.VO.HPDisplayMode;
   import net.wg.gui.battle.views.vehicleMarkers.VO.VehicleMarkerFlags;
   import net.wg.gui.battle.views.vehicleMarkers.VO.VehicleMarkerPart;
   import net.wg.gui.battle.views.vehicleMarkers.VO.VehicleMarkerVO;
   import net.wg.gui.battle.views.vehicleMarkers.events.VehicleMarkersManagerEvent;
   import net.wg.utils.TextFieldUtils;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.gfx.TextFieldEx;
   
   public class VehicleMarker extends BattleUIComponent implements IMarkerManagerHandler, IVehicleMarkerInvokable
   {
      
      public static const EXTRA_HIT_LABEL_OFFSET_Y:int = 17;
      
      protected static const V_TYPE_ICON_Y:int = -7;
      
      protected static const ICON:String = "Icon";
      
      protected static const LEVEL:String = "Level";
      
      protected static const HEALTH_LBL:String = "Hp";
      
      protected static const HEALTH_BAR:String = "HpIndicator";
      
      protected static const P_NAME_LBL:String = "PlayerName";
      
      protected static const V_NAME_LBL:String = "VehicleName";
      
      protected static const DAMAGE_PANEL:String = "Damage";
      
      protected static const MARKER:String = "marker";
      
      protected static const ALT:String = "Alt";
      
      protected static const BASE:String = "Base";
      
      protected static const MAX_HEALTH_PERCENT:uint = 100;
      
      private static const SHADOW_POSITIONS:Array = [null,new Point(-94,-59),new Point(-94,-85),new Point(-94,-42),new Point(-94,-72),new Point(-94,-77)];
      
      private static const NORMAL_MARKER_STATE:String = "normal";
      
      private static const DEAD:String = "Dead";
      
      private static const START_HORIZONTAL_OFFSET:uint = 15;
      
      private static const EXPLOSION_HORIZONTAL_OFFSET:int = -16;
      
      private static const BLOCK_HORIZONTAL_OFFSET:uint = 25;
      
      private static const EXPLOSION_SIZE:uint = 18;
      
      private static const STATE_DEAD:String = "dead";
      
      private static const STATE_IMMEDIATE_DEAD:String = "immediate_dead";
      
      private static const PERCENT_STRING:String = "%";
      
      private static const SLASH_STRING:String = " / ";
      
      private static const SHADOW_TYPE_HBAR_OFFSET:uint = 2;
      
      private static const VM_PREFIX:String = "vm_";
      
      private static const VM_DEAD_PREFIX:String = "vm_dead_";
      
      private static const VM_DEBUFF_PREFIX:String = "vm_stun_";
      
      private static const VM_BUFF_PREFIX:String = "vm_stun_";
      
      private static const VM_DEBUFF_POSTFIX:String = "_schema";
      
      private static const VM_BUFF_POSTFIX:String = "_schema";
      
      private static const VEHICLE_DESTROY_COLOR:Number = 6710886;
      
      private static const VEHICLE_RESTORE_COLOR:Number = 16777215;
      
      private static const INVALIDATE_MANAGER_READY:uint = 1 << 17;
      
      private static const SLASH:String = "/";
      
      private static const PNG_EXT:String = ".png";
      
      private static const START_Y:int = -16;
      
      private static const HP_FIELD_TO_HP_BAR_OFFSET:uint = 2;
      
      private static const WHITE_COLOR:String = "white";
      
      private static const ACTION_MARKER:String = "actionMarker";
      
      private static const ALTERNATIVE:String = "Alternative";
      
      private static const OBSERVER_SCHEME_NAME:String = "team";
      
      private static const DEFAULT_DAMAGE_COLOR:String = "white";
      
      private static const LABEL_COLOR_BLIND_HOVER:String = "colorBlindHover";
      
      private static const LABEL_ENEMY_HOVER:String = "enemyHover";
      
      private static const LABEL_PLATOON_HOVER:String = "platoonHover";
      
      private static const LABEL_ALLY_HOVER:String = "allyHover";
      
      private static const LABEL_COLOR_BLIND_HOVER_NO_PING:String = "colorBlindHoverNoPing";
      
      private static const LABEL_ENEMY_HOVER_NO_PING:String = "enemyHoverNoPing";
      
      private static const LABEL_PLATOON_HOVER_NO_PING:String = "platoonHoverNoPing";
      
      private static const LABEL_ALLY_HOVER_NO_PING:String = "allyHoverNoPing";
      
      private static const SCHEME_NAME_SQUADMAN:String = "vm_squadman";
      
      private static const LEVEL_ICON_ALPHA_DESTROYED:Number = 0.4;
      
      private static const LEVEL_ICON_ALPHA_ALIVE:int = 1;
       
      
      public var vehicleIcon:MovieClip = null;
      
      public var actionMarker:VehicleActionMarker = null;
      
      public var statusContainer:VehicleStatusContainerMarker = null;
      
      public var marker:VehicleIconAnimation = null;
      
      public var playerHitLabel:HealthBarAnimatedLabel = null;
      
      public var squadHitLabel:HealthBarAnimatedLabel = null;
      
      public var otherHitLabel:HealthBarAnimatedLabel = null;
      
      public var criticalHitLabel:HealthBarAnimatedLabel = null;
      
      public var criticalHit:AnimateExplosion = null;
      
      public var hitExplosion:AnimateExplosion = null;
      
      public var vehicleNameField:TextField = null;
      
      public var playerNameField:TextField = null;
      
      public var hpField:TextField = null;
      
      public var healthBar:HealthBar = null;
      
      public var bgShadow:MovieClip = null;
      
      public var marker2:FlagContainer = null;
      
      public var levelIcon:MovieClip = null;
      
      public var squadIcon:MovieClip = null;
      
      public var vehicleMarkerHoverMC:MovieClip = null;
      
      protected var vmManager:VehicleMarkersManager = null;
      
      protected var model:VehicleMarkerVO = null;
      
      protected var markerParts:Vector.<VehicleMarkerPart> = null;
      
      protected var isStickyAndOutOfScreen:Boolean = false;
      
      protected var vehicleDestroyed:Boolean = false;
      
      protected var offsets:Array;
      
      private var _extInfoShow:Boolean = false;
      
      private var _lastActionState:String = null;
      
      private var _objectiveActionMarker:String = null;
      
      private var _entityType:String = "enemy";
      
      private var _entityName:String = "enemy";
      
      private var _markerColor:String = "red";
      
      private var _markerState:String = "";
      
      private var _vehicleDestroyedAlready:Boolean = false;
      
      private var _isPopulated:Boolean = false;
      
      private var _exInfoOverride:Boolean = false;
      
      private var _markerSettingsOverride:Object = null;
      
      private var _maxHealthMult:Number = NaN;
      
      private var _markerSchemeName:String = "";
      
      private var _debuffSchemeName:String = "";
      
      private var _buffSchemeName:String = "";
      
      private var _isFlagShown:Boolean = false;
      
      private var _isManagerReady:Boolean = false;
      
      private var _canUseCachedVisibility:Boolean = false;
      
      private var _lastPlayerName:String = "";
      
      private var _damageType:String = "";
      
      private var _insertedPart:Dictionary;
      
      private var _insertedPartsSorted:Vector.<VehicleMarkerPart>;
      
      public function VehicleMarker()
      {
         this.offsets = [-2,-2,1,1,1,1,1,0,0,-66];
         this._insertedPart = new Dictionary();
         this._insertedPartsSorted = new Vector.<VehicleMarkerPart>(0);
         super();
         this.vmManager = VehicleMarkersManager.getInstance();
         this._isManagerReady = this.vmManager.isAtlasInited;
         if(!this._isManagerReady)
         {
            this.vmManager.addReadyHandler(this);
         }
         TextFieldEx.setNoTranslate(this.vehicleNameField,true);
         TextFieldEx.setNoTranslate(this.playerNameField,true);
         TextFieldEx.setNoTranslate(this.hpField,true);
         this.prepareLayout();
         this.vehicleMarkerHoverMC.visible = false;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.statusContainer.addEventListener(Event.COMPLETE,this.onStatusAnimationHiddenCompleteHandler);
         this.healthBar.hitSplash.addEventListener(HealthBarAnimatedPart.HIDE,this.onSplashHideHandler);
         this.vmManager.addEventListener(VehicleMarkersManagerEvent.UPDATE_SETTINGS,this.onUpdateSettingsHandler);
         this.vmManager.addEventListener(VehicleMarkersManagerEvent.UPDATE_COLORS,this.onUpdateColorsHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._isManagerReady && this.model != null && !this._isPopulated && isInvalid(InvalidationType.DATA))
         {
            this._markerColor = this.vmManager.getAliasColor(this._markerSchemeName);
            this.applyColor();
            if(this.getHealthPercents() >= 0)
            {
               this.healthBar.maxHealth = this.model.maxHealth;
               this.healthBar.currHealth = this.model.currHealth;
            }
            this.initialDrawParts();
            this.setupVehicleIcon();
            this.setupSquadIcon();
            if(this.model.vClass)
            {
               this.setVehicleType();
            }
            this.setMarkerState(this._markerState);
            this._canUseCachedVisibility = false;
            this.updateMarkerSettings();
            this._isPopulated = true;
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:VehicleMarkerPart = null;
         var _loc2_:VehicleMarkerPart = null;
         this.statusContainer.removeEventListener(Event.COMPLETE,this.onStatusAnimationHiddenCompleteHandler);
         this.healthBar.hitSplash.removeEventListener(HealthBarAnimatedPart.HIDE,this.onSplashHideHandler);
         this.vmManager.removeEventListener(VehicleMarkersManagerEvent.SHOW_EX_INFO,this.onShowExInfoHandler);
         this.vmManager.removeEventListener(VehicleMarkersManagerEvent.UPDATE_SETTINGS,this.onUpdateSettingsHandler);
         this.vmManager.removeEventListener(VehicleMarkersManagerEvent.UPDATE_COLORS,this.onUpdateColorsHandler);
         this.vehicleIcon = null;
         this.hpField = null;
         if(this.actionMarker != null)
         {
            this.actionMarker.dispose();
            this.actionMarker = null;
         }
         if(this.marker != null)
         {
            this.marker.dispose();
            this.marker = null;
         }
         if(this.marker2 != null)
         {
            this.marker2.dispose();
            this.marker2 = null;
         }
         if(this.otherHitLabel != null)
         {
            this.otherHitLabel.dispose();
            this.otherHitLabel = null;
         }
         if(this.squadHitLabel != null)
         {
            this.squadHitLabel.dispose();
            this.squadHitLabel = null;
         }
         if(this.playerHitLabel != null)
         {
            this.playerHitLabel.dispose();
            this.playerHitLabel = null;
         }
         if(this.hitExplosion != null)
         {
            this.hitExplosion.dispose();
            this.hitExplosion = null;
         }
         if(this.criticalHit != null)
         {
            this.criticalHit.dispose();
            this.criticalHit = null;
         }
         this.vehicleNameField = null;
         this.playerNameField = null;
         this.healthBar.dispose();
         this.healthBar = null;
         this.bgShadow = null;
         this.levelIcon = null;
         this.squadIcon = null;
         if(this.criticalHitLabel != null)
         {
            this.criticalHitLabel.dispose();
            this.criticalHitLabel = null;
         }
         this.statusContainer.dispose();
         this.statusContainer = null;
         this.model = null;
         this._markerSettingsOverride = null;
         this.vmManager = null;
         this.vehicleMarkerHoverMC = null;
         if(this.markerParts)
         {
            for each(_loc2_ in this.markerParts)
            {
               _loc2_.dispose();
            }
            this.markerParts.splice(0,this.markerParts.length);
            this.markerParts = null;
         }
         this.offsets.splice(0,this.offsets.length);
         this.offsets = null;
         this.cleanupDynamicObject(this._insertedPart);
         this._insertedPart = null;
         for each(_loc1_ in this._insertedPartsSorted)
         {
            _loc1_.dispose();
         }
         this._insertedPartsSorted.length = 0;
         this._insertedPartsSorted = null;
         super.onDispose();
      }
      
      public function activateHover(param1:Boolean) : void
      {
         this.vehicleMarkerHoverMC.visible = param1;
         this.updateMarkerSettings();
         this.vmManager.isMarkerHover(param1);
      }
      
      public function callInsertedSymbolMethod(param1:String, param2:String, ... rest) : void
      {
         if(this._insertedPart[param1] != undefined)
         {
            this._insertedPart[param1].part[param2].apply(null,rest);
         }
      }
      
      public function changeObjectiveActionMarker(param1:String) : void
      {
         this._objectiveActionMarker = param1 != Values.EMPTY_STR ? param1 + ALTERNATIVE : param1;
      }
      
      public function hideArtyMarker() : void
      {
      }
      
      public function hideStatusMarker(param1:int, param2:int, param3:Boolean = false, param4:Boolean = false) : void
      {
         this.statusContainer.hideMarker(param1,param2,param3,param4);
         this.updateMarkerSettings();
      }
      
      public function insertSymbol(param1:String, param2:int, param3:int) : void
      {
         if(this._insertedPart[param1] != undefined)
         {
            return;
         }
         var _loc4_:Class = getDefinitionByName(param1) as Class;
         var _loc5_:DisplayObject = new _loc4_() as DisplayObject;
         _loc5_.name = param1;
         addChild(_loc5_);
         var _loc6_:VehicleMarkerPart = new VehicleMarkerPart(_loc5_,param3,null);
         this.markerParts.splice(param2,0,_loc6_);
         this._insertedPart[param1] = _loc6_;
         this._insertedPartsSorted.push(_loc6_);
         this._insertedPartsSorted.sort(this.sortInsertedSymbols);
         this.updateMarkerSettings();
      }
      
      public function isSpeaking() : Boolean
      {
         return this.model.speaking;
      }
      
      public function managerReadyHandler() : void
      {
         this._isManagerReady = true;
         if(!this._isPopulated)
         {
            invalidate(INVALIDATE_MANAGER_READY);
         }
      }
      
      public function onVisibilityChanged(param1:Boolean) : void
      {
         if(param1)
         {
            this.vmManager.addEventListener(VehicleMarkersManagerEvent.SHOW_EX_INFO,this.onShowExInfoHandler);
         }
         else
         {
            this.vmManager.removeEventListener(VehicleMarkersManagerEvent.SHOW_EX_INFO,this.onShowExInfoHandler);
         }
         if(this._extInfoShow != this.vmManager.showExInfo)
         {
            this.onShowExInfoHandler(null);
         }
      }
      
      public function removeSymbol(param1:String) : void
      {
         if(this._insertedPart[param1] == undefined)
         {
            return;
         }
         var _loc2_:VehicleMarkerPart = this._insertedPart[param1];
         _loc2_.part.dispose();
         removeChild(_loc2_.part as DisplayObject);
         var _loc3_:int = this.markerParts.indexOf(_loc2_);
         if(_loc3_ != -1)
         {
            this.markerParts.splice(_loc3_,1);
         }
         _loc3_ = this._insertedPartsSorted.indexOf(_loc2_);
         if(_loc3_ != -1)
         {
            this._insertedPartsSorted.splice(_loc3_,1);
         }
         _loc2_.dispose();
         this.updateMarkerSettings();
         delete this._insertedPart[param1];
      }
      
      public function restore() : void
      {
         this.marker.gotoAndStop(NORMAL_MARKER_STATE);
         this._isPopulated = false;
         this._vehicleDestroyedAlready = false;
         this.hpField.textColor = VEHICLE_RESTORE_COLOR;
         this._markerState = Values.EMPTY_STR;
         this.setMarkerState(this._markerState);
         this.updateIconColor();
         invalidateData();
      }
      
      public function setActiveState(param1:int) : void
      {
         this.actionMarker.updateActionRenderer(param1);
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
         this.model.currHealth = param1;
         if(this._isPopulated)
         {
            if(this.getIsPartVisible(HEALTH_BAR))
            {
               this.healthBar.currHealth = param1;
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
      
      public function setIsStickyAndOutOfScreen(param1:Boolean) : void
      {
         this.isStickyAndOutOfScreen = param1;
         this.updateMarkerSettings();
         this.marker.visible = !param1;
         this.statusContainer.visible = !param1;
      }
      
      public function setMarkerReplied(param1:Boolean) : void
      {
         this.actionMarker.setMarkerReplied(param1);
      }
      
      public function setReplyCount(param1:int) : void
      {
         this.actionMarker.setReplyCount(param1);
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
            this.onSpeakingUpdate();
         }
      }
      
      public function setStatusTimerSnapshot(param1:int) : void
      {
         this.statusContainer.updateEffectTimer(0,param1);
         this.updateMarkerSettings();
      }
      
      public function setVehicleInfo(param1:String, param2:String, param3:String, param4:int, param5:String, param6:String, param7:String, param8:String, param9:int, param10:String, param11:Boolean, param12:int, param13:String, param14:String = "", param15:int = 0) : void
      {
         var _loc16_:int = 0;
         if(this.model)
         {
            _loc16_ = this.model.currHealth;
         }
         this.model = new VehicleMarkerVO();
         this.model.vClass = param1;
         this.model.vIconSource = param2;
         this.model.vType = param3;
         this.model.vLevel = param4;
         this.model.pFullName = param5;
         this.model.pName = param6;
         this.model.pClan = param7;
         this.model.pRegion = param8;
         this.model.maxHealth = param9;
         this.model.entityName = param10;
         this.model.hunt = param11;
         this.model.squadIndex = param12;
         this.model.currHealth = _loc16_;
         this.model.locSecString = param13;
         var _loc17_:int = this.model.maxHealth;
         if(_loc17_ == 0)
         {
            _loc17_ = 1;
         }
         this._maxHealthMult = MAX_HEALTH_PERCENT / _loc17_;
         this.statusContainer.setSecondString(this.model.locSecString);
         if(this.model.entityName != Values.EMPTY_STR)
         {
            this._entityName = this.model.entityName;
            this.actionMarker.entityName = this._entityName;
            this.makeColorSchemeName();
            this.updateEffectColor();
            if(this.isEnemy())
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
         this._lastActionState = param1;
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
      
      public function stopActionMarker() : void
      {
         this._lastActionState = null;
         this.actionMarker.stopAction();
         this.setIsStickyAndOutOfScreen(false);
      }
      
      public function triggerClickAnimation() : void
      {
         this.actionMarker.triggerClickAnimation();
      }
      
      public function update() : void
      {
         this.updateMarkerColor();
         this.updateMarkerSettings();
      }
      
      public function updateFlagBearerState(param1:Boolean) : void
      {
         this._isFlagShown = param1;
         this.updateFlag();
      }
      
      public function updateHealth(param1:int, param2:uint, param3:String) : void
      {
         var _loc5_:String = null;
         this._damageType = param3;
         if(param1 < 0)
         {
            this._damageType = VehicleMarkerFlags.DAMAGE_EXPLOSION;
            param1 = 0;
         }
         var _loc4_:int = this.model.currHealth - param1;
         this.model.currHealth = param1;
         if(this._isPopulated)
         {
            _loc5_ = this.getDamageColor(param2);
            if(this.getIsPartVisible(HEALTH_BAR))
            {
               this.healthBar.updateHealth(param1,_loc5_);
            }
            if(this.getIsPartVisible(DAMAGE_PANEL))
            {
               if(_loc4_ != Values.ZERO)
               {
                  this.showHitLabelAnim(_loc4_,_loc5_,param2);
               }
               if(VehicleMarkerFlags.checkAllowedDamages(this._damageType))
               {
                  this.hitExplosion.setColorAndDamageType(_loc5_,this._damageType);
                  this.hitExplosion.playShowTween();
               }
               this.updateCriticalLayout();
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
      
      public function updateState(param1:String, param2:Boolean, param3:String = "", param4:String = "", param5:Boolean = false) : void
      {
         if(this.vehicleDestroyed)
         {
            return;
         }
         if(param2 && param1 == STATE_DEAD)
         {
            param1 = STATE_IMMEDIATE_DEAD;
         }
         if((param4 != Values.EMPTY_STR || param3 != Values.EMPTY_STR) && this.getIsPartVisible(DAMAGE_PANEL))
         {
            if(!param5 || !(this.criticalHit.isActive() || this.criticalHitLabel.isActive()))
            {
               this.criticalHit.setAnimationType(param4);
               this.criticalHitLabel.setLabel(param3,WHITE_COLOR);
            }
            this.criticalHit.playShowTween(param5);
            this.criticalHitLabel.playShowTween(param5);
            this.updateCriticalLayout();
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
      
      protected function initialDrawParts() : void
      {
         this.levelIcon.visible = this.model.vLevel > 0;
         if(this.levelIcon.visible)
         {
            this.vmManager.drawWithCenterAlign(VMAtlasItemName.getLevelIconName(this.model.vLevel),this.levelIcon.graphics,true,false);
         }
      }
      
      protected function redrawParts() : void
      {
      }
      
      protected function onSpeakingUpdate() : void
      {
         this.setVehicleType();
      }
      
      protected function updatePartsVisibility() : Vector.<Boolean>
      {
         var _loc10_:VehicleMarkerPart = null;
         var _loc11_:Point = null;
         var _loc12_:int = 0;
         var _loc1_:Boolean = this.getIsPartVisible(ICON);
         var _loc2_:Boolean = this.getIsPartVisible(LEVEL);
         var _loc3_:Boolean = this.getIsPartVisible(P_NAME_LBL);
         var _loc4_:Boolean = this.getIsPartVisible(V_NAME_LBL);
         var _loc5_:Boolean = this.getIsPartVisible(HEALTH_BAR);
         var _loc6_:Boolean = this.getIsPartVisible(HEALTH_LBL);
         var _loc7_:Boolean = this.getIsPartVisible(DAMAGE_PANEL);
         if(_loc3_ && this._lastPlayerName != this.model.pName)
         {
            this._lastPlayerName = this.model.pName;
            TextFieldUtils.instance.truncateTextFieldText(this.playerNameField,this._lastPlayerName);
         }
         this.playerNameField.visible = _loc3_;
         if(_loc4_)
         {
            this.vehicleNameField.text = this.model.vType;
         }
         this.vehicleNameField.visible = _loc4_;
         if(_loc5_)
         {
            this.healthBar.currHealth = this.model.currHealth;
         }
         this.healthBar.visible = _loc5_;
         this.hpField.visible = _loc6_;
         if(this.vehicleDestroyed)
         {
            this.setDestroyedColorForHP();
         }
         this.setHealthText();
         this.playerHitLabel.visible = _loc7_;
         this.squadHitLabel.visible = _loc7_;
         this.otherHitLabel.visible = _loc7_;
         this.hitExplosion.visible = _loc7_;
         this.criticalHit.visible = _loc7_;
         this.levelIcon.visible = _loc2_;
         this.vehicleIcon.visible = _loc1_;
         var _loc8_:int = (!!_loc3_ ? 1 : 0) + (!!_loc4_ ? 1 : 0);
         if(!_loc5_)
         {
            _loc8_ += !!_loc6_ ? 1 : 0;
            if(_loc8_ > 0)
            {
               _loc8_ += SHADOW_TYPE_HBAR_OFFSET;
            }
         }
         if(_loc8_ > 0)
         {
            _loc11_ = this.getShadowPosition(_loc8_);
            this.vmManager.drawGraphics(VMAtlasItemName.getShadowName(_loc8_),this.bgShadow.graphics,_loc11_);
            this.bgShadow.visible = true;
         }
         else
         {
            this.bgShadow.visible = false;
         }
         var _loc9_:Vector.<Boolean> = new <Boolean>[_loc5_ || _loc6_,_loc3_,_loc4_,_loc2_,_loc1_,this.model.squadIndex != 0,this._isFlagShown,this.statusContainer.isVisible(),this.actionMarker.isVisible(),this.vehicleMarkerHoverMC.visible];
         for each(_loc10_ in this._insertedPartsSorted)
         {
            _loc12_ = this.markerParts.indexOf(_loc10_);
            _loc9_.splice(_loc12_,0,!this.isStickyAndOutOfScreen);
         }
         return _loc9_;
      }
      
      protected function getShadowPosition(param1:int) : Point
      {
         return SHADOW_POSITIONS[param1];
      }
      
      protected function getIsPartVisible(param1:String) : Boolean
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
         if(this.isStickyAndOutOfScreen)
         {
            _loc2_ = param1 == ACTION_MARKER;
         }
         if(param1 == V_NAME_LBL && _loc2_ && this.getIsPartVisible(P_NAME_LBL))
         {
            return this.model.vType != this.model.pName;
         }
         return _loc2_;
      }
      
      protected function prepareParts() : Array
      {
         return [this.hpField,this.playerNameField,this.vehicleNameField,this.levelIcon,this.vehicleIcon,this.squadIcon,this.marker2,this.statusContainer,this.actionMarker,this.vehicleMarkerHoverMC];
      }
      
      protected function prepareCrossOffsets() : Vector.<CrossOffset>
      {
         return new <CrossOffset>[null,new CrossOffset(this.hpField,-3),new CrossOffset(this.playerNameField,-7,this.hpField,-3),new CrossOffset(this.vehicleNameField,-4,this.playerNameField,-4),new CrossOffset(this.levelIcon,-12,this.vehicleNameField,-3,this.playerNameField,-3),null,null,new CrossOffset(this.vehicleNameField,3),new CrossOffset(this.statusContainer,-25),new CrossOffset(this.actionMarker,-52)];
      }
      
      protected function getStartY() : int
      {
         return START_Y;
      }
      
      protected function prepareOffsets() : void
      {
      }
      
      protected function isEnemy() : Boolean
      {
         return this._entityName == VehicleMarkersConstants.ENTITY_NAME_ENEMY;
      }
      
      protected function getHpBarOrLabelVisible() : Boolean
      {
         return this.getIsPartVisible(HEALTH_BAR) || this.getIsPartVisible(HEALTH_LBL);
      }
      
      protected function showHitLabelAnim(param1:int, param2:String, param3:uint) : void
      {
         switch(param3)
         {
            case VehicleMarkerFlags.DAMAGE_FROM_PLAYER_FLAG:
               this.playerHitLabel.damage(param1,param2);
               this.playerHitLabel.playShowTween();
               break;
            case VehicleMarkerFlags.DAMAGE_FROM_SQUAD_FLAG:
               this.squadHitLabel.damage(param1,param2);
               this.squadHitLabel.playShowTween();
               break;
            case VehicleMarkerFlags.DAMAGE_FROM_OTHER_FLAG:
            default:
               this.otherHitLabel.damage(param1,param2);
               this.otherHitLabel.playShowTween();
         }
         this.squadHitLabel.y = !!this.playerHitLabel.isActive() ? Number(this.playerHitLabel.y + EXTRA_HIT_LABEL_OFFSET_Y) : Number(this.playerHitLabel.y);
         this.otherHitLabel.y = !!this.squadHitLabel.isActive() ? Number(this.squadHitLabel.y + EXTRA_HIT_LABEL_OFFSET_Y) : Number(this.squadHitLabel.y);
      }
      
      private function updateEffectColor() : void
      {
         this.statusContainer.setBuffEffectColor(this.vmManager.getAliasColor(this._buffSchemeName),this.vmManager.getRGB(this._buffSchemeName));
         this.statusContainer.setDebuffEffectColor(this.vmManager.getAliasColor(this._debuffSchemeName),this.vmManager.getRGB(this._debuffSchemeName));
      }
      
      private function sortInsertedSymbols(param1:VehicleMarkerPart, param2:VehicleMarkerPart) : int
      {
         var _loc3_:int = this.markerParts.indexOf(param1);
         var _loc4_:int = this.markerParts.indexOf(param2);
         if(_loc3_ > _loc4_)
         {
            return -1;
         }
         if(_loc3_ < _loc4_)
         {
            return 1;
         }
         return 0;
      }
      
      protected function layoutExtended(param1:int) : void
      {
      }
      
      protected function set maxHealthMult(param1:Number) : void
      {
         this._maxHealthMult = param1;
      }
      
      private function layoutParts(param1:Vector.<Boolean>) : void
      {
         var _loc4_:VehicleMarkerPart = null;
         var _loc6_:int = 0;
         var _loc2_:int = this.getStartY();
         var _loc3_:int = this.markerParts.length;
         var _loc5_:VehicleMarkerPart = null;
         var _loc7_:Boolean = this._canUseCachedVisibility;
         var _loc8_:Boolean = false;
         var _loc9_:int = 0;
         while(_loc9_ < _loc3_)
         {
            _loc4_ = this.markerParts[_loc9_];
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
                  _loc4_.y = _loc2_ - _loc6_ - _loc4_.height;
                  _loc5_ = _loc4_;
                  _loc2_ = _loc4_.y;
               }
            }
            _loc4_.cachedVisibility = _loc8_;
            _loc9_++;
         }
         this.healthBar.y = this.hpField.y + HP_FIELD_TO_HP_BAR_OFFSET;
         this._canUseCachedVisibility = true;
         this.layoutExtended(_loc2_ - _loc6_);
      }
      
      private function showAltActionMarker(param1:Boolean) : void
      {
         if(param1 && this._objectiveActionMarker != null && this._objectiveActionMarker != Values.EMPTY_STR)
         {
            this.actionMarker.showAction(this._objectiveActionMarker);
         }
         else if(this._lastActionState == null)
         {
            this.actionMarker.stopAction(false);
         }
         else if(this._lastActionState != null && this._objectiveActionMarker != null && this._objectiveActionMarker != Values.EMPTY_STR)
         {
            this.actionMarker.showAction(this._lastActionState,true);
         }
      }
      
      private function updateExplosionLayout() : void
      {
         this.hitExplosion.x = this.healthBar.x + EXPLOSION_HORIZONTAL_OFFSET | 0;
      }
      
      private function updateCriticalLayout() : void
      {
         var _loc1_:HealthBarAnimatedLabel = null;
         if(this.playerHitLabel.visible && this.playerHitLabel.isActive())
         {
            _loc1_ = this.playerHitLabel;
         }
         else if(this.squadHitLabel.visible && this.squadHitLabel.isActive())
         {
            _loc1_ = this.squadHitLabel;
         }
         else if(this.otherHitLabel.visible && this.otherHitLabel.isActive())
         {
            _loc1_ = this.otherHitLabel;
         }
         var _loc2_:int = Boolean(_loc1_) ? int(_loc1_.damageLabel.textWidth) : int(0);
         var _loc3_:int = Boolean(_loc1_) ? int(BLOCK_HORIZONTAL_OFFSET) : int(START_HORIZONTAL_OFFSET);
         this.criticalHit.x = this.playerHitLabel.x + _loc2_ + _loc3_ | 0;
         this.criticalHitLabel.x = this.criticalHit.x + EXPLOSION_SIZE | 0;
      }
      
      private function makeColorSchemeName() : void
      {
         this._markerSchemeName = (!!this.vehicleDestroyed ? this.vmDeadPrefix : this.vmPrefix) + this._entityName;
         this._debuffSchemeName = this.vmDebuffPrefix + this._entityName + this.vmDebuffPostfix;
         this._buffSchemeName = this.vmBuffPrefix + this._entityName + this.vmBuffPostfix;
      }
      
      private function updateVehicleMarkerHover() : void
      {
         var _loc2_:VehicleMarkerPart = null;
         var _loc3_:Boolean = false;
         var _loc4_:String = null;
         var _loc1_:Boolean = false;
         for each(_loc2_ in this._insertedPartsSorted)
         {
            if(_loc2_.part.visible)
            {
               _loc1_ = true;
               break;
            }
         }
         _loc3_ = true;
         if(_loc1_ && !this.actionMarker.isVisible())
         {
            _loc3_ = false;
         }
         if(this._entityType == VehicleMarkersConstants.ENTITY_TYPE_ENEMY)
         {
            if(this.vmManager.isColorBlind)
            {
               _loc4_ = !!_loc3_ ? LABEL_COLOR_BLIND_HOVER : LABEL_COLOR_BLIND_HOVER_NO_PING;
            }
            else
            {
               _loc4_ = !!_loc3_ ? LABEL_ENEMY_HOVER : LABEL_ENEMY_HOVER_NO_PING;
            }
         }
         else if(this._markerSchemeName == SCHEME_NAME_SQUADMAN)
         {
            _loc4_ = !!_loc3_ ? LABEL_PLATOON_HOVER : LABEL_PLATOON_HOVER_NO_PING;
         }
         else
         {
            _loc4_ = !!_loc3_ ? LABEL_ALLY_HOVER : LABEL_ALLY_HOVER_NO_PING;
         }
         this.vehicleMarkerHoverMC.gotoAndStop(_loc4_);
      }
      
      protected function updateMarkerSettings() : void
      {
         this.layoutParts(this.updatePartsVisibility());
         this.redrawParts();
         this.updateVehicleMarkerHover();
      }
      
      private function updateMarkerColor() : void
      {
         var _loc1_:String = this.vmManager.getAliasColor(this._markerSchemeName);
         if(this._markerColor == _loc1_)
         {
            return;
         }
         this._markerColor = _loc1_;
         this.applyColor();
         if(this.model.vClass)
         {
            this.setVehicleType();
         }
         this.setMarkerState(this._markerState);
         this.updateIconColor();
      }
      
      protected function applyColor() : void
      {
         var _loc1_:ColorTransform = null;
         this.healthBar.color = this._markerColor;
         if(this.isObserver)
         {
            _loc1_ = this.vmManager.getTransform(this._markerSchemeName);
            this.healthBar.transform.colorTransform = _loc1_;
            this.playerHitLabel.transform.colorTransform = _loc1_;
            this.squadHitLabel.transform.colorTransform = _loc1_;
            this.otherHitLabel.transform.colorTransform = _loc1_;
         }
      }
      
      private function prepareLayout() : void
      {
         var _loc1_:Array = null;
         var _loc3_:VehicleMarkerPart = null;
         this.prepareOffsets();
         this.markerParts = new Vector.<VehicleMarkerPart>();
         _loc1_ = this.prepareParts();
         var _loc2_:Vector.<CrossOffset> = this.prepareCrossOffsets();
         var _loc4_:int = _loc1_.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = new VehicleMarkerPart(_loc1_[_loc5_],this.offsets[_loc5_],_loc2_[_loc5_]);
            this.markerParts.push(_loc3_);
            _loc5_++;
         }
         this.updateExplosionLayout();
      }
      
      private function setMarkerState(param1:String) : void
      {
         var _loc2_:uint = 0;
         this._markerState = param1;
         this.vehicleDestroyed = this._markerState == STATE_DEAD || this._markerState == STATE_IMMEDIATE_DEAD;
         this.makeColorSchemeName();
         if(initialized)
         {
            this.setVehicleType();
            _loc2_ = this.vmManager.getRGB(this._markerSchemeName);
            if(!isNaN(_loc2_))
            {
               this.playerNameField.textColor = _loc2_;
               this.vehicleNameField.textColor = _loc2_;
            }
            if(!StringUtils.isEmpty(this._markerState))
            {
               this._canUseCachedVisibility = false;
               if(this.vehicleDestroyed)
               {
                  this.actionMarker.stopAction();
                  this.updateIconColor();
                  this.setDestroyedColorForHP();
                  if(this._markerState == STATE_IMMEDIATE_DEAD)
                  {
                     this.playerHitLabel.transform.colorTransform = this.squadHitLabel.transform.colorTransform = this.otherHitLabel.transform.colorTransform = this.vmManager.getTransform(this._markerSchemeName);
                  }
               }
               this.updateMarkerSettings();
               if(!this._vehicleDestroyedAlready)
               {
                  this.marker.gotoAndPlay(this._markerState);
               }
            }
            if(!this.vehicleDestroyed)
            {
               this.updateEffectColor();
            }
            this._vehicleDestroyedAlready = this._vehicleDestroyedAlready || this.vehicleDestroyed;
         }
      }
      
      private function setDestroyedColorForHP() : void
      {
         this.hpField.textColor = !!this.isObserver ? uint(this.vmManager.getRGB(this._markerSchemeName)) : uint(VEHICLE_DESTROY_COLOR);
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
               _loc1_ = this.model.currHealth + SLASH_STRING + this.model.maxHealth;
               break;
            case HPDisplayMode.CURRENT:
               _loc1_ = this.model.currHealth.toString();
               break;
            default:
               _loc1_ = Values.EMPTY_STR;
         }
         this.hpField.text = _loc1_;
         if(this.getIsPartVisible(HEALTH_LBL) && !this.getIsPartVisible(HEALTH_BAR))
         {
            this.hpField.x = -(this.hpField.width >> 1);
         }
      }
      
      private function setVehicleType() : void
      {
         var _loc1_:String = null;
         if(this.isObserver)
         {
            this.marker.vehicleTypeIcon.transform.colorTransform = this.vmManager.getTransform(this._markerSchemeName);
         }
         if(this._vehicleDestroyedAlready)
         {
            return;
         }
         if(!this.vehicleDestroyed && this.model.speaking)
         {
            _loc1_ = VMAtlasItemName.SPEAKING_ICON;
         }
         else
         {
            _loc1_ = VMAtlasItemName.getVehicleTypeIconName(this._markerColor,this.model.vClass,this.model.hunt);
         }
         this.vmManager.drawWithCenterAlign(_loc1_,this.marker.vehicleTypeIcon.graphics,true,false,0,V_TYPE_ICON_Y);
      }
      
      private function updateIconColor() : void
      {
         this.vehicleIcon.transform.colorTransform = this.vmManager.getTransform(this._markerSchemeName);
         this.levelIcon.alpha = !!this.vehicleDestroyed ? Number(LEVEL_ICON_ALPHA_DESTROYED) : Number(LEVEL_ICON_ALPHA_ALIVE);
      }
      
      private function setupSquadIcon() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         if(this.model.squadIndex)
         {
            _loc1_ = this.vmManager.getAliasColor(this._markerSchemeName);
            _loc2_ = VMAtlasItemName.getSquadIconName(_loc1_,this.model.squadIndex);
            this.vmManager.drawWithCenterAlign(_loc2_,this.squadIcon.graphics,true,false);
         }
      }
      
      private function getHealthPercents() : int
      {
         var _loc1_:int = Math.ceil(this.model.currHealth * this._maxHealthMult);
         return _loc1_ <= MAX_HEALTH_PERCENT ? int(_loc1_) : int(MAX_HEALTH_PERCENT);
      }
      
      private function setupVehicleIcon() : void
      {
         var _loc1_:Array = this.model.vIconSource.split(SLASH);
         var _loc2_:String = _loc1_[_loc1_.length - 1].replace(PNG_EXT,Values.EMPTY_STR);
         this.vmManager.drawWithCenterAlign(_loc2_,this.vehicleIcon.graphics,true,false);
         this.updateIconColor();
      }
      
      private function updateFlag() : void
      {
         if(this._isFlagShown)
         {
            if(this._entityType == VehicleMarkersConstants.ENTITY_TYPE_ALLY)
            {
               this.marker2.showGreen();
            }
            else if(this._entityType == VehicleMarkersConstants.ENTITY_TYPE_ENEMY)
            {
               if(this.vmManager.isColorBlind)
               {
                  this.marker2.showPurple();
               }
               else
               {
                  this.marker2.showRed();
               }
            }
         }
         else
         {
            this.marker2.hide();
         }
      }
      
      private function getDamageColor(param1:uint) : String
      {
         if(this.isObserver)
         {
            return DEFAULT_DAMAGE_COLOR;
         }
         var _loc2_:Object = VehicleMarkerFlags.DAMAGE_FROM_COLORS[param1];
         return _loc2_[this._markerColor];
      }
      
      private function cleanupDynamicObject(param1:Object) : Object
      {
         var _loc3_:* = undefined;
         var _loc2_:Array = [];
         for(_loc3_ in param1)
         {
            _loc2_.push(_loc3_);
         }
         for each(_loc3_ in _loc2_)
         {
            delete param1[_loc3_];
         }
         _loc2_.splice(0,_loc2_.length);
         return null;
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
            _loc1_ = this.vmManager.markerSettings[STATE_DEAD];
         }
         else
         {
            _loc1_ = this.vmManager.markerSettings[this.entityType];
         }
         return _loc1_;
      }
      
      public function set markerSettings(param1:Object) : void
      {
         this._markerSettingsOverride = param1;
      }
      
      public function get isEnabledExInfo() : Boolean
      {
         var _loc1_:String = MARKER + (!!this.exInfo ? ALT : BASE) + DEAD;
         return this.markerSettings[_loc1_];
      }
      
      public function get exInfo() : Boolean
      {
         return this._exInfoOverride || this.vmManager.showExInfo;
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
         this.model.entityName = this._entityName;
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
      
      protected function get vmPrefix() : String
      {
         return VM_PREFIX;
      }
      
      protected function get vmDeadPrefix() : String
      {
         return VM_DEAD_PREFIX;
      }
      
      protected function get vmDebuffPrefix() : String
      {
         return VM_DEBUFF_PREFIX;
      }
      
      protected function get vmBuffPrefix() : String
      {
         return VM_BUFF_PREFIX;
      }
      
      protected function get vmBuffPostfix() : String
      {
         return VM_BUFF_POSTFIX;
      }
      
      protected function get vmDebuffPostfix() : String
      {
         return VM_DEBUFF_POSTFIX;
      }
      
      protected function get damageType() : String
      {
         return this._damageType;
      }
      
      protected function get markerColor() : String
      {
         return this._markerColor;
      }
      
      private function get isObserver() : Boolean
      {
         return this._markerSchemeName.indexOf(OBSERVER_SCHEME_NAME) != -1;
      }
      
      private function onShowExInfoHandler(param1:VehicleMarkersManagerEvent) : void
      {
         this._extInfoShow = this.vmManager.showExInfo;
         this.showAltActionMarker(this.exInfo);
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
         if(this.vehicleDestroyed || this.model.currHealth <= 0)
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
