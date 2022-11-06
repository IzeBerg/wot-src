package net.wg.gui.components.tooltips.inblocks.blocks
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.tooltips.inblocks.data.ImageTextBlockVO;
   import net.wg.gui.components.tooltips.inblocks.events.ToolTipBlockEvent;
   import net.wg.gui.events.UILoaderEvent;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class ImageTextBlockInBlocks extends SpriteTextBlockInBlocks
   {
       
      
      public var imageLoader:UILoaderAlt;
      
      protected var blockData:ImageTextBlockVO;
      
      public function ImageTextBlockInBlocks()
      {
         super();
      }
      
      override public function cleanUp() : void
      {
         this.imageLoader.removeEventListener(UILoaderEvent.COMPLETE,this.onImageLoaderCompleteHandler);
         this.imageLoader.unload();
         this.imageLoader.setSourceSize(this.imageLoader.originalWidth,this.imageLoader.originalHeight);
         super.cleanUp();
      }
      
      override public function getHeight() : Number
      {
         return this.blockData && this.blockData.ignoreImageSize ? Number(titleTF.textHeight) : Number(super.getHeight());
      }
      
      override public function setBlockData(param1:Object) : void
      {
         super.setBlockData(param1);
         this.blockData = ImageTextBlockVO(getData());
      }
      
      override protected function getBlockVO(param1:Object) : DAAPIDataClass
      {
         return new ImageTextBlockVO(param1);
      }
      
      override protected function init() : void
      {
         content = this.imageLoader;
         super.init();
      }
      
      override protected function onDispose() : void
      {
         this.blockData = null;
         super.onDispose();
         if(this.imageLoader != null)
         {
            this.imageLoader.dispose();
            this.imageLoader = null;
         }
      }
      
      override protected function applyData() : void
      {
         super.applyData();
         if(this.imageLoader != null)
         {
            this.imageLoader.visible = StringUtils.isNotEmpty(this.blockData.imagePath);
            if(this.imageLoader.visible)
            {
               this.imageLoader.addEventListener(UILoaderEvent.COMPLETE,this.onImageLoaderCompleteHandler);
               this.imageLoader.source = this.blockData.imagePath;
            }
         }
      }
      
      override protected function onLayoutImage() : void
      {
         super.onLayoutImage();
         if(this.blockData.flipHorizontal)
         {
            content.x += content.width;
         }
      }
      
      protected function onImageLoaderComplete() : void
      {
         if(this.blockData.flipHorizontal)
         {
            this.imageLoader.scaleX = -1;
         }
         dispatchEvent(new ToolTipBlockEvent(ToolTipBlockEvent.SIZE_CHANGE,this));
      }
      
      private function onImageLoaderCompleteHandler(param1:UILoaderEvent) : void
      {
         invalidateBlock();
         this.onImageLoaderComplete();
      }
   }
}
