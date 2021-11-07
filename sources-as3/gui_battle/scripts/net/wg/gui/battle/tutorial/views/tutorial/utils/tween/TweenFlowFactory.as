package net.wg.gui.battle.tutorial.views.tutorial.utils.tween
{
   import flash.utils.Dictionary;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class TweenFlowFactory implements IDisposable
   {
      
      private static var _instance:TweenFlowFactory = null;
       
      
      private var _cache:Dictionary;
      
      public function TweenFlowFactory()
      {
         this._cache = new Dictionary();
         super();
         App.utils.asserter.assert(!_instance,"Instantiation failed: Use TweenFlowFactory.getInstance() instead of new.");
      }
      
      public static function getInstance() : TweenFlowFactory
      {
         if(!_instance)
         {
            return _instance = new TweenFlowFactory();
         }
         return _instance;
      }
      
      public function getFlow(param1:Function, param2:int) : Vector.<Number>
      {
         if(this._cache[param1] && this._cache[param1][param2])
         {
            return this._cache[param1][param2].concat();
         }
         var _loc3_:Vector.<Number> = new Vector.<Number>(param2);
         var _loc4_:Number = 1 / param2;
         var _loc5_:int = 0;
         while(_loc5_ < param2)
         {
            _loc3_[_loc5_] = param1(_loc4_ * _loc5_,0,1,1);
            _loc5_++;
         }
         if(!this._cache[param1])
         {
            this._cache[param1] = new Dictionary();
         }
         this._cache[param1][param2] = _loc3_;
         return _loc3_.concat();
      }
      
      public function dispose() : void
      {
         var _loc1_:Object = null;
         for each(_loc1_ in this._cache)
         {
            delete this._cache[_loc1_];
         }
         this._cache = null;
      }
   }
}
