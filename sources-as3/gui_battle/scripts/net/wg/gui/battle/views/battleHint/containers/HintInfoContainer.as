package net.wg.gui.battle.views.battleHint.containers
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class HintInfoContainer extends Sprite implements IDisposable
   {
      
      private static const TEXTFIELD_Y_SMALL:int = -11;
      
      private static const TEXTFIELD_Y_BIG:int = -14;
      
      private static const FONT_SIZE_SMALL:int = 24;
      
      private static const FONT_SIZE_BIG:int = 36;
       
      
      public var txt:TextField = null;
      
      private var _disposed:Boolean = false;
      
      private var _isBig:Boolean = false;
      
      private var _offset:int = 0;
      
      private var _textFormat:TextFormat = null;
      
      public function HintInfoContainer()
      {
         super();
         this.txt.autoSize = TextFieldAutoSize.CENTER;
         this._textFormat = this.txt.getTextFormat();
      }
      
      public final function dispose() : void
      {
         this.txt = null;
         this._disposed = true;
      }
      
      public function clear() : void
      {
         this.txt.htmlText = Values.EMPTY_STR;
         this.setOffset(0);
      }
      
      public function setMessage(param1:String) : void
      {
         this.txt.htmlText = param1;
      }
      
      public function setOffset(param1:int) : void
      {
         this._offset = param1;
         this.updateTextField();
      }
      
      public function setIsBigSize(param1:Boolean) : void
      {
         this._isBig = param1;
         this.updateTextField();
      }
      
      private function updateTextField() : void
      {
         if(this._isBig)
         {
            this.txt.y = TEXTFIELD_Y_BIG + this._offset;
            this._textFormat.size = FONT_SIZE_BIG;
         }
         else
         {
            this.txt.y = TEXTFIELD_Y_SMALL + this._offset;
            this._textFormat.size = FONT_SIZE_SMALL;
         }
         this.txt.setTextFormat(this._textFormat);
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
