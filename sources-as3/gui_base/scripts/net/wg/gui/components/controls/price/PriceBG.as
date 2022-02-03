package net.wg.gui.components.controls.price
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class PriceBG extends MovieClip implements IDisposable
   {
       
      
      public var hit:Sprite = null;
      
      private var _disposed:Boolean = false;
      
      public function PriceBG()
      {
         super();
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this.hit = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
