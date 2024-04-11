package net.wg.gui.battle.views.actionMarkers
{
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class StickyArrow extends Sprite implements IDisposable
   {
       
      
      public var arrow:Sprite = null;
      
      private var _disposed:Boolean = false;
      
      public function StickyArrow()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.onDispose();
      }
      
      public function setRadius(param1:int) : void
      {
         this.arrow.y = -param1;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      protected function onDispose() : void
      {
         this.arrow = null;
      }
   }
}
