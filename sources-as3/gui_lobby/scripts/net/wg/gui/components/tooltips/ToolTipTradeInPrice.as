package net.wg.gui.components.tooltips
{
   import flash.text.TextField;
   import net.wg.gui.components.tooltips.VO.TradeInTooltipVo;
   import net.wg.gui.components.tooltips.helpers.Utils;
   
   public class ToolTipTradeInPrice extends ToolTipSpecial
   {
      
      private static const TEXT_FIELD_HEIGHT_PADDING:Number = 3;
      
      private static const TEXT_FIELD_WIDTH_PADDING:Number = 4;
      
      private static const SEPARATOR_TOP_PADDING:int = 9;
      
      private static const SEPARATOR_BOTTOM_PADDING:int = 11;
      
      private static const TITLE_PADDING:Number = 4;
      
      private static const HALF_TEXTFIELD_PADDING:Number = 2;
       
      
      private var _titleTF:TextField = null;
      
      private var _bodyTF:TextField = null;
      
      private var _resultTF:TextField = null;
      
      private var _model:TradeInTooltipVo = null;
      
      public function ToolTipTradeInPrice()
      {
         super();
         separators = new Vector.<Separator>();
         this._titleTF = content.titleTF;
         this._bodyTF = content.bodyTF;
         this._resultTF = content.resultTF;
      }
      
      override protected function redraw() : void
      {
         this.setData();
         this.updatePositions();
         super.redraw();
      }
      
      override protected function onDispose() : void
      {
         this._titleTF = null;
         this._bodyTF = null;
         this._resultTF = null;
         this.tryClearModel();
         while(content.numChildren > 0)
         {
            content.removeChildAt(0);
         }
         super.onDispose();
      }
      
      override protected function updatePositions() : void
      {
         var _loc1_:Number = contentMargin.left + bgShadowMargin.left + HALF_TEXTFIELD_PADDING;
         topPosition = bgShadowMargin.top + contentMargin.top;
         this._titleTF.height = this._titleTF.textHeight + TEXT_FIELD_HEIGHT_PADDING;
         this._bodyTF.height = this._bodyTF.textHeight + TEXT_FIELD_HEIGHT_PADDING;
         this._resultTF.height = this._resultTF.textHeight + TEXT_FIELD_HEIGHT_PADDING;
         this._titleTF.width = this._titleTF.textWidth + TEXT_FIELD_WIDTH_PADDING;
         this._bodyTF.width = this._bodyTF.textWidth + TEXT_FIELD_WIDTH_PADDING;
         this._resultTF.width = this._resultTF.textWidth + TEXT_FIELD_WIDTH_PADDING;
         this._titleTF.x = _loc1_ + TEXT_FIELD_WIDTH_PADDING;
         this._bodyTF.x = _loc1_ + TEXT_FIELD_WIDTH_PADDING;
         this._resultTF.x = _loc1_ + TEXT_FIELD_WIDTH_PADDING;
         this._titleTF.y = topPosition ^ 0;
         topPosition += this._titleTF.height + TITLE_PADDING;
         this._bodyTF.y = topPosition ^ 0;
         topPosition += this._bodyTF.height + SEPARATOR_TOP_PADDING;
         var _loc2_:Separator = Utils.instance.createSeparate(content);
         _loc2_.x = contentMargin.left + (contentWidth - _loc2_.width >> 1);
         _loc2_.y = topPosition ^ 0;
         separators.push(_loc2_);
         topPosition += SEPARATOR_BOTTOM_PADDING;
         this._resultTF.y = topPosition ^ 0;
         super.updatePositions();
      }
      
      private function setData() : void
      {
         this.tryClearModel();
         this._model = new TradeInTooltipVo(_data);
         this._titleTF.htmlText = this._model.header;
         this._bodyTF.htmlText = this._model.body;
         this._resultTF.htmlText = this._model.result;
      }
      
      private function tryClearModel() : void
      {
         if(this._model)
         {
            this._model.dispose();
            this._model = null;
         }
      }
   }
}
