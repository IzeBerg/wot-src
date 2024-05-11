package net.wg.gui.lobby.vehicleCustomization.controls
{
   import flash.display.Sprite;
   
   public class CarouselRendererAttachedDecal extends CarouselRendererAttachedBase
   {
       
      
      public var bg:Sprite = null;
      
      public var formMaskMc:Sprite = null;
      
      public var imgBg:Sprite = null;
      
      private var formScales:Array;
      
      public function CarouselRendererAttachedDecal()
      {
         this.formScales = [0.34,0.28,0.38,0.44,0.34,0.66];
         super();
      }
      
      override protected function setImageIconTransform() : void
      {
         imgIcon.mask = null;
         gotoAndStop(data.formFactor);
         imgIcon.scaleX = imgIcon.scaleY = this.formScales[data.formFactor - 1];
         imgIcon.x = -imgIcon.width + this.bg.width >> 1;
         imgIcon.y = -imgIcon.height + this.bg.height >> 1;
         this.imgBg.visible = data.isDim;
         if(this.imgBg.visible)
         {
            this.imgBg.width = this.bg.width;
            this.imgBg.height = this.bg.height;
         }
         imgIcon.mask = this.formMaskMc;
      }
      
      override protected function onDispose() : void
      {
         this.bg = null;
         this.formMaskMc = null;
         this.imgBg = null;
         super.onDispose();
      }
   }
}
