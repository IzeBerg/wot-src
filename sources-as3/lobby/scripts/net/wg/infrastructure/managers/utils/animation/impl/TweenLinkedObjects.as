package net.wg.infrastructure.managers.utils.animation.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.interfaces.ITween;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.IAssertable;
   
   public class TweenLinkedObjects implements IDisposable
   {
       
      
      private var _tween:ITween = null;
      
      private var _type:String = null;
      
      private var _delay:int;
      
      private var _disposed:Boolean = false;
      
      public function TweenLinkedObjects(param1:ITween, param2:int, param3:String)
      {
         super();
         var _loc4_:String = "curTween" + Errors.CANT_NULL;
         var _loc5_:String = "curDelayType" + Errors.CANT_NULL;
         var _loc6_:IAssertable = App.utils.asserter;
         _loc6_.assertNotNull(param1,_loc4_);
         _loc6_.assertNotNull(param3,_loc5_);
         this._tween = param1;
         this._type = param3;
         this._delay = param2;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this._tween = null;
      }
      
      public function get tween() : ITween
      {
         return this._tween;
      }
      
      public function set tween(param1:ITween) : void
      {
         this._tween = param1;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function set type(param1:String) : void
      {
         this._type = param1;
      }
      
      public function get delay() : int
      {
         return this._delay;
      }
      
      public function set delay(param1:int) : void
      {
         this._delay = param1;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
