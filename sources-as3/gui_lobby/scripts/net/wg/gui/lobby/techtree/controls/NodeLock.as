package net.wg.gui.lobby.techtree.controls
{
   import flash.display.Sprite;
   import net.wg.gui.lobby.techtree.interfaces.IRenderer;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class NodeLock extends Sprite implements IDisposable
   {
       
      
      public var renderer:IRenderer = null;
      
      private var _isDisposed:Boolean = false;
      
      public function NodeLock(param1:IRenderer = null)
      {
         super();
         this.renderer = param1;
      }
      
      public function dispose() : void
      {
         this._isDisposed = true;
         this.renderer = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._isDisposed;
      }
   }
}
