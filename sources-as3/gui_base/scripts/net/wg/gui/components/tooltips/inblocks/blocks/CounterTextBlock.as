package net.wg.gui.components.tooltips.inblocks.blocks
{
   import flash.text.TextField;
   import net.wg.gui.components.controls.achievements.RedCounter;
   import net.wg.gui.components.tooltips.inblocks.data.CounterTextBlockVO;
   
   public class CounterTextBlock extends BaseTooltipBlock
   {
      
      private static const TEXT_FIELD_BORDERS_SIZE:int = 4;
      
      private static const DEFAULT_RIGHT_PADDING:int = 30;
       
      
      public var counter:RedCounter = null;
      
      public var textField:TextField = null;
      
      private var _blockWidth:int = 0;
      
      private var _blockData:CounterTextBlockVO = null;
      
      public function CounterTextBlock()
      {
         super();
      }
      
      override public function setBlockData(param1:Object) : void
      {
         this._blockData = new CounterTextBlockVO(param1);
         invalidateBlock();
      }
      
      override public function setBlockWidth(param1:int) : void
      {
         this._blockWidth = param1;
      }
      
      override protected function onValidateBlock() : Boolean
      {
         this.counter.text = this._blockData.label;
         this.textField.htmlText = this._blockData.description;
         if(this._blockWidth > 0)
         {
            this.textField.width = this._blockWidth - DEFAULT_RIGHT_PADDING;
         }
         this.textField.height = this.textField.textHeight + TEXT_FIELD_BORDERS_SIZE;
         return super.onValidateBlock();
      }
      
      override protected function onDispose() : void
      {
         this._blockData.dispose();
         this._blockData = null;
         this.textField = null;
         this.counter.dispose();
         this.counter = null;
         super.onDispose();
      }
      
      override public function getWidth() : Number
      {
         return this._blockWidth > 0 ? Number(this._blockWidth) : Number(super.getWidth());
      }
   }
}
