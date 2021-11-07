package net.wg.gui.lobby.imageView
{
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.infrastructure.base.meta.IImageViewMeta;
   import net.wg.infrastructure.base.meta.impl.ImageViewMeta;
   
   public class ImageView extends ImageViewMeta implements IImageViewMeta
   {
      
      private static const MIN_SCALE:Number = 0.85;
       
      
      public var imageBG:UILoaderAlt;
      
      public function ImageView()
      {
         super();
         fadeEnable = true;
      }
      
      override public function setViewSize(param1:Number, param2:Number) : void
      {
         super.setViewSize(param1,param2);
         this.updateLayout();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.imageBG.mouseEnabled = this.imageBG.mouseChildren = false;
         closeBtn.label = MENU.VIEWHEADER_CLOSEBTN_LABEL;
         this.imageBG.addEventListener(UILoaderEvent.COMPLETE,this.onImageBGCompleteHandler);
      }
      
      override protected function onDispose() : void
      {
         this.imageBG.removeEventListener(UILoaderEvent.COMPLETE,this.onImageBGCompleteHandler);
         this.imageBG.dispose();
         this.imageBG = null;
         super.onDispose();
      }
      
      override protected function onCloseBtn() : void
      {
         onCloseS();
      }
      
      override protected function onEscapeKeyDown() : void
      {
         onCloseS();
      }
      
      public function as_setBgPath(param1:String) : void
      {
         this.imageBG.source = param1;
      }
      
      private function updateLayout() : void
      {
         var _loc1_:int = this.imageBG.width / this.imageBG.scaleX;
         var _loc2_:int = this.imageBG.height / this.imageBG.scaleY;
         if(height < _loc2_ * width / _loc1_)
         {
            this.imageBG.width = width;
            this.imageBG.scaleY = this.imageBG.scaleX;
         }
         else
         {
            this.imageBG.height = height;
            this.imageBG.scaleX = this.imageBG.scaleY;
         }
         if(this.imageBG.scaleX < MIN_SCALE)
         {
            this.imageBG.scaleX = MIN_SCALE;
            this.imageBG.scaleY = MIN_SCALE;
         }
         this.imageBG.x = width - this.imageBG.width >> 1;
         this.imageBG.y = height - this.imageBG.height >> 1;
      }
      
      private function onImageBGCompleteHandler(param1:UILoaderEvent) : void
      {
         this.updateLayout();
      }
   }
}
