package net.wg.infrastructure.uilogging.base
{
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.IDataUtils;
   
   public class BaseLogger implements IDisposable
   {
      
      private static const PROPERTIES_LIMIT:int = 200;
      
      private static const MS_IN_SECOND:int = 1000;
       
      
      private var _dataUtils:IDataUtils;
      
      private var _feature:String;
      
      private var _group:String;
      
      private var _logOnceActions:Dictionary;
      
      private var _timedActions:Dictionary;
      
      private var _suspendedActions:Dictionary;
      
      private var _logPrefix:String;
      
      private var _disposed:Boolean = false;
      
      public function BaseLogger(param1:String, param2:String)
      {
         this._dataUtils = App.utils.data;
         this._logOnceActions = new Dictionary();
         this._timedActions = new Dictionary();
         this._suspendedActions = new Dictionary();
         super();
         this._feature = param1;
         this._group = param2;
         this._logPrefix = "Feature (" + this._feature + ") group (" + this._group + "): ";
      }
      
      public function resetTimer() : void
      {
         DebugUtils.LOG_DEBUG(this._logPrefix + "Timers are reset.");
         this._dataUtils.cleanupDynamicObject(this._timedActions);
         this._dataUtils.cleanupDynamicObject(this._suspendedActions);
      }
      
      public function resetOnce() : void
      {
         this._dataUtils.cleanupDynamicObject(this._logOnceActions);
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this._dataUtils.cleanupDynamicObject(this._logOnceActions);
         this._dataUtils.cleanupDynamicObject(this._timedActions);
         this._dataUtils.cleanupDynamicObject(this._suspendedActions);
         this._dataUtils = null;
         this._logOnceActions = null;
         this._timedActions = null;
      }
      
      protected function _log(param1:String, param2:int = 20, param3:Object = null) : void
      {
         var _loc5_:* = null;
         var _loc4_:int = 0;
         param3 = param3 || {};
         for(_loc5_ in param3)
         {
            _loc4_++;
         }
         if(_loc4_ < PROPERTIES_LIMIT)
         {
            App.instance.uiLoggerManager.log(this._feature,this._group,param1,param2,param3);
         }
         else
         {
            DebugUtils.LOG_ERROR(this._logPrefix + "Action " + param1 + " number of params limit (" + PROPERTIES_LIMIT + ") exceeded.");
         }
      }
      
      protected function _logOnce(param1:String, param2:int = 20, param3:Object = null) : void
      {
         if(!this._logOnceActions.hasOwnProperty(param1))
         {
            this._logOnceActions[param1] = true;
            this._log(param1,param2,param3);
         }
         else
         {
            DebugUtils.LOG_DEBUG(this._logPrefix + "Action " + param1 + " is already logged.");
         }
      }
      
      public function suspendAction(param1:String) : void
      {
         if(!this._timedActions.hasOwnProperty(param1))
         {
            return;
         }
         if(this._suspendedActions.hasOwnProperty(param1))
         {
            return;
         }
         this._suspendedActions[param1] = getTimer();
      }
      
      public function resumeAction(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(!this._timedActions.hasOwnProperty(param1))
         {
            return;
         }
         _loc2_ = this._suspendedActions[param1];
         if(!_loc2_)
         {
            return;
         }
         delete this._suspendedActions[param1];
         _loc3_ = getTimer() - _loc2_;
         this._timedActions[param1] += _loc3_;
      }
      
      public function startAction(param1:String) : void
      {
         if(this._timedActions.hasOwnProperty(param1))
         {
            DebugUtils.LOG_DEBUG(this._logPrefix + "Action " + param1 + " is already started. Setting new action.");
         }
         this._timedActions[param1] = getTimer();
      }
      
      protected function _stopAction(param1:String, param2:int = 20, param3:Object = null, param4:Number = 0) : void
      {
         var _loc5_:uint = 0;
         var _loc6_:Number = NaN;
         var _loc8_:* = null;
         var _loc7_:Object = {};
         if(this._timedActions.hasOwnProperty(param1))
         {
            if(this._suspendedActions.hasOwnProperty(param1))
            {
               this.resumeAction(param1);
            }
            _loc5_ = this._timedActions[param1];
            _loc6_ = (getTimer() - _loc5_) / MS_IN_SECOND;
            delete this._timedActions[param1];
            if(param3)
            {
               for(_loc8_ in param3)
               {
                  _loc7_[_loc8_] = param3[_loc8_];
               }
            }
            _loc7_.timeSpent = _loc6_;
            if(_loc6_ > param4)
            {
               this._log(param1,param2,_loc7_);
            }
         }
         else
         {
            DebugUtils.LOG_DEBUG(this._logPrefix + "Action " + param1 + " isn\'t started");
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
