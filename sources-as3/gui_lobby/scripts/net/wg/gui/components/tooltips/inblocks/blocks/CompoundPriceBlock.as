package net.wg.gui.components.tooltips.inblocks.blocks
{
   import flash.geom.Point;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.controls.VO.ItemPriceVO;
   import net.wg.gui.components.controls.price.CompoundPrice;
   
   public class CompoundPriceBlock extends BaseTooltipBlock
   {
      
      private static const PRICE_ACTION_OFFSET:Point = new Point(0,3);
       
      
      public var priceView:CompoundPrice;
      
      private var _data:ItemPriceVO;
      
      private var _isDataApplied:Boolean = false;
      
      public function CompoundPriceBlock()
      {
         super();
         this.priceView.bigFonts = true;
         this.priceView.actionState = CompoundPrice.ACTION_STATE_SHOW_VALUE;
         this.priceView.priceActionOffset = PRICE_ACTION_OFFSET;
         this.priceView.oldPriceAlign = CompoundPrice.OLD_PRICE_ALIGN_BOTTOM;
         this.priceView.oldPriceVisible = true;
      }
      
      override public function getHeight() : Number
      {
         return this.priceView.contentHeight;
      }
      
      override public function setBlockData(param1:Object) : void
      {
         this.clearData();
         this._data = new ItemPriceVO(param1[0]);
         this._isDataApplied = false;
         invalidateBlock();
      }
      
      override public function setBlockWidth(param1:int) : void
      {
      }
      
      override protected function onValidateBlock() : Boolean
      {
         if(!this._isDataApplied)
         {
            App.utils.asserter.assertNotNull(this._data,"_data " + Errors.CANT_NULL);
            this.priceView.itemsDirection = CompoundPrice.DIRECTION_RIGHT;
            this.priceView.setData(this._data);
            this._isDataApplied = true;
            return true;
         }
         this.applyLayout();
         return false;
      }
      
      override protected function onDispose() : void
      {
         this.clearData();
         this.priceView.dispose();
         this.priceView = null;
         super.onDispose();
      }
      
      private function applyLayout() : void
      {
         this.priceView.x = 0;
      }
      
      private function clearData() : void
      {
         if(this._data != null)
         {
            this._data.dispose();
            this._data = null;
         }
      }
   }
}
