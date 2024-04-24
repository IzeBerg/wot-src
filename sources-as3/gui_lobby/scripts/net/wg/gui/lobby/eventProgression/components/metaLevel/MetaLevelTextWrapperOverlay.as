package net.wg.gui.lobby.eventProgression.components.metaLevel
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class MetaLevelTextWrapperOverlay extends MovieClip implements IDisposable
   {
       
      
      public var tf:TextField;
      
      public var eraser:MovieClip;
      
      private var _disposed:Boolean = false;
      
      public function MetaLevelTextWrapperOverlay()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.tf = null;
         this.eraser = null;
      }
      
      public function updateSize() : void
      {
         if(this.eraser)
         {
            this.eraser.width = this.tf.width;
            this.eraser.height = this.tf.height;
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
