package net.wg.white_tiger.gui.battle.views.staticMarkers
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class IndexedContent extends MovieClip implements IDisposable
   {
       
      
      public var indexField:TextField = null;
      
      public var icon:MovieClip = null;
      
      private var _disposed:Boolean = false;
      
      public function IndexedContent()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.onDispose();
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function setAlpha(param1:Number) : void
      {
         this.icon.alpha = param1;
      }
      
      protected function onDispose() : void
      {
         this.indexField = null;
         this.icon = null;
      }
   }
}
