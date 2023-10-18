package net.wg.gui.components.advanced.backButton
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BackButtonStates extends MovieClip implements IDisposable
   {
       
      
      public var textMc:BackButtonText = null;
      
      private var _disposed:Boolean = false;
      
      public function BackButtonStates()
      {
         super();
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this.textMc.dispose();
         this.textMc = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
