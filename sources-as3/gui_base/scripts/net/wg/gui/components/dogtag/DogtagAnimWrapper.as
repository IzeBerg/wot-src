package net.wg.gui.components.dogtag
{
   import flash.display.DisplayObject;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class DogtagAnimWrapper implements IDisposable
   {
       
      
      private var _target:DisplayObject = null;
      
      public function DogtagAnimWrapper(param1:DisplayObject)
      {
         super();
         this._target = param1;
      }
      
      public final function dispose() : void
      {
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
   }
}
