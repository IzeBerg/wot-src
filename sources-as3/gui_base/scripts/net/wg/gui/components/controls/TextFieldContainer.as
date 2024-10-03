package net.wg.gui.components.controls
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.gfx.TextFieldEx;
   
   public class TextFieldContainer extends Sprite implements IDisposable
   {
      
      protected static const TEXT_FIELD_BOUNDS_HEIGHT:Number = 4;
       
      
      public var textField:TextField = null;
      
      private var _text:String = "";
      
      private var _isMultiline:Boolean = false;
      
      private var _isUpdateWidth:Boolean = false;
      
      private var _tf:TextFormat = null;
      
      private var _autoSize:String = "none";
      
      private var _disposed:Boolean = false;
      
      public function TextFieldContainer()
      {
         super();
         this.isCacheAsBitmap = true;
         this._tf = this.textField.getTextFormat();
      }
      
      public final function dispose() : void
      {
         this.onDispose();
         this._disposed = true;
         this._tf = null;
         this.textField = null;
      }
      
      protected function onDispose() : void
      {
      }
      
      protected function updateSize() : void
      {
         if(this._autoSize == TextFieldAutoSize.NONE)
         {
            App.utils.commons.updateTextFieldSize(this.textField,this._isUpdateWidth,this._isMultiline);
            this.textField.height = this.textField.textHeight + TEXT_FIELD_BOUNDS_HEIGHT | 0;
         }
         else if(this._isMultiline || this._isUpdateWidth)
         {
            App.utils.asserter.assert(false,"Wrong TextFieldContainer properties!");
         }
      }
      
      public function get textColor() : uint
      {
         return this.textField.textColor;
      }
      
      public function set textColor(param1:uint) : void
      {
         this._tf.color = param1;
         this.textField.textColor = param1;
      }
      
      public function set textAlign(param1:String) : void
      {
         this._tf.align = param1;
         this.textField.setTextFormat(this._tf);
      }
      
      public function set defaultTextFormat(param1:TextFormat) : void
      {
         this.textField.defaultTextFormat = param1;
      }
      
      public function set noTranslateTextfield(param1:Boolean) : void
      {
         TextFieldEx.setNoTranslate(this.textField,param1);
      }
      
      public function set label(param1:String) : void
      {
         if(this._text == param1)
         {
            return;
         }
         this._text = param1;
         this.textField.text = param1;
         this.updateSize();
      }
      
      public function set htmlLabel(param1:String) : void
      {
         if(this._text == param1)
         {
            return;
         }
         this._text = param1;
         this.textField.htmlText = param1;
         this.updateSize();
      }
      
      public function set isMultiline(param1:Boolean) : void
      {
         if(this._isMultiline == param1)
         {
            return;
         }
         this._isMultiline = param1;
         this.updateSize();
      }
      
      public function set isUpdateWidth(param1:Boolean) : void
      {
         if(this._isUpdateWidth == param1)
         {
            return;
         }
         this._isUpdateWidth = param1;
         this.updateSize();
      }
      
      public function get textFilters() : Array
      {
         return this.textField.filters;
      }
      
      public function set textFilters(param1:Array) : void
      {
         this.textField.filters = param1;
      }
      
      public function get textOffsetY() : int
      {
         return this.textField.y;
      }
      
      public function set textOffsetY(param1:int) : void
      {
         this.textField.y = param1;
      }
      
      public function set fontSize(param1:int) : void
      {
         this._tf.size = param1;
         this.textField.setTextFormat(this._tf);
         this.updateSize();
      }
      
      public function get autoSize() : String
      {
         return this._autoSize;
      }
      
      public function set autoSize(param1:String) : void
      {
         this._autoSize = param1;
         this.textField.autoSize = param1;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      protected function set isCacheAsBitmap(param1:Boolean) : void
      {
         this.textField.cacheAsBitmap = param1;
      }
   }
}
