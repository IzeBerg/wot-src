package net.wg.gui.battle.views.staticMarkers.epic.headquarter
{
   import flash.display.MovieClip;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.actionMarkers.ActionMarkerStates;
   import net.wg.gui.battle.views.vehicleMarkers.HPFieldContainer;
   import net.wg.gui.battle.views.vehicleMarkers.HealthBar;
   import net.wg.gui.battle.views.vehicleMarkers.HealthBarAnimatedLabel;
   import net.wg.gui.battle.views.vehicleMarkers.VO.VehicleMarkerFlags;
   import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersConstants;
   import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersManager;
   import net.wg.gui.battle.views.vehicleMarkers.events.VehicleMarkersManagerEvent;
   import scaleform.clik.motion.Tween;
   
   public class HeadquarterMarker extends BattleUIComponent
   {
      
      private static const SEPARATOR:String = " / ";
      
      private static const FIRST_FRAME:int = 1;
      
      private static const HQ_DESTROYED_TWEEN_LENGTH:int = 500;
      
      private static const HQ_DESTROYED_TWEEN_DELAY_LENGTH:int = 1000;
      
      private static const HIT_LABEL_X_OFFSET:int = 41;
      
      private static const DAMAGE_FROM_ENEMY:int = 3;
      
      private static const HOVER_HIT_LABEL_Y_OFFSET:int = 27;
      
      private static const HOVER_HP_FIELD_CONTAINER_Y_OFFSET:int = 32;
      
      private static const HOVER_HEALTH_BAR_Y_OFFSET:int = 35;
      
      private static const HOVER_HEALTH_BAR_SHADOW_Y_OFFSET:int = 81;
      
      private static const HIT_LABEL_Y_OFFSET:int = 20;
      
      private static const HP_FIELD_CONTAINER_Y_OFFSET:int = 25;
      
      private static const HEALTH_BAR_Y_OFFSET:int = 28;
      
      private static const HEALTH_BAR_SHADOW_Y_OFFSET:int = 74;
       
      
      public var actionMarker:HeadquarterActionMarker = null;
      
      public var marker:HeadquarterIcon = null;
      
      public var hpFieldContainer:HPFieldContainer = null;
      
      public var hitLabel:HealthBarAnimatedLabel = null;
      
      public var healthBar:HealthBar = null;
      
      public var healthBarShadow:MovieClip = null;
      
      public var bgShadow:MovieClip = null;
      
      private var _headquarterDestroyed:Boolean = false;
      
      private var _currentHealth:Number = -1;
      
      private var _maxHealth:int = -1;
      
      private var _markerColor:String = "red";
      
      private var _activeMarkerState:int = -1;
      
      private var _activateHover:Boolean = false;
      
      private var _isPlayerTeam:Boolean = false;
      
      private var _healthBarVisible:Boolean = true;
      
      private var _isHighlighted:Boolean = false;
      
      private var _vmManager:VehicleMarkersManager = null;
      
      public function HeadquarterMarker()
      {
         super();
         this.marker.visible = true;
         this.marker.targetHighlight.visible = false;
         this.hpFieldContainer.visible = true;
         this.hpFieldContainer.setWithBarType(true);
         this.healthBar.visible = true;
         this.bgShadow.visible = true;
         this._vmManager = VehicleMarkersManager.getInstance();
         this._vmManager.addEventListener(VehicleMarkersManagerEvent.UPDATE_COLORS,this.onUpdateColorsHandler);
      }
      
      private function onUpdateColorsHandler(param1:VehicleMarkersManagerEvent) : void
      {
         this.setHealthColor();
         this.actionMarker.setColor();
         this.marker.setColor();
         invalidateData();
      }
      
      override protected function onDispose() : void
      {
         this._vmManager.removeEventListener(VehicleMarkersManagerEvent.UPDATE_COLORS,this.onUpdateColorsHandler);
         this._vmManager = null;
         this.hpFieldContainer.dispose();
         this.hpFieldContainer = null;
         this.hitLabel.dispose();
         this.hitLabel = null;
         this.healthBar.dispose();
         this.healthBar = null;
         this.healthBarShadow = null;
         this.bgShadow = null;
         this.actionMarker.stop();
         this.actionMarker.dispose();
         this.actionMarker = null;
         this.marker.dispose();
         this.marker = null;
         super.onDispose();
      }
      
      public function setReplyCount(param1:int) : void
      {
         this.actionMarker.setReplyCount(param1);
      }
      
      public function setMarkerReplied(param1:Boolean) : void
      {
         this.actionMarker.setMarkerReplied(param1);
      }
      
      public function triggerClickAnimation() : void
      {
         this.actionMarker.triggerClickAnimation();
      }
      
      public function setDead(param1:Boolean) : void
      {
         var _loc2_:Tween = null;
         if(this._headquarterDestroyed == param1)
         {
            return;
         }
         this._headquarterDestroyed = param1;
         if(this._headquarterDestroyed)
         {
            _loc2_ = new Tween(HQ_DESTROYED_TWEEN_LENGTH,this.healthBar,{"alpha":0},{
               "delay":HQ_DESTROYED_TWEEN_DELAY_LENGTH,
               "onComplete":this.hideHealthBar
            });
         }
         else
         {
            gotoAndStop(FIRST_FRAME);
            this.healthBar.visible = true;
         }
         this.marker.setDead(this._headquarterDestroyed);
      }
      
      public function setHealth(param1:Number, param2:int = 3, param3:Boolean = true) : void
      {
         var _loc4_:int = 0;
         var _loc5_:String = null;
         if(!this._headquarterDestroyed)
         {
            _loc4_ = this._currentHealth - param1;
            this._currentHealth = param1;
            _loc5_ = VehicleMarkerFlags.DAMAGE_FROM[param2];
            this.healthBar.updateHealth(param1,VehicleMarkerFlags.DAMAGE_COLOR[_loc5_][this._markerColor]);
            this.hpFieldContainer.setText(int(param1) + SEPARATOR + this._maxHealth);
            if(_loc4_ > 0)
            {
               this.marker.setHit(param3);
               this.actionMarker.setHit(param3);
               this.hitLabel.x = HIT_LABEL_X_OFFSET;
               this.hitLabel.damage(_loc4_,VehicleMarkerFlags.DAMAGE_COLOR[_loc5_][this._markerColor]);
               this.hitLabel.playShowTween();
            }
         }
      }
      
      public function setHighlight(param1:Boolean) : void
      {
         this.marker.targetHighlight.visible = param1;
         this._isHighlighted = param1;
         this.setHealthComponentVisibility(true);
         invalidateData();
      }
      
      public function setIsStickyAndOutOfScreen(param1:Boolean) : void
      {
         if(this._healthBarVisible)
         {
            this.healthBar.visible = !param1;
            this.healthBarShadow.visible = !param1;
            this.hpFieldContainer.visible = !param1;
            this.hitLabel.visible = !param1;
         }
      }
      
      public function setIdentifier(param1:int) : void
      {
         this.marker.setHeadquarterId(param1);
         this.actionMarker.setIdentifier(param1);
      }
      
      public function setMaxHealth(param1:Number) : void
      {
         if(!this._headquarterDestroyed)
         {
            this.healthBar.maxHealth = param1;
            this.healthBar.currHealth = param1;
            this._maxHealth = param1;
         }
      }
      
      public function setOwningTeam(param1:Boolean) : void
      {
         this._isPlayerTeam = param1;
         this.marker.setOwningTeam(param1);
         this.actionMarker.setOwningTeam(param1);
         this.setHealthColor();
      }
      
      private function setHealthColor() : void
      {
         if(this._isPlayerTeam)
         {
            this._markerColor = VehicleMarkersConstants.COLOR_GREEN;
         }
         else if(this._vmManager.isColorBlind)
         {
            this._markerColor = VehicleMarkersConstants.COLOR_PURPLE;
         }
         else
         {
            this._markerColor = VehicleMarkersConstants.COLOR_RED;
         }
         this.healthBar.color = this._markerColor;
      }
      
      public function setTarget() : void
      {
         this.actionMarker.play();
      }
      
      private function hideHealthBar() : void
      {
         this.setHealthComponentVisibility(false);
      }
      
      private function setHealthComponentVisibility(param1:Boolean) : void
      {
         this._healthBarVisible = param1;
         this.hitLabel.visible = param1;
         this.hpFieldContainer.visible = param1;
         this.healthBar.visible = param1;
         this.healthBarShadow.visible = param1;
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
      
      private function setHealthBarHeight(param1:Boolean) : void
      {
         if(param1)
         {
            this.hitLabel.y = HOVER_HIT_LABEL_Y_OFFSET;
            this.hpFieldContainer.y = HOVER_HP_FIELD_CONTAINER_Y_OFFSET;
            this.healthBar.y = HOVER_HEALTH_BAR_Y_OFFSET;
            this.healthBarShadow.y = HOVER_HEALTH_BAR_SHADOW_Y_OFFSET;
         }
         else
         {
            this.hitLabel.y = HIT_LABEL_Y_OFFSET;
            this.hpFieldContainer.y = HP_FIELD_CONTAINER_Y_OFFSET;
            this.healthBar.y = HEALTH_BAR_Y_OFFSET;
            this.healthBarShadow.y = HEALTH_BAR_SHADOW_Y_OFFSET;
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.marker.activateHover(this._activateHover);
            this.setHealthBarHeight(this._activateHover || this._activeMarkerState == ActionMarkerStates.REPLIED_ME || this._isHighlighted);
            this.actionMarker.setActiveState(this._activeMarkerState);
            this.actionMarker.activateHover(this._activateHover);
         }
      }
   }
}
