package net.wg.gui.battle.views.staticMarkers.halloween
{
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.actionMarkers.ActionMarkerStates;
   import net.wg.gui.battle.views.staticMarkers.epic.sectorbase.SectorBaseActions;
   import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersManager;
   import net.wg.gui.battle.views.vehicleMarkers.events.VehicleMarkersManagerEvent;
   
   public class HWBaseMarker extends BattleUIComponent
   {
      
      private static const INACTIVE_ALPHA_VALUE:Number = 0.75;
      
      private static const NONE:String = "none";
       
      
      public var actionMarker:SectorBaseActions = null;
      
      public var marker:HWSectorBaseIcon = null;
      
      private var _alphaVal:Number = 1;
      
      private var _activeMarkerState:int = -1;
      
      private var _activateHover:Boolean = false;
      
      private var _vmManager:VehicleMarkersManager = null;
      
      private var _isEpic:Boolean = true;
      
      private var _owningTeam:String = "none";
      
      private var _attackingTeam:String = "none";
      
      public function HWBaseMarker()
      {
         super();
         this.marker.visible = true;
         this.marker.targetHighlight.visible = false;
         this.marker.activateEpicVisibility();
         this._vmManager = VehicleMarkersManager.getInstance();
         this._vmManager.addEventListener(VehicleMarkersManagerEvent.UPDATE_COLORS,this.onUpdateColorsHandler);
      }
      
      public function setTeamStatus(param1:String, param2:String = "none") : void
      {
         this._owningTeam = param1;
         this._attackingTeam = param2;
         this.marker.setOwningTeam(param1,param2);
         this.actionMarker.initializeBase(param1);
         this.setIsEpicMarker(true);
      }
      
      public function setColorBlind(param1:Boolean) : void
      {
         this.marker.isHudElement = param1;
      }
      
      private function onUpdateColorsHandler(param1:VehicleMarkersManagerEvent) : void
      {
         this.marker.setCorrectColor();
         this.marker.setHoverColor();
         this.actionMarker.setBaseColor();
         invalidateData();
      }
      
      override protected function onDispose() : void
      {
         this._vmManager.removeEventListener(VehicleMarkersManagerEvent.UPDATE_COLORS,this.onUpdateColorsHandler);
         this._vmManager = null;
         this.marker.dispose();
         this.marker = null;
         this.actionMarker.dispose();
         this.actionMarker = null;
         super.onDispose();
      }
      
      public function notifyVehicleInCircle(param1:Boolean) : void
      {
         if(param1)
         {
            this.alpha = 0;
         }
         else
         {
            this.alpha = this._alphaVal;
         }
      }
      
      public function setCapturePoints(param1:Number) : void
      {
         this.marker.setCapturePoints(param1);
      }
      
      public function setActive(param1:Boolean) : void
      {
         if(this._isEpic)
         {
            if(param1)
            {
               this.marker.targetHighlight.visible = true;
               this._alphaVal = 1;
               this.alpha = this._alphaVal;
            }
            else
            {
               this.marker.targetHighlight.visible = false;
               this._alphaVal = INACTIVE_ALPHA_VALUE;
               this.alpha = this._alphaVal;
            }
         }
      }
      
      public function setIdentifier(param1:int) : void
      {
         this.marker.setBaseId(param1);
         this.actionMarker.setIdentifier(param1);
      }
      
      public function setIsEpicMarker(param1:Boolean) : void
      {
         this._isEpic = param1;
         this.actionMarker.activateEpicVisibility(param1);
         if(this._isEpic)
         {
            this.actionMarker.deactivateAttackAndDefendStates();
            this.marker.activateEpicVisibility();
         }
      }
      
      public function setActiveState(param1:int) : void
      {
         this._activeMarkerState = param1;
         invalidateData();
      }
      
      public function activateHover(param1:Boolean) : void
      {
         this._activateHover = param1;
         invalidateData();
      }
      
      public function setMarkerReplied(param1:Boolean) : void
      {
         this.actionMarker.setMarkerReplied(param1);
      }
      
      public function triggerClickAnimation() : void
      {
         this.actionMarker.triggerClickAnimation();
      }
      
      public function setReplyCount(param1:int) : void
      {
         this.actionMarker.setReplyCount(param1);
      }
      
      public function showReplyMarker(param1:Boolean) : void
      {
         this.actionMarker.visible = param1;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.marker.visible = this._activeMarkerState == ActionMarkerStates.NEUTRAL || this._isEpic;
            this.marker.setActiveState(this._activeMarkerState);
            this.actionMarker.setActiveState(this._activeMarkerState);
            this.actionMarker.activateHover(this._activateHover);
         }
      }
   }
}
