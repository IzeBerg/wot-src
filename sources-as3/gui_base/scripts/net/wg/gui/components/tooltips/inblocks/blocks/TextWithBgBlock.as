package net.wg.gui.components.tooltips.inblocks.blocks
{
   import net.wg.data.constants.generated.BLOCKS_TOOLTIP_TYPES;
   import net.wg.gui.components.tooltips.inblocks.data.TextWithBgBlockVO;
   
   public class TextWithBgBlock extends TextBlock
   {
       
      
      private var _data:TextWithBgBlockVO = null;
      
      public function TextWithBgBlock()
      {
         super();
      }
      
      override public function cleanUp() : void
      {
         super.cleanUp();
         textTF.x = 0;
         textTF.background = false;
      }
      
      override public function setBlockData(param1:Object) : void
      {
         this.clearData();
         this._data = new TextWithBgBlockVO(param1);
         invalidateBlock();
      }
      
      override protected function clearData() : void
      {
         if(this._data != null)
         {
            this._data.dispose();
            this._data = null;
         }
      }
      
      override protected function onValidateBlock() : Boolean
      {
         this.applyData();
         return false;
      }
      
      private function applyData() : void
      {
         var _loc1_:Number = NaN;
         if(this._data.useHtml)
         {
            textTF.htmlText = this._data.text;
         }
         else
         {
            textTF.text = this._data.text;
         }
         if(this._data.bgColor > -1)
         {
            textTF.background = true;
            textTF.backgroundColor = this._data.bgColor;
            _loc1_ = textTF.width;
            updateTextField(textTF);
            if(this._data.align == BLOCKS_TOOLTIP_TYPES.ALIGN_CENTER)
            {
               textTF.x = _loc1_ - textTF.width >> 1;
            }
            else if(this._data.align == BLOCKS_TOOLTIP_TYPES.ALIGN_RIGHT)
            {
               textTF.x = _loc1_ - textTF.width | 0;
            }
         }
         else
         {
            updateTextFieldHeight(textTF);
         }
      }
   }
}
