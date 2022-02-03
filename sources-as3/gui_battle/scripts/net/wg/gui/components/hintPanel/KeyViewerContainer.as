package net.wg.gui.components.hintPanel
{
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class KeyViewerContainer extends Sprite implements IDisposable
   {
       
      
      public var keyViewer:KeyViewer = null;
      
      private var _disposed:Boolean = false;
      
      public function KeyViewerContainer()
      {
         super();
         this.keyViewer.cacheAsBitmap = true;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.keyViewer.dispose();
         this.keyViewer = null;
      }
      
      public function setKey(param1:String) : void
      {
         this.keyViewer.setKey(param1);
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
