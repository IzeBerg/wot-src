package net.wg.gui.lobby.components
{
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.text.TextLineMetrics;
   import net.wg.gui.lobby.components.data.DetailedStatisticsLabelDataVO;
   import net.wg.gui.lobby.components.data.TruncateDetailedStatisticsLabelDataVO;
   import net.wg.gui.lobby.components.events.DashLineTextItemRendererEvent;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import net.wg.utils.ICommons;
   import scaleform.clik.constants.InvalidationType;
   
   public class StatisticsDashLineTextItemIRenderer extends ProfileDashLineTextItem implements IUpdatable
   {
      
      private static const LABEL_VALUE_GAP:int = 20;
      
      private static const DEFAULT_COLOR:uint = 15131353;
      
      private static const TEXTFIELD_PADDING:Number = 5;
       
      
      public var bubblesSizeChanged:Boolean = false;
      
      public var useDefaultFormat:Boolean = true;
      
      private var _commons:ICommons;
      
      private var _dashLineY:int = -1;
      
      private var _valueTextY:int = -1;
      
      private var _textSizeChanged:Boolean = false;
      
      private var _textNumLines:int = 1;
      
      private var _labelTextFieldBaseHeight:int = -1;
      
      public function StatisticsDashLineTextItemIRenderer()
      {
         super();
         this._commons = App.utils.commons;
         this._dashLineY = dashLine.y;
         this._valueTextY = valueTextField.y;
         this._labelTextFieldBaseHeight = labelTextField.height;
      }
      
      override protected function onDispose() : void
      {
         this._commons = null;
         super.onDispose();
      }
      
      public function update(param1:Object) : void
      {
         var _loc2_:DetailedStatisticsLabelDataVO = DetailedStatisticsLabelDataVO(param1);
         if(_loc2_)
         {
            if(_loc2_ is TruncateDetailedStatisticsLabelDataVO)
            {
               useTruncateValues(TruncateDetailedStatisticsLabelDataVO(_loc2_).truncateVo);
               this.value = String(_loc2_.data);
            }
            else
            {
               receiveAndSetValue(_loc2_.data,DEFAULT_COLOR);
            }
            label = _loc2_.label;
            tooltip = _loc2_.tooltip;
            toolTipParams = _loc2_.tooltipDataVO;
            visible = true;
         }
         else
         {
            visible = false;
         }
      }
      
      override protected function setupLabel() : void
      {
         labelTextField.wordWrap = true;
         labelTextField.width = _width - valueTextField.width - LABEL_VALUE_GAP;
         labelTextField.htmlText = label;
         var _loc1_:TextFormat = !!this.useDefaultFormat ? labelTextField.defaultTextFormat : labelTextField.getTextFormat();
         _loc1_.align = TextFormatAlign.LEFT;
         labelTextField.setTextFormat(_loc1_);
         var _loc2_:int = labelTextField.numLines;
         this._textSizeChanged = _loc2_ != this._textNumLines;
         this._textNumLines = _loc2_;
         if(_loc2_ > 1)
         {
            this._commons.updateTextFieldSize(labelTextField,false,true);
         }
         else
         {
            labelTextField.height = this._labelTextFieldBaseHeight;
            labelTextField.width = labelTextField.textWidth + TEXTFIELD_PADDING;
         }
         invalidate(InvalidationType.SIZE);
      }
      
      override protected function applySizeChanges() : void
      {
         var _loc1_:TextLineMetrics = null;
         var _loc2_:int = 0;
         if(this._textNumLines > 1)
         {
            _loc1_ = labelTextField.getLineMetrics(this._textNumLines - 1);
            _loc2_ = _loc1_.width;
            dashLine.x = _loc2_ + dashLinePadding;
            dashLine.width = _width - _loc2_ - valueTextField.width - dashLinePadding >> 0;
            dashLine.y = this._textNumLines * (_loc1_.height + _loc1_.leading - _loc1_.descent) >> 0;
            valueTextField.y = dashLine.y - valueTextField.height + valueTextField.getLineMetrics(0).descent + dashLinePadding >> 0;
         }
         else
         {
            dashLine.x = labelTextField.width + dashLinePadding >> 0;
            dashLine.width = _width - labelTextField.width - valueTextField.width - (dashLinePadding << 1) >> 0;
            dashLine.y = this._dashLineY;
            valueTextField.y = this._valueTextY;
         }
         if(bounds)
         {
            bounds.width = _width;
         }
         height = labelTextField.height >> 0;
         valueTextField.x = _width - valueTextField.width >> 0;
         if(this._textSizeChanged)
         {
            this._textSizeChanged = false;
            dispatchEvent(new DashLineTextItemRendererEvent(DashLineTextItemRendererEvent.TEXT_SIZE_CHANGED,this.bubblesSizeChanged));
         }
      }
   }
}
