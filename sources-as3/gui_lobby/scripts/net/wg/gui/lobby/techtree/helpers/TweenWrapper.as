package net.wg.gui.lobby.techtree.helpers
{
   import flash.display.DisplayObject;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class TweenWrapper implements IDisposable
   {
       
      
      private var _target:DisplayObject = null;
      
      public function TweenWrapper(param1:DisplayObject)
      {
         super();
         this._target = param1;
      }
      
      public final function dispose() : void
      {
         this._target = null;
      }
      
      public function get y() : Number
      {
         return this._target.y;
      }
      
      public function set y(param1:Number) : void
      {
         this._target.y = param1;
      }
      
      public function get alpha() : Number
      {
         return this._target.alpha;
      }
      
      public function set alpha(param1:Number) : void
      {
         this._target.alpha = param1;
      }
   }
}
