package net.wg.gui.battle.views.vehicleMarkers
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.ColorTransform;
   
   public class EventVehicleMarker extends VehicleMarker
   {
      
      private static const STUN_NAME_PREFIX:String = "event_";
      
      private static const VEHICLE_MARKER_TOP_OFFSET:Number = 7;
      
      private static const PLASMA_DAMAGE:String = "plasmaDamage";
      
      private static const PLASMA_HIT_LABEL_LEFT_OFFSET:int = 2;
      
      private static const PLASMA_ICON_LEFT_OFFSET:int = 0;
      
      private static const PLASMA_ICON_TOP_OFFSET:int = 2;
      
      private static const PLASMA_ICON_RIGHT_OFFSET:int = 5;
      
      private static const HIT_EXPLOSION_LABEL_LEFT_OFFSET:int = 15;
      
      private static const CRITICAL_HIT_LABEL_LEFT_OFFSET:int = 15;
      
      private static const HIT_LABEL_RIGHT_OFFSET:int = 2;
      
      private static const AURA_ENEMY_STATE:String = "enemy";
      
      private static const AURA_ALLY_STATE:String = "ally";
       
      
      public var plasmaBuffMc:MovieClip = null;
      
      public var plasmaHitDamage:EventPlasmaDamageAnimatedLabel = null;
      
      public var auraEffectMc:MovieClip = null;
      
      private var _plasmaDamage:Number = 0;
      
      public function EventVehicleMarker()
      {
         super();
         this.plasmaBuffMc.visible = false;
         this.auraEffectMc.visible = false;
      }
      
      public function setPlasmaBuffValue(param1:Number) : void
      {
         this.plasmaBuffMc.gotoAndStop(param1 + 1);
      }
      
      public function showPlasmaBuff(param1:Boolean) : void
      {
         if(this.plasmaBuffMc.visible == param1)
         {
            return;
         }
         marker.y += VEHICLE_MARKER_TOP_OFFSET;
         this.plasmaBuffMc.visible = param1;
      }
      
      public function showPlasmaDamage(param1:Number) : void
      {
         if(this.plasmaHitDamage.tweenState != VehicleMarkersConstants.HB_ANIMATED_INACTIVE_STATE && this.plasmaHitDamage.tweenState != VehicleMarkersConstants.HB_ANIMATED_IMITATION_STATE)
         {
            this._plasmaDamage += param1;
         }
         else
         {
            this._plasmaDamage = param1;
         }
         this.plasmaHitDamage.setLabel("(" + this._plasmaDamage.toString(),PLASMA_DAMAGE);
         this.updateCriticalLayout();
         this.plasmaHitDamage.playShowTween();
         this.plasmaHitDamage.plasmaIcon.gotoAndPlay(this.plasmaHitDamage.tweenState);
      }
      
      public function showInspireAura(param1:Boolean) : void
      {
         if(this.auraEffectMc.visible == param1)
         {
            return;
         }
         if(param1)
         {
            if(this.isEnemy())
            {
               this.auraEffectMc.gotoAndStop(AURA_ENEMY_STATE);
            }
            else
            {
               this.auraEffectMc.gotoAndStop(AURA_ALLY_STATE);
            }
         }
         this.auraEffectMc.visible = param1;
      }
      
      override protected function updatePartsVisibility() : Vector.<Boolean>
      {
         var _loc1_:Vector.<Boolean> = super.updatePartsVisibility();
         if(this.vehicleDestroyed)
         {
            this.auraEffectMc.visible = false;
         }
         return _loc1_;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.plasmaHitDamage.addEventListener(HealthBarAnimatedPart.SHOW,this.onHitSplashShowHandler);
         this.plasmaHitDamage.addEventListener(HealthBarAnimatedPart.HIDE,this.onHitSplashHideHandler);
         this.setChildIndex(this.auraEffectMc,this.numChildren - 1);
      }
      
      override protected function onDispose() : void
      {
         this.plasmaBuffMc = null;
         this.auraEffectMc = null;
         this.plasmaHitDamage.removeEventListener(HealthBarAnimatedPart.SHOW,this.onHitSplashShowHandler);
         this.plasmaHitDamage.removeEventListener(HealthBarAnimatedPart.HIDE,this.onHitSplashHideHandler);
         if(this.plasmaHitDamage != null)
         {
            this.plasmaHitDamage.dispose();
         }
         this.plasmaHitDamage = null;
         super.onDispose();
      }
      
      override protected function updateEffectColor() : void
      {
         statusContainer.setBuffEffectColor(STUN_NAME_PREFIX + vmManager.getAliasColor(_buffSchemeName),vmManager.getRGB(_buffSchemeName));
         statusContainer.setDebuffEffectColor(STUN_NAME_PREFIX + vmManager.getAliasColor(_debuffSchemeName),vmManager.getRGB(_debuffSchemeName));
      }
      
      override protected function updateCriticalLayout() : void
      {
         var _loc1_:Boolean = playerHitLabel.visible && playerHitLabel.isActive();
         var _loc2_:int = !!_loc1_ ? int(playerHitLabel.damageLabel.textWidth + HIT_LABEL_RIGHT_OFFSET) : int(0);
         this.plasmaHitDamage.x = playerHitLabel.x + _loc2_ + PLASMA_HIT_LABEL_LEFT_OFFSET | 0;
         var _loc3_:Boolean = this.plasmaHitDamage.visible && this.plasmaHitDamage.isActive();
         if(this.plasmaHitDamage.plasmaIcon)
         {
            this.plasmaHitDamage.plasmaIcon.y = PLASMA_ICON_TOP_OFFSET;
            this.plasmaHitDamage.plasmaIcon.x = this.plasmaHitDamage.damageLabel.plasmaDamage.textWidth + PLASMA_ICON_LEFT_OFFSET | 0;
         }
         var _loc4_:int = !!_loc3_ ? int(this.plasmaHitDamage.damageLabel.plasmaDamage.textWidth + this.plasmaHitDamage.plasmaIcon.width + PLASMA_ICON_RIGHT_OFFSET) : int(0);
         criticalHit.x = playerHitLabel.x + _loc2_ + _loc4_ + HIT_EXPLOSION_LABEL_LEFT_OFFSET | 0;
         criticalHitLabel.x = criticalHit.x + CRITICAL_HIT_LABEL_LEFT_OFFSET | 0;
      }
      
      override protected function applyColor() : void
      {
         var _loc1_:ColorTransform = null;
         super.applyColor();
         if(isObserver)
         {
            _loc1_ = vmManager.getTransform(_markerSchemeName);
            this.plasmaHitDamage.transform.colorTransform = _loc1_;
         }
      }
      
      private function onHitSplashShowHandler(param1:Event) : void
      {
         this.plasmaHitDamage.visible = true;
      }
      
      private function onHitSplashHideHandler(param1:Event) : void
      {
         this.plasmaHitDamage.plasmaIcon.gotoAndPlay(1);
         this.plasmaHitDamage.visible = false;
         this._plasmaDamage = 0;
      }
   }
}
