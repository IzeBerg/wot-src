package net.wg.gui.components.common
{
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class FrameStatesContainer extends Sprite implements IDisposable
   {
       
      
      public var frameStates:FrameStateCmpnt = null;
      
      private var _disposed:Boolean = false;
      
      public function FrameStatesContainer()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.frameStates.dispose();
         this.frameStates = null;
      }
      
      public function set frameLabel(param1:String) : void
      {
         this.frameStates.frameLabel = param1;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
