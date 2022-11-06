package net.wg.gui.components.crosshairPanel.components.gunMarker
{
   import flash.events.Event;
   import net.wg.data.VO.RunningTimerData;
   import net.wg.gui.components.crosshairPanel.components.gunMarker.constants.GunMarkerConsts;
   
   public class DualGunMarker extends GunMarker implements IGunMarker
   {
      
      public static const INVALID_CHARGE_ACTIVE:String = "invalidChargeActive";
      
      public static const INVALID_CHARGE_PROGRESS:String = "invalidChargeProgress";
      
      public static const INVALID_MARKER_STATE:String = "invalidMarkerState";
       
      
      public var chargeMixing:GunMarkerMixingDualGun;
      
      private var _markerState:int = 0;
      
      private var _chargeIsActive:Boolean = false;
      
      private var _chargeTimerData:RunningTimerData;
      
      public function DualGunMarker()
      {
         super();
         this._chargeTimerData = new RunningTimerData();
      }
      
      override public function setMixingScale(param1:Number) : void
      {
         super.setMixingScale(param1);
         this.chargeMixing.scaleX = this.chargeMixing.scaleY = param1;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(GunMarkerConsts.GUN_MIXING_ALPHA_VALIDATION))
         {
            this.chargeMixing.alpha = radiusMC.alpha;
         }
         if(isInvalid(INVALID_CHARGE_ACTIVE))
         {
            radiusMC.visible = !this._chargeIsActive;
            this.chargeMixing.visible = this._chargeIsActive;
         }
         if(isInvalid(INVALID_CHARGE_PROGRESS))
         {
            this.chargeMixing.setChargeProgress(this._chargeTimerData.elapsedPercent);
            this.chargeMixing.scaleX = radiusMC.scaleX;
            this.chargeMixing.scaleY = radiusMC.scaleY;
            if(this._chargeTimerData.elapsedPercent >= 1)
            {
               this.cancelChargeTimer();
            }
         }
         if(isInvalid(INVALID_MARKER_STATE))
         {
            this.chargeMixing.updateMakerState(this._markerState);
         }
      }
      
      override protected function onDispose() : void
      {
         this.chargeMixing.dispose();
         this.chargeMixing = null;
         this._chargeTimerData = null;
         this.cancelChargeTimer();
         super.onDispose();
      }
      
      public function setMarkerState(param1:int) : void
      {
         if(this._markerState != param1)
         {
            this._markerState = param1;
            invalidate(INVALID_MARKER_STATE);
         }
      }
      
      public function setSpeed(param1:Number) : void
      {
         this._chargeTimerData.setSpeed(param1);
         this.invalidateChargeProgress();
      }
      
      public function startCharging(param1:Number, param2:Number) : void
      {
         var _loc3_:Boolean = param1 > 0;
         this._chargeIsActive = true;
         this._chargeTimerData.update(param1,param2,_loc3_);
         invalidate(INVALID_CHARGE_ACTIVE);
         this.scheduleChargeTimer();
      }
      
      public function stopCharging() : void
      {
         this.cancelChargeTimer();
         this._chargeIsActive = false;
         invalidate(INVALID_CHARGE_ACTIVE);
      }
      
      private function scheduleChargeTimer() : void
      {
         addEventListener(Event.ENTER_FRAME,this.invalidateChargeProgress);
         this.invalidateChargeProgress();
      }
      
      private function cancelChargeTimer() : void
      {
         removeEventListener(Event.ENTER_FRAME,this.invalidateChargeProgress);
      }
      
      private function invalidateChargeProgress(param1:Event = null) : void
      {
         invalidate(INVALID_CHARGE_PROGRESS);
      }
   }
}
