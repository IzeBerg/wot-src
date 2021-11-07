package lesta.unbound2
{
   import flash.display.DisplayObject;
   import net.wg.infrastructure.interfaces.IPopOverCaller;
   
   public class UBPopoverCallerWrapper implements IPopOverCaller
   {
       
      
      private var _target:DisplayObject;
      
      public function UBPopoverCallerWrapper(param1:DisplayObject)
      {
         super();
         this._target = param1;
      }
      
      public function getHitArea() : DisplayObject
      {
         return this._target;
      }
      
      public function getTargetButton() : DisplayObject
      {
         return this._target;
      }
   }
}
