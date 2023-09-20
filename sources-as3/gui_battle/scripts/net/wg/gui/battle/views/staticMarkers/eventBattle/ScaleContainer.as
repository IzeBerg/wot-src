package net.wg.gui.battle.views.staticMarkers.eventBattle
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class ScaleContainer extends MovieClip implements IDisposable
   {
       
      
      public var content:IndexedContent = null;
      
      private var _disposed:Boolean = false;
      
      public function ScaleContainer()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.content.dispose();
         this.content = null;
      }
      
      public function setScale(param1:Number) : void
      {
         this.content.scaleX = param1;
         this.content.scaleY = param1;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
