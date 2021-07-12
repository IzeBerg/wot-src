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
   import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleInspireMarker;
   import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleInspireTargetMarker;
   import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleStunMarker;
   
   public class VehicleStatusContainerMarker extends BattleUIComponent
   {
      
      private static const BASE_HEIGHT:int = 55;
       
      
      public var baseEngineerMarker:VehicleEngineerEffectMarker = null;
      
      public var inspireMarker:VehicleInspireMarker = null;
      
      public var inspireTargetMarker:VehicleInspireTargetMarker = null;
      
      public var healMarker:VehicleInspireMarker = null;
      
      public var stunMarker:VehicleStunMarker = null;
      
      public var berserkerMarker:VehicleBerserkerMarker = null;
      
      public var recoveryMarker:VehicleInspireTargetMarker = null;
      
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
         this.stunMarker.setupFrameEvents();
         this.baseEngineerMarker.setupFrameEvents();
         this.inspireMarker.setupFrameEvents();
         this.inspireTargetMarker.setupFrameEvents();
         this.healMarker.setupFrameEvents();
         this.berserkerMarker.setupFrameEvents();
         this.recoveryMarker.setupFrameEvents();
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
         for(_loc1_ in this._statusEffectMarkers)
         {
            delete this._statusEffectMarkers[_loc1_];
         }
         this._statusEffectMarkers = null;
         super.onDispose();
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
      }
      
      public function setSecondString(param1:String) : void
      {
         this.stunMarker.setSecondString(param1);
         this.inspireMarker.setSecondString(param1);
         this.healMarker.setSecondString(param1);
      }
      
      public function hideMarker(param1:int, param2:int, param3:Boolean) : void
      {
         var _loc4_:VehicleAnimatedStatusBaseMarker = null;
         var _loc5_:VehicleAnimatedStatusBaseMarker = null;
         var _loc6_:VehicleAnimatedStatusBaseMarker = null;
         this._activeEffectID = param2;
         if(param1 > -1)
         {
            _loc4_ = this.getMarker(param1);
            if(_loc4_)
            {
               _loc4_.hideEffectTimer(param3);
            }
         }
         if(param2 > -1)
         {
            _loc5_ = this.getMarker(param2);
            if(_loc5_)
            {
               _loc5_.setVisibility(true);
            }
         }
         else
         {
            for each(_loc6_ in this._statusEffectMarkers)
            {
               _loc6_.setVisibility(false);
            }
         }
      }
      
      public function showMarker(param1:int, param2:int, param3:Boolean, param4:Number, param5:int, param6:int, param7:Boolean = true) : void
      {
         if(param2 > param6)
         {
            return;
         }
         if(this._activeEffectID != -1 && this._activeEffectID != param1)
         {
            this.getMarker(this._activeEffectID).setVisibility(false);
            if(param1 != param5)
            {
               this.showOneshotAnimation(param1,param2,param3,param4,param7);
            }
            else
            {
               this.showEffectTimer(param1,param3,param4,param7);
            }
         }
         else
         {
            this.showEffectTimer(param1,param3,param4,param7);
         }
         this._activeEffectID = param5;
      }
      
      private function showOneshotAnimation(param1:int, param2:int, param3:Boolean, param4:Number, param5:Boolean = true) : void
      {
         var _loc7_:VehicleAnimatedStatusBaseMarker = null;
         if(this._oneShotStatusID != -1 && param2 < this._oneShotStatusPriority)
         {
            _loc7_ = this.getMarker(this._oneShotStatusID);
            if(_loc7_)
            {
               _loc7_.resetMarkerStates();
            }
         }
         var _loc6_:VehicleAnimatedStatusBaseMarker = this.getMarker(param1);
         if(_loc6_)
         {
            this._oneShotStatusID = param1;
            this._oneShotStatusPriority = param2;
            _loc6_.showEffectTimer(param4,param3,true,param5);
         }
      }
      
      private function showEffectTimer(param1:int, param2:Boolean, param3:Number, param4:Boolean = true) : void
      {
         var _loc5_:VehicleAnimatedStatusBaseMarker = this.getMarker(param1);
         if(_loc5_)
         {
            _loc5_.showEffectTimer(param3,param2,false,param4);
         }
      }
      
      public function updateEffectTimer(param1:int, param2:Number, param3:Boolean = false) : void
      {
         var _loc4_:VehicleAnimatedStatusBaseMarker = this.getMarker(param1);
         if(_loc4_)
         {
            _loc4_.updateEffectTimer(param2,this._activeEffectID == param1,param3);
         }
      }
      
      override public function get height() : Number
      {
         return BASE_HEIGHT;
      }
      
      private function setupMarker(param1:int, param2:VehicleAnimatedStatusBaseMarker) : void
      {
         this._statusEffectMarkers[param1] = param2;
         param2.setStatusID(param1);
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
      
      private function getMarker(param1:int) : VehicleAnimatedStatusBaseMarker
      {
         return this._statusEffectMarkers[param1];
      }
   }
}
