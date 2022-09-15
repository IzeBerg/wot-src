package net.wg.gui.lobby.vehicleCustomization.tooltips.inblocks.blocks
{
   import flash.display.MovieClip;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BLOCKS_TOOLTIP_TYPES;
   import net.wg.gui.components.tooltips.inblocks.blocks.ImageBlock;
   import net.wg.gui.lobby.vehicleCustomization.tooltips.inblocks.data.CustomizationImageBlockVO;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class CustomizationImageBlock extends ImageBlock
   {
       
      
      public var bg:MovieClip;
      
      private var _data:CustomizationImageBlockVO;
      
      private var _isDataApplied:Boolean = false;
      
      private var _blockWidth:int = 0;
      
      public function CustomizationImageBlock()
      {
         super();
      }
      
      override public function setBlockData(param1:Object) : void
      {
         this.clearData();
         this._data = new CustomizationImageBlockVO(param1);
         this._isDataApplied = false;
         invalidateBlock();
      }
      
      override public function setBlockWidth(param1:int) : void
      {
         this._blockWidth = param1;
      }
      
      override protected function layout() : void
      {
         if(this._blockWidth > 0)
         {
            switch(this._data.align)
            {
               case BLOCKS_TOOLTIP_TYPES.ALIGN_LEFT:
                  imageLoader.x = 0;
                  this.bg.x = 0;
                  break;
               case BLOCKS_TOOLTIP_TYPES.ALIGN_RIGHT:
                  imageLoader.x = this._blockWidth - imageLoader.width;
                  this.bg.x = this._blockWidth - this.bg.width;
                  break;
               case BLOCKS_TOOLTIP_TYPES.ALIGN_CENTER:
                  imageLoader.x = this._blockWidth - imageLoader.width >> 1;
                  this.bg.x = this._blockWidth - this.bg.width >> 1;
            }
         }
      }
      
      override protected function onValidateBlock() : Boolean
      {
         if(!this._isDataApplied)
         {
            this.applyBlockData();
            return true;
         }
         this.layout();
         return false;
      }
      
      override protected function onDispose() : void
      {
         this.clearData();
         this.bg = null;
         super.onDispose();
      }
      
      private function clearData() : void
      {
         if(this._data != null)
         {
            this._data.dispose();
            this._data = null;
         }
      }
      
      private function applyBlockData() : void
      {
         App.utils.asserter.assert(StringUtils.isNotEmpty(this._data.imagePath),"imagePath " + Errors.CANT_EMPTY);
         imageLoader.source = this._data.imagePath;
         var _loc1_:int = this._data.width;
         var _loc2_:int = this._data.height;
         if(_loc1_ != Values.DEFAULT_INT || _loc2_ != Values.DEFAULT_INT)
         {
            imageLoader.autoSize = true;
            imageLoader.maintainAspectRatio = false;
            if(_loc1_ != Values.DEFAULT_INT)
            {
               imageLoader.width = _loc1_;
               this.bg.width = _loc1_;
            }
            if(_loc2_ != Values.DEFAULT_INT)
            {
               imageLoader.height = _loc2_;
               this.bg.height = _loc2_;
            }
         }
         else
         {
            imageLoader.autoSize = false;
            imageLoader.maintainAspectRatio = true;
         }
         this.bg.visible = this._data.isDim;
         this._isDataApplied = true;
      }
   }
}
