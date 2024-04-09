package net.wg.gui.lobby.battleMatters.components
{
   import flash.display.MovieClip;
   import net.wg.gui.components.containers.AnimatedLoaderTextContainer;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class AnimatedLoaderContainer extends MovieClip implements IDisposable
   {
       
      
      public var content:AnimatedLoaderTextContainer = null;
      
      private var _disposed:Boolean = false;
      
      public function AnimatedLoaderContainer()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.content.dispose();
         this.content = null;
      }
      
      public function set source(param1:String) : void
      {
         this.content.source = param1;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
