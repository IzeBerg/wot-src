package net.wg.gui.battle.views.staticMarkers.epic.sectorbase
{
   import flash.display.MovieClip;
   import flash.geom.Point;
   import net.wg.gui.battle.views.actionMarkers.ActionMarkerStates;
   import net.wg.gui.battle.views.actionMarkers.BaseActionMarker;
   import net.wg.gui.battle.views.staticMarkers.epic.ObjectiveIdReplyState;
   import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersManager;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class SectorBaseActions extends BaseActionMarker implements IDisposable
   {
      
      private static const ARROW_POSITION:Point = new Point(0,0);
      
      private static const REPLY_POSITION:Point = new Point(25,-1);
      
      private static const DISTANCE_POSITION:Point = new Point(-43,15);
      
      private static const ATTACK:String = "attack";
      
      private static const ATTACK_COLORBLIND:String = "attackColorBlind";
      
      private static const DEFEND:String = "defend";
      
      private static const ENEMY:String = "enemy";
      
      private static const NEUTRAL:String = "neutral";
       
      
      public var clickAnimation:MovieClip = null;
      
      public var highlightAnimation:MovieClip = null;
      
      public var epicBaseID:ObjectiveIdReplyState = null;
      
      public var epicBaseMarker:MovieClip = null;
      
      public var baseMarker:MovieClip = null;
      
      public var hoverShadow:MovieClip = null;
      
      private var _count:int = 0;
      
      private var _showHighlight:Boolean = true;
      
      private var _vmManager:VehicleMarkersManager = null;
      
      private var _baseType:String = "";
      
      private var _baseColor:String = "";
      
      private var _isEpic:Boolean = false;
      
      public function SectorBaseActions()
      {
         super();
         this.deactivateAttackAndDefendStates();
         this._vmManager = VehicleMarkersManager.getInstance();
         this.clickAnimation.visible = false;
      }
      
      override protected function get getReplyPosition() : Point
      {
         return REPLY_POSITION;
      }
      
      override protected function get getArrowPosition() : Point
      {
         return ARROW_POSITION;
      }
      
      override protected function get getDistanceToMarkerPosition() : Point
      {
         return DISTANCE_POSITION;
      }
      
      public function deactivateAttackAndDefendStates() : void
      {
         this.clickAnimation.visible = false;
         this.highlightAnimation.visible = false;
         this.epicBaseID.visible = false;
         this.epicBaseMarker.visible = false;
         this.baseMarker.visible = false;
         this.hoverShadow.visible = false;
      }
      
      override protected function onDispose() : void
      {
         this.clickAnimation.stop();
         this.clickAnimation = null;
         this.highlightAnimation.stop();
         this.highlightAnimation = null;
         this.epicBaseID.dispose();
         this.epicBaseID = null;
         this.epicBaseMarker.stop();
         this.epicBaseMarker = null;
         this.baseMarker.stop();
         this.baseMarker = null;
         this.hoverShadow.stop();
         this.hoverShadow = null;
         this._vmManager = null;
         super.onDispose();
      }
      
      public function triggerClickAnimation() : void
      {
         this.clickAnimation.visible = true;
         this.clickAnimation.play();
      }
      
      public function initializeBase(param1:String) : void
      {
         this._baseType = param1;
         this.setBaseColor();
         this.baseMarker.visible = false;
      }
      
      public function activateEpicVisibility(param1:Boolean) : void
      {
         this._isEpic = param1;
         this.epicBaseID.visible = param1;
         this.epicBaseMarker.visible = param1;
         this.baseMarker.visible = !param1;
      }
      
      public function setBaseColor() : void
      {
         if(this._baseType == ENEMY || this._baseType == NEUTRAL)
         {
            if(this._vmManager.isColorBlind)
            {
               this._baseColor = ATTACK_COLORBLIND;
            }
            else
            {
               this._baseColor = ATTACK;
            }
         }
         else
         {
            this._baseColor = DEFEND;
         }
         gotoAndStop(this._baseColor);
      }
      
      public function activateHover(param1:Boolean) : void
      {
         this.hoverShadow.visible = param1;
      }
      
      public function setActiveState(param1:int) : void
      {
         if(param1 == ActionMarkerStates.NEUTRAL)
         {
            this.deactivateAttackAndDefendStates();
            this._showHighlight = true;
            return;
         }
         gotoAndStop(this._baseColor);
         this.baseMarker.visible = !this._isEpic;
         this.epicBaseID.visible = this._isEpic;
         this.epicBaseMarker.visible = this._isEpic;
         this.highlightAnimation.visible = this._count == 0;
         if(this._count == 0 && this._showHighlight)
         {
            this.highlightAnimation.play();
         }
         else if(this._count >= 1)
         {
            this._showHighlight = false;
            this.highlightAnimation.stop();
         }
         if(this._isEpic)
         {
            this.epicBaseMarker.gotoAndStop(ActionMarkerStates.STATE_INT_TO_STRING[param1]);
            this.epicBaseID.setActiveState(param1,id);
         }
         else
         {
            this.baseMarker.gotoAndStop(ActionMarkerStates.STATE_INT_TO_STRING[param1]);
         }
      }
      
      override public function setReplyCount(param1:int) : void
      {
         this._count = param1;
         super.setReplyCount(param1);
      }
   }
}
