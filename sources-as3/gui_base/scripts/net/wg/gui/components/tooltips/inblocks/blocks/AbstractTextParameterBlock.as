package net.wg.gui.components.tooltips.inblocks.blocks
{
   import flash.text.TextField;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.tooltips.inblocks.data.TextParameterVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class AbstractTextParameterBlock extends BaseTextBlock
   {
       
      
      public var valueTF:TextField = null;
      
      protected var _data:TextParameterVO = null;
      
      private var _blockWidth:int = 0;
      
      private var _defaultValueTFWidth:Number;
      
      public function AbstractTextParameterBlock()
      {
         super();
         this._defaultValueTFWidth = this.valueTF.width;
      }
      
      override public function cleanUp() : void
      {
         this.clearData();
         this.valueTF.text = null;
         this.valueTF.width = this._defaultValueTFWidth;
         this._blockWidth = 0;
         super.cleanUp();
      }
      
      override public function setBlockData(param1:Object) : void
      {
         this.clearData();
         var _loc2_:Class = this.getDataClass();
         this._data = new _loc2_(param1);
         invalidateBlock();
      }
      
      override public function setBlockWidth(param1:int) : void
      {
         if(param1 > 0)
         {
            this._blockWidth = param1;
            this.onSetBlockWidth(param1);
         }
      }
      
      override protected function onValidateBlock() : Boolean
      {
         this.applyData();
         return false;
      }
      
      override protected function onDispose() : void
      {
         this.valueTF = null;
         this.clearData();
         super.onDispose();
      }
      
      protected function getDataClass() : Class
      {
         throw new AbstractException("AbstractTextParameterBlock.getDataClass" + Errors.ABSTRACT_INVOKE);
      }
      
      protected function applyParamName() : void
      {
         throw new AbstractException("AbstractTextParameterBlock.applyParamName" + Errors.ABSTRACT_INVOKE);
      }
      
      protected function clearData() : void
      {
         if(this._data != null)
         {
            this._data.dispose();
            this._data = null;
         }
      }
      
      protected function onSetBlockWidth(param1:int) : void
      {
         throw new AbstractException("AbstractTextParameterBlock.onSetBlockWidth" + Errors.ABSTRACT_INVOKE);
      }
      
      private function applyData() : void
      {
         if(this._data.useHtmlValue)
         {
            this.valueTF.htmlText = this._data.value;
         }
         else
         {
            this.valueTF.text = this._data.value;
         }
         if(this._data.valueWidth != -1)
         {
            this.valueTF.width = this._data.valueWidth;
         }
         this.applyParamName();
         this.onSetBlockWidth(this._blockWidth);
         updateTextFieldHeight(this.valueTF);
      }
   }
}
