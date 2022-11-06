package net.wg.gui.bootcamp.battleTopHint.containers
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class HintBackground extends MovieClip implements IDisposable
   {
       
      
      public var bg:MovieClip = null;
      
      private var _disposed:Boolean = false;
      
      public function HintBackground()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.bg = null;
      }
      
      public function updateStage(param1:int, param2:int) : void
      {
         this.bg.width = param1;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
