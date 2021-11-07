package net.wg.gui.components.tooltips.inblocks.blocks
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.tooltips.inblocks.data.TextParameterVO;
   
   public class TextParameterBlock extends AbstractTextParameterBlock
   {
       
      
      public var nameTF:TextField;
      
      private var _defaultNameTFWidth:int;
      
      public function TextParameterBlock()
      {
         super();
         this._defaultNameTFWidth = this.nameTF.width;
         this.nameTF.autoSize = TextFieldAutoSize.LEFT;
      }
      
      override public function cleanUp() : void
      {
         this.nameTF.text = this.nameTF.htmlText = null;
         this.nameTF.width = this._defaultNameTFWidth;
         super.cleanUp();
      }
      
      override protected function onSetBlockWidth(param1:int) : void
      {
         if(param1 > 0)
         {
            this.nameTF.width = param1 - this.nameTF.x;
         }
      }
      
      override protected function getDataClass() : Class
      {
         return TextParameterVO;
      }
      
      override protected function onDispose() : void
      {
         this.nameTF = null;
         super.onDispose();
      }
      
      override protected function applyParamName() : void
      {
         if(_data.useHtmlName)
         {
            this.nameTF.htmlText = _data.name;
         }
         else
         {
            this.nameTF.text = _data.name;
         }
         if(_data.gap != -1)
         {
            this.nameTF.x = valueTF.width + _data.gap;
         }
         updateTextFieldHeight(this.nameTF);
      }
   }
}
