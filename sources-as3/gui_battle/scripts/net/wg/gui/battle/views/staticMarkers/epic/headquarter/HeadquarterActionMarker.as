package net.wg.gui.battle.views.staticMarkers.epic.headquarter
{
   import flash.display.MovieClip;
   import flash.geom.Point;
   import net.wg.gui.battle.views.actionMarkers.ActionMarkerStates;
   import net.wg.gui.battle.views.actionMarkers.BaseActionMarker;
   import net.wg.gui.battle.views.staticMarkers.epic.ObjectiveIdReplyState;
   import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersManager;
   
   public class HeadquarterActionMarker extends BaseActionMarker
   {
      
      private static const ARROW_POSITION:Point = new Point(0,0);
      
      private static const REPLY_POSITION:Point = new Point(25,-1);
      
      private static const DISTANCE_POSITION:Point = new Point(-43,15);
      
      private static const ENEMY_COLORBLIND:String = "colorblind";
      
      private static const ENEMY:String = "enemy";
      
      private static const ALLY:String = "ally";
      
      private static const LABEL_LIVE:String = "live";
      
      private static const LABEL_DEAD:String = "death";
      
      private static const LABEL_HIT_PIERCED:String = "hit_pierced";
       
      
      public var hqID:ObjectiveIdReplyState = null;
      
      public var clickAnim:HeadquarterAnimation = null;
      
      public var highlightAnim:HeadquarterAnimation = null;
      
      public var markerStates:HeadquarterLifeStates = null;
      
      public var bg:MovieClip = null;
      
      public var hoverShadow:MovieClip = null;
      
      private var _hqType:String = "";
      
      private var _count:int = 0;
      
      private var _showHighlight:Boolean = false;
      
      private var _hitFlag:String = "";
      
      private var _lastActiveState:int = 3;
      
      private var _vmManager:VehicleMarkersManager;
      
      private var _isPlayerTeam:Boolean = false;
      
      public function HeadquarterActionMarker()
      {
         this._vmManager = VehicleMarkersManager.getInstance();
         super();
         this._hitFlag = LABEL_LIVE;
         this.deactivateAttackAndDefendStates();
      }
      
      override public function setReplyCount(param1:int) : void
      {
         super.setReplyCount(param1);
         this._count = param1;
      }
      
      override protected function onDispose() : void
      {
         this.hqID.dispose();
         this.hqID = null;
         this.clickAnim.dispose();
         this.clickAnim = null;
         this.highlightAnim.dispose();
         this.highlightAnim = null;
         this.markerStates.dispose();
         this.markerStates = null;
         this.bg = null;
         this.hoverShadow = null;
         this._vmManager = null;
         super.onDispose();
      }
      
      public function activateHover(param1:Boolean) : void
      {
         this.hoverShadow.visible = param1;
      }
      
      public function deactivateAttackAndDefendStates() : void
      {
         this.clickAnim.visible = false;
         this.highlightAnim.visible = false;
         this.markerStates.visible = false;
         this.bg.visible = false;
         this.hoverShadow.visible = false;
         this.hqID.visible = false;
      }
      
      public function setActiveState(param1:int) : void
      {
         this._lastActiveState = param1;
         if(param1 == ActionMarkerStates.NEUTRAL)
         {
            this.deactivateAttackAndDefendStates();
            this._showHighlight = true;
            return;
         }
         this.markerStates.visible = true;
         this.hqID.visible = true;
         this.highlightAnim.visible = this._count == 0;
         if(this._count == 0 && this._showHighlight)
         {
            this.highlightAnim.gotoAndStop(this._hitFlag);
            this.highlightAnim.playAnimation();
            this._showHighlight = false;
         }
         else if(this._count >= 1)
         {
            this._showHighlight = false;
         }
         if(this._hitFlag == LABEL_DEAD)
         {
            this.markerStates.visible = false;
            this.hqID.visible = false;
         }
         else
         {
            this.markerStates.setActiveState(this._hitFlag,param1);
            this.hqID.setActiveState(param1,id);
         }
      }
      
      public function setColor() : void
      {
         if(this._isPlayerTeam)
         {
            this._hqType = ALLY;
         }
         else if(this._vmManager.isColorBlind)
         {
            this._hqType = ENEMY_COLORBLIND;
         }
         else
         {
            this._hqType = ENEMY;
         }
         gotoAndStop(this._hqType);
         this.setActiveState(this._lastActiveState);
      }
      
      public function setHit() : void
      {
         this._hitFlag = LABEL_HIT_PIERCED;
         this.setActiveState(this._lastActiveState);
      }
      
      public function setOwningTeam(param1:Boolean) : void
      {
         this._isPlayerTeam = param1;
         this.setColor();
         this.hqID.visible = true;
         this.bg.visible = true;
      }
      
      public function triggerClickAnimation() : void
      {
         this.clickAnim.visible = true;
         this.clickAnim.gotoAndStop(this._hitFlag);
         this.clickAnim.playAnimation();
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
   }
}
