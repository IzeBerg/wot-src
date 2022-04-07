package net.wg.gui.components.tooltips.inblocks.blocks
{
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BLOCKS_TOOLTIP_TYPES;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.tooltips.inblocks.data.ImageBlockVO;
   import net.wg.gui.components.tooltips.inblocks.events.ToolTipBlockEvent;
   import net.wg.gui.events.UILoaderEvent;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class ImageBlock extends BaseTooltipBlock
   {
       
      
      public var imageLoader:UILoaderAlt;
      
      private var _blockWidth:int = 0;
      
      private var _data:ImageBlockVO;
      
      private var _isDataApplied:Boolean = false;
      
      public function ImageBlock()
      {
         super();
         this.imageLoader.addEventListener(UILoaderEvent.COMPLETE,this.onImageLoaderCompleteHandler);
      }
      
      override public function cleanUp() : void
      {
         this.clearData();
         this._blockWidth = 0;
         this.imageLoader.unload();
         this.imageLoader.x = 0;
         this.imageLoader.alpha = 1;
      }
      
      override public function getWidth() : Number
      {
         return this._blockWidth > 0 ? Number(this._blockWidth) : Number(super.getWidth());
      }
      
      override public function setBlockData(param1:Object) : void
      {
         this.clearData();
         this._data = this.createData(param1);
         this._isDataApplied = false;
         invalidateBlock();
      }
      
      override public function setBlockWidth(param1:int) : void
      {
         this._blockWidth = param1;
      }
      
      override protected function onDispose() : void
      {
         this.imageLoader.removeEventListener(UILoaderEvent.COMPLETE,this.onImageLoaderCompleteHandler);
         this.imageLoader.dispose();
         this.imageLoader = null;
         this._blockWidth = 0;
         super.onDispose();
      }
      
      override protected function onValidateBlock() : Boolean
      {
         if(!this._isDataApplied)
         {
            this.applyData();
            return true;
         }
         this.layout();
         return false;
      }
      
      protected function createData(param1:Object) : ImageBlockVO
      {
         return new ImageBlockVO(param1);
      }
      
      protected function layout() : void
      {
         if(this._blockWidth > 0)
         {
            switch(this._data.align)
            {
               case BLOCKS_TOOLTIP_TYPES.ALIGN_LEFT:
                  this.imageLoader.x = 0;
                  break;
               case BLOCKS_TOOLTIP_TYPES.ALIGN_RIGHT:
                  this.imageLoader.x = this._blockWidth - this.imageLoader.width;
                  break;
               case BLOCKS_TOOLTIP_TYPES.ALIGN_CENTER:
                  this.imageLoader.x = this._blockWidth - this.imageLoader.width >> 1;
            }
         }
      }
      
      protected function onImageLoaderComplete() : void
      {
         dispatchEvent(new ToolTipBlockEvent(ToolTipBlockEvent.SIZE_CHANGE,this));
      }
      
      private function applyData() : void
      {
         App.utils.asserter.assert(StringUtils.isNotEmpty(this._data.imagePath),"imagePath " + Errors.CANT_EMPTY);
         this.imageLoader.source = this._data.imagePath;
         var _loc1_:int = this._data.width;
         var _loc2_:int = this._data.height;
         if(_loc1_ != Values.DEFAULT_INT || _loc2_ != Values.DEFAULT_INT)
         {
            this.imageLoader.autoSize = true;
            this.imageLoader.maintainAspectRatio = false;
            if(_loc1_ != Values.DEFAULT_INT)
            {
               this.imageLoader.width = _loc1_;
            }
            if(_loc2_ != Values.DEFAULT_INT)
            {
               this.imageLoader.height = _loc2_;
            }
         }
         else
         {
            this.imageLoader.autoSize = false;
            this.imageLoader.maintainAspectRatio = true;
         }
         this.imageLoader.alpha = this._data.alpha;
         this._isDataApplied = true;
      }
      
      private function clearData() : void
      {
         if(this._data != null)
         {
            this._data.dispose();
            this._data = null;
         }
      }
      
      protected function get data() : ImageBlockVO
      {
         return this._data;
      }
      
      private function onImageLoaderCompleteHandler(param1:UILoaderEvent) : void
      {
         invalidateBlock();
         this.onImageLoaderComplete();
      }
   }
}
