package net.wg.gui.components.common.counters
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.ILabel;
   
   public class CounterLabel extends Sprite implements ILabel
   {
       
      
      public var countTF:TextField = null;
      
      private var _disposed:Boolean = false;
      
      private var _textAutosSize:String = "left";
      
      private var _text:String = "";
      
      public function CounterLabel()
      {
         super();
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this.countTF = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function setTextAutoSize(param1:String) : void
      {
         this._textAutosSize = param1;
         this.update();
      }
      
      private function update() : void
      {
         if(this._textAutosSize != this.countTF.autoSize)
         {
            this.countTF.autoSize = this._textAutosSize;
         }
         this.countTF.htmlText = this._text;
      }
      
      public function get text() : String
      {
         return this.countTF.htmlText;
      }
      
      public function set text(param1:String) : void
      {
         this._text = param1;
         this.update();
      }
   }
}
