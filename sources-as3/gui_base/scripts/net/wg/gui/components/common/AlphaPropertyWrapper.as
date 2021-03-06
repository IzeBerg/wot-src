package net.wg.gui.components.common
{
   import flash.display.DisplayObject;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class AlphaPropertyWrapper implements IDisposable
   {
       
      
      private var _target:DisplayObject = null;
      
      private var _disposed:Boolean = false;
      
      public function AlphaPropertyWrapper(param1:DisplayObject)
      {
         super();
         this._target = param1;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this._target = null;
      }
      
      public function get alpha() : Number
      {
         return this._target.alpha;
      }
      
      public function set alpha(param1:Number) : void
      {
         this._target.alpha = param1;
      }
      
      public function get x() : Number
      {
         return this._target.x;
      }
      
      public function set x(param1:Number) : void
      {
         this._target.x = param1;
      }
      
      public function get y() : Number
      {
         return this._target.y;
      }
      
      public function set y(param1:Number) : void
      {
         this._target.y = param1;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
