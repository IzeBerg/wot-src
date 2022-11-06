package net.wg.gui.components.advanced
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import net.wg.data.managers.IToolTipParams;
   import net.wg.gui.components.advanced.interfaces.IDashLineTextItem;
   import net.wg.gui.components.advanced.vo.TruncateHtmlTextVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class DashLineTextItem extends UIComponentEx implements IDashLineTextItem
   {
      
      public static const dashLinePadding:uint = 1;
      
      protected static const LABEL_INV:String = "lblInv";
      
      protected static const VALUE_INV:String = "valInv";
      
      private static const UP_STATE:String = "up";
      
      private static const DISABLED_STATE:String = "disabled";
      
      private static const DEFAULT_VALUE:String = "--";
       
      
      public var labelTextField:TextField = null;
      
      public var valueTextField:TextField = null;
      
      public var dashLine:DashLine = null;
      
      public var bounds:Sprite = null;
      
      protected var _myEnabled:Boolean = true;
      
      private var _label:String = "";
      
      private var _value:String = "";
      
      private var _tooltip:String = null;
      
      private var _toolTipParams:IToolTipParams;
      
      private var _textStyle:String = "";
      
      private var _isUseTruncate:Boolean = false;
      
      private var _maxWidth:int = -1;
      
      public function DashLineTextItem()
      {
         super();
      }
      
      private static function hideToolTip() : void
      {
         App.toolTipMgr.hide();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(VALUE_INV))
         {
            this.setupValue();
         }
         if(isInvalid(LABEL_INV))
         {
            this.setupLabel();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.applySizeChanges();
         }
         this.dashLine.validateNow();
      }
      
      override protected function onDispose() : void
      {
         this.dashLine.dispose();
         this.dashLine = null;
         this.disposeListeners();
         this.bounds = null;
         this.labelTextField = null;
         this.valueTextField = null;
         this._toolTipParams = null;
         super.onDispose();
      }
      
      public function useTruncateValues(param1:TruncateHtmlTextVO) : void
      {
         this._isUseTruncate = param1.isUseTruncate;
         this._textStyle = param1.textStyle;
         this._maxWidth = param1.maxWidthTF;
         invalidate(VALUE_INV);
      }
      
      protected function setupLabel() : void
      {
         this.labelTextField.autoSize = TextFieldAutoSize.LEFT;
         this.labelTextField.htmlText = this._label;
         invalidate(InvalidationType.SIZE);
      }
      
      protected function setupValue() : void
      {
         if(this._myEnabled)
         {
            this.changeState(UP_STATE);
            if(this._isUseTruncate)
            {
               this.changeValueTextProps();
               this.setValues(this.truncateValue());
            }
            else
            {
               this.setValues(this._value);
            }
         }
         else
         {
            this.changeState(DISABLED_STATE);
            this.setValues(DEFAULT_VALUE);
         }
         invalidate(InvalidationType.SIZE);
      }
      
      protected function showToolTip() : void
      {
         if(this._tooltip)
         {
            if(this._toolTipParams)
            {
               App.toolTipMgr.showComplexWithParams(this._tooltip,this._toolTipParams);
            }
            else
            {
               App.toolTipMgr.showComplex(this._tooltip);
            }
         }
      }
      
      protected function applySizeChanges() : void
      {
         this.dashLine.width = _width - this.labelTextField.width - this.valueTextField.width - (dashLinePadding << 1) >> 0;
         this.dashLine.x = this.labelTextField.width + dashLinePadding >> 0;
         if(this.bounds)
         {
            this.bounds.width = _width;
         }
         this.valueTextField.x = _width - this.valueTextField.width >> 0;
      }
      
      private function changeState(param1:String) : void
      {
         gotoAndPlay(param1);
      }
      
      private function changeValueTextProps() : void
      {
         var _loc1_:TextFormat = this.valueTextField.getTextFormat();
         _loc1_.align = TextFormatAlign.RIGHT;
         this.valueTextField.setTextFormat(_loc1_);
         this.valueTextField.width = this._maxWidth;
      }
      
      private function truncateValue() : String
      {
         var _loc1_:String = App.utils.commons.truncateTextFieldText(this.valueTextField,this._value);
         return App.textMgr.getTextStyleById(this._textStyle,_loc1_);
      }
      
      private function setValues(param1:String) : void
      {
         this.valueTextField.htmlText = param1;
         App.utils.commons.updateTextFieldSize(this.valueTextField,true,false);
      }
      
      private function disposeListeners() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler,false);
         removeEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler,false);
      }
      
      [Inspectable(defaultValue="true")]
      override public function get enabled() : Boolean
      {
         return this._myEnabled;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(param1 != this._myEnabled)
         {
            this._myEnabled = param1;
            invalidate(VALUE_INV);
            invalidate(LABEL_INV);
         }
      }
      
      public function set toolTipParams(param1:IToolTipParams) : void
      {
         this._toolTipParams = param1;
      }
      
      public function get label() : String
      {
         return this._label;
      }
      
      public function set label(param1:String) : void
      {
         if(this._label != param1)
         {
            this._label = param1;
            invalidate(LABEL_INV);
         }
      }
      
      public function get value() : String
      {
         return this._value;
      }
      
      public function set value(param1:String) : void
      {
         if(this._value != param1)
         {
            this._value = param1;
            invalidate(VALUE_INV);
         }
      }
      
      public function get tooltip() : String
      {
         return this._tooltip;
      }
      
      public function set tooltip(param1:String) : void
      {
         this._tooltip = param1;
         this.disposeListeners();
         if(this._tooltip)
         {
            addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler,false,0,true);
            addEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler,false,0,true);
         }
      }
      
      private function onMouseRollOutHandler(param1:MouseEvent) : void
      {
         hideToolTip();
      }
      
      private function onMouseRollOverHandler(param1:MouseEvent) : void
      {
         this.showToolTip();
      }
   }
}
