package net.wg.gui.components.advanced
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class ItemBrowserTabMask extends UIComponentEx
   {
       
      
      public var maskLayer:MovieClip;
      
      public var maskObject:MovieClip;
      
      private var _maskSize:uint = 0;
      
      private const DISABLE_MASK_SIZE_OFFSET:uint = 2;
      
      private const DISABLE_MASK_POS_OFFSET:uint = 1;
      
      public function ItemBrowserTabMask()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(InvalidationType.SIZE)
         {
            this.maskLayer.width = this._maskSize - this.DISABLE_MASK_SIZE_OFFSET;
            this.maskObject.width = this._maskSize - this.DISABLE_MASK_SIZE_OFFSET;
            this.maskObject.height = this._maskSize - this.DISABLE_MASK_SIZE_OFFSET;
            x = (this._maskSize >> 1 - width >> 1) + this.DISABLE_MASK_POS_OFFSET;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.maskObject.mask = this.maskLayer;
      }
      
      override protected function onDispose() : void
      {
         this.maskObject = null;
         this.maskLayer = null;
         super.onDispose();
      }
      
      public function setMaskSize(param1:uint) : void
      {
         this._maskSize = param1;
         invalidateSize();
      }
   }
}
