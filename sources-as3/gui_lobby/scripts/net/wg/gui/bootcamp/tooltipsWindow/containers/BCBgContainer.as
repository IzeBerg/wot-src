package net.wg.gui.bootcamp.tooltipsWindow.containers
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BCBgContainer extends MovieClip implements IDisposable
   {
       
      
      public var bg:MovieClip = null;
      
      private var _disposed:Boolean = false;
      
      public function BCBgContainer()
      {
         super();
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this.bg = null;
      }
      
      public function setWidth(param1:int) : void
      {
         this.bg.width = param1;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
