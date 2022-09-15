package net.wg.gui.battle.views.vehicleMarkers
{
   import flash.events.Event;
   import flash.utils.Dictionary;
   import net.wg.data.constants.generated.BATTLE_MARKER_STATES;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.vehicleMarkers.events.StatusAnimationEvent;
   import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleAnimatedStatusBaseMarker;
   import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleBerserkerMarker;
   import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleEngineerEffectMarker;
   import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleFLBasicMarker;
   import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleInspireMarker;
   import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleInspireTargetMarker;
   import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleStatusIconMarker;
   import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleStatusMarker;
   import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleStunMarker;
   
   public class VehicleStatusContainerMarker extends BattleUIComponent
   {
      
      private static const BASE_HEIGHT:int = 55;
       
      
      public var stealthMarker:VehicleFLBasicMarker = null;
      
      public var flRegenerationKitMarker:VehicleFLBasicMarker = null;
      
      public var baseEngineerMarker:VehicleEngineerEffectMarker = null;
      
      public var inspireMarker:VehicleInspireMarker = null;
      
      public var inspireTargetMarker:VehicleInspireTargetMarker = null;
      
      public var healMarker:VehicleInspireMarker = null;
      
      public var stunMarker:VehicleStunMarker = null;
      
      public var berserkerMarker:VehicleBerserkerMarker = null;
      
      public var recoveryMarker:VehicleInspireTargetMarker = null;
      
      public var fireCircleMarker:VehicleAnimatedStatusBaseMarker = null;
      
      public var thunderStrikeMarker:VehicleAnimatedStatusBaseMarker = null;
      
      public var adaptationHealthRestoreMarker:VehicleStatusIconMarker = null;
      
      public var shotPassionMarker:VehicleStatusIconMarker = null;
      
      public var statusMarker:VehicleStatusMarker = null;
      
      private var _statusEffectMarkers:Dictionary = null;
      
      private var _activeEffectID:int = -1;
      
      private var _oneShotStatusID:int = -1;
      
      private var _oneShotStatusPriority:int = -1;
      
      public function VehicleStatusContainerMarker()
      {
         super();
         this._statusEffectMarkers = new Dictionary();
         this.setupMarker(BATTLE_MARKER_STATES.STUN_STATE,this.stunMarker);
         this.setupMarker(BATTLE_MARKER_STATES.DEBUFF_STATE,this.stunMarker);
         this.setupMarker(BATTLE_MARKER_STATES.INSPIRING_STATE,this.inspireMarker);
         this.setupMarker(BATTLE_MARKER_STATES.INSPIRED_STATE,this.inspireTargetMarker);
         this.setupMarker(BATTLE_MARKER_STATES.ENGINEER_STATE,this.baseEngineerMarker);
         this.setupMarker(BATTLE_MARKER_STATES.HEALING_STATE,this.healMarker);
         this.setupMarker(BATTLE_MARKER_STATES.BERSERKER_STATE,this.berserkerMarker);
         this.setupMarker(BATTLE_MARKER_STATES.REPAIRING_STATE,this.recoveryMarker);
         this.setupMarker(BATTLE_MARKER_STATES.STEALTH_STATE,this.stealthMarker);
         this.setupMarker(BATTLE_MARKER_STATES.FL_REGENERATION_KIT_STATE,this.flRegenerationKitMarker);
         this.setupMarker(BATTLE_MARKER_STATES.FIRE_CIRCLE_STATE,this.fireCircleMarker);
         this.setupMarker(BATTLE_MARKER_STATES.THUNDER_STRIKE_STATE,this.thunderStrikeMarker);
         this.setupMarker(BATTLE_MARKER_STATES.SHOT_PASSION_STATE,this.shotPassionMarker);
         this.setupMarker(BATTLE_MARKER_STATES.ADAPTATION_HEALTH_RESTORE_STATE,this.adaptationHealthRestoreMarker);
         this.setupMarker(BATTLE_MARKER_STATES.COMP7_RISKY_ATTACK_STATE,this.statusMarker);
         this.setupMarker(BATTLE_MARKER_STATES.COMP7_RISKY_ATTACK_HEAL_STATE,this.statusMarker);
         this.setupMarker(BATTLE_MARKER_STATES.COMP7_SNIPER_STATE,this.statusMarker);
         this.setupMarker(BATTLE_MARKER_STATES.COMP7_ALLY_SUPPORT_STATE,this.statusMarker);
         this.setupMarker(BATTLE_MARKER_STATES.COMP7_AOE_HEAL_STATE,this.statusMarker);
         this.setupMarker(BATTLE_MARKER_STATES.COMP7_HUNTER_STATE,this.statusMarker);
         this.setupMarker(BATTLE_MARKER_STATES.COMP7_CONCENTRATION_STATE,this.statusMarker);
         this.setupMarker(BATTLE_MARKER_STATES.COMP7_JUGGERNAUT_STATE,this.statusMarker);
         this.setupMarker(BATTLE_MARKER_STATES.COMP7_BERSERK_STATE,this.statusMarker);
         this.setupMarker(BATTLE_MARKER_STATES.COMP7_FAST_RECHARGE_STATE,this.statusMarker);
         this.setupMarker(BATTLE_MARKER_STATES.COMP7_SURE_SHOT_STATE,this.statusMarker);
         this.setupMarker(BATTLE_MARKER_STATES.COMP7_AOE_INSPIRE_STATE,this.statusMarker);
         this.setupMarker(BATTLE_MARKER_STATES.COMP7_ARTYLLERY_SUPPORT_STATE,this.statusMarker);
         this.setupMarker(BATTLE_MARKER_STATES.COMP7_MARCH_STATE,this.statusMarker);
         this.setupMarker(BATTLE_MARKER_STATES.COMP7_AGGRESSIVE_DETECTION_STATE,this.statusMarker);
         this.setupMarker(BATTLE_MARKER_STATES.COMP7_POINT_RECON_STATE,this.statusMarker);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.stunMarker.addEventListener(StatusAnimationEvent.EVENT_HIDDEN,this.onStatusAnimationEventHiddenHandler);
         this.baseEngineerMarker.addEventListener(StatusAnimationEvent.EVENT_HIDDEN,this.onStatusAnimationEventHiddenHandler);
         this.inspireMarker.addEventListener(StatusAnimationEvent.EVENT_HIDDEN,this.onStatusAnimationEventHiddenHandler);
         this.inspireTargetMarker.addEventListener(StatusAnimationEvent.EVENT_HIDDEN,this.onStatusAnimationEventHiddenHandler);
         this.healMarker.addEventListener(StatusAnimationEvent.EVENT_HIDDEN,this.onStatusAnimationEventHiddenHandler);
         this.berserkerMarker.addEventListener(StatusAnimationEvent.EVENT_HIDDEN,this.onStatusAnimationEventHiddenHandler);
         this.recoveryMarker.addEventListener(StatusAnimationEvent.EVENT_HIDDEN,this.onStatusAnimationEventHiddenHandler);
         this.stealthMarker.addEventListener(StatusAnimationEvent.EVENT_HIDDEN,this.onStatusAnimationEventHiddenHandler);
         this.flRegenerationKitMarker.addEventListener(StatusAnimationEvent.EVENT_HIDDEN,this.onStatusAnimationEventHiddenHandler);
         this.fireCircleMarker.addEventListener(StatusAnimationEvent.EVENT_HIDDEN,this.onStatusAnimationEventHiddenHandler);
         this.thunderStrikeMarker.addEventListener(StatusAnimationEvent.EVENT_HIDDEN,this.onStatusAnimationEventHiddenHandler);
         this.shotPassionMarker.addEventListener(StatusAnimationEvent.EVENT_HIDDEN,this.onStatusAnimationEventHiddenHandler);
         this.adaptationHealthRestoreMarker.addEventListener(StatusAnimationEvent.EVENT_HIDDEN,this.onStatusAnimationEventHiddenHandler);
         this.statusMarker.addEventListener(StatusAnimationEvent.EVENT_HIDDEN,this.onStatusAnimationEventHiddenHandler);
         this.stunMarker.setupFrameEvents();
         this.baseEngineerMarker.setupFrameEvents();
         this.inspireMarker.setupFrameEvents();
         this.inspireTargetMarker.setupFrameEvents();
         this.healMarker.setupFrameEvents();
         this.berserkerMarker.setupFrameEvents();
         this.recoveryMarker.setupFrameEvents();
         this.stealthMarker.setupFrameEvents();
         this.flRegenerationKitMarker.setupFrameEvents();
         this.fireCircleMarker.setupFrameEvents();
         this.thunderStrikeMarker.setupFrameEvents();
         this.shotPassionMarker.setupFrameEvents();
         this.adaptationHealthRestoreMarker.setupFrameEvents();
         this.statusMarker.setupFrameEvents();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:* = undefined;
         this.stunMarker.removeEventListener(StatusAnimationEvent.EVENT_HIDDEN,this.onStatusAnimationEventHiddenHandler);
         this.baseEngineerMarker.removeEventListener(StatusAnimationEvent.EVENT_HIDDEN,this.onStatusAnimationEventHiddenHandler);
         this.inspireMarker.removeEventListener(StatusAnimationEvent.EVENT_HIDDEN,this.onStatusAnimationEventHiddenHandler);
         this.inspireTargetMarker.removeEventListener(StatusAnimationEvent.EVENT_HIDDEN,this.onStatusAnimationEventHiddenHandler);
         this.healMarker.removeEventListener(StatusAnimationEvent.EVENT_HIDDEN,this.onStatusAnimationEventHiddenHandler);
         this.berserkerMarker.removeEventListener(StatusAnimationEvent.EVENT_HIDDEN,this.onStatusAnimationEventHiddenHandler);
         this.recoveryMarker.removeEventListener(StatusAnimationEvent.EVENT_HIDDEN,this.onStatusAnimationEventHiddenHandler);
         this.stealthMarker.removeEventListener(StatusAnimationEvent.EVENT_HIDDEN,this.onStatusAnimationEventHiddenHandler);
         this.flRegenerationKitMarker.removeEventListener(StatusAnimationEvent.EVENT_HIDDEN,this.onStatusAnimationEventHiddenHandler);
         this.fireCircleMarker.removeEventListener(StatusAnimationEvent.EVENT_HIDDEN,this.onStatusAnimationEventHiddenHandler);
         this.thunderStrikeMarker.removeEventListener(StatusAnimationEvent.EVENT_HIDDEN,this.onStatusAnimationEventHiddenHandler);
         this.shotPassionMarker.removeEventListener(StatusAnimationEvent.EVENT_HIDDEN,this.onStatusAnimationEventHiddenHandler);
         this.adaptationHealthRestoreMarker.removeEventListener(StatusAnimationEvent.EVENT_HIDDEN,this.onStatusAnimationEventHiddenHandler);
         this.statusMarker.removeEventListener(StatusAnimationEvent.EVENT_HIDDEN,this.onStatusAnimationEventHiddenHandler);
         this.baseEngineerMarker.dispose();
         this.baseEngineerMarker = null;
         this.inspireMarker.dispose();
         this.inspireMarker = null;
         this.stunMarker.dispose();
         this.stunMarker = null;
         this.inspireTargetMarker.dispose();
         this.inspireTargetMarker = null;
         this.healMarker.dispose();
         this.healMarker = null;
         this.berserkerMarker.dispose();
         this.berserkerMarker = null;
         this.recoveryMarker.dispose();
         this.recoveryMarker = null;
         this.stealthMarker.dispose();
         this.stealthMarker = null;
         this.flRegenerationKitMarker.dispose();
         this.flRegenerationKitMarker = null;
         this.fireCircleMarker.dispose();
         this.fireCircleMarker = null;
         this.thunderStrikeMarker.dispose();
         this.thunderStrikeMarker = null;
         this.shotPassionMarker.dispose();
         this.shotPassionMarker = null;
         this.adaptationHealthRestoreMarker.dispose();
         this.adaptationHealthRestoreMarker = null;
         this.statusMarker.dispose();
         this.statusMarker = null;
         for(_loc1_ in this._statusEffectMarkers)
         {
            delete this._statusEffectMarkers[_loc1_];
         }
         this._statusEffectMarkers = null;
         super.onDispose();
      }
      
      public function hideMarker(param1:int, param2:int, param3:Boolean, param4:Boolean) : void
      {
         var _loc5_:VehicleAnimatedStatusBaseMarker = null;
         var _loc6_:VehicleAnimatedStatusBaseMarker = null;
         var _loc7_:VehicleStatusMarker = null;
         var _loc8_:VehicleAnimatedStatusBaseMarker = null;
         this._activeEffectID = param2;
         if(param1 > -1)
         {
            _loc5_ = this.getMarker(param1);
            if(_loc5_)
            {
               _loc5_.hideEffectTimer(param3);
            }
         }
         if(param2 > -1)
         {
            _loc6_ = this.getMarker(param2);
            if(_loc6_)
            {
               if(_loc6_.isAtlasSrcMode())
               {
                  _loc6_.setStatusID(param2);
                  _loc6_.updateAssets();
                  _loc7_ = _loc6_ as VehicleStatusMarker;
                  if(_loc7_)
                  {
                     _loc7_.switchTimerVisible(param4);
                  }
               }
               _loc6_.setVisibility(true);
            }
         }
         else
         {
            for each(_loc8_ in this._statusEffectMarkers)
            {
               _loc8_.setVisibility(false);
            }
         }
      }
      
      public function isVisible() : Boolean
      {
         return this._activeEffectID == -1 ? Boolean(false) : Boolean(this.getMarker(this._activeEffectID).isVisible());
      }
      
      public function setEffectColor(param1:String, param2:uint) : void
      {
         this.stunMarker.setEffectColor(param1,param2);
         this.baseEngineerMarker.setEffectColor(param1,param2);
         this.inspireMarker.setEffectColor(param1,param2);
         this.inspireTargetMarker.setEffectColor(param1,param2);
         this.healMarker.setEffectColor(param1,param2);
         this.berserkerMarker.setEffectColor(param1,param2);
         this.recoveryMarker.setEffectColor(param1,param2);
         this.stealthMarker.setEffectColor(param1,param2);
         this.flRegenerationKitMarker.setEffectColor(param1,param2);
         this.fireCircleMarker.setEffectColor(param1,param2);
         this.thunderStrikeMarker.setEffectColor(param1,param2);
         this.shotPassionMarker.setEffectColor(param1,param2);
         this.adaptationHealthRestoreMarker.setEffectColor(param1,param2);
         this.statusMarker.setEffectColor(param1,param2);
      }
      
      public function setSecondString(param1:String) : void
      {
         this.stunMarker.setSecondString(param1);
         this.inspireMarker.setSecondString(param1);
         this.healMarker.setSecondString(param1);
         this.statusMarker.setSecondString(param1);
      }
      
      public function showMarker(param1:int, param2:int, param3:Boolean, param4:Number, param5:int, param6:int, param7:Boolean = true) : void
      {
         var _loc10_:VehicleAnimatedStatusBaseMarker = null;
         var _loc11_:VehicleAnimatedStatusBaseMarker = null;
         if(param2 > param6)
         {
            return;
         }
         var _loc8_:VehicleAnimatedStatusBaseMarker = this.getMarker(param1);
         var _loc9_:Boolean = false;
         if(this._activeEffectID != -1 && this._activeEffectID != param1)
         {
            _loc10_ = this.getMarker(this._activeEffectID);
            if(_loc10_ != _loc8_)
            {
               _loc10_.setVisibility(false);
            }
            if(param1 != param5)
            {
               if(this._oneShotStatusID != -1 && param2 < this._oneShotStatusPriority)
               {
                  _loc11_ = this.getMarker(this._oneShotStatusID);
                  if(_loc11_)
                  {
                     _loc11_.resetMarkerStates();
                  }
               }
               if(_loc8_)
               {
                  this._oneShotStatusID = param1;
                  this._oneShotStatusPriority = param2;
                  _loc9_ = true;
               }
            }
         }
         if(_loc8_)
         {
            if(_loc8_.isAtlasSrcMode())
            {
               _loc8_.setStatusID(param1);
               _loc8_.updateAssets();
            }
            _loc8_.showEffectTimer(param4,param3,_loc9_,param7);
         }
         this._activeEffectID = param5;
      }
      
      public function updateEffectTimer(param1:int, param2:Number, param3:Boolean = false) : void
      {
         var _loc4_:VehicleAnimatedStatusBaseMarker = this.getMarker(param1);
         if(_loc4_)
         {
            _loc4_.updateEffectTimer(param2,this._activeEffectID == param1,param3);
         }
      }
      
      private function setupMarker(param1:int, param2:VehicleAnimatedStatusBaseMarker) : void
      {
         this._statusEffectMarkers[param1] = param2;
         param2.setStatusID(param1);
      }
      
      private function getMarker(param1:int) : VehicleAnimatedStatusBaseMarker
      {
         return this._statusEffectMarkers[param1];
      }
      
      override public function get height() : Number
      {
         return BASE_HEIGHT;
      }
      
      private function onStatusAnimationEventHiddenHandler(param1:StatusAnimationEvent) : void
      {
         var _loc2_:VehicleAnimatedStatusBaseMarker = null;
         if(param1.isOneShotAnimation)
         {
            this._oneShotStatusID = -1;
            this._oneShotStatusPriority = -1;
         }
         if(this._activeEffectID > -1)
         {
            _loc2_ = this.getMarker(this._activeEffectID);
            if(_loc2_)
            {
               _loc2_.setVisibility(true);
            }
         }
         dispatchEvent(new Event(Event.COMPLETE));
      }
   }
}
