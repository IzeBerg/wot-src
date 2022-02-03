package net.wg.gui.bootcamp.battleTopHint.containers
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class HintInfoContainer extends Sprite implements IDisposable
   {
       
      
      public var txt:TextField = null;
      
      private var _disposed:Boolean = false;
      
      public function HintInfoContainer()
      {
         super();
         this.txt.autoSize = TextFieldAutoSize.CENTER;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.txt = null;
      }
      
      public function setHintText(param1:String) : void
      {
         this.txt.text = param1;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
