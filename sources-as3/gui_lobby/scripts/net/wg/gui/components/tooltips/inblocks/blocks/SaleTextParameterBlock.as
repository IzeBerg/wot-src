package net.wg.gui.components.tooltips.inblocks.blocks
{
   import flash.text.TextField;
   import net.wg.data.constants.generated.ACTION_PRICE_CONSTANTS;
   import net.wg.gui.components.controls.ActionPrice;
   import net.wg.gui.components.tooltips.inblocks.data.SaleTextParameterVO;
   
   public class SaleTextParameterBlock extends BaseTextBlock
   {
      
      private static const STATE_ALIGNED_TOP_TOP:int = -2;
      
      private static const STATE_CAMOUFLAGE_TOP:int = 3;
       
      
      public var nameTF:TextField;
      
      public var saleAP:ActionPrice;
      
      private var _data:SaleTextParameterVO;
      
      private var _isDataApplied:Boolean = false;
      
      public function SaleTextParameterBlock()
      {
         super();
      }
      
      override public function setBlockData(param1:Object) : void
      {
         this.clearData();
         this._data = new SaleTextParameterVO(param1);
         this._isDataApplied = false;
         invalidateBlock();
      }
      
      override public function setBlockWidth(param1:int) : void
      {
         if(param1 > 0)
         {
            this.nameTF.width = param1 - this.nameTF.x;
         }
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
      
      override protected function onDispose() : void
      {
         this.saleAP.dispose();
         this.nameTF = null;
         this.saleAP = null;
         this.clearData();
         super.onDispose();
      }
      
      private function layout() : void
      {
         updateTextFieldHeight(this.nameTF);
         if(this.saleAP.state == ACTION_PRICE_CONSTANTS.STATE_ALIGN_TOP)
         {
            this.saleAP.y = STATE_ALIGNED_TOP_TOP;
         }
         else
         {
            this.saleAP.y = STATE_CAMOUFLAGE_TOP;
         }
      }
      
      private function applyData() : void
      {
         if(this._data.useHtmlName)
         {
            this.nameTF.htmlText = this._data.name;
         }
         else
         {
            this.nameTF.text = this._data.name;
         }
         this.saleAP.state = this._data.actionStyle;
         this.saleAP.setData(this._data.saleData);
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
   }
}
