package net.wg.gui.lobby.vehicleCustomization.controls
{
   import flash.display.MovieClip;
   import scaleform.clik.constants.InvalidationType;
   
   public class CarouselRendererAttached extends CarouselRendererAttachedBase
   {
      
      private static const IMAGE_MARGIN:int = 1;
      
      private static const BORDER_SIZE_OFFSET:int = 58;
      
      private static const RENDERER_HEIGHT:int = 34;
       
      
      public var bg:MovieClip = null;
      
      public var border:MovieClip = null;
      
      public function CarouselRendererAttached()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.setImageIconTransform();
            this.bg.x = imgIcon.x;
            this.bg.y = imgIcon.y;
            this.bg.width = imgIcon.width;
            this.bg.height = imgIcon.height;
            this.border.width = width + BORDER_SIZE_OFFSET;
            this.border.height = height + BORDER_SIZE_OFFSET;
         }
      }
      
      override protected function setImageIconTransform() : void
      {
         var _loc1_:Number = RENDERER_HEIGHT / imgIcon.height;
         setSize(imgIcon.width * _loc1_,imgIcon.height * _loc1_);
         imgIcon.x = IMAGE_MARGIN;
         imgIcon.y = IMAGE_MARGIN;
         imgIcon.width = width;
         imgIcon.height = height;
      }
      
      override protected function onDispose() : void
      {
         this.bg = null;
         this.border = null;
      }
   }
}
