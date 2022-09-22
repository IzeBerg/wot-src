package net.wg.gui.lobby.sessionStats.components
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class SessionStatsTankInfoMainMark extends Sprite implements IDisposable
   {
       
      
      public var text:TextField = null;
      
      private var _disposed:Boolean = false;
      
      public function SessionStatsTankInfoMainMark()
      {
         super();
      }
      
      public function setData(param1:String) : void
      {
         this.text.htmlText = param1;
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this.text = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
