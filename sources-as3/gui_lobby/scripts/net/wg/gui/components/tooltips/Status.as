package net.wg.gui.components.tooltips
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import net.wg.gui.components.tooltips.VO.ToolTipStatusColorsVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.ICommons;
   
   public class Status extends UIComponentEx
   {
      
      private static const ICO_DEF:String = "none";
      
      public static const ICO_NEW_SKILL:String = "newskill";
       
      
      public var textFieldHeader:TextField = null;
      
      public var textField:TextField = null;
      
      public var icon:MovieClip = null;
      
      private var _header:String;
      
      private var _text:String;
      
      private var _ico:String = "none";
      
      private var _commons:ICommons = null;
      
      private var _textFormat:TextFormat = null;
      
      public function Status()
      {
         super();
         this._commons = App.utils.commons;
         this.init();
      }
      
      override protected function onDispose() : void
      {
         this.textFieldHeader = null;
         this.textField = null;
         this.icon = null;
         this._textFormat = null;
         this._commons = null;
         super.onDispose();
      }
      
      public function setData(param1:String = null, param2:String = null, param3:ToolTipStatusColorsVO = null, param4:String = "none") : Number
      {
         var _loc5_:Number = 0;
         this._header = param1;
         this._text = param2;
         this._ico = param4;
         this.icon.gotoAndStop(this._ico);
         if(this._ico != ICO_DEF)
         {
            this.textFieldHeader.x = this.icon.width | 0;
            this.textField.x = this.icon.width | 0;
         }
         this.textFieldHeader.htmlText = this._header;
         this._commons.updateTextFieldSize(this.textFieldHeader,false,true);
         this.textField.htmlText = this._text;
         if(param3.textColor > 0)
         {
            this._textFormat.color = param3.textColor;
         }
         if(param2)
         {
            this._textFormat.align = TextFormatAlign.LEFT;
            this.textField.y = (Boolean(param1) ? this.textFieldHeader.height : 0) | 0;
         }
         else
         {
            this.textField.visible = false;
         }
         this.textFieldHeader.setTextFormat(this._textFormat);
         this.textField.setTextFormat(this._textFormat);
         this.filters = param3.filters;
         _loc5_ = Math.max(this.textFieldHeader.textWidth,this.textField.textWidth);
         invalidate();
         return _loc5_;
      }
      
      public function updateWidth(param1:Number) : void
      {
         if(this._ico != ICO_DEF)
         {
            param1 -= this.icon.width;
            this.textFieldHeader.x = this.icon.width | 0;
            this.textField.x = this.icon.width | 0;
         }
         this._commons.updateTextFieldSize(this.textFieldHeader,false,true);
         this.textFieldHeader.width = param1;
         this.textField.width = param1;
         if(this._text)
         {
            this.textField.y = (Boolean(this._header) ? this.textFieldHeader.height : 0) | 0;
         }
      }
      
      private function init() : void
      {
         this.textFieldHeader.multiline = true;
         this.textFieldHeader.autoSize = TextFieldAutoSize.LEFT;
         this.textFieldHeader.wordWrap = true;
         this.textField.multiline = true;
         this.textField.autoSize = TextFieldAutoSize.LEFT;
         this.textField.wordWrap = true;
         this._textFormat = new TextFormat();
      }
      
      override public function get height() : Number
      {
         return _originalHeight;
      }
   }
}
