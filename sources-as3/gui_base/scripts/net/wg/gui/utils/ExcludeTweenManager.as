package net.wg.gui.utils
{
   import flash.utils.Dictionary;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.motion.Tween;
   
   public class ExcludeTweenManager implements IDisposable
   {
       
      
      private var _currentTweens:Dictionary;
      
      private var _disposed:Boolean = false;
      
      public function ExcludeTweenManager()
      {
         super();
         this._currentTweens = new Dictionary();
      }
      
      public function registerAndLaunch(param1:Number, param2:Object, param3:Object, param4:Object) : Tween
      {
         var _loc5_:Tween = null;
         if(this._currentTweens[param2])
         {
            _loc5_ = Tween(this._currentTweens[param2]);
            this.unregister(_loc5_);
         }
         _loc5_ = new Tween(param1,param2,param3,param4);
         this._currentTweens[param2] = _loc5_;
         return _loc5_;
      }
      
      public function unregister(param1:Tween) : void
      {
         if(this._currentTweens && this._currentTweens[param1.target])
         {
            delete this._currentTweens[param1.target];
            param1.paused = true;
            param1.dispose();
         }
      }
      
      public function unregisterAll() : void
      {
         var _loc1_:Tween = null;
         for each(_loc1_ in this._currentTweens)
         {
            _loc1_.paused = true;
            _loc1_.dispose();
         }
         App.utils.data.cleanupDynamicObject(this._currentTweens);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.unregisterAll();
         this._currentTweens = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
