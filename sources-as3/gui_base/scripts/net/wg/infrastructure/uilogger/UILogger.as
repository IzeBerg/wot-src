package net.wg.infrastructure.uilogger
{
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.IDataUtils;
   
   public class UILogger implements IDisposable
   {
      
      private static const PROPERTIES_LIMIT:int = 200;
       
      
      private var _dataUtils:IDataUtils;
      
      private var _feature:String;
      
      private var _group:String;
      
      private var _logOnce:Dictionary;
      
      private var _timedActions:Dictionary;
      
      private var _logPrefix:String;
      
      public function UILogger(param1:String, param2:String)
      {
         this._dataUtils = App.utils.data;
         this._logOnce = new Dictionary();
         this._timedActions = new Dictionary();
         super();
         this._feature = param1;
         this._group = param2;
         this._logPrefix = "Feature (" + this._feature + ") group (" + this._group + "): ";
      }
      
      public function resetTimer() : void
      {
         DebugUtils.LOG_DEBUG(this._logPrefix + "Timers are reset.");
         this._dataUtils.cleanupDynamicObject(this._timedActions);
      }
      
      public function resetOnce() : void
      {
         this._dataUtils.cleanupDynamicObject(this._logOnce);
      }
      
      public function dispose() : void
      {
         this._dataUtils.cleanupDynamicObject(this._logOnce);
         this._dataUtils.cleanupDynamicObject(this._timedActions);
         this._dataUtils = null;
         this._logOnce = null;
         this._timedActions = null;
      }
      
      protected function debug(param1:String, param2:Object = null) : void
      {
         this.log(param1,LogLevels.DEBUG,param2);
      }
      
      protected function info(param1:String, param2:Object = null) : void
      {
         this.log(param1,LogLevels.INFO,param2);
      }
      
      protected function warning(param1:String, param2:Object = null) : void
      {
         this.log(param1,LogLevels.WARNING,param2);
      }
      
      protected function log(param1:String, param2:int = 20, param3:Object = null) : void
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
      
      protected function logOnce(param1:String, param2:int = 20, param3:Object = null) : void
      {
         if(!this._logOnce.hasOwnProperty(param1))
         {
            this._logOnce[param1] = true;
            this.log(param1,param2,param3);
         }
         else
         {
            DebugUtils.LOG_DEBUG(this._logPrefix + "Action " + param1 + " is already logged.");
         }
      }
      
      protected function startAction(param1:String) : void
      {
         if(this._timedActions.hasOwnProperty(param1))
         {
            DebugUtils.LOG_DEBUG(this._logPrefix + "Action " + param1 + " is already started. Setting new action.");
         }
         this._timedActions[param1] = getTimer();
      }
      
      protected function stopAction(param1:String, param2:int = 20, param3:Object = null, param4:Number = 0) : void
      {
         var _loc5_:uint = 0;
         var _loc6_:Number = NaN;
         var _loc8_:* = null;
         var _loc7_:Object = {};
         if(this._timedActions.hasOwnProperty(param1))
         {
            _loc5_ = this._timedActions[param1];
            _loc6_ = (getTimer() - _loc5_) / 1000;
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
               this.log(param1,param2,_loc7_);
            }
         }
         else
         {
            DebugUtils.LOG_DEBUG(this._logPrefix + "Action " + param1 + " isn\'t started");
         }
      }
   }
}
