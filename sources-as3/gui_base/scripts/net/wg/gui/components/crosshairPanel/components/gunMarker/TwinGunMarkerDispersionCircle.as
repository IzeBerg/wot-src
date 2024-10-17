package net.wg.gui.components.crosshairPanel.components.gunMarker
{
   import com.gskinner.motion.GTweener;
   import fl.motion.easing.Circular;
   import fl.motion.easing.Sine;
   import net.wg.gui.components.crosshairPanel.components.gunMarker.constants.GunMarkerConsts;
   
   public class TwinGunMarkerDispersionCircle extends GunMarkerDispersionCircle
   {
      
      private static const SWITCH_ANIMATION_DURATION:Number = 0.25;
      
      private static const SWITCH_ANIMATION_ROTATION:Number = -15;
       
      
      public var twinGunMixing:GunMarkerMixingTwinGun;
      
      private var _isTwinGunActive:Boolean = false;
      
      public function TwinGunMarkerDispersionCircle()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(GunMarkerConsts.GUN_MIXING_TYPE_VALIDATION))
         {
            if(currMixingMC != null)
            {
               currMixingMC.visible = !this._isTwinGunActive;
            }
         }
         if(isInvalid(GunMarkerConsts.TWIN_GUN_ACTIVE_VALIDATION))
         {
            GTweener.removeTweens(currMixingMC);
            GTweener.removeTweens(this.twinGunMixing);
            if(this._isTwinGunActive)
            {
               if(currMixingMC != null)
               {
                  currMixingMC.alpha = mixingAlpha;
                  GTweener.to(currMixingMC,SWITCH_ANIMATION_DURATION,{"alpha":0},{"ease":Sine.easeOut});
               }
               this.twinGunMixing.alpha = 0;
               this.twinGunMixing.visible = true;
               this.twinGunMixing.rotation = SWITCH_ANIMATION_ROTATION;
               GTweener.to(this.twinGunMixing,SWITCH_ANIMATION_DURATION,{
                  "alpha":mixingAlpha,
                  "rotation":0
               },{
                  "onComplete":this.onFadeTweenComplete,
                  "ease":Circular.easeIn
               });
            }
            else
            {
               if(currMixingMC != null)
               {
                  currMixingMC.alpha = 0;
                  currMixingMC.visible = true;
                  GTweener.to(currMixingMC,SWITCH_ANIMATION_DURATION,{"alpha":mixingAlpha},{"ease":Circular.easeIn});
               }
               this.twinGunMixing.alpha = mixingAlpha;
               this.twinGunMixing.rotation = 0;
               GTweener.to(this.twinGunMixing,SWITCH_ANIMATION_DURATION,{
                  "alpha":0,
                  "rotation":SWITCH_ANIMATION_ROTATION
               },{
                  "onComplete":this.onFadeTweenComplete,
                  "ease":Sine.easeOut
               });
            }
         }
      }
      
      override protected function onDispose() : void
      {
         GTweener.removeTweens(currMixingMC);
         GTweener.removeTweens(this.twinGunMixing);
         this.twinGunMixing.dispose();
         this.twinGunMixing = null;
         super.onDispose();
      }
      
      override public function setReloadingParams(param1:Number, param2:String) : void
      {
         super.setReloadingParams(param1,param2);
         this.twinGunMixing.reloadProgress = param1;
      }
      
      public function set zoomFactor(param1:Number) : void
      {
         this.twinGunMixing.zoomFactor = param1;
      }
      
      override public function setAlpha(param1:Number, param2:Boolean) : void
      {
         super.setAlpha(param1,param2);
         this.twinGunMixing.alpha = mixingAlpha;
      }
      
      public function set isTwinGunActive(param1:Boolean) : void
      {
         if(param1 == this._isTwinGunActive)
         {
            return;
         }
         this._isTwinGunActive = param1;
         invalidate(GunMarkerConsts.TWIN_GUN_ACTIVE_VALIDATION);
      }
      
      public function set twinGunMarkerState(param1:uint) : void
      {
         this.twinGunMixing.markerState = param1;
      }
      
      private function onFadeTweenComplete() : void
      {
         if(this._isTwinGunActive)
         {
            if(currMixingMC != null)
            {
               currMixingMC.visible = false;
            }
         }
         else
         {
            this.twinGunMixing.visible = false;
         }
      }
   }
}
