package net.wg.gui.components.tooltips.inblocks.blocks
{
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.tooltips.inblocks.data.TextBetweenLineVO;
   
   public class TextBetweenLineBlock extends TextBlock
   {
      
      private static const LINE_COLOR:uint = 9211006;
       
      
      private var _data:TextBetweenLineVO = null;
      
      private var _blockWidth:int = 0;
      
      public function TextBetweenLineBlock()
      {
         super();
         textTF.autoSize = TextFieldAutoSize.CENTER;
      }
      
      override public function cleanUp() : void
      {
         this._blockWidth = 0;
         graphics.clear();
         super.cleanUp();
      }
      
      override public function setBlockData(param1:Object) : void
      {
         clearData();
         this._data = new TextBetweenLineVO(param1);
         invalidateBlock();
      }
      
      override public function setBlockWidth(param1:int) : void
      {
         if(param1 > 0)
         {
            this._blockWidth = param1;
            this.updateObjectsSize(this._blockWidth);
         }
      }
      
      override protected function onValidateBlock() : Boolean
      {
         this.applyData();
         return false;
      }
      
      private function updateObjectsSize(param1:int) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(this._data != null)
         {
            _loc2_ = param1 - textTF.width - 2 * this._data.customGap >> 1;
            textTF.x = _loc2_ + this._data.customGap;
            _loc3_ = textTF.x + textTF.width + this._data.customGap;
            _loc4_ = textTF.y + textTF.height >> 1;
            graphics.clear();
            graphics.lineStyle(this._data.lineThickness,LINE_COLOR,this._data.lineAlpha);
            graphics.moveTo(0,_loc4_);
            graphics.lineTo(_loc2_,_loc4_);
            graphics.moveTo(_loc3_,_loc4_);
            graphics.lineTo(_loc3_ + _loc2_,_loc4_);
            graphics.endFill();
         }
      }
      
      private function applyData() : void
      {
         if(this._data.useHtml)
         {
            textTF.htmlText = this._data.text;
         }
         else
         {
            textTF.text = this._data.text;
         }
         App.utils.commons.updateTextFieldSize(textTF);
         this.updateObjectsSize(this._blockWidth);
      }
   }
}
