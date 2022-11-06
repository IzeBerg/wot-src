package net.wg.gui.lobby.sessionStats.components
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class SessionStatsAnimatedNumberCounter extends Sprite implements IDisposable
   {
       
      
      public var txt:TextField = null;
      
      private var _disposed:Boolean = false;
      
      public function SessionStatsAnimatedNumberCounter()
      {
         super();
         this.txt.autoSize = TextFieldAutoSize.LEFT;
         this.txt.multiline = true;
      }
      
      public function set text(param1:String) : void
      {
         this.txt.htmlText = param1;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.txt = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
