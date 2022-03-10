package net.wg.gui.components.damageIndicator
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class AnimationContainer extends MovieClip implements IDisposable
   {
       
      
      public var stateContainer:StandardStateContainer = null;
      
      private var _disposed:Boolean = false;
      
      public function AnimationContainer()
      {
         super();
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this.stateContainer.dispose();
         this.stateContainer = null;
      }
      
      public function rotateInfo(param1:Number) : void
      {
         this.stateContainer.rotateInfo(param1);
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
