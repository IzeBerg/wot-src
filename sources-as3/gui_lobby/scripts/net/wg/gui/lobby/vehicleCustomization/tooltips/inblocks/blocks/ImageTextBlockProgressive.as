package net.wg.gui.lobby.vehicleCustomization.tooltips.inblocks.blocks
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import net.wg.data.constants.ImageCacheTypes;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.tooltips.inblocks.blocks.SpriteTextBlockInBlocks;
   import net.wg.gui.components.tooltips.inblocks.data.ImageTextBlockVO;
   import net.wg.gui.components.tooltips.inblocks.events.ToolTipBlockEvent;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class ImageTextBlockProgressive extends SpriteTextBlockInBlocks
   {
      
      private static const CUSTOM_IMG_WIDTH:uint = 78;
      
      private static const CUSTOM_IMG_HEIGHT:uint = 34;
      
      private static const DESCRIPTION_TF_Y:int = -5;
       
      
      public var bg:MovieClip = null;
      
      public var imgIcon:Image = null;
      
      protected var blockData:ImageTextBlockVO;
      
      public function ImageTextBlockProgressive()
      {
         super();
         this.bg.width = CUSTOM_IMG_WIDTH;
         this.bg.height = CUSTOM_IMG_HEIGHT;
         this.imgIcon.cacheType = ImageCacheTypes.USE_WEB_CACHE;
         this.imgIcon.addEventListener(Event.CHANGE,this.onImageChangeHandler);
      }
      
      override public function cleanUp() : void
      {
         if(this.imgIcon)
         {
            this.resetImageSizeAndPosition();
            this.imgIcon.source = null;
         }
         super.cleanUp();
         descriptionTF.y = DESCRIPTION_TF_Y;
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
         content = this.imgIcon;
         super.init();
      }
      
      override protected function onDispose() : void
      {
         this.blockData = null;
         super.onDispose();
         if(this.imgIcon != null)
         {
            this.imgIcon.removeEventListener(Event.CHANGE,this.onImageChangeHandler);
            this.imgIcon.dispose();
            this.imgIcon = null;
         }
      }
      
      override protected function applyData() : void
      {
         super.applyData();
         if(this.imgIcon != null)
         {
            this.imgIcon.visible = StringUtils.isNotEmpty(this.blockData.imagePath);
            if(this.imgIcon.visible)
            {
               this.imgIcon.source = this.blockData.imagePath;
            }
         }
         this.setImageIconTransform();
      }
      
      override protected function onLayoutImage() : void
      {
         if(this.imgIcon.width == CUSTOM_IMG_WIDTH && this.imgIcon.height == CUSTOM_IMG_HEIGHT)
         {
            this.imgIcon.x = this.imgIcon.y = 0;
         }
         else if(this.imgIcon.height == CUSTOM_IMG_HEIGHT)
         {
            this.imgIcon.x = CUSTOM_IMG_WIDTH - this.imgIcon.width >> 1;
         }
         else if(this.imgIcon.width == CUSTOM_IMG_WIDTH)
         {
            this.imgIcon.y = CUSTOM_IMG_HEIGHT - this.imgIcon.height >> 1;
         }
         descriptionTF.y = DESCRIPTION_TF_Y;
      }
      
      protected function onImageLoaderComplete() : void
      {
         this.setImageIconTransform();
         dispatchEvent(new ToolTipBlockEvent(ToolTipBlockEvent.SIZE_CHANGE,this));
      }
      
      private function setImageIconTransform() : void
      {
         this.resetImageSizeAndPosition();
         this.imgIcon.height = CUSTOM_IMG_HEIGHT;
         this.imgIcon.scaleX = this.imgIcon.scaleY;
         if(this.imgIcon.width > CUSTOM_IMG_WIDTH)
         {
            this.resetImageSizeAndPosition();
            this.imgIcon.width = CUSTOM_IMG_WIDTH;
            this.imgIcon.scaleY = this.imgIcon.scaleX;
         }
      }
      
      private function resetImageSizeAndPosition() : void
      {
         this.imgIcon.x = this.imgIcon.y = 0;
         this.imgIcon.scaleX = this.imgIcon.scaleY = 1;
      }
      
      private function onImageChangeHandler(param1:Event) : void
      {
         invalidateBlock();
         this.onImageLoaderComplete();
      }
   }
}
