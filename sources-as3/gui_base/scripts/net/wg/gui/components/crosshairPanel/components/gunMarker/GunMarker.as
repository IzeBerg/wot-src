package net.wg.gui.components.crosshairPanel.components.gunMarker
{
   import net.wg.gui.components.crosshairPanel.components.gunMarker.constants.GunMarkerConsts;
   import net.wg.infrastructure.base.SimpleContainer;
   
   public class GunMarker extends SimpleContainer implements IGunMarker
   {
       
      
      public var gunTag:GunMarkerTag = null;
      
      public var radiusMC:GunMarkerDispersionCircle = null;
      
      private var _gunTagAlpha:Number = -1;
      
      private var _mixingAlpha:Number = -1;
      
      private var _scale:Number = 1;
      
      public function GunMarker()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(GunMarkerConsts.GUN_TAG_ALPHA_VALIDATION))
         {
            this.gunTag.alpha = this._gunTagAlpha;
         }
         if(isInvalid(GunMarkerConsts.GUN_MIXING_ALPHA_VALIDATION))
         {
            this.radiusMC.alpha = this._mixingAlpha;
         }
         if(isInvalid(GunMarkerConsts.GUN_SCALE_VALIDATION))
         {
            this.gunTag.scaleX = this.gunTag.scaleY = this._scale;
         }
      }
      
      override protected function onDispose() : void
      {
         if(this.radiusMC)
         {
            this.radiusMC.dispose();
            this.radiusMC = null;
         }
         if(this.gunTag)
         {
            this.gunTag.dispose();
            this.gunTag = null;
         }
         super.onDispose();
      }
      
      public function setColor(param1:String) : void
      {
         this.gunTag.setColor(param1);
      }
      
      public function setMixingScale(param1:Number) : void
      {
         this.radiusMC.scaleX = this.radiusMC.scaleY = param1;
      }
      
      public function setReloadingParams(param1:Number, param2:String) : void
      {
         this.radiusMC.setReloadingParams(param1,param2);
         this.gunTag.setReloadingState(param2);
      }
      
      public function setScale(param1:Number) : void
      {
         this._scale = param1;
         invalidate(GunMarkerConsts.GUN_SCALE_VALIDATION);
      }
      
      public function setSettings(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         this.gunTag.setType(param1);
         this.radiusMC.setType(param2);
         if(this._gunTagAlpha != param3)
         {
            this._gunTagAlpha = param3;
            invalidate(GunMarkerConsts.GUN_TAG_ALPHA_VALIDATION);
         }
         if(this._mixingAlpha != param4)
         {
            this._mixingAlpha = param4;
            invalidate(GunMarkerConsts.GUN_MIXING_ALPHA_VALIDATION);
         }
      }
   }
}
